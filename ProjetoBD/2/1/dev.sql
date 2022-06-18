/* isto não tem de ser uma transação na super_categoria e tem_outra? */

CREATE OR REPLACE FUNCTION category_contains_itself_procedure()

RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.categoria = NEW.super_categoria THEN 
		RAISE EXCEPTION 'super categoria nao pode estar contida em si propria';
	END IF;
	
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER category_contains_itself_trigger
BEFORE UPDATE OR INSERT ON tem_outra
FOR EACH ROW EXECUTE PROCEDURE category_contains_itself_procedure();


CREATE OR REPLACE FUNCTION  reposition_procedure()
RETURNS TRIGGER AS
$$
DECLARE max_units INTEGER;
BEGIN

    SELECT unidades INTO max_units
    FROM planograma
    WHERE ean = NEW.ean AND nro = NEW.nro AND num_serie = NEW.num_serie AND fabricante = NEW.fabricante; 	
	
    IF NEW.unidades > max_units THEN
	    RAISE EXCEPTION 'nao pode ser reposto uma quantidade superior as unidades planeadas no planograma';
    END IF;

	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER reposition_trigger
BEFORE UPDATE OR INSERT ON evento_reposicao
FOR EACH ROW EXECUTE PROCEDURE reposition_procedure();
