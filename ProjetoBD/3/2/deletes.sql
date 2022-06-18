DELETE FROM responsavel_por WHERE num_serie = 4 AND fabricante = 'fabricante SQL-2 1';
DELETE FROM responsavel_por WHERE num_serie = 5 AND fabricante = 'fabricante SQL-2 2';

DELETE FROM planograma WHERE ean = 3333333333331 AND nro = 4 AND num_serie = 4 AND fabricante = 'fabricante SQL-2 1';
DELETE FROM planograma WHERE ean = 3333333333332 AND nro = 5 AND num_serie = 5 AND fabricante = 'fabricante SQL-2 2';

DELETE FROM prateleira WHERE nro = 4;
DELETE FROM prateleira WHERE nro = 5;

DELETE FROM instalada_em WHERE num_serie = 4 AND fabricante = 'fabricante SQL-2 1';
DELETE FROM instalada_em WHERE num_serie = 5 AND fabricante = 'fabricante SQL-2 2';

DELETE FROM ponto_de_retalho WHERE nome = 'ponto de retalho SQL-2 1';
DELETE FROM ponto_de_retalho WHERE nome = 'ponto de retalho SQL-2 2';

DELETE FROM IVM WHERE num_serie = 4 AND fabricante = 'fabricante SQL-2 1';
DELETE FROM IVM WHERE num_serie = 5 AND fabricante = 'fabricante SQL-2 2';

DELETE FROM tem_categoria WHERE ean = 3333333333331 AND nome = 'categoria simples 2';
DELETE FROM tem_categoria WHERE ean = 3333333333332 AND nome = 'categoria simples 3';

DELETE FROM produto WHERE ean = 3333333333331;
DELETE FROM produto WHERE ean = 3333333333332;
