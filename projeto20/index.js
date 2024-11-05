const http = require("http");
const fs = require("fs");
const path = require("path");
http
  .createServer(function (requisicao, resposta) {
    let caminhoArquivo = requisicao.url == "/" ? "/index" : requisicao.url;
    let caminhoCompleto = path.join(__dirname, `${caminhoArquivo}.html`);
    fs.readFile(caminhoCompleto, function (erro, arquivo) {
      if (erro) {
        let caminho404 = path.join(__dirname, "404.html");
        fs.readFile(caminho404, function (erro, arquivo) {
          resposta.writeHead(404, { "Content-Type": "text/html" });
          resposta.write(arquivo);
          resposta.end();
        });
      } else {
        resposta.writeHead(200, { "Content-Type": "text/html" });
        resposta.write(arquivo);
        resposta.end();
      }
    });
  })
  .listen(3000, function () {
    console.log("Servidor rodando em localhost:3000");
  });
