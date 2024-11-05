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

app.get("/", (requisicao, resposta) => {
  resposta.render("index");
});

app.get("/produtos", (requisicao, resposta) => {
  let sql = "SELECT * FROM produtos";
  db.query(sql, (erro, dados) => {
    let produtos = dados;
    resposta.render("produtos", { produtos });
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

app.get("/produtos/editar", (requisicao, resposta) => {
  let id = requisicao.query.id;
  let sql = `SELECT * FROM produtos WHERE id = '${id}'`;
  db.query(sql, (erro, dado) => {
    let produto = dado[0];
    resposta.render("produtos-editar", { produto });
  });
});

app.use((requisicao, resposta) => {
  resposta.status(404);
  resposta.render("404");
});

app.listen(3000, () => {
  console.log("Servidor rodando em localhost:3000...");
});
