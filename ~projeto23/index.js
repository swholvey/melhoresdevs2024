const express = require("express");
const path = require("path");
const mysql = require("mysql");

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

app.use(express.static(path.join(__dirname, "public")));

app.use(express.urlencoded({ extended: true }));

app.get("/", (requisicao, resposta) => {
  resposta.render("index");
});

app.get("/produtos", (requisicao, resposta) => {
  let order = "asc";
  let orderColumn = "id";
  if (requisicao.query.order && requisicao.query.column) {
    order = requisicao.query.order;
    orderColumn = requisicao.query.column;
  }
  let sql = `SELECT * FROM produtos ORDER BY ${orderColumn} ${order}`;
  db.query(sql, (erro, dados) => {
    let produtos = dados;
    resposta.render("produtos", { produtos });
  });
});

app.get("/produtos/novo", (requisicao, resposta) => {
  resposta.render("produtos-novo");
});

app.get("/produtos/editar", (requisicao, resposta) => {
  let id = requisicao.query.id;
  let sql = `SELECT * FROM produtos WHERE id = ${id}`;
  db.query(sql, (erro, dado) => {
    let produto = dado[0];
    resposta.render("produtos-editar", { produto });
  });
});

app.post("/produtos/salvar", (requisicao, resposta) => {
  let nome = requisicao.body.nome;
  let valor = requisicao.body.valor;
  let visivel = requisicao.body.visivel;
  let sql;
  if (requisicao.body.id) {
    let id = requisicao.body.id;
    sql = `UPDATE produtos SET nome = '${nome}', valor = '${valor}', visivel = '${visivel}' WHERE id = ${id}`;
  } else {
    sql = `INSERT INTO produtos (nome, valor, visivel) VALUES ('${nome}','${valor}','${visivel}')`;
  }
  db.query(sql, (erro) => {
    if (erro) {
      resposta.status(500).send(erro);
    }
    resposta.redirect("/produtos");
  });
});

app.get("/produtos/excluir", (requisicao, resposta) => {
  let id = requisicao.query.id;
  let sql = `DELETE FROM produtos WHERE id = '${id}'`;
  db.query(sql, (erro) => {
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
