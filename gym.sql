# ------------------------------------STANDARD-----------------------------------------------
CREATE DATABASE GYM CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
use GYM;

# ----------------------------------STATUS---------------------------------------------------------
create table status(
                       id           tinyint not null primary key auto_increment,
                       status_člana varchar(255)
);

insert into status(status_člana) values('Student'),
                                       ('Zaposlena osoba'),
                                       ('Ne zaposlena osoba'),
                                       ('Umirovljenik');
# ------------------------------------VRSTA TRENINGA-------------------------------------------------------
create table vrsta_treninga(
                               id tinyint not null primary key auto_increment,
                               vrsta_treninga varchar(255)
);

insert into vrsta_treninga(vrsta_treninga) values ('Individualni trening'),
                                                  ('3 Individualna treninga + 3 treninga uz trenera'),
                                                  ('Treninzi uz trenera'),
                                                  ('grupni treninzi');
# ----------------------------------------Cijena------------------------------------
create table cijena(
                       id tinyint not null primary key auto_increment,
                       cijena double
);
insert into cijena(cijena) values(149.00),
                                 (179.00),
                                 (199.00),
                                 (209.00),
                                 (229.00),
                                 (239.00),
                                 (269.00);
# ----------------------------------------TRAJANJE UGOVORA------------------------------------
create table ugovor(
                       id tinyint not null auto_increment primary key,
                       trajanje int
);

insert into ugovor(trajanje) values(12),(6);
# ----------------------------------------ČLANOVI---------------------------------------------------
create table ČLANOVI(
                        id int not null primary key auto_increment,
                        ime varchar(255),
                        prezime varchar(255),
                        godine tinyint,
                        status tinyint,
                        foreign key(status) REFERENCES status(id) ON DELETE CASCADE

);
insert into članovi(ime,prezime,godine, status) values('Marin','Paunović',24, 1),
                                                      ('Filip','Paunović',25, 2),
                                                      ('Petar','Kalinić',68, 3),
                                                      ('Stjepan','Stipić',59,3),
                                                      ('Borna','Dijanović',17,2),                                                         ('Luka','Šarac',29,1),
                                                      ('Dražen','Štrudlić',32,2),
                                                      ('Kruno','Milić',52,2);
# --------------------------------------CIJENOVNIK-----------------------------------------------------
create table cjenovnik(
                          id tinyint not null primary key auto_increment,
                          vrsta_treninga tinyint,
                          trajanje_ugovora tinyint,
                          cijena tinyint,
                          status tinyint,
                          foreign key(status) REFERENCES status(id) ON DELETE CASCADE,
                          foreign key(vrsta_treninga) REFERENCES vrsta_treninga(id) ON DELETE CASCADE,
                          foreign key(cijena) REFERENCES cijena(id) ON DELETE CASCADE,
                          foreign key(trajanje_ugovora) REFERENCES ugovor(id) ON DELETE CASCADE
);


insert into cjenovnik (vrsta_treninga, trajanje_ugovora, cijena, status) values (1,1,3,1),
                                                                                (1,2,5,1),
                                                                                (4,1,1,1),
                                                                                (4,2,2,1),
                                                                                (1,1,6,2),
                                                                                (1,2,7,2),
                                                                                (4,1,3,2),
                                                                                (4,2,6,2),
                                                                                (1,1,4,3),
                                                                                (1,2,6,3),
                                                                                (4,1,3,3),
                                                                                (4,2,5,3);

# ----------------------------------AKTIVNI ČLANOVI------------------------------------------------------------------
Create table aktivni_članovi(
                                id int not null auto_increment primary key,
                                user_id int not null,
                                cjenovnik_id tinyint not null,
                                foreign key(user_id) REFERENCES članovi(id) ON DELETE CASCADE,
                                foreign key(cjenovnik_id) REFERENCES cjenovnik(id) ON DELETE CASCADE
);
ALTER TABLE aktivni_članovi ADD istek_ugovora DATE NOT NULL AFTER cjenovnik_id;

insert into aktivni_članovi(user_id , cjenovnik_id, istek_ugovora) values (1,5,'2021-03-09'),
                                                                          (1,7,'2021-06-17'),
                                                                          (2,5,'2021-01-06'),
                                                                          (6,3,'2020-12-25');
# --------------------------------------------------------------------------------------------------


