-- cd C:\xampp7433-2\mysql\bin>

-- mysql -u root;

CREATE DATABASE projetox;

SHOW DATABASES;

DROP DATABASE projetox;

CREATE DATABASE projetox;

USE projetox;

CREATE TABLE acessorios (
    id int,
    nome varchar(255),
    preco decimal(10,2)
);

SHOW tables;

DROP TABLE acessorios;

CREATE TABLE acessorios (
    id int,
    nome varchar(255),
    preco decimal(10,2)
);

DESC acessorios;

INSERT INTO acessorios (id, nome, preco)
VALUES (1, 'Roda', 15000);

INSERT INTO acessorios (id, nome, preco)
VALUES (2, 'Aerofolio', 7000);

ALTER TABLE acessorios
ADD estoque int;

UPDATE acessorios SET estoque = 10;

SELECT * FROM acessorios;

SELECT * FROM acessorios ORDER BY preco;

SELECT * FROM acessorios ORDER BY preco ASC;

SELECT * FROM acessorios ORDER BY preco ASC, nome ASC;

SELECT * FROM acessorios ORDER BY preco DESC;

SELECT * FROM acessorios LIMIT 1;

SELECT MIN(preco) FROM acessorios;

SELECT MAX(preco) FROM acessorios;

SELECT COUNT(*) AS total FROM acessorios;

SELECT AVG(preco) AS precoMedio FROM acessorios;

SELECT SUM(preco) AS precoMedio FROM acessorios;

SELECT * FROM acessorios WHERE nome LIKE 'a%';

SELECT * FROM acessorios WHERE nome LIKE '%a';

SELECT * FROM acessorios WHERE nome LIKE '%a%';

SELECT * FROM acessorios WHERE id = 1;

SELECT * FROM acessorios WHERE preco < 10000;

SELECT * FROM acessorios WHERE preco <= 10000;

SELECT * FROM acessorios WHERE preco > 10000;

SELECT * FROM acessorios WHERE preco >= 10000;

SELECT * FROM acessorios WHERE NOT nome = 'Roda';

SELECT * FROM acessorios WHERE nome <> 'Roda';

SELECT * FROM acessorios WHERE nome <> 'Roda' AND preco > 10000;

SELECT * FROM acessorios WHERE nome <> 'Roda' OR preco < 10000;

SELECT * FROM acessorios WHERE estoque IS null;

SELECT * FROM acessorios WHERE estoque IS NOT null;

SELECT * FROM acessorios WHERE id IN (2, 3);

SELECT * FROM acessorios WHERE id NOT IN (2, 3);

SELECT * FROM acessorios WHERE preco BETWEEN 5000 AND 15000;

DELETE FROM acessorios;

INSERT INTO acessorios (id, nome, preco, estoque)
VALUES (1, 'Roda', 15000, 4);

INSERT INTO acessorios (id, nome, preco, estoque)
VALUES (2, 'Aerofolio', 7000, 15);

SELECT * FROM acessorios;

DELETE FROM acessorios WHERE id = 2;

SELECT MAX(id) FROM acessorios;

INSERT INTO acessorios (id, nome, preco, estoque)
VALUES (3, 'Cor Verde', 25000, 15);

DESC acessorios;

-- Constraints - Usadas para especificar uma regras para um dado em uma tabela

ALTER TABLE acessorios
MODIFY id INT AUTO_INCREMENT PRIMARY KEY;

DESC acessorios;

INSERT INTO acessorios (nome, preco, estoque)
VALUES 
('Roda', 15000, 4),
('Aerofolio', 7000, 15),
('Cor Verde', 25000, 15);

SELECT * FROM acessorios;

ALTER TABLE acessorios MODIFY id INT;

ALTER TABLE acessorios DROP PRIMARY KEY;

DESC acessorios;

DELETE FROM acessorios;

INSERT INTO acessorios (nome, preco, estoque)
VALUES 
('Roda', 15000, 4),
('Aerofolio', 7000, 15),
('Cor Verde', 25000, 15);

TRUNCATE acessorios;

ALTER TABLE acessorios
MODIFY id INT AUTO_INCREMENT PRIMARY KEY;

INSERT INTO acessorios (nome, preco, estoque)
VALUES 
('Roda', 15000, 4),
('Aerofolio', 7000, 15),
('Cor Verde', 25000, 15);

SELECT * FROM acessorios;

ALTER TABLE acessorios
ADD COLUMN status ENUM('1', '0') NOT NULL DEFAULT '1';