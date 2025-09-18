CREATE TABLE Denominaciones (
    tipo VARCHAR2(15) PRIMARY KEY,
    valor NUMBER(5)
);

INSERT INTO Denominaciones VALUES ('billete500', 500);
INSERT INTO Denominaciones VALUES ('billete200', 200);
INSERT INTO Denominaciones VALUES ('billete100', 100);
INSERT INTO Denominaciones VALUES ('billete50', 50);
INSERT INTO Denominaciones VALUES ('billete20', 20);
INSERT INTO Denominaciones VALUES ('billete10', 10);
INSERT INTO Denominaciones VALUES ('billete5', 5);
INSERT INTO Denominaciones VALUES ('moneda2', 2);
INSERT INTO Denominaciones VALUES ('moneda1', 1);

CREATE OR REPLACE PROCEDURE DescomponerDinero (
    cantidad IN NUMBER
) AS
    v_valor_denominacion NUMBER(5);
    v_cantidad_restante NUMBER(5);
BEGIN
    -- Iterar en orden descendente
    FOR denom IN (
        SELECT *
        FROM Denominaciones
        WHERE cantidad / valor >= 1
        ORDER BY valor DESC
    ) LOOP
        v_valor_denominacion := denom.valor;
        
        -- Calcular la cantidad de billetes o monedas necesarios
        v_cantidad_restante := FLOOR(cantidad / v_valor_denominacion);
        
        -- Mostrar el resultado
        DBMS_OUTPUT.PUT_LINE(v_cantidad_restante || ' ' || denom.tipo);
        
        -- Actualizar la cantidad restante para la próxima iteración
        cantidad := cantidad - (v_cantidad_restante * v_valor_denominacion);
    END LOOP;
END;

SET SERVEROUTPUT ON;
    
BEGIN
    DescomponerDinero(139);
END;