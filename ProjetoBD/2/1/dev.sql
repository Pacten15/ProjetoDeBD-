/* isto não tem de ser uma transação na super_categoria e tem_outra? */

CREATE OR REPLACE FUNCTION category_contains_itself_procedure()

RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.categoria = NEW.super_categoria THEN 
		RAISE EXCEPTION 'Super categoria nao pode estar contida em si propria';
	END IF;
	
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER category_contains_itself_trigger
BEFORE UPDATE OR INSERT ON tem_outra
FOR EACH ROW EXECUTE PROCEDURE category_contains_itself_procedure();