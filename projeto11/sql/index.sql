-- cd C:\xampp7433-2\mysql\bin>
-- mysql -u root;
-- CREATE DATABASE projetox;
-- CREATE DATABASE IF NOT EXISTS projetox;
-- SHOW DATABASES;
-- DROP DATABASE projetox;
-- DROP DATABASE IF EXISTS projetox;
-- CREATE DATABASE projetox;
-- USE projetox;
-- CREATE TABLE acessorios (id int, nome varchar(255), preco decimal(10,2));
-- SHOW CREATE TABLE acessorios;
-- SHOW tables;
-- DROP TABLE acessorios;
-- DROP TABLE IF EXISTS acessorios;
-- CREATE TABLE acessorios (id int, nome varchar(255), preco decimal(10,2));
-- DESC acessorios;
-- INSERT INTO acessorios (id, nome, preco) VALUES (1, 'Roda', 15000);
-- INSERT INTO acessorios (id, nome, preco) VALUES (2, 'Aerofolio', 7000);
-- SELECT * FROM acessorios;
-- ALTER TABLE acessorios ADD estoque int;
-- ALTER TABLE acessorios DROP COLUMN estoque;
-- ALTER TABLE acessorios ADD estoque int FIRST;
-- ALTER TABLE acessorios DROP COLUMN estoque;
-- ALTER TABLE acessorios ADD estoque int AFTER preco;
-- ALTER TABLE acessorios MODIFY COLUMN estoque INT, MODIFY COLUMN preco tipo_preco AFTER estoque;
-- UPDATE acessorios SET estoque = 10;
-- SELECT id, nome FROM acessorios;
-- SELECT * FROM acessorios ORDER BY preco ASC;
-- SELECT * FROM acessorios ORDER BY preco DESC;
-- SELECT * FROM acessorios ORDER BY preco DESC, nome ASC;
-- SELECT * FROM acessorios LIMIT 1;
-- SELECT * FROM acessorios LIMIT 1 OFFSET 1;
-- SELECT MIN(preco) FROM acessorios;
-- SELECT MAX(preco) FROM acessorios;
-- SELECT COUNT(*) AS total FROM acessorios;
-- SELECT COUNT(nome) AS total FROM acessorios;

-- CREATE TABLE categorias (id int, nome varchar(255));

-- INSERT INTO categorias (id, nome) VALUES (1, 'Rodas');

-- INSERT INTO categorias (id, nome) VALUES (2, 'Aerofolios');

-- INSERT INTO categorias (id, nome) VALUES (3, 'Escapamentos');

-- ALTER TABLE acessorios ADD idCategoria int AFTER id;

-- UPDATE acessorios SET idCategoria = 1 WHERE id = 1;

-- UPDATE acessorios SET idCategoria = 2 WHERE id = 2;

-- SELECT DISTINCT idCategoria AS categoria FROM acessorios;

-- SELECT SUM(preco) AS precoTotal FROM acessorios;

-- SELECT AVG(preco) AS precoMedio FROM acessorios;

-- SELECT * FROM acessorios WHERE id = 1;

-- DELETE FROM acessorios;

-- INSERT INTO acessorios (id, nome, preco) VALUES (1, 'Roda ABC', 15000);

-- INSERT INTO acessorios (id, nome, preco) VALUES (2, 'Aerofolio BCD', 7000);

-- INSERT INTO acessorios (id, nome, preco) VALUES (3, 'Escapamento CDE', 5000);

-- ALTER TABLE acessorios MODIFY id INT AUTO_INCREMENT PRIMARY KEY;

-- SELECT * FROM acessorios;

-- TRUNCATE acessorios;

-- INSERT INTO acessorios (id, nome, preco) VALUES (1, 'Roda ABC', 15000);

-- INSERT INTO acessorios (id, nome, preco) VALUES (2, 'Aerofolio BCD', 7000);

-- INSERT INTO acessorios (id, nome, preco) VALUES (3, 'Escapamento CDE', 5000);

-- SELECT * FROM acessorios;

-- DELETE FROM acessorios WHERE id = 1;

-- INSERT INTO acessorios (id, nome, preco) VALUES (1, 'Roda', 15000);

-- SELECT * FROM acessorios WHERE nome LIKE 'a%';

-- SELECT * FROM acessorios WHERE nome LIKE '%a';

-- SELECT * FROM acessorios WHERE nome LIKE '%a%';

-- SELECT * FROM acessorios WHERE nome NOT LIKE '%a%';

-- SELECT * FROM acessorios WHERE preco < 10000;

-- SELECT * FROM acessorios WHERE preco <= 10000;

-- SELECT * FROM acessorios WHERE preco > 10000;

-- SELECT * FROM acessorios WHERE preco >= 10000;

-- SELECT * FROM acessorios WHERE NOT nome = 'Roda';

-- SELECT * FROM acessorios WHERE nome <> 'Roda';

-- SELECT * FROM acessorios WHERE nome <> 'Roda' AND preco > 10000;

-- SELECT * FROM acessorios WHERE nome <> 'Roda' OR preco < 10000;

-- SELECT * FROM acessorios WHERE estoque IS null;

-- SELECT * FROM acessorios WHERE estoque IS NOT null;

-- SELECT * FROM acessorios WHERE id IN (2, 3);

-- SELECT * FROM acessorios WHERE id NOT IN (2, 3);

-- SELECT * FROM acessorios WHERE preco BETWEEN 5000 AND 15000;

-- INSERT INTO acessorios (id, nome, preco, estoque) VALUES (1, 'Roda', 15000, 4);

-- INSERT INTO acessorios (id, nome, preco, estoque) VALUES (2, 'Aerofolio', 7000, 15);

-- SELECT * FROM acessorios;

-- DELETE FROM acessorios WHERE id = 2;

-- ALTER TABLE acessorios MODIFY id INT AUTO_INCREMENT PRIMARY KEY;

-- ALTER TABLE acessorios ADD COLUMN status ENUM ('1', '0') NOT NULL DEFAULT '1';

SELECT * FROM acessorios WHERE nome like 'r%' OR nome like '%a';

SELECT * FROM acessorios WHERE nome like 'r%' OR preco > 7000;

INSERT INTO acessorios (nome, preco, estoque) VALUES
('Roda', 15000, 4),
('Aerofolio', 7000, 15),
('Cor Verde', 25000, 15);

SELECT status AS visivel FROM acessorios;

CREATE TABLE clientes (id int, nome varchar(255), email varchar(255));

ALTER TABLE clientes MODIFY id INT AUTO_INCREMENT PRIMARY KEY;

INSERT INTO clientes (nome, email) VALUES 
('John','john@gmail.com'),
('Mary','mary@gmail.com'),
('Peter','peter@gmail.com');

CREATE TABLE pedidos (id int, idCliente int, idAcessorio int, quantidade int, precoUnitario decimal(10,2), precoTotal decimal(10,2));

ALTER TABLE pedidos MODIFY id INT AUTO_INCREMENT PRIMARY KEY;

INSERT INTO pedidos (idCliente, idAcessorio, quantidade, precoUnitario, precoTotal) VALUES 
(1, 1, 10, 5000, 50000),
(1, 2, 2, 7000, 14000),
(2, 3, 2, 15000, 0),
(2, 4, 2, 0, 40000),
(1, 4, 0, 20000, 40000),
(2, 1, 10, 0, 0),
(null, 1, 10, 0, 0),
(1, null, 10, 0, 0);

UPDATE pedidos SET precoTotal = quantidade * precoUnitario WHERE quantidade > 0 AND precoUnitario > 0 AND precoTotal = 0;

UPDATE pedidos SET precoUnitario = precoTotal / quantidade WHERE quantidade > 0 AND precoTotal > 0 AND precoUnitario = 0;

UPDATE pedidos SET quantidade = precoTotal / precoUnitario WHERE precoTotal > 0 AND precoUnitario > 0 AND quantidade = 0;

UPDATE pedidos AS p SET precoUnitario = (SELECT preco FROM acessorios WHERE id = p.idAcessorio) WHERE precoUnitario = 0;

SELECT id, nome FROM acessorios a WHERE a.id IN (SELECT idAcessorio FROM pedidos);

-- Ilustração
-- https://www.w3schools.com/MySQL/mysql_join.asp

-- INNER acessorios
SELECT pedidos.id, acessorios.nome FROM pedidos
INNER JOIN acessorios ON pedidos.idAcessorio = acessorios.id;

-- LEFT acessorios
SELECT pedidos.id, acessorios.nome FROM pedidos
LEFT JOIN acessorios ON pedidos.idAcessorio = acessorios.id;

-- RIGHT acessorios
SELECT pedidos.id, acessorios.nome FROM pedidos
RIGHT JOIN acessorios ON pedidos.idAcessorio = acessorios.id;

-- Self join
SELECT pedidos.id, acessorios.nome
FROM pedidos, acessorios
WHERE pedidos.idAcessorio = acessorios.id;

-- Self join
SELECT p.id, a.nome
FROM pedidos as p, acessorios as a
WHERE p.idAcessorio = a.id;

-- Union
SELECT nome FROM clientes UNION SELECT nome FROM acessorios ORDER BY nome;

-- Union com alias
SELECT email as coluna1 FROM clientes UNION SELECT idCategoria as coluna1 FROM acessorios ORDER BY coluna1;

-- Group by

SELECT a.nome, count(*)
FROM pedidos p, acessorios a
WHERE p.idAcessorio = a.id
GROUP BY a.nome
ORDER BY count(*) DESC;

SELECT a.nome, count(*) as vendidos
FROM pedidos p, acessorios a
WHERE p.idAcessorio = a.id
GROUP BY a.nome
ORDER BY vendidos DESC;

-- View
CREATE VIEW acessorios_mais_vendidos AS
SELECT a.nome, count(*) as vendidos
FROM pedidos p, acessorios a
WHERE p.idAcessorio = a.id
GROUP BY a.nome
ORDER BY vendidos DESC;

DROP VIEW acessorios_mais_vendidos;

-- Case

UPDATE acessorios SET status = '0' WHERE id = 5;

SELECT nome,
CASE
    WHEN status = '1' THEN 'Ativado'
    ELSE 'Desativado'
END as status
FROM acessorios;

ALTER TABLE categorias ADD COLUMN status ENUM ('1', '0') NOT NULL DEFAULT '1';

ALTER TABLE pedidos ADD COLUMN status ENUM ('1', '0') NOT NULL DEFAULT '1';

ALTER TABLE categorias ADD COLUMN dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE acessorios ADD COLUMN dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE pedidos ADD COLUMN dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP;

-- Datas

SELECT NOW();

SELECT DATE_ADD("2024-09-10 19:00:00", INTERVAL 1 MONTH);
SELECT DATE_ADD("2024-09-10 19:00:00", INTERVAL 1 DAY);
SELECT DATE_ADD("2024-09-10 19:00:00", INTERVAL 1 HOUR);
SELECT DATE_ADD("2024-09-10 19:00:00", INTERVAL 1 MINUTE);
SELECT DATE_ADD("2024-09-10 19:00:00", INTERVAL 1 SECOND);

SELECT DATE_SUB("2024-09-10 19:00:00", INTERVAL 1 MONTH);
SELECT DATE_SUB("2024-09-10 19:00:00", INTERVAL 1 DAY);
SELECT DATE_SUB("2024-09-10 19:00:00", INTERVAL 1 HOUR);
SELECT DATE_SUB("2024-09-10 19:00:00", INTERVAL 1 MINUTE);
SELECT DATE_SUB("2024-09-10 19:00:00", INTERVAL 1 SECOND);

SELECT DATEDIFF("2024-09-10", "2023-09-10");
SELECT DATEDIFF("2024-09-10 19:00:00", "2024-01-01 00:00:00");

SELECT TIMEDIFF("13:10:11", "13:10:10");

SELECT DATE_FORMAT("2024-09-10", "%d/%m/%Y");

SELECT DATE_FORMAT(dataCadastro, "%d/%m/%Y") FROM pedidos;