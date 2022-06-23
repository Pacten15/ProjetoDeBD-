SELECT concelho, cat, dia_semana, unidades
FROM vendas
WHERE distrito = 'Lisboa'
GROUP BY
ROLLUP (concelho,cat, dia_semana, unidades);
