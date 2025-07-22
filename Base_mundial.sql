CREATE DATABASE mundial_futbol;
use mundial_futbol;

CREATE TABLE T_Equipos (
    id_equipo int identity(1,1) constraint pk_Equipo primary key,
    nombre_equipo varchar(50) constraint nn_nombreEquipo not null,
    pais varchar(50) constraint nn_paisEquipo not null,
    entrenador varchar(100),
    año_mundial int constraint nn_añoEquipo not null
);

CREATE TABLE T_Estadios (
    id_estadio int identity(1,1) constraint pk_Estadio primary key,
    nombre_estadio varchar(100) constraint nn_nombreEstadio not null,
    ciudad varchar(50) constraint nn_ciudadEstadio not null,
    capacidad int constraint df_capacidadEstadio default 10000,
    pais_estadio varchar(50) constraint nn_paisEstadio not null
);

CREATE TABLE T_Grupos (
    id_grupo int identity(1,1) constraint pk_Grupo primary key,
    nombre_grupo char(1) constraint nn_nombreGrupo not null,
    año_mundial int constraint nn_añoGrupo not null
);

CREATE TABLE T_Arbitros (
    id_arbitro int identity(1,1) constraint pk_Arbitro primary key,
    nombre_arbitro varchar(100) constraint nn_nombreArbitro not null,
    apellido_arbitro varchar(100) constraint nn_apellidoArbitro not null,
    nacionalidad varchar(50) constraint nn_nacionalidadArbitro not null,
    posicion varchar(10) not null,
    año_mundial int constraint nn_añoArbitro not null
);

CREATE TABLE T_Jugadores (
    id_jugador int identity(1,1) constraint pk_Jugador primary key,
    nombre_jugador varchar(100) constraint nn_nombreJugador not null,
    apellido_jugador varchar(100) constraint nn_apellidoJugador not null,
    edad int not null,
    posicion varchar(20) not null,
    numero_camiseta int,
    id_equipo int constraint nn_equipoJugador not null,
    constraint fk_equipoJugador foreign key (id_equipo) references T_Equipos(id_equipo)
);

CREATE TABLE T_Equipo_Grupo (
    id_equipo int constraint nn_equipoGrupo not null,
    id_grupo int constraint nn_grupoEquipo not null,
    constraint pk_equipoGrupo primary key (id_equipo, id_grupo),
    constraint fk_equipoEnGrupo foreign key (id_equipo) references T_Equipos(id_equipo),
    constraint fk_grupoConEquipo foreign key (id_grupo) references T_Grupos(id_grupo)
);

CREATE TABLE T_Partidos_Jugados (
    id_partido int identity(1,1) constraint pk_Partido primary key,
    id_equipo_local int constraint nn_equipoLocal not null,
    id_equipo_visitante int constraint nn_equipoVisitante not null,
    goles_local int constraint nn_golesLocal not null constraint df_golesLocal default 0,
    goles_visitante int constraint nn_golesVisitante not null constraint df_golesVisitante default 0,
    fecha_partido date constraint df_fechaPartido default getdate(),
    id_estadio int constraint nn_estadioPartido not null,
    id_arbitro_central int constraint nn_arbitroPartido not null,
    id_grupo int,
    año_mundial int constraint nn_añoPartido not null,
    constraint fk_equipoLocal foreign key (id_equipo_local) references T_Equipos(id_equipo),
    constraint fk_equipoVisitante foreign key (id_equipo_visitante) references T_Equipos(id_equipo),
    constraint fk_estadioPartido foreign key (id_estadio) references T_Estadios(id_estadio),
    constraint fk_arbitroPartido foreign key (id_arbitro_central) references T_Arbitros(id_arbitro),
    constraint fk_grupoPartido foreign key (id_grupo) references T_Grupos(id_grupo)
);

INSERT INTO T_Estadios (nombre_estadio, ciudad, capacidad, pais_estadio) VALUES
('Estadio Soccer City', 'Johannesburgo', 84490, 'Sudáfrica'),
('Maracaná', 'Río de Janeiro', 78838, 'Brasil'),
('Luzhniki', 'Moscú', 81000, 'Rusia'),
('Lusail', 'Lusail', 80000, 'Qatar');

INSERT INTO T_Grupos (nombre_grupo, año_mundial) VALUES
('A', 2010), ('B', 2010),
('A', 2014), ('B', 2014),
('A', 2018), ('B', 2018),
('A', 2022), ('B', 2022);

INSERT INTO T_Equipos (nombre_equipo, pais, entrenador, año_mundial) VALUES
('Sudáfrica', 'Sudáfrica', 'Carlos Alberto Parreira', 2010),
('México', 'México', 'Javier Aguirre', 2010),
('Uruguay', 'Uruguay', 'Óscar Tabárez', 2010),
('Francia', 'Francia', 'Raymond Domenech', 2010),
('Argentina', 'Argentina', 'Diego Maradona', 2010),
('Nigeria', 'Nigeria', 'Lars Lagerbäck', 2010),
('Corea del Sur', 'Corea del Sur', 'Huh Jung-moo', 2010),
('Grecia', 'Grecia', 'Otto Rehhagel', 2010),
('Brasil', 'Brasil', 'Luiz Felipe Scolari', 2014),
('Croacia', 'Croacia', 'Niko Kovač', 2014),
('México 2014', 'México', 'Miguel Herrera', 2014),
('Camerún', 'Camerún', 'Volker Finke', 2014),
('España', 'España', 'Vicente del Bosque', 2014),
('Países Bajos', 'Países Bajos', 'Louis van Gaal', 2014),
('Chile', 'Chile', 'Jorge Sampaoli', 2014),
('Australia', 'Australia', 'Ange Postecoglou', 2014),
('Rusia', 'Rusia', 'Stanislav Cherchesov', 2018),
('Arabia Saudita', 'Arabia Saudita', 'Juan Antonio Pizzi', 2018),
('Egipto', 'Egipto', 'Héctor Cúper', 2018),
('Uruguay 2018', 'Uruguay', 'Óscar Tabárez', 2018),
('Portugal', 'Portugal', 'Fernando Santos', 2018),
('España 2018', 'España', 'Fernando Hierro', 2018),
('Marruecos', 'Marruecos', 'Hervé Renard', 2018),
('Irán', 'Irán', 'Carlos Queiroz', 2018),
('Qatar', 'Qatar', 'Félix Sánchez', 2022),
('Ecuador', 'Ecuador', 'Gustavo Alfaro', 2022),
('Senegal', 'Senegal', 'Aliou Cissé', 2022),
('Países Bajos 2022', 'Países Bajos', 'Louis van Gaal', 2022),
('Inglaterra', 'Inglaterra', 'Gareth Southgate', 2022),
('Irán 2022', 'Irán', 'Carlos Queiroz', 2022),
('Estados Unidos', 'Estados Unidos', 'Gregg Berhalter', 2022),
('Gales', 'Gales', 'Rob Page', 2022);

INSERT INTO T_Equipo_Grupo (id_equipo, id_grupo) VALUES
(1, 1), (2, 1), (3, 1), (4, 1),
(5, 2), (6, 2), (7, 2), (8, 2),
(9, 3), (10, 3), (11, 3), (12, 3),
(13, 4), (14, 4), (15, 4), (16, 4),
(17, 5), (18, 5), (19, 5), (20, 5),
(21, 6), (22, 6), (23, 6), (24, 6),
(25, 7), (26, 7), (27, 7), (28, 7),
(29, 8), (30, 8), (31, 8), (32, 8);

INSERT INTO T_Arbitros (nombre_arbitro, apellido_arbitro, nacionalidad, posicion, año_mundial) VALUES
('Howard', 'Webb', 'Inglaterra', 'central', 2010),
('Ravshan', 'Irmatov', 'Uzbekistán', 'central', 2010),
('Darren', 'Cann', 'Australia', 'banda', 2010),
('Mike', 'Mullarkey', 'Inglaterra', 'banda', 2010),
('Nicola', 'Rizzoli', 'Italia', 'central', 2014),
('Björn', 'Kuipers', 'Países Bajos', 'central', 2014),
('Erwin', 'Zeinstra', 'Países Bajos', 'banda', 2014),
('Renato', 'Faverani', 'Italia', 'banda', 2014),
('Néstor', 'Pitana', 'Argentina', 'central', 2018),
('Alireza', 'Faghani', 'Irán', 'central', 2018),
('Hernan', 'Maidana', 'Argentina', 'banda', 2018),
('Reza', 'Sokhandan', 'Irán', 'banda', 2018),
('Szymon', 'Marciniak', 'Polonia', 'central', 2022),
('Daniele', 'Orsato', 'Italia', 'central', 2022),
('Pawel', 'Sokolnicki', 'Polonia', 'banda', 2022),
('Tomasz', 'Listkiewicz', 'Polonia', 'banda', 2022);

INSERT INTO T_Jugadores (nombre_jugador, apellido_jugador, edad, posicion, numero_camiseta, id_equipo) VALUES
('Itumeleng', 'Khune', 25, 'portero', 1, 1),
('Steven', 'Pienaar', 28, 'medio campista', 10, 1),
('Katlego', 'Mphela', 26, 'delantero', 9, 1),
('Lucas', 'Thwala', 30, 'defensa', 4, 1),
('Tsepo', 'Masilela', 24, 'defensa', 3, 1);

INSERT INTO T_Jugadores (nombre_jugador, apellido_jugador, edad, posicion, numero_camiseta, id_equipo) VALUES
('Óscar', 'Pérez', 32, 'portero', 1, 2),
('Andrés', 'Guardado', 24, 'medio campista', 18, 2),
('Javier', 'Hernández', 22, 'delantero', 14, 2),
('Rafael', 'Márquez', 31, 'defensa', 4, 2),
('Carlos', 'Salcido', 30, 'defensa', 3, 2);

INSERT INTO T_Jugadores (nombre_jugador, apellido_jugador, edad, posicion, numero_camiseta, id_equipo) VALUES
('Julio', 'César', 34, 'portero', 12, 9),
('Oscar', 'dos Santos', 22, 'medio campista', 11, 9),
('Neymar', 'da Silva', 22, 'delantero', 10, 9),
('Thiago', 'Silva', 29, 'defensa', 3, 9),
('David', 'Luiz', 27, 'defensa', 4, 9);

INSERT INTO T_Jugadores (nombre_jugador, apellido_jugador, edad, posicion, numero_camiseta, id_equipo) VALUES
('Fernando', 'Muslera', 24, 'portero', 1, 3),
('Diego', 'Forlán', 31, 'delantero', 10, 3),
('Luis', 'Suárez', 23, 'delantero', 9, 3),
('Diego', 'Lugano', 29, 'defensa', 2, 3),
('Maxi', 'Pereira', 26, 'defensa', 16, 3),
('Hugo', 'Lloris', 23, 'portero', 1, 4),
('Thierry', 'Henry', 32, 'delantero', 12, 4),
('Franck', 'Ribéry', 27, 'medio campista', 7, 4),
('William', 'Gallas', 33, 'defensa', 5, 4),
('Patrice', 'Evra', 29, 'defensa', 3, 4);

INSERT INTO T_Partidos_Jugados (id_equipo_local, id_equipo_visitante, goles_local, goles_visitante, fecha_partido, id_estadio, id_arbitro_central, id_grupo, año_mundial) VALUES
(1, 2, 1, 1, '2010-06-11', 1, 1, 1, 2010),
(3, 4, 0, 0, '2010-06-11', 1, 2, 1, 2010),
(5, 6, 1, 0, '2010-06-12', 1, 1, 2, 2010),
(9, 10, 3, 1, '2014-06-12', 2, 5, 3, 2014),
(13, 14, 1, 5, '2014-06-13', 2, 6, 4, 2014),
(17, 18, 5, 0, '2018-06-14', 3, 9, 5, 2018),
(21, 22, 3, 3, '2018-06-15', 3, 10, 6, 2018),
(25, 26, 0, 2, '2022-11-20', 4, 13, 7, 2022),
(29, 30, 6, 2, '2022-11-21', 4, 14, 8, 2022);

CREATE VIEW V_Jugadores_Equipos AS
SELECT 
    j.nombre_jugador,
    j.apellido_jugador,
    j.edad,
    j.posicion,
    j.numero_camiseta,
    e.nombre_equipo,
    e.pais,
    e.año_mundial
FROM T_Jugadores j
INNER JOIN T_Equipos e ON j.id_equipo = e.id_equipo;

CREATE VIEW V_Arbitros_Sin_Partidos AS
SELECT 
    a.nombre_arbitro,
    a.apellido_arbitro,
    a.nacionalidad,
    a.posicion,
    a.año_mundial
FROM T_Arbitros a
LEFT JOIN T_Partidos_Jugados p ON a.id_arbitro = p.id_arbitro_central
WHERE p.id_arbitro_central IS NULL;

CREATE VIEW V_Equipos_Grupo_A AS
SELECT 
    e.nombre_equipo,
    e.pais,
    e.entrenador,
    e.año_mundial,
    g.nombre_grupo
FROM T_Equipos e
INNER JOIN T_Equipo_Grupo eg ON e.id_equipo = eg.id_equipo
INNER JOIN T_Grupos g ON eg.id_grupo = g.id_grupo
WHERE g.nombre_grupo = 'A' 
AND e.año_mundial IN (2014, 2018, 2022);

CREATE VIEW V_Partidos_Completa AS
SELECT 
    est.nombre_estadio,
    a.nombre_arbitro,
    a.apellido_arbitro,
    el.nombre_equipo AS equipo_local,
    ev.nombre_equipo AS equipo_visitante,
    p.goles_local,
    p.goles_visitante,
    g.nombre_grupo AS grupo,
    p.año_mundial,
    p.fecha_partido
FROM T_Partidos_Jugados p
INNER JOIN T_Estadios est ON p.id_estadio = est.id_estadio
INNER JOIN T_Arbitros a ON p.id_arbitro_central = a.id_arbitro
INNER JOIN T_Equipos el ON p.id_equipo_local = el.id_equipo
INNER JOIN T_Equipos ev ON p.id_equipo_visitante = ev.id_equipo
LEFT JOIN T_Grupos g ON p.id_grupo = g.id_grupo;

SELECT 
    nombre_jugador,
    apellido_jugador,
    posicion,
    numero_camiseta,
    nombre_equipo,
    pais
FROM V_Jugadores_Equipos;

SELECT 
    nombre_arbitro,
    apellido_arbitro,
    nacionalidad,
    posicion,
    año_mundial
FROM V_Arbitros_Sin_Partidos;

SELECT 
    nombre_equipo,
    pais,
    entrenador,
    año_mundial
FROM V_Equipos_Grupo_A;

SELECT 
    nombre_estadio,
    nombre_arbitro,
    apellido_arbitro,
    equipo_local,
    equipo_visitante,
    goles_local,
    goles_visitante,
    grupo,
    año_mundial,
    fecha_partido
FROM V_Partidos_Completa;

SELECT * FROM V_Jugadores_Equipos 
WHERE nombre_equipo = 'Brasil';

SELECT * FROM V_Partidos_Completa 
WHERE año_mundial = 2022;

SELECT * FROM V_Jugadores_Equipos 
WHERE posicion = 'portero';

SELECT * FROM V_Equipos_Grupo_A 
WHERE pais = 'España';