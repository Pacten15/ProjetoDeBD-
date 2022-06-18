-- 3
-- Quais os produtos (ean) que nunca foram repostos?

SELECT ean
FROM produto
WHERE ean NOT IN (SELECT DISTINCT ean FROM evento_reposicao);