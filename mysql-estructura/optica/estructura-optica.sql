DROP DATABASE IF EXISTS optica;
CREATE DATABASE optica CHARACTER SET utf8mb4;
USE optica;

create table client
(
    nom           varchar(50)  not null,
    telefon       varchar(9)   null,
    email         varchar(100) not null,
    data_registre date         not null,
    recomanat_per int          null,
    id            int auto_increment
        primary key,
    constraint recomanat_per__fk
        foreign key (recomanat_per) references client (id)
);

INSERT INTO client (nom, telefon, email, data_registre, recomanat_per) VALUES
('John Doe', '123456789', 'john.doe@example.com', '2024-01-01', NULL),
('Jane Smith', '987654321', 'jane.smith@example.com', '2024-01-05', 1),
('Alice Johnson', '555555555', 'alice.j@example.com', '2024-01-10', NULL),
('Bob Brown', '666666666', 'bob.brown@example.com', '2024-01-15', 1),
('Charlie White', '777777777', 'charlie.white@example.com', '2024-01-20', 2);

create table empleat
(
    id  int auto_increment
        primary key,
    nom varchar(50) not null
);

INSERT INTO empleat (nom) VALUES
('Eve Adams'),
('Frank Black'),
('Grace Green'),
('Hank White'),
('Ivy Gold');

create table proveidor
(
    nom     varchar(50) not null,
    telefon varchar(9)  not null,
    fax     varchar(25) not null,
    id      int auto_increment
        primary key,
    nif     varchar(9)  not null,
    constraint proveidor_nif
        unique (nif)
);

INSERT INTO proveidor (nom, telefon, fax, nif) VALUES
('Supplier One', '123456789', 'F12345678', 'NIF12345'),
('Supplier Two', '987654321', 'F87654321', 'NIF54321'),
('Supplier Three', '555555555', 'F55555555', 'NIF11111'),
('Supplier Four', '666666666', 'F66666666', 'NIF22222'),
('Supplier Five', '777777777', 'F77777777', 'NIF33333');

create table adreces (
    carrer      varchar(95) not null,
    numero      int         not null,
    pis         int         null,
    ciutat      varchar(95) not null,
    codi_postal varchar(10) null,
    pais        varchar(50) null,
    id_referencia   int         not null,
    tipus       enum('client', 'proveidor') not null,
    id          int auto_increment primary key
);

INSERT INTO adreces (carrer, numero, pis, ciutat, codi_postal, pais, id_referencia, tipus) VALUES
('Carrer Major', 123, 2, 'Barcelona', '08001', 'Spain', 1, 'client'),
('Gran Via', 45, 4, 'Madrid', '28013', 'Spain', 2, 'client'),
('Avinguda Diagonal', 100, NULL, 'Barcelona', '08028', 'Spain', 3, 'client'),
('Carrer del Raval', 10, 1, 'Barcelona', '08001', 'Spain', 1, 'client'),
('Carrer de la Pau', 5, NULL, 'Valencia', '46001', 'Spain', 4, 'client'),
('Carrer de les Flors', 12, NULL, 'Barcelona', '08002', 'Spain', 1, 'proveidor'),
('Carrer de la Mar', 34, 1, 'Valencia', '46002', 'Spain', 2, 'proveidor'),
('Carrer de la Llum', 56, NULL, 'Madrid', '28002', 'Spain', 3, 'proveidor'),
('Carrer de la Pau', 78, 2, 'Barcelona', '08003', 'Spain', 4, 'proveidor'),
('Carrer del Sol', 90, 3, 'Sevilla', '41001', 'Spain', 5, 'proveidor');

create table marca
(
    id           int auto_increment
        primary key,
    nom          varchar(50) null,
    id_proveidor int         not null,
    constraint marca_id_proveidor__fk
        foreign key (id_proveidor) references proveidor (id)
);

INSERT INTO marca (nom, id_proveidor) VALUES
('Marca A', 1),
('Marca B', 2),
('Marca C', 1),
('Marca D', 3),
('Marca E', 2);

create table ulleres
(
    id_marca             int                                   not null,
    id                   int auto_increment
        primary key,
    graduacio_vidre_dret float                                 not null,
    graduacio_vidre_esq  float                                 not null,
    muntura              enum ('flotant', 'pasta', 'metalica') not null,
    color_vidre_dret     varchar(10)                           not null,
    color_vidre_esq      varchar(10)                           not null,
    color_muntura        varchar(10)                           not null,
    preu                 decimal                                 not null,
    constraint ulleres_marca__fk
        foreign key (id_marca) references marca (id)
);

INSERT INTO ulleres (id_marca, graduacio_vidre_dret, graduacio_vidre_esq, muntura, color_vidre_dret, color_vidre_esq, color_muntura, preu) VALUES
(1, 0.5, 0.5, 'metalica', 'blue', 'blue', 'silver', 100),
(2, 1.0, 1.0, 'pasta', 'black', 'black', 'black', 150),
(1, 2.0, 2.0, 'flotant', 'green', 'green', 'gold', 200),
(3, 0.75, 0.75, 'metalica', 'red', 'red', 'gray', 120),
(2, 1.5, 1.5, 'pasta', 'purple', 'purple', 'white', 180);

create table vendes
(
    id         int auto_increment
        primary key,
    data       date null,
    id_empleat int  not null,
    quantitat  int  not null,
    id_ulleres int  not null,
    id_client  int  null,
    constraint vendes_client__fk
        foreign key (id_client) references client (id),
    constraint venta_empleat__fk
        foreign key (id_empleat) references empleat (id),
    constraint venta_ulleres__fk
        foreign key (id_ulleres) references ulleres (id)
);

INSERT INTO vendes (data, id_empleat, quantitat, id_ulleres, id_client) VALUES
('2024-02-01', 1, 2, 1, 1),
('2024-02-05', 2, 1, 2, 2),
('2024-02-10', 3, 3, 3, 3),
('2024-02-15', 4, 1, 4, 1),
('2024-02-20', 5, 2, 5, 4);