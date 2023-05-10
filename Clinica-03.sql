create database Proyecto_Clinica

use Proyecto_Clinica

CREATE TABLE Pacientes 
(
    paciente_id INT PRIMARY KEY,
    nombre NVARCHAR(50) not null,
    apellido NVARCHAR(50) not null,
	sexo NCHAR(10) CHECK (sexo IN ('Masculino', 'Femenino')),
    fecha_nacimiento DATE not null,
	edad int,
    direccion NVARCHAR(100),
    telefono NVARCHAR(15) not null
);



create TABLE Especialidades
(
    especialidad_id INT PRIMARY KEY,
    descripcion NVARCHAR(50) CONSTRAINT CH_descEspec
	CHECK (descripcion in('Medicina General','Pediatría','Ginecología','Dermatología', 'Cardiología'))
);

CREATE TABLE Doctores 
(
    doctor_id INT PRIMARY KEY,
    nombre NVARCHAR(50),
    apellido NVARCHAR(50),
	fecha_nacimiento DATE,
    especialidad_id INT FOREIGN KEY REFERENCES Especialidades(especialidad_id)
);

CREATE TABLE Unidades 
(
    unidad_id INT PRIMARY KEY,
    descripcion NVARCHAR(100) CONSTRAINT CH_descUnid 
	CHECK (descripcion in('Urgencias','Consulta Externa','Pediatría','Ginecología y Obstetricia','Cardiología'))
);

CREATE TABLE Citas 
(
    cita_id INT identity(1,1) PRIMARY KEY,
    paciente_id INT FOREIGN KEY REFERENCES Pacientes(paciente_id),
    doctor_id INT FOREIGN KEY REFERENCES Doctores(doctor_id),
    unidad_id INT FOREIGN KEY REFERENCES Unidades(unidad_id),
    fecha DATE,
	hora TIME(0) CONSTRAINT CH_RangoHora CHECK (DATEPART(HOUR, hora) BETWEEN 8 AND 17),
    estado NVARCHAR(20) CONSTRAINT CH_estado CHECK (estado in('Activo','Finalizado','Cancelado'))
);


CREATE TABLE Servicios 
(
    servicio_id INT PRIMARY KEY,
    descripcion NVARCHAR(50),
    costo DECIMAL(10, 2)
);

CREATE TABLE Facturas 
(
    factura_id INT identity(1,1) PRIMARY KEY,
    cita_id INT FOREIGN KEY REFERENCES Citas(cita_id),
    servicio_id INT FOREIGN KEY REFERENCES Servicios(servicio_id),
    fecha SMALLDATETIME DEFAULT GETDATE(),
    monto DECIMAL(10, 2)
);

--Ingreso de datos de la tabla Paciente--
select*from Pacientes
INSERT INTO Pacientes VALUES
(1, 'Juan', 'Pérez', 'Masculino','1985-03-15', 38,'Calle 1 #10-20', '3001234567'),
(2, 'Maria', 'González', 'Femenino','1990-08-25',33, 'Calle 2 #15-30', '3109876543'),
(3, 'Carlos', 'Rodríguez', 'Masculino', '1982-11-30', 41,'Calle 3 #20-40', '3204567890'),
(4, 'Ana', 'Martínez', 'Femenino', '1975-06-10', 48,'Calle 4 #25-50', '3308521479'),
(5, 'Miguel', 'García', 'Masculino', '2000-01-05',23, 'Calle 5 #30-60', '3401592638');

--Ingreso de datos de la tabla Especialidades--
select*from Especialidades
INSERT INTO Especialidades VALUES
(1, 'Medicina General'),
(2, 'Pediatría'),
(3, 'Ginecología'),
(4, 'Dermatología'),
(5, 'Cardiología');

--Ingreso de datos de la tabla Doctores--
select*from Doctores
INSERT INTO Doctores VALUES
(1, 'Laura', 'Ramírez', '1968/09/23', 1),
(2, 'Pedro', 'López', '1970/05/05', 2),
(3, 'Sandra', 'Morales', '1985/07/26', 3),
(4, 'Fernando', 'Gómez', '1991/04/01', 4),
(5, 'Carmen', 'Torres', '1989/08/14', 5);

--Ingreso de datos de la tabla Unidades--
select*from Unidades
INSERT INTO Unidades VALUES
(1, 'Urgencias'),
(2, 'Consulta Externa'),
(3, 'Pediatría'),
(4, 'Ginecología y Obstetricia'),
(5, 'Cardiología');

--Ingreso de datos de la tabla Citas--
select*from Citas
INSERT INTO Citas (paciente_id, doctor_id, unidad_id, fecha, hora, estado) VALUES
(1, 1, 1, '2023-06-16', '09:00', 'Activo'),
(2, 2, 2, '2023-09-20', '09:30', 'Activo'),
(3, 3, 3, '2023-01-15', '10:00', 'Activo'),
(4, 4, 4, '2023-07-12', '10:30', 'Activo'),
(5, 5, 5, '2023-04-25', '11:00', 'Activo');

--Ingreso de datos de la tabla Servicios
select*from Servicios
INSERT INTO Servicios VALUES
(1, 'Consulta General', 5.00),
(2, 'Curaciones', 20.0),
(3, 'Exámenes', 20.0),
(4, 'Citología', 30.0),
(5, 'Rayos-x', 35.0);

--Ingreso de datos de la tabla Facturas
select*from Facturas
INSERT INTO Facturas (cita_id, servicio_id, monto) VALUES
(2, 1, 5.00),
(3, 2, 20.0),
(4, 3, 20.0),
(5, 4, 30.0);

	  
--CONSULTAS--

-- 1.Citas de pacientes por doctor y especialidad:
SELECT 
p.paciente_id,
p.nombre +' '+p.apellido as 'Nombre del Paciente',
d.nombre AS Doctor, 
e.descripcion AS Especialidad, 
c.fecha, c.hora, 
u.descripcion AS Unidad
FROM Citas c 
JOIN Pacientes p ON c.paciente_id = p.paciente_id
JOIN Doctores d ON c.doctor_id = d.doctor_id
JOIN Especialidades e ON d.especialidad_id = e.especialidad_id
JOIN Unidades u ON c.unidad_id = u.unidad_id;

-- 2.Consulta de facturas por paciente y servicio:
SELECT 
p.paciente_id,
p.nombre AS Paciente, 
s.descripcion AS Servicio, 
f.fecha, 
f.monto
FROM Facturas f
JOIN Citas c ON f.cita_id = c.cita_id
JOIN Pacientes p ON c.paciente_id = p.paciente_id
JOIN Servicios s ON f.servicio_id = s.servicio_id;

-- 3.Consulta de citas por especialidad y unidad:
SELECT e.descripcion AS especialidad, 
u.descripcion AS unidad, 
COUNT(c.cita_id) AS cantidad_citas
FROM Citas c
JOIN Doctores d ON c.doctor_id = d.doctor_id
JOIN Especialidades e ON d.especialidad_id = e.especialidad_id
JOIN Unidades u ON c.unidad_id = u.unidad_id
GROUP BY e.descripcion, u.descripcion;

-- 4.Consulta de doctores con más citas por especialidad:
SELECT CONCAT(d.nombre,' ',d.apellido) AS Doctor, e.descripcion AS especialidad, COUNT(c.cita_id) AS cantidad_citas
FROM Citas c
JOIN Doctores d ON c.doctor_id = d.doctor_id
JOIN Especialidades e ON d.especialidad_id = e.especialidad_id
GROUP BY d.nombre, d.apellido, e.descripcion
ORDER BY COUNT(c.cita_id) DESC;

-- 5.Consulta de ingresos por unidad y servicio:
SELECT 
u.descripcion AS unidad, 
s.descripcion AS servicio, 
SUM(f.monto) AS ingresos
FROM Facturas f
JOIN Citas c ON f.cita_id = c.cita_id
JOIN Unidades u ON c.unidad_id = u.unidad_id
JOIN Servicios s ON f.servicio_id = s.servicio_id
GROUP BY u.descripcion, s.descripcion;

---------------------------SP--------------------------------

--------registrar PACIENTES---------------
select*from Pacientes

create proc sp_RegistrarPaciente
(
@pacienteID int,
@nombre NVARCHAR(50),
@apellido NVARCHAR(50),
@sexo NCHAR(10),
@fechaNacimiento DATE,
@edad int,
@direccion NVARCHAR(100),
@telefono NVARCHAR(15)
)
as begin
insert into Pacientes values(@pacienteID,@nombre,@apellido,@sexo,@fechaNacimiento,@edad,@direccion,@telefono)
end

--------actualizar Pacientes---------------
create proc sp_ActualizarPaciente
(
@pacienteID int,
@nombre NVARCHAR(50),
@apellido NVARCHAR(50),
@sexo NCHAR(10),
@fechaNacimiento DATE,
@edad int,
@direccion NVARCHAR(100),
@telefono NVARCHAR(15)
)
as begin
UPDATE Pacientes
SET nombre = @nombre, apellido = @apellido, sexo = @sexo, fecha_nacimiento=@fechaNacimiento, edad=@edad, direccion = @direccion
WHERE paciente_id = @pacienteID
end

--------eliminar Pacientes---------------
create proc sp_EliminarPaciente
@pacienteID int
as begin
DELETE FROM Pacientes
WHERE paciente_id = @pacienteID
end


--------registrar DOCTORES---------------
select*from Doctores

create proc sp_RegistrarDoctores
(
@doctorID int,
@nombre NVARCHAR(50),
@apellido NVARCHAR(50),
@fechaNacimiento DATE,
@especialidad INT
)
as begin
insert into Doctores values(@doctorID,@nombre,@apellido,@fechaNacimiento,@especialidad)
end

--------actualizar DOCTORES---------------
create proc sp_ActualizarDoctores
(
@doctorID int,
@nombre NVARCHAR(50),
@apellido NVARCHAR(50),
@fechaNacimiento DATE,
@especialidad INT
)
as begin
UPDATE Doctores
SET nombre = @nombre, apellido = @apellido, fecha_nacimiento=@fechaNacimiento, especialidad_id=@especialidad
WHERE doctor_id = @doctorID
end

--------eliminar DOCTOR---------------
create proc sp_EliminarDoctor
@doctorID int
as begin
DELETE FROM Doctores
WHERE doctor_id = @doctorID
end

--------programar CITA---------------
select*from Citas

create proc sp_ProgramarCita
(
@pacienteID int,
@doctorID int,
@unidadID int,
@fechaCita DATE,
@horaCita time(0),
@estado nvarchar(20)
)
as begin
insert into Citas values(@pacienteID,@doctorID,@unidadID,@fechaCita,@horaCita,@estado)
end

--------actualizar CITA---------------
create proc sp_ActualizarCita
(
@citaID int,
@pacienteID int,
@doctorID int,
@unidadID int,
@fechaCita DATE,
@horaCita time(0),
@estado nvarchar(20)
)
as begin
UPDATE Citas
SET paciente_id = @pacienteID, doctor_id = @doctorID, unidad_id=@unidadID, fecha=@fechaCita,hora=@horaCita,estado=@estado
WHERE cita_id = @citaID
end
---no cree SP de eliminar cita ya que en el -estado- de la cita se puede modificar a -CANCELADO- 
--y así tener el registro para futuros reportes

--------crear FACTURA---------------
select*from Facturas

create proc sp_CrearFactura
(
@citaID int,
@servicioID int,
@monto decimal(10,2)
)
as begin
insert into Facturas (cita_id, servicio_id, monto) 
values(@citaID,@servicioID,@monto)
end

--------actualizar FACTURA---------------
create proc sp_ActualizarFactura
(
@facturaID int,
@citaID int,
@servicioID int,
@monto decimal(10,2)
)
as begin
UPDATE Facturas
SET cita_id = @citaID, servicio_id = @servicioID, monto=@monto
WHERE factura_id = @facturaID
end

----------Registro Especialidad------------
CREATE PROCEDURE sp_Registrar_Especialidad
(
   @especialidad_id INT,
   @descripcion VARCHAR(50)
)
AS
BEGIN
   INSERT INTO Especialidades (especialidad_id, descripcion)
   VALUES (@especialidad_id, @descripcion)
END
-------Eliminar Registro ---------

CREATE PROCEDURE sp_EliminarEspecialidad
(
   @especialidad_id INT
)
AS
BEGIN
   DELETE FROM Especialidades WHERE especialidad_id = @especialidad_id
END

--------registrar SERVICIOS---------------
create proc sp_CrearServicio
(
	@servicio_id int,
	@descripcion nvarchar(50),
	@costo decimal(10, 2)
)
as
	begin
		insert into Servicios (servicio_id, descripcion, costo)
		values (@servicio_id, @descripcion, @costo)
	end

--------actualizar SERVICIOS---------------
create proc sp_ActualizarServicio
(
	@servicio_id int,
	@descripcion nvarchar(50),
	@costo decimal(10, 2)
)
as
	begin
		update Servicios set servicio_id = @servicio_id, descripcion = @descripcion, costo = @costo 
		where servicio_id = @servicio_id
	end
--------eliminar SERVICIOS---------------
create proc sp_EliminarServicio
(
	@servicio_id int
)
	as
	begin
		delete from Servicios
		where servicio_id = @servicio_id
	end

--------registrar unidad---------
CREATE PROCEDURE sp_Registrar_Unidad
(
   @unidad_id INT,
   @descripcion VARCHAR(50)
)
AS
BEGIN
   INSERT INTO Unidades (unidad_id, descripcion)
   VALUES (@unidad_id, @descripcion)
END

--------Eliminar unidad-----------------
CREATE PROCEDURE sp_EliminarUnidad
(
   @unidad_id INT
)
AS
BEGIN
   DELETE FROM Unidades WHERE unidad_id = @unidad_id
END