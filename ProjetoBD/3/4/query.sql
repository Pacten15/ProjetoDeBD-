-- 4
-- Quais os produtos (ean) que foram repostos sempre pelo mesmo retalhista?

SELECT ean
FROM (SELECT ean, COUNT(DISTINCT tin)
      FROM evento_reposicao
      GROUP BY ean) AS foo
WHERE count = 1;