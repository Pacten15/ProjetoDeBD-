SELECT concelho, cat, dia_semana, unidades
FROM vendas
WHERE distrito = 'distrito 1'
GROUP BY
ROLLUP (concelho,cat, dia_semana, unidades)
ORDER BY (concelho,cat,dia_semana,unidades);
