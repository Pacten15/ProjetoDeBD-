-- retalhista 1 faz mais que um evento de reposicao de um produto de outra categoria

DELETE FROM evento_reposicao WHERE instante = '2001-01-02';
INSERT INTO evento_reposicao VALUES(2222222222222, 2, 2, 'fabricante 2', '2001-01-02', 2, 1);
