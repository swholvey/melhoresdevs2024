document.addEventListener("DOMContentLoaded", () => {
  calculo();
});

function calculo() {
  let elementos = document.querySelectorAll(".calculo");

  elementos.forEach((elemento) => {
    let resultado = 0;
    let numero1 = parseFloat(elemento.dataset.numero1);
    let numero2 = parseFloat(elemento.dataset.numero2);
    let operacao = elemento.dataset.operacao;
    if (operacao == "soma") {
      resultado = numero1 + numero2;
    } else if (operacao == "subtracao") {
      resultado = numero1 - numero2;
    } else if (operacao == "multiplicacao") {
      resultado = numero1 * numero2;
    } else if (operacao == "divisao") {
      resultado = numero1 / numero2;
    }
    elemento.textContent = resultado;
  });
}
