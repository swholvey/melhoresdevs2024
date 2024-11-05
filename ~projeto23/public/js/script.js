let w = document.querySelectorAll(".w");

w.forEach((elemento) => {
  let dataW = elemento.getAttribute("data-w");
  elemento.style.width = dataW;
});
