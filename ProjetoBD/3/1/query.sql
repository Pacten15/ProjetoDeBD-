-- 1 
-- Qual o nome do retalhista (ou retalhistas) responsáveis pela reposição do maior número de
-- categorias?

SELECT name, COUNT(DISTINCT cat) as cou
FROM retalhista NATURAL JOIN evento_reposicao NATURAL JOIN produto
GROUP BY name
HAVING COUNT(*) >= ALL (
	SELECT COUNT(*)
    FROM retalhista NATURAL JOIN evento_reposicao NATURAL JOIN produto
    GROUP BY name);
