const express = require("express");
const mongoose = require("mongoose");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");

const app = express();
const port = 3000;

app.use(express.json());

const SECRET_KEY = "sua_chave_secreta_super_segura";

mongoose.connect("mongodb://localhost:27017/projetoz", {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

const UsuarioSchema = new mongoose.Schema({
  email: {
    type: String,
    required: true,
    unique: true,
  },
  senha: {
    type: String,
    required: true,
  },
});

const ProdutoSchema = new mongoose.Schema({
  nome: {
    type: String,
    required: true,
  },
  preco: {
    type: Number,
    required: true,
  },
  estoque: {
    type: Number,
    required: true,
  },
});

const Usuario = mongoose.model("Usuario", UsuarioSchema);
const Produto = mongoose.model("Produto", ProdutoSchema);

function authenticateToken(req, res, next) {
  const token = req.headers["authorization"]?.split(" ")[1];
  if (!token) return res.status(401).json({ error: "Token não fornecido" });

  jwt.verify(token, SECRET_KEY, (err, user) => {
    if (err) return res.status(403).json({ error: "Token inválido" });
    req.user = user;
    next();
  });
}

app.post("/register", async (req, res) => {
  const { email, senha } = req.body;

  if (!email || !senha) {
    return res.status(400).json({ error: "E-mail e senha são obrigatórios" });
  }

  try {
    const hash = await bcrypt.hash(senha, 10);
    const novoUsuario = new Usuario({ email, senha: hash });
    await novoUsuario.save();
    res.status(201).json({ message: "Usuário registrado com sucesso" });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

app.post("/login", async (req, res) => {
  const { email, senha } = req.body;
  if (!email || !senha) {
    return res.status(400).json({ error: "E-mail e senha são obrigatórios" });
  }

  try {
    const usuario = await Usuario.findOne({ email });
    if (!usuario) {
      return res.status(404).json({ error: "Usuário não encontrado" });
    }

    const senhaValida = await bcrypt.compare(senha, usuario.senha);
    if (!senhaValida) {
      return res.status(401).json({ error: "Senha inválida" });
    }

    const user = { id: usuario._id, email: usuario.email };
    const token = jwt.sign(user, SECRET_KEY, { expiresIn: "1h" });

    res.status(200).json({ token });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.post("/produtos", authenticateToken, async (req, res) => {
  const { nome, preco, estoque } = req.body;
  try {
    const novoProduto = new Produto({ nome, preco, estoque });
    await novoProduto.save();
    res.status(201).json(novoProduto);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

app.get("/produtos", authenticateToken, async (req, res) => {
  try {
    const produtos = await Produto.find();
    res.status(200).json(produtos);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.get("/produtos/:id", authenticateToken, async (req, res) => {
  try {
    const produto = await Produto.findById(req.params.id);
    if (!produto) {
      return res.status(404).json({ error: "Produto não encontrado" });
    }
    res.status(200).json(produto);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.put("/produtos/:id", authenticateToken, async (req, res) => {
  const { nome, preco, estoque } = req.body;
  try {
    const produto = await Produto.findById(req.params.id);
    if (!produto) {
      return res.status(404).json({ error: "Produto não encontrado" });
    }

    produto.nome = nome;
    produto.preco = preco;
    produto.estoque = estoque;
    await produto.save();
    res.status(200).json(produto);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

app.delete("/produtos/:id", authenticateToken, async (req, res) => {
  try {
    const produto = await Produto.findById(req.params.id);
    if (!produto) {
      return res.status(404).json({ error: "Produto não encontrado" });
    }
    await produto.deleteOne();
    res.status(204).send();
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
});
