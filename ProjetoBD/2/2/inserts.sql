INSERT INTO prateleira VALUES(3, 2, 'fabricante 2', 3.7, 'super categoria 3');
INSERT INTO prateleira VALUES(3, 2, 'fabricante 2', 3.8, 'super categoria 1');

INSERT INTO evento_reposicao VALUES(3333333333333, 3, 2, 'fabricante 2', '2000-03-02', 4, 3);
INSERT INTO planograma VALUES(3333333333333, 3, 2, 'fabricante 2', 4, 5, 'loc 2');


/*nao vai dar trigger*/
INSERT INTO evento_reposicao VALUES(3333333333333, 3, 2, 'fabricante 2', '2000-03-02', 4, 3);

/*vai dar trigger RI-4*/
INSERT INTO evento_reposicao VALUES(3333333333333, 3, 2, 'fabricante 2', '2000-03-02', 6, 3);

/*vai dar trigger RI-4*/
INSERT INTO evento_reposicao VALUES(3333333333333, 3, 3, 'fabricante 3', '2000-03-02', 4, 3);
