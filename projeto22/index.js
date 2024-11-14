const express = require("express");
const path = require("path");
const mysql = require("mysql");
const { engine } = require ('express-handlebars');

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: '',
  database: 'projetoz',
});

db.connect( (erro) => {
 if (erro) {
  console.log(erro);
 }
 console.log("Conectou ao MySQL!");
});



const app = express();


app.engine('handlebars', engine({
  defaultLayout:'main',
  layoutsDir:path.join(__dirname,'views','layouts'),
  partialsDir:path.join(__dirname,'views', 'partials'),
}));
app.set("view engine", "handlebars");

app.use(express.static(path.join(__dirname,"public")));

app.get("/", (requisicao, resposta) => {
  resposta.render("index");
});

app.get("/produtos", (requisicao, resposta) => {
  let sql = "SELECT * FROM PRODUTOS";
  db.query(sql, function (erro, dados){
      let produtos = dados;
      resposta.render("produtos", { produtos });
  });
});

app.use((requisicao, resposta) => {
  resposta.status(404);
  resposta.render("404");
});

app.listen(3000, () => {
  console.log('Servidor rodando em localhost:3000...');
});
