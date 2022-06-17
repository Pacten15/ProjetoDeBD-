/* isto não tem de ser uma transação na super_categoria e tem_outra? */

CREATE OR REPLACE FUNCTION category_contains_itself_procedure()

RETURNS TRIGGER AS
$$
BEGIN
    IF 
        NEW.super_categoria IN (SELECT super_categoria FROM tem_outra) OR
        NEW.catoria IN (SELECT categoria FROM tem_outra)
    THEN
        RAISE EXCEPTION 'Categoria % nao pode conter-se a si propria!';
    END IF;

    RETURN NEW
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER category_contains_itself_trigger
BEFORE UPDATE OR INSERT ON tem_outra
FOR EACH ROW EXECUTE PROCEDURE category_contains_itself_procedure();