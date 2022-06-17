DELETE FROM evento_reposicao;
DELETE FROM responsavel_por;
DELETE FROM retalhista;
DELETE FROM planograma;
DELETE FROM prateleira;
DELETE FROM instalada_em;
DELETE FROM ponto_de_retalho;
DELETE FROM IVM;
DELETE FROM tem_categoria;
DELETE FROM produto;
DELETE FROM tem_outra;
DELETE FROM super_categoria;
DELETE FROM categoria_simples;
DELETE FROM categoria;

INSERT INTO categoria VALUES('categoria simples 1');
INSERT INTO categoria VALUES('categoria simples 2');
INSERT INTO categoria VALUES('categoria simples 3');
INSERT INTO categoria VALUES('super categoria 1');
INSERT INTO categoria VALUES('super categoria 2');
INSERT INTO categoria VALUES('super categoria 3');

DELETE FROM categoria_simples;
INSERT INTO categoria_simples VALUES('categoria simples 1');
INSERT INTO categoria_simples VALUES('categoria simples 2');
INSERT INTO categoria_simples VALUES('categoria simples 3');

INSERT INTO super_categoria VALUES('super categoria 1');
INSERT INTO super_categoria VALUES('super categoria 2');
INSERT INTO super_categoria VALUES('super categoria 3');

INSERT INTO tem_outra VALUES('super categoria 1', 'categoria simples 1');
INSERT INTO tem_outra VALUES('super categoria 2', 'super categoria 3');
INSERT INTO tem_outra VALUES('super categoria 3', 'categoria simples 2');
INSERT INTO tem_outra VALUES('super categoria 3', 'categoria simples 3');

INSERT INTO produto VALUES(1111111111111, 'categoria simples 1', 'descricao 1');
INSERT INTO produto VALUES(2222222222222, 'super categoria 2',   'descricao 2');
INSERT INTO produto VALUES(3333333333333, 'super categoria 3', 'descricao 3');

DELETE FROM tem_categoria;
INSERT INTO tem_categoria VALUES(1111111111111, 'categoria simples 1');
INSERT INTO tem_categoria VALUES(2222222222222, 'super categoria 2');
INSERT INTO tem_categoria VALUES(3333333333333, 'super categoria 3');

ALTER SEQUENCE IVM_num_serie_seq RESTART WITH 1; /* isto é estupido */
INSERT INTO IVM VALUES(DEFAULT /* 1 */, 'fabricante 1');
INSERT INTO IVM VALUES(DEFAULT /* 2 */, 'fabricante 2');
INSERT INTO IVM VALUES(DEFAULT /* 3 */, 'fabricante 3');

DELETE FROM ponto_de_retalho;
INSERT INTO ponto_de_retalho VALUES('ponto de retalho 1', 'distrito 1', 'concelho 1');
INSERT INTO ponto_de_retalho VALUES('ponto de retalho 2', 'distrito 2', 'concelho 2');
INSERT INTO ponto_de_retalho VALUES('ponto de retalho 3', 'distrito 3', 'concelho 3');

INSERT INTO instalada_em VALUES(1, 'fabricante 1', 'ponto de retalho 1');
INSERT INTO instalada_em VALUES(2, 'fabricante 2', 'ponto de retalho 2');
INSERT INTO instalada_em VALUES(3, 'fabricante 3', 'ponto de retalho 3');

INSERT INTO prateleira VALUES(1, 1, 'fabricante 1', 1.1, 'categoria simples 1');
INSERT INTO prateleira VALUES(2, 2, 'fabricante 2', 2.2, 'super categoria 2');
INSERT INTO prateleira VALUES(3, 3, 'fabricante 3', 3.3, 'super categoria 3');

INSERT INTO planograma VALUES(1111111111111, 1, 1, 'fabricante 1', 1, 1, 'loc 1');
INSERT INTO planograma VALUES(2222222222222, 2, 2, 'fabricante 2', 2, 2, 'loc 2');
INSERT INTO planograma VALUES(3333333333333, 3, 3, 'fabricante 3', 3, 3, 'loc 3');

ALTER SEQUENCE retalhista_tin_seq RESTART WITH 1; /* isto é estupido */
INSERT INTO retalhista VALUES(DEFAULT /* 1 */, 'retalhista 1');
INSERT INTO retalhista VALUES(DEFAULT /* 2 */, 'retalhista 2');
INSERT INTO retalhista VALUES(DEFAULT /* 3 */, 'retalhista 3');

INSERT INTO responsavel_por VALUES('categoria simples 1', 1, 1, 'fabricante 1');
INSERT INTO responsavel_por VALUES('super categoria 2'  , 2, 2, 'fabricante 2');
INSERT INTO responsavel_por VALUES('super categoria 3'  , 3, 3, 'fabricante 3');

INSERT INTO evento_reposicao VALUES(1111111111111, 1, 1, 'fabricante 1', '2000-01-01', 1, 1);
INSERT INTO evento_reposicao VALUES(2222222222222, 2, 2, 'fabricante 2', '2000-02-03', 2, 2);
INSERT INTO evento_reposicao VALUES(3333333333333, 3, 3, 'fabricante 3', '2000-03-02', 3, 3);
