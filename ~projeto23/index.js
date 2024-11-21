const path = require("path");
const fs = require("fs");
const mysql = require("mysql");
const express = require("express");
const multer = require("multer");
const session = require("express-session");
const md5 = require("md5");

const app = express();

app.use(
  session({
    secret: "chave-secreta",
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false },
  })
);

function verificarLogin(requisicao, resposta, next) {
  if (requisicao.session.usuario) {
    return next();
  } else {
    resposta.redirect("/login");
  }
}

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

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "projetoz",
});

db.connect((erro) => {
  if (erro) {
    console.log(erro);
  }
  console.log("Conectou no MySQL!");
});

app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));

app.use(express.static(path.join(__dirname, "public")));

app.use(express.urlencoded({ extended: true }));

const armazenamento = multer.diskStorage({
  destination: function (requisicao, arquivo, cb) {
    cb(null, path.join(__dirname, "public/uploads"));
  },
  filename: function (requisicao, arquivo, cb) {
    const sufixoUnico = Date.now() + "-" + Math.round(Math.random() * 1e9);
    const nomeSanitizado = sanitizeFileName(arquivo.originalname);
    cb(null, sufixoUnico + "-" + nomeSanitizado);
  },
});

const upload = multer({ storage: armazenamento });

app.get("/login", (req, res) => {
  res.render("login");
});

app.post("/login", (requisicao, resposta) => {
  const { email, senha } = requisicao.body;
  const senhaCriptografada = md5(senha);

  const sql = `SELECT * FROM usuarios WHERE email = ? AND senha = ?`;
  db.query(sql, [email, senhaCriptografada], (erro, resultados) => {
    if (erro) {
      return resposta.status(500).send(erro);
    }
    if (resultados.length > 0) {
      requisicao.session.usuario = resultados[0];
      resposta.redirect("/produtos");
    } else {
      resposta.render("login", { erro: "Usuário ou senha incorretos" });
    }
  });
});

app.get("/logout", (requisicao, resposta) => {
  requisicao.session.destroy((erro) => {
    if (erro) {
      return resposta.status(500).send(erro);
    }
    resposta.redirect("/login");
  });
});

app.get("/", (requisicao, resposta) => {
  resposta.render("index");
});

app.get("/produtos", verificarLogin, (requisicao, resposta) => {
  let where = "1";

  let limit = parseInt(requisicao.query.limit) || 5;
  let offset = parseInt(requisicao.query.offset) || 0;

  if (
    requisicao.query.search &&
    requisicao.query.column &&
    requisicao.query.operator &&
    requisicao.query.value
  ) {
    let column = mysql.escapeId(requisicao.query.column);
    let operator = requisicao.query.operator;
    let value = mysql.escape(requisicao.query.value);
    where += ` AND ${column} ${operator} ${value}`;
  }

  let order = requisicao.query.order === "desc" ? "DESC" : "ASC";
  let orderColumn = requisicao.query.orderColumn
    ? mysql.escapeId(requisicao.query.orderColumn)
    : "p.id";

  let sql = `
    SELECT p.*, c.nome AS categoria_nome 
    FROM produtos p 
    JOIN categorias c ON p.categoria_id = c.id 
    WHERE ${where} 
    ORDER BY ${orderColumn} ${order} 
    LIMIT ${limit} OFFSET ${offset}
  `;

  let sqlTotal = `SELECT COUNT(*) AS total FROM produtos p JOIN categorias c ON p.categoria_id = c.id WHERE ${where}`;

  db.query(sqlTotal, (erro, resultadoTotal) => {
    if (erro) {
      return resposta.status(500).send(erro);
    }

    const totalRegistros = resultadoTotal[0].total;

    db.query(sql, (erro, dados) => {
      if (erro) {
        return resposta.status(500).send(erro);
      }

      resposta.render("produtos", {
        requisicao,
        produtos: dados,
        totalRegistros,
        limit,
        offset,
      });
    });
  });
});

app.get("/produtos/novo", verificarLogin, (requisicao, resposta) => {
  let sqlCategorias = `SELECT * FROM categorias ORDER BY nome`;

  db.query(sqlCategorias, (erro, dados) => {
    let categorias = dados;
    resposta.render("produtos-novo", { categorias });
  });
});

app.get("/produtos/editar", verificarLogin, (requisicao, resposta) => {
  let id = requisicao.query.id;

  let sqlProduto = `SELECT * FROM produtos WHERE id = ?`;

  let sqlCategorias = `SELECT * FROM categorias`;

  db.query(sqlProduto, [id], (erro, resultadoProduto) => {
    if (erro) {
      return resposta.status(500).send(erro);
    }

    let produto = resultadoProduto[0];

    db.query(sqlCategorias, (erro, resultadoCategorias) => {
      if (erro) {
        return resposta.status(500).send(erro);
      }

      let categorias = resultadoCategorias;

      resposta.render("produtos-editar", { produto, categorias });
    });
  });
});

app.post(
  "/produtos/insert",
  verificarLogin,
  upload.single("imagem"),
  (requisicao, resposta) => {
    let { categoria_id, nome, valor, visivel } = requisicao.body;

    let imagemNova = requisicao.file
      ? sanitizeFileName(requisicao.file.filename)
      : null;

    if (nome == "" || valor == "" || visivel == "") {
      return resposta
        .status(400)
        .send("Todos os campos devem ser preenchidos.");
    }

    let campos = [categoria_id, nome, valor, visivel, imagemNova];

    let sql;

    sql = `INSERT INTO produtos (categoria_id, nome, valor, visivel, imagem) VALUES (?, ?, ?, ?, ?)`;

    db.query(sql, campos, (erro) => {
      if (erro) {
        return resposta.status(500).send(erro);
      }
      resposta.redirect("/produtos");
    });
  }
);

app.post(
  "/produtos/update",
  verificarLogin,
  upload.single("imagem"),
  (requisicao, resposta) => {
    let { categoria_id, id, nome, valor, visivel } = requisicao.body;

    let imagemNova = requisicao.file
      ? sanitizeFileName(requisicao.file.filename)
      : null;

    if (nome == "" || valor == "" || visivel == "") {
      return resposta
        .status(400)
        .send("Todos os campos devem ser preenchidos.");
    }

    let sql;

    let buscaImagemSQL = `SELECT imagem FROM produtos WHERE id = ${id}`;

    db.query(buscaImagemSQL, (erro, resultados) => {
      if (erro) {
        return resposta.status(500).send(erro);
      }

      let imagemAntiga = resultados[0].imagem;

      if (imagemNova && imagemAntiga) {
        const caminhoImagemAntiga = path.join(
          __dirname,
          "public/uploads",
          imagemAntiga
        );

        fs.unlink(caminhoImagemAntiga, (erro) => {
          if (erro) {
            console.log("Erro ao excluir a imagem antiga:", erro);
          }
        });
      }

      let campos = [nome, valor, visivel, imagemNova, categoria_id, id];

      sql = `UPDATE produtos SET nome = ?, valor = ?, visivel = ?, imagem = ?, categoria_id = ? WHERE id = ?`;

      db.query(sql, campos, (erro) => {
        if (erro) {
          return resposta.status(500).send(erro);
        }
        resposta.redirect("/produtos");
      });
    });
  }
);

app.get("/produtos/excluir", verificarLogin, (requisicao, resposta) => {
  let id = requisicao.query.id;
  let sql = `DELETE FROM produtos WHERE id = '${id}'`;
  db.query(sql, (erro) => {
    if (erro) {
      resposta.status(500).send(erro);
    }
    resposta.redirect("/produtos");
  });
});

app.get("/produtos/excluir", verificarLogin, (requisicao, resposta) => {
  let id = requisicao.query.id;
  let sql = `DELETE FROM produtos WHERE id = ?`;
  db.query(sql, [id], (erro) => {
    if (erro) {
      resposta.status(500).send(erro);
    }
    resposta.redirect("/produtos");
  });
});

app.use((requisicao, resposta) => {
  resposta.status(404);
  resposta.render("404");
});

app.listen(3000, () => {
  console.log("Servidor rodando em localhost:3000...");
});
