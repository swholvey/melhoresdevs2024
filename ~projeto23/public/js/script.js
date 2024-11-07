let w = document.querySelectorAll(".w");

w.forEach((elemento) => {
  let dataW = elemento.getAttribute("data-w");
  elemento.style.width = dataW;
});

function orderBy(orderColumn, order) {
  const url = new URL(window.location.href);

  url.searchParams.set("orderColumn", orderColumn);
  url.searchParams.set("order", order);

  window.location.href = url.toString();
}

function pagination(total, recordsByPage, page) {
  const url = new URL(window.location.href);

  recordsByPage = parseInt(recordsByPage);
  page = parseInt(page) * recordsByPage;

  url.searchParams.set("offset", page);
  url.searchParams.set("limit", recordsByPage);

  window.location.href = url.toString();
}

function limit(element) {
  const url = new URL(window.location.href);

  url.searchParams.set("limit", element.value);

  window.location.href = url.toString();
}

function exportTableForCSV(idTabela, incluirColunas = []) {
  
  const tabela = document.getElementById(idTabela);
  
  if (!tabela) {
    console.error(`Tabela com ID "${idTabela}" não encontrada!`);
    return;
  }

  let csv = [];
  
  const deveIncluirColuna = (indice) => {
    return incluirColunas.length > 0 ? incluirColunas.includes(indice) : true;
  };

  const headers = Array.from(tabela.querySelectorAll("thead th"));
  const linhaCabecalho = headers
    .map((celula, index) => (deveIncluirColuna(index) ? `"${celula.innerText}"` : null))
    .filter((celula) => celula !== null)
    .join(";");
  csv.push(linhaCabecalho);

  const linhas = Array.from(tabela.querySelectorAll("tbody tr"));
  
  linhas.forEach((linha) => {
    const dados = Array.from(linha.querySelectorAll("td"))
      .map((celula, index) => (deveIncluirColuna(index) ? `"${celula.innerText}"` : null))
      .filter((celula) => celula !== null)
      .join(";");
    csv.push(dados);
  });

  const conteudoCSV = "\uFEFF" + csv.join("\n");

  const blob = new Blob([conteudoCSV], { type: "text/csv;charset=utf-8;" });
  const url = window.URL.createObjectURL(blob);

  const link = document.createElement("a");
  link.href = url;
  link.download = "tabela.csv";
  link.style.display = "none";

  document.body.appendChild(link);
  link.click();
  document.body.removeChild(link);

  window.URL.revokeObjectURL(url);
  
}
