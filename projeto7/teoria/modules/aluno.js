export default class Aluno {
  constructor(pNome, pNotas) {
    this.nome = pNome;
    this.notas = pNotas;
  }
  media = function () {
    return (this.notas[0] + this.notas[1] + this.notas[2] + this.notas[3]) / 4;
  };
}
