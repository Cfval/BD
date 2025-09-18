--Forma guarrindonga de crear tablas

DROP TABLE ej3_cliente CASCADE CONSTRAINTS;
DROP TABLE ej3_entidad CASCADE CONSTRAINTS;
DROP TABLE ej3_sucursal CASCADE CONSTRAINTS;
DROP TABLE ej3_cuenta CASCADE CONSTRAINTS;

--CREACIÓN DE TABLAS
CREATE TABLE ej3_cliente(

    nombre VARCHAR2(50) PRIMARY KEY,
    telefono VARCHAR2(9),
    edad NUMBER(3),
    domicilio VARCHAR2(50)
);

CREATE TABLE ej3_entidad(
    nombre VARCHAR2(20),
    sede VARCHAR2(50),
    CONSTRAINT pk_ej3_entidad PRIMARY KEY (nombre)
);

CREATE TABLE ej3_sucursal(
    nombre_ent VARCHAR2(20),
    numero NUMBER(4),
    direccion VARCHAR2(50),
    director VARCHAR2(50),
    CONSTRAINT pk_ej3_sucursal PRIMARY KEY (nombre_ent,numero),
    CONSTRAINT fk_ej3_sucursal_ej3_entidad FOREIGN KEY (nombre_ent) REFERENCES ej3_entidad
);

CREATE TABLE ej3_cuenta(
    nombre_ent VARCHAR2(20),
    numero_suc NUMBER(4),
    numero NUMBER(8),
    tipo VARCHAR2(10),
    saldo NUMBER(10,2),
    nombre_cli VARCHAR2(50) REFERENCES ej3_cliente,
    CONSTRAINT pk_ej3_cuenta PRIMARY KEY (nombre_ent,numero_suc,numero),
    CONSTRAINT fk_ej3_cuenta_ej3_sucursal FOREIGN KEY (nombre_ent,numero_suc) REFERENCES ej3_sucursal ON DELETE CASCADE
);

--Inserción de datos 
--Tabla Cliente
INSERT INTO ej3_cliente VALUES('Alba Navarro','965467898',31,'C/Azorín, 15');
INSERT INTO ej3_cliente VALUES('Juan Pérez','965381654',21,'C/Boccacio,38');
INSERT INTO ej3_cliente VALUES('Alex Cuenca','965551985',15,'C/Cervantes, 28');

--Tabla Entidad
INSERT INTO ej3_entidad VALUES('BBVA','Bilbao');
INSERT INTO ej3_entidad VALUES('Caixa','Barcelona');
INSERT INTO ej3_entidad VALUES('Bankia','Madrid');

--Tabla Sucursal
INSERT INTO ej3_sucursal VALUES('BBVA',0001,'C/Los pinos, 34','Fernando Calleja');
INSERT INTO ej3_sucursal VALUES('BBVA',0002,'C/Cruzados, 71','Silvia Verdú');
INSERT INTO ej3_sucursal VALUES('Caixa',0001,'C/Mayor, 1','Lorena Juan');
INSERT INTO ej3_sucursal VALUES('Caixa',0002,'C/Real, 3','Lorena Moreno');
INSERT INTO ej3_sucursal VALUES('Bankia',1245,'C/Cotos, 54','Roberto Bautista');
INSERT INTO ej3_sucursal VALUES('Bankia',0564,'C/Calabacines, 12','Sara Navarro');

--Tabla Cuenta
INSERT INTO ej3_cuenta VALUES('BBVA',0001,89765432,'Ahorro',5000.54,'Alba Navarro');
INSERT INTO ej3_cuenta VALUES('Caixa',0002,23456788,'Corriente',78654.65,'Juan Perez');
INSERT INTO ej3_cuenta VALUES('Bankia',1245,87654875,'Ahorro',123.45,'Alex Cuenca');
INSERT INTO ej3_cuenta VALUES('BBVA',0002,57648775,'Corriente',12.5,'Alex Cuenca');
INSERT INTO ej3_cuenta VALUES('Caixa',0002,45648746,'Corriente',984746.5,'Alba Navarro');
INSERT INTO ej3_cuenta VALUES('BBVA',0001,89776535,'Corriente',654877.4,'Alba Navarro');
INSERT INTO ej3_cuenta VALUES('BBVA',0002,89776535,'Corriente',654877.4,'Alba Navarro');
INSERT INTO ej3_cuenta VALUES('Caixa',0001,89776535,'Corriente',654877.4,'Alba Navarro');
--
select * from ej3_cliente;
select * from ej3_entidad;
select * from ej3_sucursal;
select * from ej3_cuenta;

--Modificaciones

UPDATE ej3_cuenta SET saldo=12456.97 WHERE numero=89776535;

UPDATE ej3_sucursal SET director='Ricardo Campos' WHERE nombre_ent='BBVA' AND numero=0001;

UPDATE ej3_cliente SET domicilio='C/Lorca, 24' WHERE nombre='Alex Cuenca';

UPDATE ej3_sucursal SET direccion='C/ Los abetos', director='Juan Cabezo' WHERE nombre_ent='Caixa' AND numero=0002;

UPDATE ej3_entidad SET sede='Alicante' WHERE nombre='Caixa';

--Borrados

DELETE FROM ej3_sucursal WHERE nombre_ent='Bankia' AND numero=0564;

DELETE FROM ej3_cuenta WHERE nombre_cli='Juan Perez';

DELETE FROM ej3_cuenta WHERE numero=89765432;

DELETE FROM ej3_sucursal WHERE nombre_ent='Caixa' AND numero=0002;

DELETE FROM ej3_cliente WHERE nombre='Alba Navarro'; --No deja porque es la Primary Key, habría que modificar alguna sentencia con delete cascade o algo. 

--
select * from ej3_cliente;
select * from ej3_entidad;
select * from ej3_sucursal;
select * from ej3_cuenta;