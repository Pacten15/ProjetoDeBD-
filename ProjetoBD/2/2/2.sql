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