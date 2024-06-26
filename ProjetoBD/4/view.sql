CREATE VIEW vendas(ean, cat, ano, trimestre, mes, dia_mes, dia_semana, distrito, concelho, unidades)
AS 
SELECT b.ean, cat, EXTRACT(YEAR    FROM instante), 
                   EXTRACT(QUARTER FROM instante), 
                   EXTRACT(MONTH   FROM instante), 
                   EXTRACT(DAY     FROM instante),
                   EXTRACT(DOW     FROM instante), distrito, concelho, a.unidades
FROM evento_reposicao a, produto b, planograma c, instalada_em d, ponto_de_retalho e
WHERE   a.ean = b.ean
    AND b.ean = c.ean
    AND c.num_serie = d.num_serie
    AND c.fabricante = d.fabricante
    AND d.local = e.nome;
