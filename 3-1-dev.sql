--
-- deletes pela ordem correta
--
DELETE FROM evento_reposicao;
DELETE FROM retalhista;
DELETE FROM planograma;
DELETE FROM prateleira;
DELETE FROM IVM;
DELETE FROM produto;
DELETE FROM categoria;

-- 
-- inserts pela ordem correta
--

-- nao "precisa"
DELETE FROM categoria;
INSERT INTO categoria VALUES('categoria 1');
INSERT INTO categoria VALUES('categoria 2');
INSERT INTO categoria VALUES('categoria 3');
SELECT * FROM categoria;

-- "precisa" de categoria
DELETE FROM produto;
INSERT INTO produto VALUES(1111111111111, 'categoria 1', 'descricao 1');
INSERT INTO produto VALUES(2222222222222, 'categoria 2', 'descricao 2');
INSERT INTO produto VALUES(3333333333333, 'categoria 3', 'descricao 3');
SELECT * FROM produto;

-- nao "precisa"
DELETE FROM IVM;
ALTER SEQUENCE IVM_num_serie_seq RESTART WITH 1; /* isto é estupido */
INSERT INTO IVM VALUES(DEFAULT /* 1 */, 'fabricante 1');
INSERT INTO IVM VALUES(DEFAULT /* 2 */, 'fabricante 2');
INSERT INTO IVM VALUES(DEFAULT /* 3 */, 'fabricante 3');
SELECT * FROM IVM;

-- "precisa" de IVM e categoria
DELETE FROM prateleira;
INSERT INTO prateleira VALUES(1, 1, 'fabricante 1', 1.1, 'categoria 1');
INSERT INTO prateleira VALUES(2, 2, 'fabricante 2', 2.2, 'categoria 2');
INSERT INTO prateleira VALUES(3, 3, 'fabricante 3', 3.3, 'categoria 3');
SELECT * FROM prateleira;

-- [JATURAL JOIN] "precisa" de produto e prateleira 
DELETE FROM planograma;
INSERT INTO planograma VALUES(1111111111111, 1, 1, 'fabricante 1', 1, 1, 'planograma 1');
INSERT INTO planograma VALUES(2222222222222, 2, 2, 'fabricante 2', 2, 2, 'planograma 2');
INSERT INTO planograma VALUES(3333333333333, 3, 3, 'fabricante 3', 3, 3, 'planograma 3');
SELECT * FROM planograma;

-- [NATURAL JOIN] nao "precisa"
DELETE FROM retalhista;
ALTER SEQUENCE retalhista_tin_seq RESTART WITH 1; /* isto é estupido */
INSERT INTO retalhista VALUES(DEFAULT /* 1 */, 'retalhista 1');
INSERT INTO retalhista VALUES(DEFAULT /* 2 */, 'retalhista 2');
INSERT INTO retalhista VALUES(DEFAULT /* 3 */, 'retalhista 3');
SELECT * FROM retalhista;

-- [NATURAL JOIN] "precisa" de planograma e retalhista
DELETE FROM evento_reposicao;
INSERT INTO evento_reposicao VALUES(1111111111111, 1, 1, 'fabricante 1', '2001-01-01', 1, 1);
INSERT INTO evento_reposicao VALUES(2222222222222, 2, 2, 'fabricante 2', '2002-02-02', 2, 2);
INSERT INTO evento_reposicao VALUES(3333333333333, 3, 3, 'fabricante 3', '2003-03-03', 3, 3);
SELECT * FROM evento_reposicao;

--
-- query
--

-- 3-1
-- Qual o nome do retalhista (ou retalhistas) responsáveis pela reposição do maior número de
-- categorias?
SELECT name, COUNT(DISTINCT cat) as cou
FROM retalhista NATURAL JOIN evento_reposicao NATURAL JOIN produto
GROUP BY name
HAVING COUNT(*) >= ALL (
	SELECT COUNT(*)
    FROM retalhista NATURAL JOIN evento_reposicao NATURAL JOIN produto
    GROUP BY name);
