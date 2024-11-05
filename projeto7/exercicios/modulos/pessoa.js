export default class Pessoa {
  constructor(pNome, pIdade) {
    this.nome = pNome;
    this.idade = pIdade;
  }
  apresentar = function () {
    return `Olá meu nome é ${this.nome} e eu tenho ${this.idade} anos.`;
  };
}