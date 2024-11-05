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

-- SELECT * FROM acessorios WHERE nome like 'r%' OR nome like '%a';

-- SELECT * FROM acessorios WHERE nome like 'r%' OR preco > 7000;

-- select *, status as visivel from acessorios;

-- SELECT nome, CASE WHEN status = '1' THEN 'Ativado' ELSE 'Desativado' END as status FROM acessorios;

-- CREATE TABLE clientes (id int, nome varchar(255), email varchar(255));

-- ALTER TABLE clientes MODIFY id INT AUTO_INCREMENT PRIMARY KEY;

-- INSERT INTO clientes (nome, email) VALUES ('John','john@gmail.com'), ('Mary','mary@gmail.com'),('Peter','peter@gmail.com');

-- CREATE TABLE pedidos (id int, idCliente int, idAcessorio int, quantidade int, precoUnitario decimal(10,2), precoTotal decimal(10,2));

-- ALTER TABLE pedidos MODIFY id INT AUTO_INCREMENT PRIMARY KEY;

-- INSERT INTO pedidos (idCliente, idAcessorio, quantidade, precoUnitario, precoTotal) VALUES 
-- (1, 1, 10, 5000, 50000),
-- (1, 2, 2, 7000, 14000),
-- (2, 3, 2, 15000, 0),
-- (2, 4, 2, 0, 40000),
-- (1, 4, 0, 20000, 40000),
-- (2, 1, 10, 0, 0),
-- (null, 1, 10, 0, 0),
-- (1, null, 10, 0, 0);

-- Como atualizar precoTotal na tabela pedidos
-- UPDATE pedidos SET precoTotal = quantidade * precoUnitario WHERE quantidade > 0 AND precoUnitario > 0 AND precoTotal = 0;

-- Como atualizar precoUnitario na tabela pedidos
-- UPDATE pedidos SET precoUnitario = precoTotal / quantidade WHERE quantidade > 0 AND precoTotal > 0 AND precoUnitario = 0;

-- Como atualizar quantidade na tabela pedidos
-- UPDATE pedidos SET quantidade = precoTotal / precoUnitario WHERE precoTotal > 0 AND precoUnitario > 0 AND quantidade = 0;

-- Como atualizar precoUnitario na tabela pedidos
-- UPDATE pedidos AS p SET precoUnitario = (SELECT preco FROM acessorios WHERE id = p.idAcessorio) WHERE precoUnitario = 0;

-- Lista apenas os acessórios que foram comprados
-- SELECT id, nome FROM acessorios a WHERE a.id IN (SELECT idAcessorio FROM pedidos);

-- Ilustração
-- https://www.w3schools.com/MySQL/mysql_join.asp

-- INNER acessorios
-- SELECT pedidos.id, acessorios.nome, pedidos.quantidade 
-- FROM pedidos INNER JOIN acessorios ON pedidos.idAcessorio = acessorios.id;

-- LEFT acessorios
-- SELECT pedidos.id, acessorios.nome FROM pedidos
-- LEFT JOIN acessorios ON pedidos.idAcessorio = acessorios.id;

-- RIGHT acessorios
-- SELECT pedidos.id, acessorios.nome FROM pedidos
-- RIGHT JOIN acessorios ON pedidos.idAcessorio = acessorios.id;

-- Self join
-- SELECT pedidos.id, acessorios.nome
-- FROM pedidos, acessorios
-- WHERE pedidos.idAcessorio = acessorios.id;

-- Self join abreviado
-- SELECT p.id, a.nome
-- FROM pedidos as p, acessorios as a
-- WHERE p.idAcessorio = a.id;

-- Union
-- SELECT nome FROM clientes 
-- UNION
-- SELECT nome FROM acessorios
-- ORDER BY nome;

-- Union com alias
-- SELECT email as coluna1 FROM clientes UNION SELECT idCategoria as coluna1 FROM acessorios ORDER BY coluna1;

-- Group by

-- SELECT a.nome, count(*)
-- FROM pedidos p, acessorios a
-- WHERE p.idAcessorio = a.id
-- GROUP BY a.nome
-- ORDER BY count(*) DESC;

-- SELECT a.nome, count(*) as vendidos
-- FROM pedidos p, acessorios a
-- WHERE p.idAcessorio = a.id
-- GROUP BY a.nome
-- ORDER BY vendidos DESC;

-- View
-- CREATE VIEW acessorios_mais_vendidos AS
-- SELECT a.nome, count(*) as vendidos
-- FROM pedidos p, acessorios a
-- WHERE p.idAcessorio = a.id
-- GROUP BY a.nome
-- ORDER BY vendidos DESC;

-- Executa a view
-- SELECT * FROM acessorios_mais_vendidos;

-- Lista todas as views criadas no banco
-- SELECT table_name AS view_name FROM information_schema.views WHERE table_schema = 'projetox';

-- Apaga a view
-- DROP VIEW acessorios_mais_vendidos;

-- Adicionando coluna status

-- ALTER TABLE categorias ADD COLUMN status ENUM ('1', '0') NOT NULL DEFAULT '1';

-- ALTER TABLE pedidos ADD COLUMN status ENUM ('1', '0') NOT NULL DEFAULT '1';

-- Adicionando coluna para data de cadastro

-- ALTER TABLE categorias ADD COLUMN dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP;

-- ALTER TABLE acessorios ADD COLUMN dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP;

--ALTER TABLE pedidos ADD COLUMN dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP;

-- Datas

-- SELECT NOW();

-- SELECT DATE_ADD("2024-09-10 19:00:00", INTERVAL 1 MONTH);
-- SELECT DATE_ADD("2024-09-10 19:00:00", INTERVAL 1 DAY);
-- SELECT DATE_ADD("2024-09-10 19:00:00", INTERVAL 1 HOUR);
-- SELECT DATE_ADD("2024-09-10 19:00:00", INTERVAL 1 MINUTE);
-- SELECT DATE_ADD("2024-09-10 19:00:00", INTERVAL 1 SECOND);

-- SELECT DATE_SUB("2024-09-10 19:00:00", INTERVAL 1 MONTH);
-- SELECT DATE_SUB("2024-09-10 19:00:00", INTERVAL 1 DAY);
-- SELECT DATE_SUB("2024-09-10 19:00:00", INTERVAL 1 HOUR);
-- SELECT DATE_SUB("2024-09-10 19:00:00", INTERVAL 1 MINUTE);
-- SELECT DATE_SUB("2024-09-10 19:00:00", INTERVAL 1 SECOND);

-- SELECT DATEDIFF("2024-09-10", "2023-09-10");
-- SELECT DATEDIFF("2024-09-10 19:00:00", "2024-01-01 00:00:00");

-- SELECT TIMEDIFF("13:10:11", "13:10:10");

-- SELECT DATE_FORMAT("2024-09-10", "%d/%m/%Y");

-- SELECT DATE_FORMAT(dataCadastro, "%d/%m/%Y") FROM pedidos;

-- Clonar a estrutura de outra tabela
-- CREATE TABLE clientes_temp LIKE clientes;

-- Copia todos os dados de todas as colunas de uma tabela para outra
-- INSERT INTO clientes_temp SELECT * FROM clientes

-- Copia dados de colunas específicas de uma tabela para outra
-- INSERT INTO clientes2 (nome, email) SELECT nome, email FROM clientes;

-- Clonar a estrutura e dados de outra tabela
-- CREATE TABLE clientes_temp
-- AS
-- SELECT * 
-- FROM clientes;

-- Clonar a estrutura e os valores distintos da coluna de outra tabela
-- CREATE TABLE clientes_temp
-- SELECT DISTINCT email
-- FROM clientes;

-- Adicionar uma constraint para evitar a exclusão acidental de uma categoria vinculada a um acessorio
-- ALTER TABLE acessorios
-- ADD CONSTRAINT idCategoria
-- FOREIGN KEY (idCategoria) 
-- REFERENCES categorias(id) 
-- ON DELETE RESTRICT 
-- ON UPDATE RESTRICT;

-- Exibe o código de criação da tabela para descobrir o nome da constraint
-- SHOW CREATE TABLE acessorios;

-- Remove a constraint da tabela
-- ALTER TABLE acessorios DROP FOREIGN KEY idCategoria;

-- Adiciona coluna cpf na tabela clientes
-- ALTER TABLE clientes ADD COLUMN cpf VARCHAR(255) DEFAULT NULL;

-- Limpa a tabela clientes
-- TRUNCATE clientes;

-- Adiciona vários clientes aleatórios
-- http://localhost/automacoes/gera-clientes-randomicos
/*
insert into `clientes` (`nome`, `email`, `cpf`) values ('Pato Savi','bago.savi@hotmail.com','49 5.809535-77');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Lato Funo','pofu.lipo@outlook.com','.2731927284 10');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Fulo Pala','gura.rago@yahoo.com','6211813.414317');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Topa Guto','gola.lira@outlook.com','0-67723702. 07');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Bapo Liba','ramo.topo@email.com','09.45 7733469-');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Popo Fuvi','lisa.gono@outlook.com','432430 5.-9844');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Lalo Ramu','novi.fugo@outlook.com','90838227471892');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Pofu Toli','popa.visa@outlook.com','78085.4361191 ');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Mupa Baba','lisa.poto@outlook.com',' 0701.797366-7');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Pamu Para','muto.fugu@hotmail.com','2.08821 029774');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Ralo Rago','lovi.logu@yahoo.com','97.90299129887');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Gogo Noba','lomo.pora@outlook.com','816.-3032 5841');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Fugo Basa','guto.papa@outlook.com','48583.680954 2');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Nomo Rapo','lono.viba@hotmail.com','66172002004818');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Samu Pagu','lano.moli@yahoo.com','00505758381779');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Mola Lavi','tomo.salo@outlook.com','7-644 6.869720');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Sasa Gusa','goli.musa@email.com','-858029.3 7073');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Goto Mupo','loli.mupa@gmail.com','35295329 38-.1');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Vito Tola','gugu.visa@yahoo.com','876.2983201498');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Lapa Gugo','topa.mufu@email.com','487546107777.3');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Mugu Rara','mono.lomo@gmail.com','92053.93979875');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Toli Tola','gupo.fuvi@hotmail.com','05 84403616.94');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Futo Sago','mugu.poli@yahoo.com','17. 3711775806');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Nogo Bago','lopa.sano@email.com','.48541 42-9003');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Pogu Topo','momu.fusa@email.com','22544626 158.6');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Mopa Mupo','nogu.gopo@email.com','-3168008 568.3');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Lala Lino','mopa.funo@yahoo.com','92992188236278');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Mola Paba','bavi.vigo@outlook.com','649001 865.452');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Nofu Bapo','lolo.gugu@gmail.com','558.1328635459');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Laba Pafu','lipa.poto@gmail.com','8863 354.85629');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Paba Guto','lila.sapo@outlook.com','4. 13879727549');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Savi Fusa','mupa.poto@yahoo.com','62514795837210');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Sagu Mugo','molo.posa@hotmail.com','04087833440424');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Vilo Rato','noba.vimu@outlook.com','936.8079988693');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Mofu Goli','rara.pomu@hotmail.com','8922 5-926.447');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Fura Lapo','lino.pamu@hotmail.com','006 725-.38686');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Nosa Gofu','saba.popo@outlook.com','62780. 2331-95');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Topa Liba','sara.vivi@yahoo.com','68209326740067');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Poto Gola','rafu.viba@hotmail.com','9793 15-451.82');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Ralo Raba','tola.lagu@outlook.com',' 032996705586.');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Lasa Ravi','mulo.rala@hotmail.com','330.2489458564');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Mopa Rano','rasa.vigo@gmail.com','7444744.840312');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Gono Visa','bavi.balo@gmail.com','56971740396589');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Mulo Noba','nono.vigu@hotmail.com','15615536336496');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Pago Vipo','bano.lamo@outlook.com','71361860386176');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Pora Vigu','lafu.lara@gmail.com','51791 5.8-9311');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Losa Safu','bano.toba@gmail.com','34 2.640-35473');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Gora Mura','sasa.goli@email.com','72827111356242');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Pamo Gora','lasa.rano@email.com','.2 24344866785');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Lapo Papo','vigo.polo@gmail.com','64890. 616-749');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Gomu Mupa','muli.para@hotmail.com','5.1-1 06905016');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Noto Mono','saba.lano@hotmail.com','18.3042 112883');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Pamu Pago','sano.savi@email.com','15974816703207');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Salo Vila','polo.sara@yahoo.com','71802717062324');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Vivi Mumu','lapo.gomo@outlook.com',' 1-0366650302.');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Pano Ligu','poli.pavi@hotmail.com','11985149715.66');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Sara Tolo','mofu.ramo@yahoo.com','9133703066.59 ');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Mosa Tora','lifu.polo@outlook.com','08927727824680');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Mulo Noto','momu.lato@yahoo.com','0 31999.86-753');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Moto Gofu','moto.rafu@yahoo.com','76552500284163');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Lipa Nopa','mopo.lara@yahoo.com','1.6 7539624618');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Novi Mula','bamu.lira@gmail.com','40227149877835');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Lamu Sato','raba.vipo@email.com','28.33352698920');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Fugo Vifu','bamu.popa@yahoo.com','3-874. 5459246');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Mosa Gumo','savi.pala@outlook.com','.735179-08 143');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Vimo Laba','tovi.rala@hotmail.com','7893841874.574');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Mogo Pali','mugu.rala@outlook.com','85775219925317');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Topo Guli','loba.momu@outlook.com','937387.5320044');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Popa Pogo','bavi.popo@gmail.com','803 63571417.3');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Pano Muto','mono.bamo@outlook.com','6 85010533.-39');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Molo Bamu','pomo.pago@gmail.com','46484730594.20');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Gomu Sano','mupa.gogo@email.com','87810750812726');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Mopo Mono','sapo.mugu@yahoo.com','38795057676846');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Bafu Mumo','gola.gula@outlook.com','22939.51-7 054');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Lavi Gofu','loba.guli@gmail.com','365.9 61296999');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Palo Sali','bala.goto@email.com','3.959315760184');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Lili Pago','gumo.mugo@outlook.com','447-5.2091 766');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Lila Muvi','gura.lifu@gmail.com','595118388.7002');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Lino Pavi','palo.pasa@yahoo.com','33611115.53822');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Lopa Mopo','bano.fugo@gmail.com','79860958015266');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Lafu Vimo','mupa.pofu@gmail.com','3858203965291.');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Polo Sapo','lito.saba@outlook.com','573 5489.62562');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Bala Toto','rano.samo@gmail.com','13636150981759');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Tosa Mofu','tosa.viba@hotmail.com','041.0953771978');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Rali Bamu','fugo.fuli@hotmail.com','1936 854825.48');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Sara Lofu','guvi.novi@hotmail.com','46987337657018');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Rara Gomu','safu.vimo@outlook.com','44232251.1-06 ');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Gogo Mugu','momu.ligu@gmail.com','33438.3212-21 ');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Raba Nopa','rapa.fuvi@yahoo.com','4908406322808.');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Mugo Rali','sato.mogo@gmail.com','6. 14936-94783');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Futo Mola','goto.gopo@email.com',' -12.022622323');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Lomu Pogu','ramu.tovi@email.com','3327-3 623.371');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Popa Gupo','moto.goto@hotmail.com','422287968483.8');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Mulo Pafu','vino.togo@gmail.com',' 113.295689166');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Pagu Sano','tofu.nono@outlook.com','233270.7155111');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Bapa Lifu','golo.lora@gmail.com','11016.580481 -');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Lomo Poli','salo.gumo@gmail.com','79094.86 06180');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Pagu Goli','liba.guno@email.com','53446895417070');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Goba Musa','rasa.bapo@yahoo.com','400.246-92 735');
insert into `clientes` (`nome`, `email`, `cpf`) values ('Noli Savi','lisa.gufu@hotmail.com','42512.73325548');
*/

-- Explicação da criação da função
-- https://docs.google.com/document/d/1JkEzOk288hLoN-Q3yCd1QfDMC37LqJe1ALuA_zojWgo/edit

-- Função personalizada para formatar os valores da coluna CPF

DELIMITER //

CREATE FUNCTION formatar_cpf(numero VARCHAR(14)) RETURNS VARCHAR(14)
DETERMINISTIC
BEGIN

    DECLARE cpf VARCHAR(14);
    
    -- Remover pontos, espaços e hífens
    SET cpf = REPLACE(numero, '.', '');
    SET cpf = REPLACE(cpf, '-', '');
    SET cpf = REPLACE(cpf, ' ', '');
    
    -- Preencher com zeros à esquerda se for menor que 11 caracteres
    SET cpf = LPAD(cpf, 11, '0');
    
    -- Formatar o CPF no formato XXX.XXX.XXX-XX
    SET cpf = CONCAT(
        SUBSTRING(cpf, 1, 3),
        '.',
        SUBSTRING(cpf, 4, 3),
        '.',
        SUBSTRING(cpf, 7, 3),
        '-',
        SUBSTRING(cpf, 10, 2)
    );
    
    RETURN cpf;
END //

DELIMITER ;

-- Listar todas as funções criadas
-- SELECT ROUTINE_NAME, ROUTINE_SCHEMA, ROUTINE_TYPE FROM information_schema.ROUTINES WHERE ROUTINE_TYPE = 'FUNCTION';

-- Exibe o script da função
/*
SELECT ROUTINE_DEFINITION
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_SCHEMA = 'projetox' AND ROUTINE_NAME = 'formatar_cpf' AND ROUTINE_TYPE = 'FUNCTION';
*/

-- Apagar uma função
-- DROP FUNCTION IF EXISTS formatar_cpf;

-- Listar os clientes com CPF formatado
-- SELECT *, formatar_cpf(cpf) FROM clientes;

-- Atualizar os clientes com CPF formatado
-- UPDATE clientes SET cpf = formatar_cpf(cpf);

-- Trigger

/*
DELIMITER //
 CREATE TRIGGER `atualiza_estoque_do_acessorio` AFTER INSERT ON `pedidos`
 FOR EACH ROW BEGIN
    UPDATE acessorios
    SET estoque = estoque - NEW.quantidade
    WHERE id = NEW.idAcessorio;
END //

DELIMITER ;
*/

-- Inserindo um acessorio na tabela pedidos para testar a trigger que atualiza o estoque
-- INSERT INTO pedidos (idCliente, idAcessorio, quantidade, precoUnitario, precoTotal) VALUES (1,1,2,5000,10000);

-- Lista as triggers criadas
-- SHOW triggers;

-- Exibe o script da trigger
/*
SELECT ACTION_STATEMENT
FROM INFORMATION_SCHEMA.TRIGGERS
WHERE TRIGGER_SCHEMA = 'projetox' AND TRIGGER_NAME = 'atualiza_estoque_do_acessorio';
*/

-- Remove a trigger
-- DROP TRIGGER atualiza_estoque_do_acessorio;

-- Cria uma procedure que ajusta o estoque dos produtos

/*
DELIMITER //

CREATE PROCEDURE atualizar_estoque_acessorios()
BEGIN
    UPDATE acessorios a
    JOIN (
        SELECT idAcessorio, SUM(quantidade) AS total_vendido
        FROM pedidos
        GROUP BY idAcessorio
    ) p ON a.id = p.idAcessorio
    SET a.estoque = a.estoque - p.total_vendido;
END //

DELIMITER ;
*/

-- Reset no estoque antes de testar a procedure
-- UPDATE acessorios SET estoque = 100;

-- Executando a procedure
-- CALL atualizar_estoque_acessorios();

-- Lista todas as procedures
-- SHOW PROCEDURE STATUS;

-- Exibe o código da procedure
-- SHOW CREATE PROCEDURE atualizar_estoque_acessorios;

-- Apaga a procedure
-- DROP PROCEDURE IF EXISTS atualizar_estoque_acessorios;

-- Garante que a coluna email seja única, não haja valores duplicados
-- ALTER TABLE clientes ADD CONSTRAINT unique_email UNIQUE (email);

-- Remove CONSTRAINT UNIQUE
-- ALTER TABLE clientes DROP INDEX unique_email;