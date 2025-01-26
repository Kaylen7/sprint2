DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;
USE pizzeria;

create table clients
(
    nom           varchar(50)  not null,
    cognom1       varchar(100) not null,
    cognom2       varchar(100) null,
    telefon       varchar(9)   null,
    email         varchar(100) not null unique,
    id            int auto_increment
        primary key
);

create table botigues
(
    nom           varchar(255)  not null,
    id            int auto_increment
        primary key
);

create table empleats
(
    nom           varchar(50)  not null,
    cognom1       varchar(100) not null,
    cognom2       varchar(100) null,
    nif           varchar(9) not null unique,
    telefon       varchar(9)   null,
    email         varchar(100) not null,
    carrec        enum('cuina', 'repartiment') not null,
    id_botiga     int not null,
    id            int auto_increment
        primary key,
    constraint id_botiga__empleat__fk
        foreign key (id_botiga) references botigues (id)
);

create table adreces
(
    carrer      varchar(95) not null,
    numero      int         not null,
    pis         int         null,
    ciutat      varchar(95) not null,
    codi_postal varchar(10) null,
    localitat   varchar(50) null,
    provincia   varchar(50) null,
    id_usuari   int         not null,
    tipus       enum('client', 'botiga') not null,
    id          int auto_increment
        primary key
);

create table comandes
(
    id  int auto_increment
        primary key,
    data  datetime default current_timestamp,
    id_client int not null,
    id_botiga int not null,
    id_repartidor int null,
    a_domicili  bool default false,
    constraint id_client__comandes__fk
        foreign key (id_client) references clients (id),
    constraint id_botiga__comandes__fk
        foreign key (id_botiga) references botigues (id),
    constraint id_repartidor__comandes__fk
        foreign key (id_repartidor) references empleats (id)
);

create table comanda_a_domicili
(
    id   int auto_increment
        primary key,
    id_comanda  int not null,
    id_repartiment int not null,
    data_entrega   datetime default current_timestamp,
    constraint id_comanda__comanda_domicili__fk
        foreign key (id_comanda) references comandes(id),
    constraint id_repartiment__comanda_domicili__fk
        foreign key (id_repartiment) references empleats(id)
);

create table productes
(
    tipus       enum('hamburguesa', 'pizza', 'beguda') not null,
    nom         varchar(255) not null,
    descripcio  mediumtext null,
    imatge      longblob null,
    preu        int,
    id          int auto_increment
        primary key
);

create table comanda_productes
(
    id      int auto_increment
        primary key,
    id_producte int not null,
    id_comanda  int not null,
    quantitat   int default 1,

    constraint id_producte__comanda_productes__fk
        foreign key (id_producte) references productes (id),
        foreign key (id_comanda) references comandes (id)
);

create table pizza_categories
(
    id  int auto_increment
        primary key,
    nom varchar(255) not null
);

create table producte_pizza_categories
(
    id            int auto_increment
        primary key,
    id_producte   int,
    id_categoria  int,

    constraint id_producte__pizza_categoria__fk
        foreign key (id_producte) references productes (id),
    constraint id_categoria__pizza_categoria__fk
        foreign key (id_categoria) references pizza_categories(id)
);

create trigger validar_compra_a_domicili
    before insert on comanda_a_domicili
    for each row
    begin
        declare entrega boolean;

    select a_domicili from comandes
            where id = NEW.id_comanda
            into entrega;

    if entrega = False then
        signal sqlstate '45000'
        set message_text = 'Error: la compra no és a domicili';
    end if;
    end;

USE pizzeria;
INSERT INTO clients (nom, cognom1, cognom2, telefon, email) VALUES
('Joan', 'Garcia', 'Pérez', '931234567', 'joan.garcia@example.com'),
('Maria', 'Martínez', 'López', '936543210', 'maria.martinez@example.com'),
('Pere', 'Soler', 'Ribas', '934567890', 'pere.soler@example.com'),
('Anna', 'Fernández', 'Balcells', '935678901', 'anna.fernandez@example.com'),
('Marta', 'Vila', 'Casals', '933456789', 'marta.vila@example.com');

INSERT INTO botigues (nom) VALUES
('Botiga Barcelona - Eixample'),
('Botiga Barcelona - Gràcia'),
('Botiga Girona'),
('Botiga Tarragona'),
('Botiga Lleida');

INSERT INTO empleats (nom, cognom1, cognom2, nif, telefon, email, carrec, id_botiga) VALUES
('Sergi', 'Font', 'Martínez', '431234567', 'S12345678', 'sergi.font@example.com', 'cuina', 1),
('Laura', 'Camps', 'Grau', '436543210', 'S87654321', 'laura.camps@example.com', 'repartiment', 1),
('Pol', 'Roig', 'Puig', '434567890', 'S56789123', 'pol.roig@example.com', 'cuina', 3),
('Clara', 'Verdú', 'Serrano', '435678901', 'S56781234', 'clara.verdu@example.com', 'repartiment',2),
('Jordi', 'Esteve', 'Ferrer', '433456789', 'S67891234', 'jordi.esteve@example.com', 'cuina', 5);


INSERT INTO comandes (data, id_client, id_botiga, a_domicili, id_repartidor) VALUES
('2024-10-16 12:30:00', 1, 1, 1, 4),
('2024-10-16 13:00:00', 2, 2, 0, null),
('2024-10-16 14:00:00', 3, 3, 1, 5),
('2024-10-16 12:45:00', 4, 1, 1, 4),
('2024-10-16 13:15:00', 5, 2, 0, null);

INSERT INTO productes (tipus, nom, descripcio, imatge, preu)VALUES
('pizza', 'Margarita', 'Pizza Margarita clàssica', 'image1.png', 8),
('pizza', 'Quatre formatges', 'Pizza amb barreja de 4 formatges', 'image2.png', 10),
('hamburguesa', 'Cheeseburger', 'Hamburguesa amb formatge', 'image3.png', 7),
('beguda', 'Coca Cola', 'Llauna de Coca Cola 33cl', 'image4.png', 2),
('beguda', 'Aigua', 'Ampolla d’aigua 500ml', 'image5.png', 1);

INSERT INTO pizza_categories (nom) VALUES
('Vegetariana'),
('Carn'),
('Formatge'),
('Pikant'),
('Especialitats');

INSERT INTO producte_pizza_categories (id_producte, id_categoria) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO comanda_productes (id_producte, id_comanda, quantitat) VALUES
(1, 2, 2),
(2, 1, 1),
(3, 5, 5),
(4, 3, 3),
(5, 4, 4);

INSERT INTO adreces (carrer, numero, pis, ciutat, codi_postal, localitat, provincia, id_usuari, tipus) VALUES
('Carrer Mallorca', 101, 1, 'Barcelona', '08036', 'Barcelona', 'Barcelona', 1, 'botiga'),
('Carrer Gran de Gràcia', 132, 3, 'Barcelona', '08012', 'Barcelona', 'Barcelona', 2, 'botiga'),
('Carrer Major', 45, 2, 'Girona', '17001', 'Girona', 'Girona', 3, 'botiga'),
('Rambla Nova', 67, 4, 'Tarragona', '43001', 'Tarragona', 'Tarragona', 4, 'botiga'),
('Carrer de la Pau', 23, 1, 'Lleida', '25001', 'Lleida', 'Lleida', 5, 'botiga'),
('Carrer Aragó', 15, 3, 'Barcelona', '08015', 'Barcelona', 'Barcelona', 1, 'client'),
('Carrer del Sol', 7, 2, 'Sabadell', '08201', 'Barcelona', 'Barcelona', 2, 'client'),
('Avinguda Diagonal', 201, 1, 'Barcelona', '08018', 'Barcelona', 'Barcelona', 3, 'client'),
('Carrer València', 102, 5, 'Barcelona', '08010', 'Barcelona', 'Barcelona', 3, 'client'),
('Passeig de Gràcia', 200, 2, 'Barcelona', '08008', 'Barcelona', 'Barcelona', 5, 'client');


INSERT INTO comanda_a_domicili (id_comanda, id_repartiment) VALUES
(1, 1),
(3, 3),
(4, 4);
