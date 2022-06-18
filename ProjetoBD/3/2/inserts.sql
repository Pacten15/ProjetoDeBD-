INSERT INTO produto VALUES(3333333333331, 'categoria simples 2', 'SQL-2 cat simples 2');
INSERT INTO produto VALUES(3333333333332, 'categoria simples 3', 'SQL-2 cat simples 3');

INSERT INTO tem_categoria VALUES(3333333333331, 'categoria simples 2');
INSERT INTO tem_categoria VALUES(3333333333332, 'categoria simples 3');

INSERT INTO IVM VALUES(4, 'fabricante SQL-2 1');
INSERT INTO IVM VALUES(5, 'fabricante SQL-2 2');

INSERT INTO ponto_de_retalho VALUES('ponto de retalho SQL-2 1', 'distrito SQL-2 1', 'conselho SQL-2 1');
INSERT INTO ponto_de_retalho VALUES('ponto de retalho SQL-2 2', 'distrito SQL-2 2', 'conselho SQL-2 2');

INSERT INTO instalada_em VALUES(4, 'fabricante SQL-2 1', 'ponto de retalho SQL-2 1');
INSERT INTO instalada_em VALUES(5, 'fabricante SQL-2 2', 'ponto de retalho SQL-2 2');

INSERT INTO prateleira VALUES(4, 4, 'fabricante SQL-2 1', 4.4, 'categoria simples 2');
INSERT INTO prateleira VALUES(5, 5, 'fabricante SQL-2 2', 5.5, 'categoria simples 3');

INSERT INTO planograma VALUES(3333333333331, 4, 4, 'fabricante SQL-2 1', 4, 4, 'loc SQL-2 1');
INSERT INTO planograma VALUES(3333333333332, 5, 5, 'fabricante SQL-2 2', 5, 5, 'loc SQL-2 2');

INSERT INTO responsavel_por VALUES('categoria simples 2', 1, 4, 'fabricante SQL-2 1');
INSERT INTO responsavel_por VALUES('categoria simples 3', 1, 5, 'fabricante SQL-2 2');
