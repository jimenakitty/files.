use master
go
drop database bd_pedidos
go
create database bd_pedidos 
go
use bd_pedidos
go
create table T_Proveedores (
id int identity(1,1) constraint pk_Proveedor primary key,
nombre varchar (100) not null,
telefeno int constraint un_telefonoP unique not null,
correo varchar (100) constraint un_correoP unique not null,
estado bit not null
)
go
create table T_Productos (
id int identity (1,1) constraint pk_Producto primary key,
nombre varchar (100) not null,
stok int not null,
estado bit not null,
precio float not null,
cod_Proveedor int constraint fk_CodProveedor foreign key references T_Proveedores(id)
)
go
create table T_Clientes(
id int identity (1,1) constraint pk_Cliente primary key,
nombre varchar (100) not null,
telefono int constraint un_telefonoC unique not null,
correo varchar (100) constraint un_correoC unique not null,
estado bit not null
)
create table T_Pedidos (
id int identity (1,1) constraint pk_pedido primary key,
fechaPedido date constraint df_FechaPedido default (getdate()),
codigoPedido int not null,
cod_cliente int constraint fk_CodCliente foreign key references T_Clientes(id),
cod_producto int constraint fk_CodProducto foreign key references T_Productos(id)
)
go
insert into T_Proveedores (nombre, telefeno,correo,estado)
					values('Tosty',234234,'tosty@tsty.com',1),
						  ('Coca Cola',23423,'coca@cola.com',1),
						  ('Diana',394803,'productos_diana@diana.com',1),
						  ('Dos Pinos',324234,'dospinos@dosP.com',1),
						  ('Los patitos', 29903,'Patitlos@patos.com',0),
						  ('Los michis',32342,'michiis@mich.com',1)
go
select * from T_Proveedores
go
insert into T_Productos (nombre, stok,estado,precio,cod_Proveedor)
				  values('Chirulitos',20, 1,350,1),
						('Bolitas de queso',12, 1,350,1),
						('Chirulitos',20, 1,350,1),
						('Coca cola',100, 1,500,2),
						('Fanta naranja',0, 0,500,2),
						('Hi-c',30, 1,650,2),
						('Centavitos',13,1,200,3),
						('Alborotos',34,1,200,3),
						('Maiz chino picante',32,1,200,3),
						('Frecoleche fresa', 12,1,650,4),
						('Frecoleche chocolate', 12,1,650,4),
						('Frecoleche vainilla', 12,1,650,4),
						('Frecoleche caramelo', 0,0,650,4),
						('patito de hule' , 0, 0,250,5)
go
select * from T_Productos
go

insert into T_Clientes (nombre,telefono,correo,estado)
				values('Sara Vargas',34323233,'saravargas@gmail.com',1),
					  ('Mariana Marin',6533433,'nana@gmial.com',0),
					  ('Daniel Fernandez',3343533,'dafer@gmail.com',1),
					  ('Alexis Mata',23242,'alexis@hotmail.com',0),
					  ('Sharon Cordero',9909768,'sharon@outlook.com',1)
go
select * from T_Clientes
go

insert into T_Pedidos (cod_cliente,cod_producto,codigoPedido)
				values(1,1,1),
				(1,3,1),
				(1,5,1),
				(1,6,2),
				(2,7,3),
				(3,2,3),
				(3,1,3),
				(3,7,4),
				(3,9,4),
				(5,6,5),
				(5,8,5)
select * from T_Pedidos
-- 1. Mostrar los nombres de los clientes que han comprado los productos con los ids 5, 4 y 3
SELECT DISTINCT c.nombre
FROM T_Clientes c
INNER JOIN T_Pedidos p ON c.id = p.cod_cliente
WHERE p.cod_producto IN (3, 4, 5);

-- 2. Mostrar los productos que están inactivos y que tengan un precio menor o igual a 500
SELECT *
FROM T_Productos
WHERE estado = 0 AND precio <= 500;

-- 3. Validar que exista el producto con id 10, si no existe deberá indicarlo en consola
IF EXISTS (SELECT 1 FROM T_Productos WHERE id = 10)
    PRINT 'El producto con ID 10 existe';
ELSE
    PRINT 'El producto con ID 10 no existe';

-- 4. Mostrar los productos que tengan un precio entre los 500 y 650 y que estén activos
SELECT *
FROM T_Productos
WHERE precio BETWEEN 500 AND 650 AND estado = 1;

-- 5. Mostrar los nombres de los proveedores que contengan "T" y que estén activos
SELECT nombre
FROM T_Proveedores
WHERE nombre LIKE '%T%' AND estado = 1;

-- 6. Sumar los precios de los productos con id 4, 8 y 4 y mostrar el resultado en consola
DECLARE @suma DECIMAL(10,2);
SELECT @suma = SUM(precio)
FROM T_Productos
WHERE id IN (4, 8);

PRINT 'La suma de los precios es: ' + CAST(@suma AS VARCHAR(20));

-- 7. Validar que exista un cliente por medio del id y cambiar el nombre y el telefono
-- en caso que no exista deberá de guardar el nuevo cliente
DECLARE @cliente_id INT = 1; -- ID del cliente a buscar
DECLARE @nuevo_nombre VARCHAR(100) = 'Juan Pérez';
DECLARE @nuevo_telefono INT = 12345678;
DECLARE @nuevo_correo VARCHAR(100) = 'juan.perez@email.com';

IF EXISTS (SELECT 1 FROM T_Clientes WHERE id = @cliente_id)
BEGIN
    UPDATE T_Clientes
    SET nombre = @nuevo_nombre, telefono = @nuevo_telefono
    WHERE id = @cliente_id;
    PRINT 'Cliente actualizado correctamente';
END
ELSE
BEGIN
    INSERT INTO T_Clientes (nombre, telefono, correo, estado)
    VALUES (@nuevo_nombre, @nuevo_telefono, @nuevo_correo, 1);
    PRINT 'Nuevo cliente guardado correctamente';
END
