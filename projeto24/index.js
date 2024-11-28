const path = require("path");
const fs = require("fs");
const express = require("express");
const multer = require("multer");
const session = require("express-session");
const md5 = require("md5");
const { Sequelize, DataTypes, Op } = require("sequelize");

const app = express();

// Configuração do Sequelize
const sequelize = new Sequelize("projetoz", "root", "", {
  host: "localhost",
  dialect: "mysql",
});

// Modelos
const Usuario = sequelize.define(
  "Usuario",
  {
    email: { type: DataTypes.STRING, allowNull: false, unique: true },
    senha: { type: DataTypes.STRING, allowNull: false },
  },
  { tableName: "usuarios", timestamps: false }
);

const Categoria = sequelize.define(
  "Categoria",
  {
    nome: { type: DataTypes.STRING, allowNull: false },
  },
  { tableName: "categorias", timestamps: false }
);

const Produto = sequelize.define(
  "Produto",
  {
    nome: { type: DataTypes.STRING, allowNull: false },
    valor: { type: DataTypes.FLOAT, allowNull: false },
    visivel: { type: DataTypes.BOOLEAN, defaultValue: true },
    imagem: { type: DataTypes.STRING },
  },
  { tableName: "produtos", timestamps: false }
);

// Relacionamento
Produto.belongsTo(Categoria, { foreignKey: "categoria_id", as: "Categoria" });

app.use(
  session({
    secret: "chave-secreta",
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false },
  })
);

app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));
app.use(express.static(path.join(__dirname, "public")));
app.use(express.urlencoded({ extended: true }));

// Middleware de login
function verificarLogin(requisicao, resposta, next) {
  if (requisicao.session.usuario) {
    return next();
  } else {
    resposta.redirect("/login");
  }
}

// Configuração do multer
function sanitizeFileName(filename) {
  return filename
    .toLowerCase()
    .replace(/ç/g, "c")
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/\s+/g, "-")
    .replace(/[^a-z0-9.-]/g, "")
    .replace(/-+/g, "-");
}

const armazenamento = multer.diskStorage({
  destination: (req, file, cb) =>
    cb(null, path.join(__dirname, "public/uploads")),
  filename: (req, file, cb) => {
    const sufixoUnico = Date.now() + "-" + Math.round(Math.random() * 1e9);
    const nomeSanitizado = sanitizeFileName(file.originalname);
    cb(null, sufixoUnico + "-" + nomeSanitizado);
  },
});
const upload = multer({ storage: armazenamento });

app.get("/login", (req, res) => {
  res.render("login");
});

app.post("/login", async (req, res) => {
  const { email, senha } = req.body;
  const senhaCriptografada = md5(senha);

  const usuario = await Usuario.findOne({
    where: { email, senha: senhaCriptografada },
  });

  if (usuario) {
    req.session.usuario = usuario;
    res.redirect("/produtos");
  } else {
    res.render("login", { erro: "Usuário ou senha incorretos" });
  }
});

app.get("/logout", (req, res) => {
  req.session.destroy((erro) => {
    if (erro) return res.status(500).send(erro);
    res.redirect("/login");
  });
});

app.get("/", (req, res) => {
  res.render("index");
});

app.get("/produtos", verificarLogin, async (req, res) => {
  let { limit, offset, orderColumn, order, column, operator, value } = req.query;

  limit = parseInt(limit) || 5;
  offset = parseInt(offset) || 0;
  orderColumn = orderColumn || "id";
  order = order || "ASC";

  let where = {};

  // Configuração do filtro de busca
  if (column && operator && value) {
    switch (operator) {
      case "=":
        where[column] = value;
        break;
      case ">":
        where[column] = { [Op.gt]: value };
        break;
      case ">=":
        where[column] = { [Op.gte]: value };
        break;
      case "<":
        where[column] = { [Op.lt]: value };
        break;
      case "<=":
        where[column] = { [Op.lte]: value };
        break;
      case "<>":
        where[column] = { [Op.ne]: value };
        break;
      case "like":
        where[column] = { [Op.like]: `%${value}%` };
        break;
      default:
        break;
    }
  }

  try {
    const { count: totalRegistros, rows: produtos } = await Produto.findAndCountAll({
      include: [
        {
          model: Categoria,
          as: "Categoria",
          attributes: ["nome"],
        },
      ],
      where,
      order: [
        orderColumn === "Categoria.nome"
          ? [{ model: Categoria, as: "Categoria" }, "nome", order]
          : [orderColumn, order],
      ],
      limit,
      offset,
    });

    res.render("produtos", {
      produtos,
      totalRegistros,
      limit,
      offset,
      requisicao: req,
    });
  } catch (erro) {
    console.error("Erro ao buscar produtos:", erro);
    res.status(500).send("Erro ao buscar produtos.");
  }
});

app.get("/produtos/novo", verificarLogin, async (req, res) => {
  const categorias = await Categoria.findAll({ order: [["nome", "ASC"]] });
  res.render("produtos-novo", { categorias });
});

app.get("/produtos/editar", verificarLogin, async (req, res) => {
  const { id } = req.query;

  const produto = await Produto.findByPk(id);
  const categorias = await Categoria.findAll({ order: [["nome", "ASC"]] });

  res.render("produtos-editar", { produto, categorias });
});

app.post(
  "/produtos/insert",
  verificarLogin,
  upload.single("imagem"),
  async (req, res) => {
    const { categoria_id, nome, valor, visivel } = req.body;
    const imagem = req.file ? sanitizeFileName(req.file.filename) : null;

    await Produto.create({ categoria_id, nome, valor, visivel, imagem });

    res.redirect("/produtos");
  }
);

app.post(
  "/produtos/update",
  verificarLogin,
  upload.single("imagem"),
  async (req, res) => {
    const { id, categoria_id, nome, valor, visivel } = req.body;
    const imagem = req.file ? sanitizeFileName(req.file.filename) : null;

    const produto = await Produto.findByPk(id);

    if (produto.imagem && imagem) {
      const caminhoImagemAntiga = path.join(
        __dirname,
        "public/uploads",
        produto.imagem
      );
      fs.unlink(caminhoImagemAntiga, (erro) => {
        if (erro) console.log("Erro ao excluir a imagem antiga:", erro);
      });
    }

    await produto.update({ nome, valor, visivel, imagem, categoria_id });

    res.redirect("/produtos");
  }
);

app.get("/produtos/excluir", verificarLogin, async (req, res) => {
  const { id } = req.query;

  const produto = await Produto.findByPk(id);
  if (produto.imagem) {
    const caminhoImagem = path.join(
      __dirname,
      "public/uploads",
      produto.imagem
    );
    fs.unlink(caminhoImagem, (erro) => {
      if (erro) console.log("Erro ao excluir a imagem:", erro);
    });
  }

  await produto.destroy();

  res.redirect("/produtos");
});

app.use((req, res) => {
  res.status(404).render("404");
});

app.listen(3000, () => {
  console.log("Servidor rodando em localhost:3000...");
});
