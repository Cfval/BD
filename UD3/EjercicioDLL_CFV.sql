DROP TABLE departamento cascade constraints;
DROP TABLE empleado cascade constraints;
DROP TABLE empleado_departamento cascade constraints;
DROP TABLE nomina cascade constraints;
DROP TABLE linea cascade constraints;
DROP TABLE elemento_de_coste cascade constraints;
DROP TABLE ingreso cascade constraints;
DROP TABLE descuento cascade constraints;
DROP TABLE concepto_retributivo cascade constraints;

CREATE TABLE departamento( 
    codigo number(3), 
    nombre varchar2(100) 
);

CREATE TABLE empleado( 
    num_mat number(4), 
    nif varchar2(9), 
    nombre varchar2(100), 
    num_hijos number(2), 
    retencion number(6), 
    cuanta_corriente varchar2(30) 
);

CREATE TABLE empleado_departamento( 
    num_mat number(4), 
    codigo number(3) 
);

CREATE TABLE nomina( 
    num_mat number(4), 
    ejercicio number(7), 
    mes varchar2(50), 
    numero number(12), 
    ingreso_total number(8,2), 
    descuento_total number(8) 
);

CREATE TABLE linea( 
    num_linea number(5), 
    num_mat number(4), 
    ejercicio number(7), 
    mes varchar2(50), 
    numero number(12), 
    cantidad number (8,2) 
);

CREATE TABLE elemento_de_coste( 
    codigo number(3), 
    descripcion varchar2(250), 
    saldo number(8,2), 
    pertenece_elemento varchar2(100) 
);

CREATE TABLE ingreso( 
	num_linea number(5), 
    num_mat number(4), 
    ejercicio number(7), 
    mes varchar2(50), 
    numero number(12), 
    codigo number(5) NOT NULL 
);

CREATE TABLE descuento( 
	num_linea number(5), 
    num_mat number(4), 
    ejercicio number(7), 
    mes varchar2(50), 
    numero number(12), 
    base number (9), 
    porcentaje number(2) 
);

CREATE TABLE concepto_retributivo( 
    codigo number(5), 
    descripcion varchar2(250) 
);

-- Definición de claves primarias
ALTER TABLE departamento add constraint pk_departamento primary key (codigo);
ALTER TABLE empleado add constraint pk_empleado primary key (num_mat);
ALTER TABLE empleado_departamento add constraint pk_empleado_departamento primary key (num_mat, codigo);
ALTER TABLE nomina add constraint pk_nomina primary key (num_mat, ejercicio, mes, numero);
ALTER TABLE linea add constraint pk_linea primary key (num_linea, num_mat, ejercicio, mes, numero);
ALTER TABLE elemento_de_coste add constraint pk_elemento_de_coste primary key (codigo);
ALTER TABLE ingreso add constraint pk_ingreso primary key (num_linea, num_mat, ejercicio, mes, numero);
ALTER TABLE descuento add constraint pk_descuento primary key (num_linea, num_mat, ejercicio, mes, numero);
ALTER TABLE concepto_retributivo add constraint pk_concepto_retributivo primary key (codigo);


-- Definición de claves ajenas
ALTER TABLE empleado_departamento add constraint fk_empleado_departamento_empleado foreign key (num_mat) references empleado(num_mat);
ALTER TABLE empleado_departamento add constraint fk_empleado_departamento_departamento foreign key (codigo) references departamento(codigo);
ALTER TABLE nomina add constraint fk_nomina_empleado foreign key (num_mat) references empleado(num_mat);
ALTER TABLE linea add constraint fk_linea_nomina foreign key (num_mat, ejercicio, mes, numero) references nomina(num_mat, ejercicio, mes, numero);
ALTER TABLE ingreso add constraint fk_ingreso_linea foreign key (num_linea, num_mat, ejercicio, mes, numero) references linea(num_linea, num_mat, ejercicio, mes, numero);
ALTER TABLE ingreso add constraint fk_ingreso_concepto_retributivo foreign key (codigo) references concepto_retributivo(codigo);

-- Defincicón de comprovaciones check
ALTER TABLE ingreso add constraint ck_codigo check (codigo is not null);