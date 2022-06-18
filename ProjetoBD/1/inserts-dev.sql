--
-- deletes pela ordem correta
--
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

--
-- inserts pela ordem correta
--

-- nao "precisa"
-- R1-RE1: "mandatory & disjoint" (mas coloco à mesma): O valor do atributo nome de qualquer registo da relação categoria tem de existir em na relação categoria_simples ou na relação super_categoria
DELETE FROM categoria;
INSERT INTO categoria VALUES('categoria simples 1');
INSERT INTO categoria VALUES('categoria simples 2');
INSERT INTO categoria VALUES('categoria simples 3');
INSERT INTO categoria VALUES('super categoria 1');
INSERT INTO categoria VALUES('super categoria 2');
INSERT INTO categoria VALUES('super categoria 3');
SELECT * FROM categoria;

-- "precisa" de categoria.nome
-- RI-RE2: O valor do atributo nome de qualquer registo de categoria_simples não pode existir em super_categoria
DELETE FROM categoria_simples;
INSERT INTO categoria_simples VALUES('categoria simples 1');
INSERT INTO categoria_simples VALUES('categoria simples 2');
INSERT INTO categoria_simples VALUES('categoria simples 3');
SELECT * FROM categoria_simples;

--  "precisa" de categoria.nome
-- RI-E3: "toda a super_supercategoria tem de estar relacionada com outra categoria em tem_outra" :O valor do atributo nome de qualquer registo tem de existir no atributo super_categoria da relação constituída
DELETE FROM super_categoria;
INSERT INTO super_categoria VALUES('super categoria 1');
INSERT INTO super_categoria VALUES('super categoria 2');
INSERT INTO super_categoria VALUES('super categoria 3');
SELECT * FROM super_categoria;

-- "precisa" de super_categoria.nome e categoria.nome
-- RI-RE4: a categoria nao pode ter 2 pais (tratada por PK(categoria)): Não podem existir valores repetidos dos atributos super_categoria e categoria numa sequência de registos relacionados pela FK categoria
-- RI-RE5: UNIQUE(super_categoria, categoria): Para qualquer registo desta relação, verifica-se que os atributos super_categoria e categoria são distintos.
DELETE FROM tem_outra;
INSERT INTO tem_outra VALUES('super categoria 1', 'categoria simples 1');
INSERT INTO tem_outra VALUES('super categoria 2', 'super categoria 3');
INSERT INTO tem_outra VALUES('super categoria 3', 'categoria simples 2');
INSERT INTO tem_outra VALUES('super categoria 3', 'categoria simples 3');
SELECT * FROM tem_outra;

-- "precisa" de categoria.nome
-- RI-RE6: O valor do atributo ean existente em qualquer registo da relacao produto tem de existir tambem no atributo ean da relacao tem_categoria
DELETE FROM produto;
INSERT INTO produto VALUES(1111111111111, 'categoria simples 1', 'descricao 1');
INSERT INTO produto VALUES(2222222222222, 'super categoria 2',   'descricao 2');
INSERT INTO produto VALUES(3333333333333, 'super categoria 3', 'descricao 3');
SELECT * FROM produto;

-- "precisa" de produto.ean e categoria.nome
DELETE FROM tem_categoria;
INSERT INTO tem_categoria VALUES(1111111111111, 'categoria simples 1');
INSERT INTO tem_categoria VALUES(2222222222222, 'super categoria 2');
INSERT INTO tem_categoria VALUES(3333333333333, 'super categoria 3');
SELECT * FROM tem_categoria;

-- nao "precisa"
DELETE FROM IVM;
ALTER SEQUENCE IVM_num_serie_seq RESTART WITH 1; /* isto é estupido */
INSERT INTO IVM VALUES(DEFAULT /* 1 */, 'fabricante 1');
INSERT INTO IVM VALUES(DEFAULT /* 2 */, 'fabricante 2');
INSERT INTO IVM VALUES(DEFAULT /* 3 */, 'fabricante 3');
SELECT * FROM IVM;

-- nao "precisa"
DELETE FROM ponto_de_retalho;
INSERT INTO ponto_de_retalho VALUES('ponto de retalho 1', 'distrito 1', 'concelho 1');
INSERT INTO ponto_de_retalho VALUES('ponto de retalho 2', 'distrito 2', 'concelho 2');
INSERT INTO ponto_de_retalho VALUES('ponto de retalho 3', 'distrito 3', 'concelho 3');
SELECT * FROM ponto_de_retalho;

-- "precisa" de ponto_de_retalho.nome e IVM.num_serie,fabricante
DELETE FROM instalada_em;
INSERT INTO instalada_em VALUES(1, 'fabricante 1', 'ponto de retalho 1');
INSERT INTO instalada_em VALUES(2, 'fabricante 2', 'ponto de retalho 2');
INSERT INTO instalada_em VALUES(3, 'fabricante 3', 'ponto de retalho 3');
SELECT * FROM instalada_em;

-- "precisa" de IVM.num_serie,fabricante e categoria.nome
--
-- notas: escolhi categorias dos produtos existentes
DELETE FROM prateleira;
INSERT INTO prateleira VALUES(1, 1, 'fabricante 1', 1.1, 'categoria simples 1');
INSERT INTO prateleira VALUES(2, 2, 'fabricante 2', 2.2, 'super categoria 2');
INSERT INTO prateleira VALUES(3, 3, 'fabricante 3', 3.3, 'super categoria 3');
SELECT * FROM prateleira;

-- "precisa" produto.ean e prateleira.nro,num_serie,fabricante
DELETE FROM planograma;
INSERT INTO planograma VALUES(1111111111111, 1, 1, 'fabricante 1', 1, 1, 'loc 1');
INSERT INTO planograma VALUES(2222222222222, 2, 2, 'fabricante 2', 2, 2, 'loc 2');
INSERT INTO planograma VALUES(3333333333333, 3, 3, 'fabricante 3', 3, 3, 'loc 3');
SELECT * FROM planograma;

-- nao "precisa"
-- RI-RE7: unique(name)
DELETE FROM retalhista;
ALTER SEQUENCE retalhista_tin_seq RESTART WITH 1; /* isto é estupido */
INSERT INTO retalhista VALUES(DEFAULT, 'retalhista 1');
INSERT INTO retalhista VALUES(DEFAULT, 'retalhista 2');
INSERT INTO retalhista VALUES(DEFAULT, 'retalhista 3');
SELECT * FROM retalhista;

-- "precisa" de IVM.num_serie,fabricante , retalhista.tin e categoria.nome
--
-- notas: coloquei as IVMs, retalhistas e categorias ja existentes
DELETE FROM responsavel_por;
INSERT INTO responsavel_por VALUES('categoria simples 1', 1, 1, 'fabricante 1');
INSERT INTO responsavel_por VALUES('super categoria 2'  , 2, 2, 'fabricante 2');
INSERT INTO responsavel_por VALUES('super categoria 3'  , 3, 3, 'fabricante 3');
SELECT * FROM responsavel_por;

-- precisa de planograma.ean,nro,num_serie,fabricante e retalhista.tin
-- RI-RE8: o valor do atributo unidades de um registo X desta relação não pode exceder o valor do atributo unidades do registo da relação planograma referido pelo registo X.
--
-- notas: coloquei evento_reposicao tal que respeite RI-RE8 e as coisas ja existentes
DELETE FROM evento_reposicao;
INSERT INTO evento_reposicao VALUES(1111111111111, 1, 1, 'fabricante 1', '2000-01-01', 1, 1);
INSERT INTO evento_reposicao VALUES(2222222222222, 2, 2, 'fabricante 2', '2000-02-03', 2, 2);
INSERT INTO evento_reposicao VALUES(3333333333333, 3, 3, 'fabricante 3', '2000-03-03', 3, 3);
SELECT * FROM retalhista;
