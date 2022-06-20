CREATE OR REPLACE FUNCTION  reposition_procedure2()
RETURNS TRIGGER 
AS $$ 
DECLARE cat_prod VARCHAR(255);
DECLARE cat_prateleira VARCHAR(255);
DECLARE super_cat_prod VARCHAR(255);
BEGIN
    SELECT cat INTO cat_prod
    FROM produto
    WHERE ean = NEW.ean;

    SELECT nome INTO cat_prateleira
    FROM prateleira
    WHERE nro = NEW.nro AND fabricante = NEW.fabricante;

    select super_categoria into super_cat_prod
    from tem_outra
    where categoria = cat_prod;

    IF cat_prod = cat_prateleira THEN
        RETURN NEW;
    ELSEIF super_cat_prod = cat_prateleira THEN 
        return NEW;
    ELSE
        RAISE EXCEPTION 'produto não pode ser reposto nesta prateleira';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER reposition_product_trigger
BEFORE UPDATE OR INSERT ON evento_reposicao
FOR EACH ROW EXECUTE PROCEDURE reposition_procedure2();