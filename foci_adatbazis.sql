CREATE TABLE csapatok (
    nev          VARCHAR(200) NOT NULL,
    alapitas_eve INTEGER NOT NULL,
    edzo         VARCHAR(200) NOT NULL
);

ALTER TABLE csapatok ADD CONSTRAINT csapatok_pk PRIMARY KEY ( nev );

				
CREATE TABLE jatekosok (
    nev       VARCHAR(200) NOT NULL,
    eletkor   INTEGER NOT NULL,
    magassag  INTEGER NOT NULL,
    piros_lap INTEGER,
    sarga_lap INTEGER,
	pozicio   VARCHAR(200),
    csapat    VARCHAR(200) NOT NULL
);

ALTER TABLE jatekosok ADD CONSTRAINT jatekosokv1_pk PRIMARY KEY ( nev );

ALTER TABLE jatekosok
    ADD CONSTRAINT jatekosok_csapatok_fk FOREIGN KEY ( csapat )
        REFERENCES csapatok ( nev );
		
		
CREATE TABLE merkozesek (
    id       INTEGER NOT NULL,
    idopont  DATE NOT NULL,
    helyszin VARCHAR(200) NOT NULL,
    biro     VARCHAR(200) NOT NULL,
    hazai    VARCHAR(200) NOT NULL,
    vendeg   VARCHAR(200) NOT NULL
);

ALTER TABLE merkozesek ADD CONSTRAINT merkozesek_pk PRIMARY KEY ( id );

ALTER TABLE merkozesek
    ADD CONSTRAINT merkozesek_csapatok_fk FOREIGN KEY ( hazai )
        REFERENCES csapatok ( nev );

ALTER TABLE merkozesek
    ADD CONSTRAINT merkozesek_csapatok_fkv2 FOREIGN KEY ( vendeg )
        REFERENCES csapatok ( nev );

CREATE TABLE golok (
    golok_szama INTEGER NOT NULL,
    jatekos     VARCHAR(200),
    merkozes_id INTEGER NOT NULL
);

ALTER TABLE golok
    ADD CONSTRAINT golok_jatekosok_fk FOREIGN KEY ( jatekos )
        REFERENCES jatekosok ( nev );

ALTER TABLE golok
    ADD CONSTRAINT golok_merkozesek_fk FOREIGN KEY ( merkozes_id )
        REFERENCES merkozesek ( id );
		
		
CREATE TABLE pontszamok (
    pont             INTEGER NOT NULL,
    merkozesek_szama INTEGER NOT NULL,
    csapat           VARCHAR(200) NOT NULL
);

CREATE UNIQUE INDEX pontszamok__idx ON
    pontszamok (
        csapat
    ASC );

ALTER TABLE pontszamok
    ADD CONSTRAINT pontszamok_csapatok_fk FOREIGN KEY ( csapat )
        REFERENCES csapatok ( nev );


INSERT INTO csapatok (nev,alapitas_eve,edzo)
values ('Binaris keresofa FC',2020,'Nagy Bela'),
('IKEA FC',1756,'Jurgen Czopf'),
('Kertvarosi kigyok',1954,'Kreativ Karoly'),
('Mucsarocsoge FC',1600,'Kiss Bela'),
('Szeged United',1878,'Rudolf Wangnick')



INSERT INTO jatekosok (nev,csapat,eletkor,pozicio,magassag,piros_lap,sarga_lap)
values ('Almos Elod','Mucsarocsoge FC',23,'kozeppalyas',171,2,3),
('Balazs Gabor','Mucsarocsoge FC',18,'hatved',172,0,2),
('Fekete Zoltan','Szeged United',24,'kapus',185,0,2),
('Ferenc Geza','IKEA FC',24,'kozeppalyas',177,1,1),
('Gipsz Bela','Binaris keresofa FC',19,'kozeppalyas',164,0,2),
('Gipsz Jakab','Binaris keresofa FC',18,'kapus',175,1,2),
('Kerekes Teodor','Szeged United',23,'kozeppalyas',181,1,2),
('Kovacs Bence','Kertvarosi kigyok',19,'csatar',181,1,4),
('Kovacs Mate','Mucsarocsoge FC',20,'kapus',155,2,2),
('Mohamed Ali','Szeged United',25,'csatar',168,1,2),
('Molnar Adam','Kertvarosi kigyok',23,'kozeppalyas',167,3,0),
('Nagy Aron','Binaris keresofa FC',18,'hatved',178,0,3),
('Nagy Balint','Szeged United',19,'kozeppalyas',167,0,3),
('Nagy Gergo','Mucsarocsoge FC',22,'kozeppalyas',163,4,0),
('Soltesz Rezso','Mucsarocsoge FC',22,'csatar',190,3,4),
('Szabo Levente','IKEA FC',19,'hatved',200,1,4),
('Szabo Marko','IKEA FC',25,'kapus',160,1,2),
('Szabo Szergej','IKEA FC',26,'kozeppalyas',184,0,1),
('Szerecsen Dio','Kertvarosi kigyok',21,'kapus',180,2,0),
('Szoke Barna','Kertvarosi kigyok',20,'hatved',169,0,1),
('Toth David','Binaris keresofa FC',21,'kozeppalyas',151,2,2),
('Toth Vencel','Szeged United',22,'hatved',175,3,4),
('Varga Balint','Binaris keresofa FC',18,'csatar',173,2,1),
('Varga Daniel','Kertvarosi kigyok',22,'kozeppalyas',170,0,1),
('Varga Patrik','IKEA FC',19,'csatar',172,1,1)






INSERT INTO merkozesek (id,hazai,vendeg,idopont,helyszin,biro)
values (1,'Binaris keresofa FC','Szeged United','2020-05-22','Debrecen','Korrupt Karoly'),
(2,'IKEA FC','Binaris keresofa FC','2023-02-27','Budapest','Igazsagos Istvan'),
(3,'Szeged United','Mucsarocsoge FC','1989-04-30','Szeged','Gaz Gedeon'),
(4,'Mucsarocsoge FC','Kertvarosi kigyok','1955-12-11','Mucsarocsoge','Fair Ferenc'),
(5,'Kertvarosi kigyok','Szeged United','1977-06-12','Budapest','Rugos Rudolf'),
(6,'IKEA FC','Szeged United','1890-05-07','Budapest','Igazsagos Istvan'),
(7,'Mucsarocsoge FC','IKEA FC','1757-11-22','Mucsarocsoge','Gaz Gedeon'),
(8,'Kertvarosi kigyok','Binaris keresofa FC','2024-02-24','Budapest','Fair Ferenc')

INSERT INTO golok (merkozes_id,jatekos,golok_szama)
values (1,'Gipsz Bela',2),
(1,'Mohamed Ali',1),
(1,'Toth Vencel',1),
(1,'Toth David',2),
(2,'Ferenc Geza',5),
(3,'Nagy Balint',2),
(4,'Varga Daniel',1),
(5,'Varga Daniel',1),
(5,'Mohamed Ali',2),
(6,'Szabo Szergej',1),
(6,'Ferenc Geza',1),
(6,'Kerekes Teodor',1),
(7,'Nagy Gergo',2),
(7,'Soltesz Rezso',2),
(8,'Gipsz Bela',2),
(8,'Varga Balint',1),
(8,'Molnar Adam',2)


INSERT INTO pontszamok (csapat,pont,merkozesek_szama)
values ('Binaris keresofa FC',6,3),
('IKEA FC',6,3),
('Kertvarosi kigyok',3,3),
('Mucsarocsoge FC',3,3),
('Szeged United',6,4)
