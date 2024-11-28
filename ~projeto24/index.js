const express = require('express');
const { Sequelize, DataTypes } = require('sequelize');

const app = express();
const port = 3000;

// Middleware para trabalhar com JSON
app.use(express.json());

// Configurando o banco de dados MySQL
const sequelize = new Sequelize('projetoz', 'root', '', {
    host: 'localhost', // Endereço do seu servidor MySQL
    dialect: 'mysql',
});

// Definindo o modelo (Tabela de Produtos)
const Produto = sequelize.define('Produto', {
    nome: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    preco: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false,
    },
    estoque: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
});

// Sincronizando com o banco
sequelize.sync({ force: true }).then(() => {
    console.log('Tabela produtos sincronizada com o banco de dados');
});

// Rotas CRUD

// CREATE: Inserir um novo produto
app.post('/produtos', async (req, res) => {
    try {
        const { nome, preco, estoque } = req.body;
        const produto = await Produto.create({ nome, preco, estoque });
        res.status(201).json(produto);
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
});

// READ: Listar todos os produtos
app.get('/produtos', async (req, res) => {
    try {
        const produtos = await Produto.findAll();
        res.status(200).json(produtos);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// READ: Buscar um produto por ID
app.get('/produtos/:id', async (req, res) => {
    try {
        const produto = await Produto.findByPk(req.params.id);
        if (!produto) {
            return res.status(404).json({ error: 'Produto não encontrado' });
        }
        res.status(200).json(produto);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// UPDATE: Atualizar um produto por ID
app.put('/produtos/:id', async (req, res) => {
    try {
        const { nome, preco, estoque } = req.body;
        const produto = await Produto.findByPk(req.params.id);
        if (!produto) {
            return res.status(404).json({ error: 'Produto não encontrado' });
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

// DELETE: Remover um produto por ID
app.delete('/produtos/:id', async (req, res) => {
    try {
        const produto = await Produto.findByPk(req.params.id);
        if (!produto) {
            return res.status(404).json({ error: 'Produto não encontrado' });
        }
        await produto.destroy();
        res.status(204).send();
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Iniciando o servidor
app.listen(port, () => {
    console.log(`Servidor rodando em http://localhost:${port}`);
});
