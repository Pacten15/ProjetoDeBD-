-- colocar um evento de reposicao do primeiro produto pelo segundo retalhista

DELETE FROM evento_reposicao WHERE ean = 1111111111111 AND nro = 1 AND num_serie = 1 AND fabricante = 'fabricante 1' AND instante = '2022-01-01';
INSERT INTO evento_reposicao VALUES(1111111111111, 1, 1, 'fabricante 1', '2022-01-01', 1, 2);
