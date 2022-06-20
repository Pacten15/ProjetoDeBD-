INSERT INTO prateleira VALUES(1, 2, 'fabricante 2', 3.8, 'super categoria 1');
INSERT INTO prateleira VALUES(3, 2, 'fabricante 2', 3.8, 'super categoria 1');
INSERT INTO prateleira VALUES(5, 2, 'fabricante 2', 3.8, 'categoria simples 2');

INSERT INTO produto VALUES(1234567891011, 'categoria simples 2', 'descricao 5');

INSERT INTO planograma VALUES(1234567891011, 1, 2, 'fabricante 2', 3, 3, 'loc 4');
INSERT INTO planograma VALUES(1234567891011, 3, 3, 'fabricante 3', 3, 3, 'loc 8');
INSERT INTO planograma VALUES(1234567891011, 5, 2, 'fabricante 2', 3, 3, 'loc 8');
/*vai dar trigger RI-5*/
INSERT INTO evento_reposicao VALUES(1234567891011, 1, 2, 'fabricante 2', '2000-03-02', 3, 3);
INSERT INTO evento_reposicao VALUES(1234567891011, 3, 3, 'fabricante 3', '2000-03-02', 3, 3);
INSERT INTO evento_reposicao VALUES(1234567891011, 5, 2, 'fabricante 2', '2000-03-02', 3, 3);