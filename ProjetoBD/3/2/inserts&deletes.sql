-- o 1.2-inserts.sql tem 1 retalhista a uma so categoria
-- vou agora fazer o retalhista 1 responsavel por todas as categorias simples, i.e. a 2 e a 3

DELETE FROM produto WHERE ean = 3333333333331;
DELETE FROM produto WHERE ean = 3333333333332;
INSERT INTO produto VALUES(3333333333331, 'categoria simples 2', 'SQL-2 cat simples 2');
INSERT INTO produto VALUES(3333333333332, 'categoria simples 3', 'SQL-2 cat simples 3');

DELETE FROM tem_categoria WHERE ean = 3333333333331 AND nome = 'categoria simples 2';
DELETE FROM tem_categoria WHERE ean = 3333333333332 AND nome = 'categoria simples 3';
INSERT INTO tem_categoria VALUES(3333333333331, 'categoria simples 2');
INSERT INTO tem_categoria VALUES(3333333333332, 'categoria simples 3');

DELETE FROM IVM WHERE num_serie = 4 AND fabricante = 'fabricante SQL-2 1';
DELETE FROM IVM WHERE num_serie = 5 AND fabricante = 'fabricante SQL-2 2';
INSERT INTO IVM VALUES(4, 'fabricante SQL-2 1');
INSERT INTO IVM VALUES(5, 'fabricante SQL-2 2');

DELETE FROM ponto_de_retalho WHERE nome = 'ponto de retalho SQL-2 1';
DELETE FROM ponto_de_retalho WHERE nome = 'ponto de retalho SQL-2 2';
INSERT INTO ponto_de_retalho VALUES('ponto de retalho SQL-2 1', 'distrito SQL-2 1', 'conselho SQL-2 1');
INSERT INTO ponto_de_retalho VALUES('ponto de retalho SQL-2 2', 'distrito SQL-2 2', 'conselho SQL-2 2');

DELETE FROM instalada_em WHERE num_serie = 4 AND fabricante = 'fabricante SQL-2 1';
DELETE FROM instalada_em WHERE num_serie = 5 AND fabricante = 'fabricante SQL-2 2';
INSERT INTO instalada_em VALUES(4, 'fabricante SQL-2 1', 'ponto de retalho SQL-2 1');
INSERT INTO instalada_em VALUES(5, 'fabricante SQL-2 2', 'ponto de retalho SQL-2 2');

DELETE FROM prateleira WHERE nro = 4;
DELETE FROM prateleira WHERE nro = 5;
INSERT INTO prateleira VALUES(4, 4, 'fabricante SQL-2 1', 4.4, 'categoria simples 2');
INSERT INTO prateleira VALUES(5, 5, 'fabricante SQL-2 2', 5.5, 'categoria simples 3');

DELETE FROM planograma WHERE ean = 3333333333331 AND nro = 4 AND num_serie = 4 AND fabricante = 'fabricante SQL-2 1';
DELETE FROM planograma WHERE ean = 3333333333332 AND nro = 5 AND num_serie = 5 AND fabricante = 'fabricante SQL-2 2';
INSERT INTO planograma VALUES(3333333333331, 4, 4, 'fabricante SQL-2 1', 4, 4, 'loc SQL-2 1');
INSERT INTO planograma VALUES(3333333333332, 5, 5, 'fabricante SQL-2 2', 5, 5, 'loc SQL-2 2');

DELETE FROM responsavel_por WHERE num_serie = 4 AND fabricante = 'fabricante SQL-2 1';
DELETE FROM responsavel_por WHERE num_serie = 5 AND fabricante = 'fabricante SQL-2 2';
INSERT INTO responsavel_por VALUES('categoria simples 2', 1, 4, 'fabricante SQL-2 1');
INSERT INTO responsavel_por VALUES('categoria simples 3', 1, 5, 'fabricante SQL-2 2');
