const express = require("express");
const path = require("path");
const mysql = require("mysql");
const session = require("express-session");
const md5 = require("md5");

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

const app = express();

app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));

app.use(
  session({
    secret: "chave-secreta",
    resave: false,
    saveUninitialized: true,
    cookie: {
      secure: false,
    },
  })
);

function verificarLogin(requisicao, resposta, next) {
  if (requisicao.session.usuario) {
    return next();
  } else {
    resposta.redirect("/login");
  }
}

app.use(express.static(path.join(__dirname, "public")));

app.use(express.urlencoded({ extended: true }));

app.get("/login", (requisicao, resposta) => {
  resposta.render("login");
});

app.post("/login", (requisicao, resposta) => {
  let { email, senha } = requisicao.body;
  let senhaCriptografada = md5(senha);
  let sql = "SELECT * FROM usuarios WHERE email = ? AND senha = ?";
  db.query(sql, [email, senhaCriptografada], (erro, resultados) => {
    if (erro) {
      return resposta.status(500).send(erro);
    }
    if (resultados.length > 0) {
      requisicao.session.usuario = resultados[0];
      resposta.redirect("/produtos");
    } else {
      resposta.render("login", { erro: "Usuário ou senha inválidos." });
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
  let sql = `
  SELECT p.*, c.nome categoria_nome 
  FROM produtos p, categorias c 
  WHERE p.categoria_id = c.id
  `;
  db.query(sql, (erro, dados) => {
    if (erro) {
      resposta.status(500).send(erro);
    }
    let produtos = dados;
    resposta.render("produtos", { produtos });
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

app.get("/produtos/editar", verificarLogin, (requisicao, resposta) => {
  let id = requisicao.query.id;
  let sqlProdutos = `SELECT * FROM produtos WHERE id = '${id}'`;
  db.query(sqlProdutos, (erro, produto) => {
    if (erro) {
      resposta.status(500).send(erro);
    }
    let sqlCategorias = "SELECT * FROM categorias ORDER BY nome";
    db.query(sqlCategorias, (erro, categorias) => {
      if (erro) {
        resposta.status(500).send(erro);
      }
      resposta.render("produtos-editar", { produto: produto[0], categorias });
    });
  });
});

app.post("/produtos/insert", verificarLogin, (requisicao, resposta) => {
  let { categoria_id, nome, valor, visivel } = requisicao.body;
  if (categoria_id == "" || nome == "" || valor == "" || visivel == "") {
    return resposta
      .status(400)
      .send("É obrigatório o preenchimento de todos os campos.");
  }
  let sql;
  sql = `INSERT INTO produtos (categoria_id, nome, valor, visivel) VALUES (?,?,?,?)`;
  db.query(sql, [categoria_id, nome, valor, visivel], (erro) => {
    if (erro) {
      resposta.status(500).send(erro);
    }
    resposta.redirect("/produtos");
  });
});

app.post("/produtos/update", verificarLogin, (requisicao, resposta) => {
  let { id, categoria_id, nome, valor, visivel } = requisicao.body;
  if (id == "" || categoria_id == "" || nome == "" || valor == "" || visivel == "") {
    return resposta
      .status(400)
      .send("É obrigatório o preenchimento de todos os campos.");
  }
  let sql;
  sql = `UPDATE produtos SET categoria_id = ?, nome = ?, valor = ?, visivel = ? WHERE id = ?`;
  db.query(sql, [categoria_id, nome, valor, visivel, id], (erro) => {
    if (erro) {
      resposta.status(500).send(erro);
    }
    resposta.redirect("/produtos");
  });
});

app.get("/produtos/novo", verificarLogin, (requisicao, resposta) => {
  let sql = "SELECT * FROM categorias ORDER BY nome";
  db.query(sql, (erro, categorias) => {
    if (erro) {
      resposta.status(500).send(erro);
    }
    resposta.render("produtos-novo", { categorias });
  });
});

app.use((requisicao, resposta) => {
  resposta.status(404);
  resposta.render("404");
});

app.listen(3000, () => {
  console.log("Servidor rodando em localhost:3000...");
});
