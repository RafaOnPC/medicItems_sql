USE MASTER

--CREACION DE BASE DE DATOS
CREATE DATABASE BD_GESTOR_OTM

use BD_GESTOR_OTM

SET DATEFORMAT DMY

-- TABLA: Actividades
CREATE TABLE Actividades
( 
	id_act               char(10)  NOT NULL ,
	descrip_act          varchar(max)  NOT NULL 
)
go


ALTER TABLE Actividades
	ADD CONSTRAINT XPKActividades PRIMARY KEY  CLUSTERED (id_act ASC)
go


--TABLA: Clientegob
CREATE TABLE Clientegob
( 
	id_clientgob         char(10)  NOT NULL ,
	name_proy            varchar(max)  NOT NULL ,
	localidad            varchar(max)  NOT NULL ,
	departamento         varchar(20)  NOT NULL 
)
go



ALTER TABLE Clientegob
	ADD CONSTRAINT XPKClientegob PRIMARY KEY  CLUSTERED (id_clientgob ASC)
go


--TABLA: Detalle_actividades_mantenimiento
CREATE TABLE Detalle_actividades_mantenimiento
( 
	id_act               char(10)  NOT NULL ,
	id_mnt               char(5)  NOT NULL ,
	estatus              varchar(20)  NULL 
)
go



ALTER TABLE Detalle_actividades_mantenimiento
	ADD CONSTRAINT XPKDetalle_actividades_mantenimiento PRIMARY KEY  CLUSTERED (id_act ASC,id_mnt ASC)
go


-- TABLA: Detalle_mantenimiento
CREATE TABLE Detalle_mantenimiento
( 
	id_mnt               char(5)  NOT NULL ,
	horas_hombre         integer  NOT NULL ,
	servicio_hosp        varchar(max)  NOT NULL ,
	id_per               char(10)  NOT NULL 
)
go



ALTER TABLE Detalle_mantenimiento
	ADD CONSTRAINT XPKDetalle_mantenimiento PRIMARY KEY  CLUSTERED (id_mnt ASC,id_per ASC)
go


-- TABLA: Detalle_repuesto_mantenimiento
CREATE TABLE Detalle_repuesto_mantenimiento
( 
	id_rep               char(10)  NOT NULL ,
	id_mnt               char(5)  NOT NULL ,
	cantidad_usada       integer  NOT NULL 
)
go



ALTER TABLE Detalle_repuesto_mantenimiento
	ADD CONSTRAINT XPKDetalle_repuesto_mantenimiento PRIMARY KEY  CLUSTERED (id_rep ASC,id_mnt ASC)
go


-- TABLA: Equipo
CREATE TABLE Equipo
( 
	id_eq                char(5)  NOT NULL ,
	denominacion         varchar(40)  NOT NULL ,
	grupo_gen            varchar(20)  NOT NULL ,
	marca_eq             varchar(20)  NOT NULL ,
	model_eq             varchar(20)  NOT NULL ,
	fech_ini_grt         date  NOT NULL ,
	fech_fin_grt         date  NOT NULL ,
	cant_mnto_ejec       integer  NOT NULL ,
	cant_mnto_pend       integer  NOT NULL ,
	vigencia             varchar(20)  NOT NULL ,
	comentario_fin_grt   varchar(max)  NOT NULL 
)
go




ALTER TABLE Equipo
	ADD CONSTRAINT XPKEquipo PRIMARY KEY  CLUSTERED (id_eq ASC)
go


-- TABLA: Fechamnto
CREATE TABLE Fechamnto
( 
	id_fec               char(5)  NOT NULL ,
	fech_prog            date  NOT NULL ,
	fech_ejec            date  NOT NULL ,
	comentario           varchar(max)  NOT NULL ,
	id_eq                char(5)  NOT NULL 
)
go


ALTER TABLE Fechamnto
	ADD CONSTRAINT XPKFechamnto PRIMARY KEY  CLUSTERED (id_fec ASC)
go


-- TABLA: Mantenimiento
CREATE TABLE Mantenimiento
( 
	id_mnt               char(5)  NOT NULL ,
	nro_otm              char(10)  NOT NULL ,
	prioridad            varchar(20)  NOT NULL ,
	fec_ini_eje_mnt      date  NOT NULL ,
	fec_fin_eje_mnt      date  NOT NULL ,
	hora_ini             time(0)  NOT NULL ,
	hora_fin             time(0)  NOT NULL ,
	descrip_problema     text  NOT NULL ,
	diag_fall            text  NOT NULL ,
	fec_emision          datetime  NOT NULL ,
	id_tipo              char(5)  NOT NULL ,
	id_clientgob         char(10)  NOT NULL ,
	id_eq                char(5)  NOT NULL ,
	id_otm               char(5)  NOT NULL 
)
go

ALTER TABLE Mantenimiento
ALTER COLUMN fec_emision date not null

ALTER TABLE Mantenimiento
	ADD CONSTRAINT XPKMantenimiento PRIMARY KEY  CLUSTERED (id_mnt ASC)
go


--TABLE: Personal
CREATE TABLE Personal
( 
	id_per               char(10)  NOT NULL ,
	name_per             varchar(max)  NOT NULL ,
	DNI                  varchar(8)  NOT NULL ,
	cargo                varchar(20)  NOT NULL 
)
go

--Modificando una columna "Cargo"
ALTER TABLE Personal
ALTER COLUMN cargo varchar(max) not null

--Agregando una nueva columna "experiencia"
ALTER TABLE Personal
ADD experiencia integer NULL;

ALTER TABLE Personal
ALTER COLUMN experiencia integer NOT NULL;



ALTER TABLE Personal
	ADD CONSTRAINT XPKPersonal PRIMARY KEY  CLUSTERED (id_per ASC)
go


--TABLE:Repuesto
CREATE TABLE Repuesto
( 
	id_rep               char(10)  NOT NULL ,
	detalle              varchar(max)  NOT NULL ,
	uni_med              varchar(5)  NOT NULL 
)
go



ALTER TABLE Repuesto
	ADD CONSTRAINT XPKRepuesto PRIMARY KEY  CLUSTERED (id_rep ASC)
go


--TABLE: Tipomnto
CREATE TABLE Tipomnto
( 
	id_tipo              char(5)  NOT NULL ,
	tipo_mnto            varchar(20)  NOT NULL 
)
go



ALTER TABLE Tipomnto
	ADD CONSTRAINT XPKTipomnto PRIMARY KEY  CLUSTERED (id_tipo ASC)
go


--TABLE: Tipootm
CREATE TABLE Tipootm
( 
	id_otm               char(5)  NOT NULL ,
	tipo_otm             varchar(20)  NOT NULL 
)
go


-- Relaciones
ALTER TABLE Tipootm
	ADD CONSTRAINT XPKTipootm PRIMARY KEY  CLUSTERED (id_otm ASC)
go




ALTER TABLE Detalle_actividades_mantenimiento
	ADD CONSTRAINT R_47 FOREIGN KEY (id_act) REFERENCES Actividades(id_act)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Detalle_actividades_mantenimiento
	ADD CONSTRAINT R_51 FOREIGN KEY (id_mnt) REFERENCES Mantenimiento(id_mnt)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Detalle_mantenimiento
	ADD CONSTRAINT R_21 FOREIGN KEY (id_mnt) REFERENCES Mantenimiento(id_mnt)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Detalle_mantenimiento
	ADD CONSTRAINT R_25 FOREIGN KEY (id_per) REFERENCES Personal(id_per)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Detalle_repuesto_mantenimiento
	ADD CONSTRAINT R_46 FOREIGN KEY (id_rep) REFERENCES Repuesto(id_rep)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Detalle_repuesto_mantenimiento
	ADD CONSTRAINT R_49 FOREIGN KEY (id_mnt) REFERENCES Mantenimiento(id_mnt)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Fechamnto
	ADD CONSTRAINT R_39 FOREIGN KEY (id_eq) REFERENCES Equipo(id_eq)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Mantenimiento
	ADD CONSTRAINT R_16 FOREIGN KEY (id_eq) REFERENCES Equipo(id_eq)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Mantenimiento
	ADD CONSTRAINT R_18 FOREIGN KEY (id_tipo) REFERENCES Tipomnto(id_tipo)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Mantenimiento
	ADD CONSTRAINT R_19 FOREIGN KEY (id_clientgob) REFERENCES Clientegob(id_clientgob)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Mantenimiento
	ADD CONSTRAINT R_32 FOREIGN KEY (id_otm) REFERENCES Tipootm(id_otm)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


--Restricciones para insercion de datos
--EL id_rep debe comenzar con 'REP-%' en la tabla REPUESTOS
ALTER TABLE REPUESTO
ADD CONSTRAINT CK_IDREP
CHECK (id_rep LIKE 'REP-[A-Z][A-Z][0-9][0-9]')

--La uni_med debe ser "UND"
ALTER TABLE REPUESTO
ADD CONSTRAINT CK_UNMED
CHECK (uni_med IN ('UND'))

--El id_act debe comenzar con 'ACT-%' en la tabla ACTIVIDADES
ALTER TABLE ACTIVIDADES
ADD CONSTRAINT CK_IDACT
CHECK (id_act LIKE 'ACT-[0-9][0-9][0-9]')

--El id_clientgob debe comenzar con 'GOB-%' en la tabla CLIENTEGOB
ALTER TABLE CLIENTEGOB
ADD CONSTRAINT CK_IDCLI
CHECK (id_clientgob LIKE 'GOB-[0-9][0-9][0-9]')

--El id_per debe comenzar con 'PER-%' en la tabla PERSONAL
ALTER TABLE PERSONAL
ADD CONSTRAINT CK_IDPER
CHECK (id_per LIKE 'PER-[0-9][0-9][0-9]')

--Cantidad usada debe ser mayor a 0 en tabla DETALLE EQUIPO
ALTER TABLE DETALLE_REPUESTO_MANTENIMIENTO
ADD CONSTRAINT CK_DE
CHECK (cantidad_usada>0)

--El campo tipo_mnto solo debe permitir los valores: 'Programado' e 'Imprevisto'
ALTER TABLE TIPOMNTO
ADD CONSTRAINT CK_TM
CHECK (TIPO_MNTO IN ('Programado','Imprevisto'))

--El campo tipo_otm solo debe permitir los valores: 'Preventivo' & 'Correctivo'
ALTER TABLE TIPOOTM
ADD CONSTRAINT CK_TO
CHECK (TIPO_OTM IN ('Preventivo','Correctivo'))

--El campo estatus debera tener los siguiente valores: "PENDIENTE", "REALIZADO", "POR REALIZAR" 
ALTER TABLE DETALLE_ACTIVIDADES_MANTENIMIENTO
ADD CONSTRAINT CK_EST
CHECK (ESTATUS IN ('Pendiente','Realizado','Por realizar'))

--Mantenimiento: La fecha de emision debera ser una fecha posterior a fec_fin_eje_mnto
ALTER TABLE Mantenimiento
ADD CONSTRAINT CK_MNT_FECH_EMISION
CHECK(fec_emision > fec_fin_eje_mnt)

ALTER TABLE Mantenimiento
DROP CONSTRAINT CK_MNT_FECH_EMISION;

--Mantenimiento: La fech_ini_eje_mnt debe ser una fecha anterior a fech_fin_eje_mnto 
ALTER TABLE Mantenimiento
ADD CONSTRAINT CK_MNT_FECH_MNT
CHECK(fec_fin_eje_mnt >= fec_ini_eje_mnt)

--Mantenimiento: Fecha y hora fin sea posterior al inicio
ALTER TABLE Mantenimiento
ADD CONSTRAINT CK_MNT_FECHA_HORA
CHECK (hora_fin > hora_ini)

--Ingreso de datos
--REPUESTO
insert into Repuesto (id_rep, detalle, uni_med) values ('REP-LC01', 'PANTALLA LCD', 'UND')
insert into Repuesto (id_rep, detalle, uni_med) values ('REP-CT01', 'CABLE TRONCAL', 'UND')
insert into Repuesto (id_rep, detalle, uni_med) values ('REP-EC01', 'ENCODER', 'UND')
insert into Repuesto (id_rep, detalle, uni_med) values ('REP-PF01', 'PANEL FRONTAL', 'UND')
insert into Repuesto (id_rep, detalle, uni_med) values ('REP-BP01', 'BOMBA DE PISTON', 'UND')
insert into Repuesto (id_rep, detalle, uni_med) values ('REP-SC01', 'CABLE DE ALIMENTACION SCHUKO', 'UND')
insert into Repuesto (id_rep, detalle, uni_med) values ('REP-TI01', 'SENSOR DE TEMPERATURA TI-200', 'UND')
insert into Repuesto (id_rep, detalle, uni_med) values ('REP-SH01', 'SENSOR DE HUMEDAD TI-200', 'UND')
insert into Repuesto (id_rep, detalle, uni_med) values ('REP-PE01', 'PLACA ELECTRONICA TI-200', 'UND')
insert into Repuesto (id_rep, detalle, uni_med) values ('REP-DP01', 'TRANSDUCTOR DP-100', 'UND')
insert into Repuesto (id_rep, detalle, uni_med) values ('REP-BT01', 'BATERIA DP', 'UND')
insert into Repuesto (id_rep, detalle, uni_med) values ('REP-LD01', 'PANTALLA LCD DP-100', 'UND')

select * from Repuesto

--ACTIVIDADES
insert into Actividades (id_act, descrip_act) values ('ACT-001', 'LIMPIEZA GENERAL')
insert into Actividades (id_act, descrip_act) values ('ACT-002', 'CAMBIO DE REPUESTO')
insert into Actividades (id_act, descrip_act) values ('ACT-003', 'REMPLAZO DE COMPONENTE DAÑADO')
insert into Actividades (id_act, descrip_act) values ('ACT-004','LIMPIEZA INTERNA DEL EQUIPO')
insert into Actividades (id_act, descrip_act) values ('ACT-005','CALIBRACION DEL SISTEMA')
insert into Actividades (id_act, descrip_act) values ('ACT-006','DESINFECCION DE ACCESORIO')

select * from Actividades

--PERSONAL
insert into Personal (id_per, name_per, DNI, cargo) values ('PER-001', 'Julian Sanchez Bueno', '06120651', 'Ingeniero Biomedico')
insert into Personal (id_per, name_per, DNI, cargo) values ('PER-002', 'Jose Gomez Herrera', '73221651', 'Tecnico en electronica')
insert into Personal (id_per, name_per, DNI, cargo) values ('PER-003', 'Josefina Angulo Cruz', '73221651', 'Ingeniero Electronico')
insert into Personal (id_per, name_per, DNI, cargo) values ('PER-004', 'Luisa Dominguez Gonzalez', '71985671', 'Tecnico en electronica')
insert into Personal (id_per, name_per, DNI, cargo) values ('PER-005','Juan Pérez Del Portal','985645221','Ingeniero Electronico')
insert into Personal (id_per, name_per, DNI, cargo) values ('PER-006','Miguel Gutierrez Escarate','87654321','Ingeniero Electronico')
insert into Personal (id_per, name_per, DNI, cargo) values ('PER-007', 'Enrique Mondragon Aguilar', '78265210', 'Tecnico en electronica')
insert into Personal (id_per, name_per, DNI, cargo) values ('PER-008','Juan Jose Da silva Souza','06125488','Ingeniero Electronico')
insert into Personal (id_per, name_per, DNI, cargo) values ('PER-009','Carlos Ramos Ugarte','09963352','Ingeniero Electronico')
insert into Personal (id_per, name_per, DNI, cargo) values ('PER-010', 'Estefano Ramirez Sanchez', '02145632', 'Tecnico en electronica')

UPDATE Personal
SET experiencia = 1
WHERE id_per = 'PER-001';

UPDATE Personal
SET experiencia = 3
WHERE id_per = 'PER-002';

UPDATE Personal
SET experiencia = 2
WHERE id_per = 'PER-003';

UPDATE Personal
SET experiencia = 1
WHERE id_per = 'PER-004';

UPDATE Personal
SET experiencia = 1
WHERE id_per = 'PER-006';

UPDATE Personal
SET experiencia = 4
WHERE id_per = 'PER-007';

UPDATE Personal
SET experiencia = 5
WHERE id_per = 'PER-008';

UPDATE Personal
SET experiencia = 1
WHERE id_per = 'PER-009';

UPDATE Personal
SET experiencia = 1
WHERE id_per = 'PER-010';


select * from Personal

--TIPOOTM 
insert into Tipootm (id_otm, tipo_otm) values (1, 'Preventivo')
insert into Tipootm (id_otm, tipo_otm) values (2, 'Correctivo')

select * from Tipootm

--TIPOMNTO
insert into Tipomnto (id_tipo, tipo_mnto) values (1, 'Programado')
insert into Tipomnto (id_tipo, tipo_mnto) values (2, 'Imprevisto')

select * from Tipomnto

--CLIENTEGOB
insert into Clientegob (id_clientgob, name_proy, localidad, departamento)
values ('GOB-001', 'Gobierno Regional de Cajamarca', 'Jaen', 'Cajamarca')
insert into Clientegob (id_clientgob, name_proy, localidad, departamento)
values ('GOB-002', 'Gobierno Regional de Junin', 'Pangoa', 'Junin')

insert into Clientegob (id_clientgob, name_proy, localidad, departamento)
values ('GOB-003', 'Gobierno Regional de Piura', 'Tacala', 'Piura')

insert into Clientegob (id_clientgob, name_proy, localidad, departamento)
values ('GOB-004', 'Gobierno Regional de Cusco', 'Cusco', 'Cusco')

insert into Clientegob (id_clientgob, name_proy, localidad, departamento)
values ('GOB-005', 'Gobierno Regional de Arequipa', 'Yarabanba', 'Arequipa')


select * from Clientegob

--EQUIPOS - Datos 
insert into Equipo 
(id_eq, denominacion, grupo_gen, marca_eq, model_eq, fech_ini_grt, fech_fin_grt, cant_mnto_ejec, cant_mnto_pend, vigencia, comentario_fin_grt) 
values
('D-1', 'Electrocardiografo', 'BIOMEDICO', 'MINDRAY', 'R3', '15/10/2022', '31/12/2025', 2, 1, 'Vigente', 'Garantia vigente')

insert into Equipo 
(id_eq, denominacion, grupo_gen, marca_eq, model_eq, fech_ini_grt, fech_fin_grt, cant_mnto_ejec, cant_mnto_pend, vigencia, comentario_fin_grt) 
values('D-18', 'Monitor de funciones vitales', 'BIOMEDICO', 'EDAN', 'IM80', '10/06/2023', '10/12/2025', 1, 3, 'Vigente', 'Garantía vigente')

insert into Equipo 
(id_eq, denominacion, grupo_gen, marca_eq, model_eq, fech_ini_grt, fech_fin_grt, cant_mnto_ejec, cant_mnto_pend, vigencia, comentario_fin_grt) 
values
('D-201', 'Nebulizador', 'BIOMEDICO', 'CA-MI', 'CLINB PRO', '01/04/2023', '01/04/2026', 3, 4, 'Vigente', 'Garantía vigente')

insert into Equipo 
(id_eq, denominacion, grupo_gen, marca_eq, model_eq, fech_ini_grt, fech_fin_grt, cant_mnto_ejec, cant_mnto_pend, vigencia, comentario_fin_grt) 
values
('D-112', 'Incubadora de transporte', 'BIOMEDICO', 'Ningbo David', 'TI-2000', '30/10/2022', '05/06/2024', 2, 0, 'Terminada', 'Garantía Terminada')

insert into Equipo 
(id_eq, denominacion, grupo_gen, marca_eq, model_eq, fech_ini_grt, fech_fin_grt, cant_mnto_ejec, cant_mnto_pend, vigencia, comentario_fin_grt) 
values
('D-103', 'Ecografo portatil', 'BIOMEDICO', 'MINDRAY', 'DP-100', '20/05/2021', '05/06/2023', 3, 0, 'Terminada', 'Garantía Terminada')

insert into Equipo 
(id_eq, denominacion, grupo_gen, marca_eq, model_eq, fech_ini_grt, fech_fin_grt, cant_mnto_ejec, cant_mnto_pend, vigencia, comentario_fin_grt) 
values
('D-118', 'Ventilador mecánico', 'BIOMEDICO', 'MINDRAY', 'SV-600', '19/11/2024', '05/06/2026', 1, 1, 'Vigente', 'Garantía Vigente')


select * from Equipo

--MANTENIMIENTO - Datos

insert into Mantenimiento
(id_mnt, nro_otm, prioridad, fec_ini_eje_mnt, fec_fin_eje_mnt, hora_ini, hora_fin, 
descrip_problema, diag_fall, fec_emision, id_tipo, id_clientgob, id_eq, id_otm)
values ('1','OTM-001','URGENTE','15/03/2025','15/03/2025','08:00','17:00'
,'El equipo no enciende','Cable de corriente deteriorado','24/03/2025','1','GOB-001','D-1','1')
insert into Mantenimiento
(id_mnt, nro_otm, prioridad, fec_ini_eje_mnt, fec_fin_eje_mnt, hora_ini, hora_fin
, descrip_problema, diag_fall, fec_emision, id_tipo, id_clientgob, id_eq, id_otm)
values ('2','OTM-002','URGENTE','26/07/2025','27/07/2025',
'08:00','15:00','Dificultad para visualizar parametros','Pantalla defectuosa','10/08/2025','1','GOB-001','D-1','1')

insert into Mantenimiento
(id_mnt, nro_otm, prioridad, fec_ini_eje_mnt, fec_fin_eje_mnt, hora_ini, hora_fin
, descrip_problema, diag_fall, fec_emision, id_tipo, id_clientgob, id_eq, id_otm)
values ('3','OTM-003','URGENTE','20/10/2023','21/10/2023',
'09:00','17:00','Control con retraso del monitor','Panel tactil y Perilla defectuosa','30/10/2023','2','GOB-002','D-18','2')

insert into Mantenimiento
(id_mnt, nro_otm, prioridad, fec_ini_eje_mnt, fec_fin_eje_mnt, hora_ini, hora_fin
, descrip_problema, diag_fall, fec_emision, id_tipo, id_clientgob, id_eq, id_otm)
values ('4','OTM-004','URGENTE','06/08/2023','10/08/2023',
'08:00','16:00','Fugas de aire y filtro inoperativo','Manguera y filtro de aire obstruido','12/08/2023','1','GOB-003','D-201','1')


insert into Mantenimiento
(id_mnt, nro_otm, prioridad, fec_ini_eje_mnt, fec_fin_eje_mnt, hora_ini, hora_fin
, descrip_problema, diag_fall, fec_emision, id_tipo, id_clientgob, id_eq, id_otm)
values ('5','OTM-005','URGENTE','12/04/2024','15/04/2024',
'09:00','17:00','Nebulizador inoperativo','Piston malogrado','20/04/2024','2','GOB-003','D-201','2')

insert into Mantenimiento
(id_mnt, nro_otm, prioridad, fec_ini_eje_mnt, fec_fin_eje_mnt, hora_ini, hora_fin
, descrip_problema, diag_fall, fec_emision, id_tipo, id_clientgob, id_eq, id_otm)
values ('6','OTM-006','URGENTE','20/02/2025','21/02/2025',
'09:00','17:00','Emision de presion baja','Valvula obstruida','23/02/2025','1','GOB-003','D-201','1') 

insert into Mantenimiento
(id_mnt, nro_otm, prioridad, fec_ini_eje_mnt, fec_fin_eje_mnt, hora_ini, hora_fin
, descrip_problema, diag_fall, fec_emision, id_tipo, id_clientgob, id_eq, id_otm)
values ('7','OTM-007','URGENTE','15/01/2023','16/01/2023',
'09:00','18:00','Lectura inestable de parametros del neonato','Fallo en sensor de temperatura y humedad','18/01/2023','2','GOB-004','D-112','2') 

insert into Mantenimiento
(id_mnt, nro_otm, prioridad, fec_ini_eje_mnt, fec_fin_eje_mnt, hora_ini, hora_fin
, descrip_problema, diag_fall, fec_emision, id_tipo, id_clientgob, id_eq, id_otm)
values ('8','OTM-008','URGENTE','20/01/2024','23/01/2024',
'09:00','17:00','Equipo no enciende','Fallo en placa electronica','25/01/2024','2','GOB-004','D-112','2') 

insert into Mantenimiento
(id_mnt, nro_otm, prioridad, fec_ini_eje_mnt, fec_fin_eje_mnt, hora_ini, hora_fin
, descrip_problema, diag_fall, fec_emision, id_tipo, id_clientgob, id_eq, id_otm)
values ('9','OTM-009','URGENTE','10/11/2021','12/11/2021',
'08:00','17:00','Imagen con ruido y falso contacto','Transductor fallando','15/11/2021','2','GOB-005','D-103','2') 

insert into Mantenimiento
(id_mnt, nro_otm, prioridad, fec_ini_eje_mnt, fec_fin_eje_mnt, hora_ini, hora_fin
, descrip_problema, diag_fall, fec_emision, id_tipo, id_clientgob, id_eq, id_otm)
values ('10','OTM-010','URGENTE','05/10/2022','06/10/2022',
'09:00','17:00','Poca duracion y sobrecalentamiento del equipo','Bateria fallando','10/10/2022','2','GOB-005','D-103','2') 

insert into Mantenimiento
(id_mnt, nro_otm, prioridad, fec_ini_eje_mnt, fec_fin_eje_mnt, hora_ini, hora_fin
, descrip_problema, diag_fall, fec_emision, id_tipo, id_clientgob, id_eq, id_otm)
values ('11','OTM-011','URGENTE','02/10/2023','03/10/2023',
'09:00','17:00','Equipo enciende pero no muestra imagen','Fallo en pantalla','05/10/2023','2','GOB-005','D-103','2') 

insert into Mantenimiento
(id_mnt, nro_otm, prioridad, fec_ini_eje_mnt, fec_fin_eje_mnt, hora_ini, hora_fin
, descrip_problema, diag_fall, fec_emision, id_tipo, id_clientgob, id_eq, id_otm)
values ('12','OTM-012','URGENTE','19/06/2025','20/06/2025',
'08:00','17:00','Obstruccion de canales del equipo','Filtro inspiratorio y expiratorio obstruido','21/06/2025','2','GOB-005','D-118','2') 

SELECT * FROM Mantenimiento

--FECHAMNTTO - Datos

insert into Fechamnto (id_fec, fech_prog, fech_ejec, comentario, id_eq) values ('1', '30/04/2025','15/03/2025','Primer mantenimiento ejecutado', 'D-1')
insert into Fechamnto (id_fec, fech_prog, fech_ejec, comentario, id_eq) values ('2', '12/08/2025','26/07/2025','Segundo mantenimiento ejecutado', 'D-1')

insert into Fechamnto (id_fec, fech_prog, fech_ejec, comentario, id_eq) values ('3', '12/10/2023','20/10/2023','Primer mantenimiento ejecutado', 'D-18')

insert into Fechamnto (id_fec, fech_prog, fech_ejec, comentario, id_eq) values ('4', '01/08/2023','06/08/2023','Primer mantenimiento ejecutado', 'D-201')
insert into Fechamnto (id_fec, fech_prog, fech_ejec, comentario, id_eq) values ('5', '20/04/2024','15/04/2024','Segundo mantenimiento ejecutado', 'D-201')
insert into Fechamnto (id_fec, fech_prog, fech_ejec, comentario, id_eq) values ('6', '10/02/2025','20/02/2025','Tercer mantenimiento ejecutado', 'D-201')

insert into Fechamnto (id_fec, fech_prog, fech_ejec, comentario, id_eq) values ('7', '20/01/2023','15/01/2023','Primer mantenimiento ejecutado', 'D-112')
insert into Fechamnto (id_fec, fech_prog, fech_ejec, comentario, id_eq) values ('8', '30/01/2024','20/01/2024','Segundo mantenimiento ejecutado', 'D-112')

insert into Fechamnto (id_fec, fech_prog, fech_ejec, comentario, id_eq) values ('9', '15/11/2021','10/11/2021','Primer mantenimiento ejecutado', 'D-103')
insert into Fechamnto (id_fec, fech_prog, fech_ejec, comentario, id_eq) values ('10', '30/09/2022','05/10/2022','Segundo mantenimiento ejecutado', 'D-103')
insert into Fechamnto (id_fec, fech_prog, fech_ejec, comentario, id_eq) values ('11', '25/09/2023','02/10/2023','Tercer mantenimiento ejecutado', 'D-103')

insert into Fechamnto (id_fec, fech_prog, fech_ejec, comentario, id_eq) values ('12', '20/06/2025','19/06/2025','Primer mantenimiento ejecutado', 'D-118')
select * from Fechamnto


--DETALLE REPUESTO MANTENIMIENTO - Datos

insert into Detalle_repuesto_mantenimiento (id_rep, id_mnt ,cantidad_usada) values ('REP-LC01', '2', 1)
insert into Detalle_repuesto_mantenimiento (id_rep, id_mnt ,cantidad_usada) values ('REP-CT01', '1', 2)

insert into Detalle_repuesto_mantenimiento (id_rep, id_mnt ,cantidad_usada) values ('REP-EC01', '3', 1)
insert into Detalle_repuesto_mantenimiento (id_rep, id_mnt ,cantidad_usada) values ('REP-PF01', '3', 2)

insert into Detalle_repuesto_mantenimiento (id_rep, id_mnt ,cantidad_usada) values ('REP-EC01', '3', 1)

insert into Detalle_repuesto_mantenimiento (id_rep, id_mnt ,cantidad_usada) values ('REP-BP01', '5', 1)
insert into Detalle_repuesto_mantenimiento (id_rep, id_mnt ,cantidad_usada) values ('REP-SC01', '5', 1)

insert into Detalle_repuesto_mantenimiento (id_rep, id_mnt ,cantidad_usada) values ('REP-SH01', '7', 1)
insert into Detalle_repuesto_mantenimiento (id_rep, id_mnt ,cantidad_usada) values ('REP-TI01', '7', 1)
insert into Detalle_repuesto_mantenimiento (id_rep, id_mnt ,cantidad_usada) values ('REP-PE01', '8', 1)

insert into Detalle_repuesto_mantenimiento (id_rep, id_mnt ,cantidad_usada) values ('REP-DP01', '9', 1)
insert into Detalle_repuesto_mantenimiento (id_rep, id_mnt ,cantidad_usada) values ('REP-BT01', '10', 1)
insert into Detalle_repuesto_mantenimiento (id_rep, id_mnt ,cantidad_usada) values ('REP-LD01', '11', 1)


select * from Detalle_repuesto_mantenimiento
select * from Repuesto
select * from Mantenimiento

--DETALLE ACTIVIDADES MANTENIMIENTO - Datos
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-001', '1', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-003', '1', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-001', '2', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-002', '2', 'REALIZADO')

insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-001', '3', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-004', '3', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-005', '3', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-002', '3', 'REALIZADO')

insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-001', '4', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-004', '4', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-006', '4', 'REALIZADO')

insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-001', '5', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-002', '5', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-004', '5', 'REALIZADO')

insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-001', '6', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-006', '6', 'REALIZADO')

insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-001', '7', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-004', '7', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-002', '7', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-005', '7', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-006', '7', 'REALIZADO')

insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-001', '8', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-004', '8', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-002', '8', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-005', '8', 'REALIZADO')

insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-001', '9', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-003', '9', 'REALIZADO')

insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-001', '10', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-004', '10', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-002', '10', 'REALIZADO')

insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-001', '11', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-004', '11', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-002', '11', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-005', '11', 'REALIZADO')

insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-001', '12', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-004', '12', 'REALIZADO')
insert into Detalle_actividades_mantenimiento (id_act, id_mnt, estatus) values ('ACT-006', '12', 'REALIZADO')

select * from Detalle_actividades_mantenimiento

select * from Actividades

select * from Mantenimiento

--DETALLE MANTENIMIENTO - Datos
INSERT INTO Detalle_mantenimiento (id_mnt, horas_hombre, servicio_hosp, id_per)
SELECT 
    m.id_mnt,
    DATEDIFF(MINUTE, m.hora_ini, m.hora_fin) / 60.0,
    'Sala de emergencias',
    'PER-001'
FROM Mantenimiento m
WHERE m.id_mnt = 1;

INSERT INTO Detalle_mantenimiento (id_mnt, horas_hombre, servicio_hosp, id_per)
SELECT 
    m.id_mnt,
    DATEDIFF(MINUTE, m.hora_ini, m.hora_fin) / 60.0,
    'Sala de emergencias',
    'PER-002'
FROM Mantenimiento m
WHERE m.id_mnt = 2;

INSERT INTO Detalle_mantenimiento (id_mnt, horas_hombre, servicio_hosp, id_per)
SELECT 
    m.id_mnt,
    DATEDIFF(MINUTE, m.hora_ini, m.hora_fin) / 60.0,
    'Sala de emergencias',
    'PER-001'
FROM Mantenimiento m
WHERE m.id_mnt = 2;


INSERT INTO Detalle_mantenimiento (id_mnt, horas_hombre, servicio_hosp, id_per)
SELECT 
    m.id_mnt,
    DATEDIFF(MINUTE, m.hora_ini, m.hora_fin) / 60.0,
    'Central de monitoreo',
    'PER-008'
FROM Mantenimiento m
WHERE m.id_mnt = 3;

INSERT INTO Detalle_mantenimiento (id_mnt, horas_hombre, servicio_hosp, id_per)
SELECT 
    m.id_mnt,
    DATEDIFF(MINUTE, m.hora_ini, m.hora_fin) / 60.0,
    'Central de monitoreo',
    'PER-009'
FROM Mantenimiento m
WHERE m.id_mnt = 3;

INSERT INTO Detalle_mantenimiento (id_mnt, horas_hombre, servicio_hosp, id_per)
SELECT 
    m.id_mnt,
    DATEDIFF(MINUTE, m.hora_ini, m.hora_fin) / 60.0,
    'Central de monitoreo',
    'PER-010'
FROM Mantenimiento m
WHERE m.id_mnt = 3;


INSERT INTO Detalle_mantenimiento (id_mnt, horas_hombre, servicio_hosp, id_per)
SELECT 
    m.id_mnt,
    DATEDIFF(MINUTE, m.hora_ini, m.hora_fin) / 60.0,
    'Consultorio medicina general',
    'PER-004'
FROM Mantenimiento m
WHERE m.id_mnt = 4;

INSERT INTO Detalle_mantenimiento (id_mnt, horas_hombre, servicio_hosp, id_per)
SELECT 
    m.id_mnt,
    DATEDIFF(MINUTE, m.hora_ini, m.hora_fin) / 60.0,
    'Consultorio medicina general',
    'PER-006'
FROM Mantenimiento m
WHERE m.id_mnt = 5;

INSERT INTO Detalle_mantenimiento (id_mnt, horas_hombre, servicio_hosp, id_per)
SELECT 
    m.id_mnt,
    DATEDIFF(MINUTE, m.hora_ini, m.hora_fin) / 60.0,
    'Consultorio medicina general',
    'PER-007'
FROM Mantenimiento m
WHERE m.id_mnt = 5;

INSERT INTO Detalle_mantenimiento (id_mnt, horas_hombre, servicio_hosp, id_per)
SELECT 
    m.id_mnt,
    DATEDIFF(MINUTE, m.hora_ini, m.hora_fin) / 60.0,
    'Consultorio medicina general',
    'PER-003'
FROM Mantenimiento m
WHERE m.id_mnt = 5;

INSERT INTO Detalle_mantenimiento (id_mnt, horas_hombre, servicio_hosp, id_per)
SELECT 
    m.id_mnt,
    DATEDIFF(MINUTE, m.hora_ini, m.hora_fin) / 60.0,
    'Consultorio medicina general',
    'PER-001'
FROM Mantenimiento m
WHERE m.id_mnt = 6;


INSERT INTO Detalle_mantenimiento (id_mnt, horas_hombre, servicio_hosp, id_per)
SELECT 
    m.id_mnt,
    DATEDIFF(MINUTE, m.hora_ini, m.hora_fin) / 60.0,
    'Area de neonatologia',
    'PER-009'
FROM Mantenimiento m
WHERE m.id_mnt = 7;

INSERT INTO Detalle_mantenimiento (id_mnt, horas_hombre, servicio_hosp, id_per)
SELECT 
    m.id_mnt,
    DATEDIFF(MINUTE, m.hora_ini, m.hora_fin) / 60.0,
    'Area de neonatologia',
    'PER-009'
FROM Mantenimiento m
WHERE m.id_mnt = 8;

INSERT INTO Detalle_mantenimiento (id_mnt, horas_hombre, servicio_hosp, id_per)
SELECT 
    m.id_mnt,
    DATEDIFF(MINUTE, m.hora_ini, m.hora_fin) / 60.0,
    'Area de neonatologia',
    'PER-010'
FROM Mantenimiento m
WHERE m.id_mnt = 8;


INSERT INTO Detalle_mantenimiento (id_mnt, horas_hombre, servicio_hosp, id_per)
SELECT 
    m.id_mnt,
    DATEDIFF(MINUTE, m.hora_ini, m.hora_fin) / 60.0,
    'Area de Ginecologia',
    'PER-008'
FROM Mantenimiento m
WHERE m.id_mnt = 9;

INSERT INTO Detalle_mantenimiento (id_mnt, horas_hombre, servicio_hosp, id_per)
SELECT 
    m.id_mnt,
    DATEDIFF(MINUTE, m.hora_ini, m.hora_fin) / 60.0,
    'Area de Ginecologia',
    'PER-007'
FROM Mantenimiento m
WHERE m.id_mnt = 10;

INSERT INTO Detalle_mantenimiento (id_mnt, horas_hombre, servicio_hosp, id_per)
SELECT 
    m.id_mnt,
    DATEDIFF(MINUTE, m.hora_ini, m.hora_fin) / 60.0,
    'Area de Ginecologia',
    'PER-008'
FROM Mantenimiento m
WHERE m.id_mnt = 11;


INSERT INTO Detalle_mantenimiento (id_mnt, horas_hombre, servicio_hosp, id_per)
SELECT 
    m.id_mnt,
    DATEDIFF(MINUTE, m.hora_ini, m.hora_fin) / 60.0,
    'UCI',
    'PER-001'
FROM Mantenimiento m
WHERE m.id_mnt = 12;

select * from Detalle_mantenimiento

select * from Personal

select * from Mantenimiento

/*
Consultas
*/
--1. Consulta para saber la cantidad de horas hombre realizadas por persona
SELECT 
p.name_per,
COUNT(dm.id_mnt) AS total_participaciones
FROM Detalle_mantenimiento dm
INNER JOIN Personal p ON dm.id_per = p.id_per
GROUP BY p.name_per
ORDER BY total_participaciones DESC;
--2. Equipos con mas mantenimientos ejecutados realizados
SELECT 
e.denominacion,
COUNT(m.id_mnt) AS [Total Mantenimientos Ejec.]
FROM Mantenimiento m
INNER JOIN Equipo e ON m.id_eq = e.id_eq
GROUP BY e.denominacion
ORDER BY [Total Mantenimientos Ejec.] DESC;
--3. Cantidad de Mantenimiento por tipos
SELECT 
    t.tipo_mnto,
    COUNT(*) AS cantidad
FROM Mantenimiento m
INNER JOIN Tipomnto t ON m.id_tipo = t.id_tipo
GROUP BY t.tipo_mnto;
--4. Cuales son los equipos que han tenido mantenimientos correctivos
SELECT DISTINCT
    e.id_eq,
    e.denominacion,
    e.marca_eq,
    e.model_eq
FROM Mantenimiento m
INNER JOIN Equipo e 
    ON m.id_eq = e.id_eq
INNER JOIN Tipootm t
    ON m.id_otm = t.id_otm
WHERE t.tipo_otm = 'Correctivo';

--5 Cantidad de mantenimientos realizados por anios
SELECT
    YEAR(fec_ini_eje_mnt) AS Anio,
    COUNT(id_mnt) AS Total_Mantenimientos
FROM Mantenimiento
GROUP BY YEAR(fec_ini_eje_mnt)
ORDER BY Anio;
--6. Promedio de horas por mantenimineto - Obj: Disposicion de viaticos
SELECT 
    m.nro_otm,
    AVG(dm.horas_hombre) AS promedio_horas
FROM Mantenimiento m
INNER JOIN Detalle_mantenimiento dm ON m.id_mnt = dm.id_mnt
GROUP BY m.id_mnt, m.nro_otm;
--7. Actividades mas realizadas en mantenimientos - Obj: Saber como agrupar al personal para futuros mantenimientos
SELECT
    a.descrip_act,
    COUNT(*) AS veces_realizada
FROM Detalle_actividades_mantenimiento dam
INNER JOIN Actividades a ON dam.id_act = a.id_act
GROUP BY a.descrip_act
ORDER BY veces_realizada DESC;
--8. Equipos que generan mas costo operativo
SELECT
    e.denominacion AS equipo,
    SUM(dm.horas_hombre) AS horas_invertidas
FROM Mantenimiento m
INNER JOIN Detalle_mantenimiento dm ON m.id_mnt = dm.id_mnt
INNER JOIN Equipo e ON m.id_eq = e.id_eq
GROUP BY e.denominacion
ORDER BY horas_invertidas DESC;
--9.Que equipos cuentan con mantenimientos retrasados y saber la cantidad de dias de retraso
SELECT
    e.denominacion AS equipo,
    f.fech_prog,
    f.fech_ejec,
    DATEDIFF(DAY, f.fech_prog, f.fech_ejec) AS dias_retraso
FROM Fechamnto f
INNER JOIN Equipo e ON f.id_eq = e.id_eq
WHERE f.fech_ejec > f.fech_prog
ORDER BY dias_retraso DESC;
/*
Procedimentos almacendados
--1. Que repuestos se utilizaron en un mantenimiento y a que equipo se realizaron realizando busqueda por NroOTM
*/
CREATE PROCEDURE sp_RepuestosPorOTM
    @nro_otm CHAR(10)
AS
BEGIN
    SELECT
        m.id_mnt,
        m.nro_otm,
        e.id_eq,
        e.denominacion AS equipo,
        r.id_rep,
        r.detalle AS repuesto,
        drm.cantidad_usada
    FROM Detalle_repuesto_mantenimiento drm
    INNER JOIN Repuesto r 
        ON drm.id_rep = r.id_rep
    INNER JOIN Mantenimiento m
        ON drm.id_mnt = m.id_mnt
    INNER JOIN Equipo e
        ON m.id_eq = e.id_eq
    WHERE m.nro_otm = @nro_otm
    ORDER BY r.detalle
END

EXEC sp_RepuestosPorOTM 'OTM-007'


/*--2. Que actividades se realizaron en tal mantenimiento y a que equipo realizando su busqueda por NroOTM */

CREATE PROCEDURE sp_ActividadesPorOTM
    @nro_otm CHAR(10)
AS
BEGIN
    SELECT
        m.id_mnt,
        m.nro_otm,
        e.id_eq,
        e.denominacion AS equipo,
        a.id_act,
        a.descrip_act AS actividad,
        dam.estatus
    FROM Detalle_actividades_mantenimiento dam
    INNER JOIN Actividades a
        ON dam.id_act = a.id_act
    INNER JOIN Mantenimiento m
        ON dam.id_mnt = m.id_mnt
    INNER JOIN Equipo e
        ON m.id_eq = e.id_eq
    WHERE m.nro_otm = @nro_otm
    ORDER BY a.descrip_act
END

EXEC sp_ActividadesPorOTM 'OTM-007'



