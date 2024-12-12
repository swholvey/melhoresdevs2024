// Importar os módulos necessários
const express = require('express');
const http = require('http');
const { Server } = require('socket.io');

// Configurar o servidor
const app = express();
const server = http.createServer(app);
const io = new Server(server);

// Servir arquivos estáticos (HTML, CSS, JS)
app.use(express.static('public'));

// Evento de conexão ao Socket.IO
io.on('connection', (socket) => {
    console.log('Um usuário se conectou');

    // Ouvir mensagens do cliente
    socket.on('chat message', ({ name, message }) => {
        const date = new Date();
        const timestamp = `${date.toLocaleDateString('pt-BR')} às ${date.toLocaleTimeString('pt-BR')}`;
        console.log(`Mensagem de ${name} em ${timestamp}: ${message}`);
        io.emit('chat message', { timestamp, name, message }); // Enviar a mensagem para todos os clientes conectados
    });

    // Evento de desconexão
    socket.on('disconnect', () => {
        console.log('Um usuário se desconectou');
    });
});

// Inicializar o servidor
const PORT = 3000;
server.listen(PORT, () => {
    console.log(`Servidor rodando em http://localhost:${PORT}`);
});
