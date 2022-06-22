SELECT dia_semana, concelho, unidades
FROM vendas
WHERE dia_mes >= 2000-01-01
AND dia_mes < 2000-03-03
GROUP BY
ROLLUP (dia_semana, concelho, unidades);
