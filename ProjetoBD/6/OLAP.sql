SELECT dia_semana, concelho, unidades
FROM vendas
WHERE ano >= EXTRACT(YEAR FROM '2000-01-01')
AND ano <= EXTRACT(YEAR FROM '2000-03-03')
AND mes >= EXTRACT(YEAR FROM '2000-01-01')
AND mes <= EXTRACT(YEAR FROM '2000-03-03')
AND dia_mes >= EXTRACT(YEAR FROM '2000-01-01')
AND dia_mes <= EXTRACT(YEAR FROM '2000-03-03')
GROUP BY
ROLLUP (dia_semana, concelho, unidades);
