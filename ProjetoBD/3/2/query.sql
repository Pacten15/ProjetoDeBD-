-- 2
-- Qual o nome do ou dos retalhistas que são responsáveis por todas as categorias simples?

--
-- compact
--
SELECT nome_retalhista
FROM (SELECT nome_retalhista, COUNT(*)
	  FROM (SELECT name AS nome_retalhista, tin FROM retalhista) AS foo1 NATURAL JOIN
	 	   (SELECT tin, nome_cat AS nome FROM responsavel_por) AS foo2 NATURAL JOIN 
           categoria_simples
	  GROUP BY nome_retalhista) AS foo43
WHERE count = (SELECT COUNT(*) FROM categoria_simples);

--
-- explained
--
SELECT name AS nome_retalhista, tin INTO var1
FROM retalhista;

SELECT tin, nome_cat AS nome INTO var2 
FROM responsavel_por;

SELECT nome_retalhista, nome AS nome_categoria INTO var3
FROM var1 NATURAL JOIN var2 NATURAL JOIN categoria_simples;

SELECT nome_retalhista, COUNT(DISTINCT nome_categoria) INTO var4
FROM var3
GROUP BY nome_retalhista;

SELECT COUNT(*) INTO numero_categorias_simples
FROM categoria_simples; 

SELECT nome_retalhista
FROM var4
WHERE count = (SELECT * FROM numero_categorias_simples);

--DROP TABLE var1;
--DROP TABLE var2;
--DROP TABLE var3;
--DROP TABLE var4;
--DROP TABLE numero_categorias_simples;
