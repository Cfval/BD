--Creo una tabla para almacenar las contraseñas

CREATE TABLE vendedor_passwd(
    numvend NUMBER(4) PRIMARY KEY,
    passwd VARCHAR2(50)
);

--Función para generar contraseña

CREATE OR REPLACE FUNCTION generar_passwd(length IN NUMBER) RETURN VARCHAR2 AS
    chars VARCHAR2(115) := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()'¡?¿[]{}-_<>*^ºª; 
    resultado VARCHAR2(50) := '';
BEGIN
    FOR i IN 1..length LOOP
        resultado := resultado || SUBSTR(chars, CEIL(DBMS_RANDOM.VALUE(1, LENGTH(chars))), 1);
    END LOOP;
    RETURN resultado;
END;


--Trigger que genera contraseña al insertar un nuevo vendedor

CREATE OR REPLACE TRIGGER insertar_vendedor_passwd
AFTER INSERT ON vendedor
FOR EACH ROW
DECLARE
    new_passwd VARCHAR2(50);
BEGIN
    new_passwd := generar_passwd(20); -- Aquí se introduce cuantos carácteres queremos que tenga la contraseña

    --Control para la longitud de la contraseña
    IF LENGTH(new_password) < 6 OR LENGTH(new_password) > 50 THEN
        RAISE LONGITUD_INVALIDA;
    END IF;

    INSERT INTO vendedor_passwd (numvend, passwd)
    VALUES (:NEW.numvend, new_passwd);
    
    -- Mostrar mensaje de éxito
    DBMS_OUTPUT.PUT_LINE('Se ha generado una contraseña para el vendedor ' || :NEW.numvend || ': ' || new_passwd);
EXCEPTION
WHEN LONGITUD_INVALIDA THEN
    DBMS_OUTPUT.PUT_LINE('La longitud de la contraseña generada no está dentro del rango permitido');
WHEN OTHERS THEN
    -- Control de errores comunes
    DBMS_OUTPUT.PUT_LINE('Error al insertar contraseña para ' || :NEW.numvend || ': ' || SQLERRM);
END;


