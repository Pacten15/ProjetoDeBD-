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
INSERT INTO categoria VALUES('categoria 1');
INSERT INTO categoria VALUES('categoria 2');
INSERT INTO categoria VALUES('categoria 3');

INSERT INTO produto VALUES(1111111111111, 'categoria 1', 'descricao 1');
INSERT INTO produto VALUES(2222222222222, 'categoria 2', 'descricao 2');
INSERT INTO produto VALUES(3333333333333, 'categoria 3', 'descricao 3');

ALTER SEQUENCE IVM_num_serie_seq RESTART WITH 1; /* isto é estupido */
INSERT INTO IVM VALUES(DEFAULT /* 1 */, 'fabricante 1');
INSERT INTO IVM VALUES(DEFAULT /* 2 */, 'fabricante 2');
INSERT INTO IVM VALUES(DEFAULT /* 3 */, 'fabricante 3');

INSERT INTO prateleira VALUES(1, 1, 'fabricante 1', 1.1, 'categoria 1');
INSERT INTO prateleira VALUES(2, 2, 'fabricante 2', 2.2, 'categoria 2');
INSERT INTO prateleira VALUES(3, 3, 'fabricante 3', 3.3, 'categoria 3');

INSERT INTO planograma VALUES(1111111111111, 1, 1, 'fabricante 1', 1, 1, 'planograma 1');
INSERT INTO planograma VALUES(2222222222222, 2, 2, 'fabricante 2', 2, 2, 'planograma 2');
INSERT INTO planograma VALUES(3333333333333, 3, 3, 'fabricante 3', 3, 3, 'planograma 3');

ALTER SEQUENCE retalhista_tin_seq RESTART WITH 1; /* isto é estupido */
INSERT INTO retalhista VALUES(DEFAULT /* 1 */, 'retalhista 1');
INSERT INTO retalhista VALUES(DEFAULT /* 2 */, 'retalhista 2');
INSERT INTO retalhista VALUES(DEFAULT /* 3 */, 'retalhista 3');
SELECT * FROM retalhista;

INSERT INTO evento_reposicao VALUES(1111111111111, 1, 1, 'fabricante 1', '2001-01-01', 1, 1);
-- retalhista 1 faz mais que um evento de reposicao de um produto de outra categoria
INSERT INTO evento_reposicao VALUES(2222222222222, 2, 2, 'fabricante 2', '2001-01-02', 2, 1); 
INSERT INTO evento_reposicao VALUES(2222222222222, 2, 2, 'fabricante 2', '2002-02-02', 2, 2);
INSERT INTO evento_reposicao VALUES(3333333333333, 3, 3, 'fabricante 3', '2003-03-03', 3, 3);


--
-- query
--
SELECT name, COUNT(DISTINCT cat) as cou
FROM retalhista NATURAL JOIN evento_reposicao NATURAL JOIN produto
GROUP BY name
HAVING COUNT(*) >= ALL (
	SELECT COUNT(*)
    FROM retalhista NATURAL JOIN evento_reposicao NATURAL JOIN produto
    GROUP BY name);