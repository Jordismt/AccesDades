-- ==========================================================
-- Creación de la Base de Datos
-- ==========================================================

CREATE database IF NOT EXISTS bookstore;

-- ==========================================================
-- Seleccionar la Base de Datos
-- ==========================================================

   USE bookstore;

-- ==========================================================
-- Eliminar las tablas en caso existan
-- ==========================================================

   DROP TABLE IF EXISTS venta;
   DROP TABLE IF EXISTS publicacion;
   DROP TABLE IF EXISTS tipo;
   DROP TABLE IF EXISTS usuario;
   DROP TABLE IF EXISTS empleado;
   DROP TABLE IF EXISTS promocion;
   DROP TABLE IF EXISTS control;


  /*Creem els tipos necessaris: */
   CREATE type tipo as(
       idtipo               char(3) NOT NULL,
       descripcion          varchar(50) NOT NULL,
       contador             integer NOT NULL,
       CONSTRAINT pk_tipo PRIMARY KEY (idtipo)
   );
  
  create type Persona as(
		nombre varchar(20),
		apellido varchar(50),
		direccion varchar (100),
		email varchar(50)
	
	);


/*Creem les taules: */

   CREATE TABLE promocion (
       idpromocion          smallint NOT NULL,
       cantmin              smallint NOT NULL,
       cantmax              smallint NOT NULL,
       porcentaje           decimal(4,2) NOT NULL,
       CONSTRAINT pk_promocion PRIMARY KEY (idpromocion)
   );

  
   CREATE TABLE publicacion (
       idpublicacion        char(8) NOT NULL,
       titulo               varchar(100) NOT NULL,
       autor                varchar(100) NOT NULL,
       nroedicion           smallint NOT NULL,
       precio               decimal(10,2) NOT NULL,
       stock                integer NOT NULL,
       idtipo               tipo,
       CONSTRAINT pk_publicacion PRIMARY KEY (idpublicacion),
       CONSTRAINT fk_publicacion_tipo 
            FOREIGN KEY (idtipo)
            REFERENCES tipo (idtipo)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT
   );
	
  
	CREATE TABLE empleado (
	   idempleado           INTEGER NOT NULL,
	   persona				 Persona,
	   CONSTRAINT pk_empleado PRIMARY KEY (idempleado)
   )inherit (usuario);/*Heredem de usuario, ja que un empleado tambien puede ser un usuario*/
   
   
   CREATE TABLE usuario
   (
	   idempleado           INTEGER NOT NULL,
	   usuario              varchar(20) NOT NULL,
	   clave                VARCHAR(100) NOT NULL,
	   activo               INTEGER NOT NULL,
	   persona				Persona,
	   PRIMARY KEY (idempleado),
	   FOREIGN KEY (idempleado) 
		REFERENCES empleado (idempleado)
   );   

  
   CREATE TABLE venta (
       idventa              int NOT NULL,
       cliente              varchar(100) NOT NULL,
       fecha                date NOT NULL,
       idempleado           int NOT NULL,
       idpublicacion        char(8) NOT NULL,
       cantidad             integer NOT NULL,
       precio               decimal(10,2) NOT NULL,
       dcto                 decimal(10,2) NOT NULL,
       subtotal             decimal(10,2) NOT NULL,
       impuesto             decimal(10,2) NOT NULL,
       total                decimal(10,2) NOT NULL,
       CONSTRAINT pk_venta PRIMARY KEY (idventa),
       CONSTRAINT fk_venta_publicacion 
            FOREIGN KEY (idpublicacion)
            REFERENCES publicacion  (idpublicacion)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT,
       CONSTRAINT fk_venta_empleado 
            FOREIGN KEY (idempleado)
            REFERENCES empleado  (idempleado)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT
   );
  

   CREATE TABLE control (
       parametro            varchar(50) NOT NULL,
       valor                varchar(50) NOT NULL,
       CONSTRAINT pk_control PRIMARY KEY (parametro)
   );


-- ==========================================================
-- Insertar Datos de Prova
-- ==========================================================

  -- Tabla: tipo

   Insert Into tipo( idtipo,descripcion,contador ) Values( 'LIB','Libro',10 );
   Insert Into tipo( idtipo,descripcion,contador ) Values( 'REV','Revista',3 );
   Insert Into tipo( idtipo,descripcion,contador ) Values( 'SEP','Separata',8 );


-- Libros

   Insert Into publicacion( idpublicacion,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('LIB00001','LIB','Power Builder 6.0','William B. Heys',1, 50.00,1000);
   Insert Into publicacion( idpublicacion,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('LIB00002','LIB','Visual Basic 6.0','Joel Carrasco',2,45.00,1500);
   Insert Into publicacion( idpublicacion,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('LIB00003','LIB','Programación C/S con VB','Kenneth L. Spenver',1,45.00,450);
   Insert Into publicacion( idpublicacion,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('LIB00004','LIB','VBScript a través de Ejemplos','Jery Honeycutt',1,35.00,720);

   -- Revistas

   Insert Into publicacion( idpublicacion,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('REV00001','REV','Eureka','GrapPeru',1,4.00,770);
   Insert Into publicacion( idpublicacion,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('REV00002','REV','El Programador','ElectroSoft S.A.C.',1,6.00,1200);
   Insert Into publicacion( idpublicacion,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('REV00003','REV','La Revista del Programador','PeruDev',1,10.00,590);


-- Separatas

   Insert Into publicacion( idpublicacion,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('SEP00001','SEP','Power Builder 7.0 Básico','Eric G. Coronel C.',1,20.00,500);
   Insert Into publicacion( idpublicacion,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('SEP00002','SEP','Power Builder 7.0 Avanzado','Eric G. Coronel C.',1,20.00,500);
   Insert Into publicacion( idpublicacion,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('SEP00003','SEP','Visual Basic 6.0 Básico','Hugo Valencia M.',1,20.00,500);
   Insert Into publicacion( idpublicacion,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('SEP00004','SEP','Visual Bsic 6.0 Avanzado','Hugo Valencia M.',1,20.00,500);
   Insert Into publicacion( idpublicacion,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('SEP00005','SEP','SQL Server 7.0 Básico','Sergio Matsukawa',1,20.00,500);
    
   -- promociones

   Insert Into promocion(idpromocion,cantmin,cantmax,porcentaje) Values(1,1,4,0);
   Insert Into promocion(idpromocion,cantmin,cantmax,porcentaje) Values(2,5,10,0.03);
   Insert Into promocion(idpromocion,cantmin,cantmax,porcentaje) Values(3,11,20,0.05);
   Insert Into promocion(idpromocion,cantmin,cantmax,porcentaje) Values(4,21,50,0.07);
   Insert Into promocion(idpromocion,cantmin,cantmax,porcentaje) Values(5,51,100,0.10);
   Insert Into promocion(idpromocion,cantmin,cantmax,porcentaje) Values(6,101,1000,0.12);


-- empleados

   Insert Into empleado(idempleado,apellido,nombre,direccion,email) 
     Values(1,'AGUERO RAMOS','EMILIO','Lima','emilio@gmail.com');
   Insert Into empleado(idempleado,apellido,nombre,direccion,email) 
     Values(2,'SANCHEZ ROMERO','KATHIA','Miraflores','kathia@yahoo.es');
   Insert Into empleado(idempleado,apellido,nombre,direccion,email) 
     Values(3,'LUNG WON','FELIX','Los Olivos','gato@hotmail.com');
     
 -- usuarios  
   
   Insert Into usuario(idempleado,usuario,clave,activo) Values
   (1,'eaguero',SHA('cazador'),1),
   (2,'ksanchez',SHA('suerte'),1),
   (3,'flung',SHA('por100pre'),0),
   (4,'ecastillo',SHA('hastalavista'),1),
   (5,'lmilicich',SHA('turuleka'),0),
   (6,'kdelgado',SHA('noimporta'),1);   
 
-- ventas

   insert into venta (idventa,cliente,idempleado,fecha,idpublicacion,cantidad,precio,dcto,subtotal,impuesto,total)
    values(01,'ISIL',   05,date_sub(sysdate(),interval 60 day),'LIB00003',2,0,0,0,0,0);
   insert into venta (idventa,cliente,idempleado,fecha,idpublicacion,cantidad,precio,dcto,subtotal,impuesto,total)
    values(02,'UNI',    01,date_sub(sysdate(),interval 59 day),'REV00002',4,0,0,0,0,0);
   insert into venta (idventa,cliente,idempleado,fecha,idpublicacion,cantidad,precio,dcto,subtotal,impuesto,total)
    values(03,'Pedro',  03,date_sub(sysdate(),interval 58 day),'LIB00005',6,0,0,0,0,0);
   insert into venta (idventa,cliente,idempleado,fecha,idpublicacion,cantidad,precio,dcto,subtotal,impuesto,total)
    values(04,'Pablo',  02,date_sub(sysdate(),interval 58 day),'SEP00002',1,0,0,0,0,0);
   insert into venta (idventa,cliente,idempleado,fecha,idpublicacion,cantidad,precio,dcto,subtotal,impuesto,total)
    values(05,'Vilma',  01,date_sub(sysdate(),interval 57 day),'LIB00003',3,0,0,0,0,0);
  
   
  -- control

   Insert Into control(parametro,valor) Values('IGV','0.18');
   Insert Into control(parametro,valor) Values('venta','24');
   Insert Into control(parametro,valor) Values('Empresa','EGCC');
   Insert Into control(parametro,valor) Values('Empleado','7');
   Insert Into control(parametro,valor) Values('Site','www.egcc.net'); 
    