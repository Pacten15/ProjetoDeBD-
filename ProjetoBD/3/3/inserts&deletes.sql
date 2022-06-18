-- coloquei novo produto sem o associar a um evento de reposicao

DELETE FROM produto WHERE ean = 4444444444444;
INSERT INTO produto VALUES(4444444444444, 'categoria simples 1', 'descricao SQL-3');
