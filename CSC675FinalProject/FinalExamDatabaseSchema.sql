-- Final Exam Database Schema
-- CSC 675-775 Database Systems
-- Author: Jose Ortiz
-- Date: 05/07/2020
-- This script contains the CREATE and INSERT SQL statements needed to build this database schema 
-- Usage: in this fiddle, click on "Build Schema", then write your SQL SELECT statements on the right side

/* 
The next two lines are not necessary in this sql fiddle. However, 
they are needed if you need to run this database schema in MySQLWorkBench 
*/


Use ArtGalleryManagementDB;

CREATE TABLE IF NOT EXISTS Genre 
(
 genre_id TINYINT PRIMARY KEY,
 description VARCHAR(255) NOT NULL
);

-- TABLE Album
CREATE TABLE IF NOT EXISTS Album 
(
 album_id TINYINT PRIMARY KEY,
 title VARCHAR(255) NOT NULL,
 year_released INT NOT NULL
);

-- TABLE Artist
CREATE TABLE IF NOT EXISTS Artist1  
(
 artist_id TINYINT PRIMARY KEY,
 name VARCHAR(100) NOT NULL
);

-- Table Customer
CREATE TABLE IF NOT EXISTS Customer 
(
 customer_id TINYINT PRIMARY KEY,
 name VARCHAR(100) NOT NULL,
 zipcode INT(5) NOT NULL, 
 state CHAR(2) NOT NULL
);

-- TABLE Track
CREATE TABLE IF NOT EXISTS Track
(
 track_id TINYINT PRIMARY KEY,
 genre TINYINT, -- FK
 album TINYINT, -- FK
 artist1 TINYINT, -- FK 
 title VARCHAR(255) NOT NULL,
 length INT,
 FOREIGN KEY (album) REFERENCES Album(album_id)
 ON DELETE SET NULL ON UPDATE CASCADE,
 FOREIGN KEY (genre) REFERENCES Genre(genre_id)
 ON DELETE SET NULL ON UPDATE CASCADE,
 FOREIGN KEY (artist1) REFERENCES Artist1(artist_id)
 ON DELETE SET NULL ON UPDATE CASCADE
);

-- TABLE Invoice
CREATE TABLE IF NOT EXISTS Invoice
(
 invoice_id TINYINT PRIMARY KEY,
 track TINYINT NOT NULL, -- FK
 customer TINYINT NOT NULL, -- FK
 quantity INT DEFAULT 0, 
 unit_price DECIMAL (5,2),
 FOREIGN KEY (track) REFERENCES Track(track_id)
 ON DELETE CASCADE ON UPDATE CASCADE,
 FOREIGN KEY (customer) REFERENCES Customer(customer_id)
 ON DELETE CASCADE ON UPDATE CASCADE
);

-- INSERTS

-- GENRE INSERTS
/*
INSERT INTO Genre (genre_id, description) VALUES (1, 'Rock');
INSERT INTO Genre (genre_id, description) VALUES (2, 'Jazz');
INSERT INTO Genre (genre_id, description) VALUES (3, 'Metal');
INSERT INTO Genre (genre_id, description) VALUES (4, 'Alternative & Punk');
INSERT INTO Genre (genre_id, description) VALUES (5, 'Rock And Roll');
INSERT INTO Genre (genre_id, description) VALUES (6, 'Blues');
INSERT INTO Genre (genre_id, description) VALUES (7, 'Latin');
INSERT INTO Genre (genre_id, description) VALUES (9, 'Pop');
INSERT INTO Genre (genre_id, description) VALUES (10, 'Dance & Electronic');

-- ALBUM INSERTS
INSERT INTO Album (album_id, title, year_released) VALUES (1, 'Do not smile at me', 2019);
INSERT INTO Album (album_id, title, year_released) VALUES (2, 'Alanis',1993), (3, 'Jagged Little Pill', 1995);
INSERT INTO Album (album_id, title, year_released) VALUES (4, 'fly on the wall', 1985);
INSERT INTO Album (album_id, title, year_released) VALUES (5, 'Objection overruled',1993), (6, 'Death Row', 1994);
INSERT INTO Album (album_id, title, year_released) VALUES (7,'Check to check', 1975);

-- ARTIST INSERTS
INSERT INTO Artist1 (artist_id, name) Values (1, 'AC/DC');
INSERT INTO Artist1 (artist_id, name) Values (2, 'Accept');
INSERT INTO Artist1 (artist_id, name) Values (3, 'Alanis Morissete');
INSERT INTO Artist1 (artist_id, name) Values (4, 'Ella Fitzgerald');
INSERT INTO Artist1 (artist_id, name) Values (5, 'Billie Ellish');
*/
-- TRACK INSERTS 
INSERT INTO Track (track_id, genre, album, artist1, title, length) VALUES (1, 4, 1, 5,  'Bury a Friend', 240);
INSERT INTO Track (track_id, genre, album, artist1, title, length) VALUES (2, 4, 1, 5, 'Lovely', 360);
INSERT INTO Track (track_id, genre, album, artist1, title, length) VALUES (3, 4, 1, 5, 'Copy cat', 840);
INSERT INTO Track (track_id, genre, album, artist1, title, length) VALUES (4, 9, 2, 3, 'Ironic', 244);
INSERT INTO Track (track_id, genre, album, artist1, title, length) VALUES (5, 9, 3, 3, 'Perfect', 230);
INSERT INTO Track (track_id, genre, album, artist1, title, length) VALUES (6, 9, 2, 3, 'Feel your love', 248);
INSERT INTO Track (track_id, genre, album, artist1, title, length) VALUES (7, 3, 5, 2,  'Just by my own',  250);
INSERT INTO Track (track_id, genre, album, artist1, title, length) VALUES (8, 9, 3, 2, 'Superman', 249);
INSERT INTO Track (track_id, genre, album, artist1, title, length) VALUES (9, 3, 5, 2, 'All or nothing',  260);
INSERT INTO Track (track_id, genre, album, artist1, title, length) VALUES (10, 3, 5, 2,  'Donation', 220);
INSERT INTO Track (track_id, genre, album, artist1, title, length) VALUES (11, 3, 6, 2, 'Bad religion', 290);
INSERT INTO Track (track_id, genre, album, artist1, title, length) VALUES (12, 2, 7, 4, 'Oops', 200);
INSERT INTO Track (track_id, genre, album, artist1, title, length) VALUES (13, 2, 7, 4, 'Can anyone explain', 210);
INSERT INTO Track (track_id, genre, album, artist1, title, length) VALUES (14, 3, 4, 1, 'Danger', 210);

-- CUSTOMER INSERTS
INSERT INTO Customer (customer_id, name, zipcode, state) VALUES (1, "Jose", 94112, "CA");
INSERT INTO Customer (customer_id, name, zipcode, state) VALUES (2, "Alice", 94332, "CA");
INSERT INTO Customer (customer_id, name, zipcode, state) VALUES (3, "Bob", 85001, "AZ");
INSERT INTO Customer (customer_id, name, zipcode, state) VALUES (4, "Tobi", 87012, "AZ");
INSERT INTO Customer (customer_id, name, zipcode, state) VALUES (5, "Lulu", 81201, "CO");
INSERT INTO Customer (customer_id, name, zipcode, state) VALUES (6, "Howie", 81301, "CO");
INSERT INTO Customer (customer_id, name, zipcode, state) VALUES (7, "Trudi", 72001, "AR");
INSERT INTO Customer (customer_id, name, zipcode, state) VALUES (8, "Maria", 72002, "AR");
INSERT INTO Customer (customer_id, name, zipcode, state) VALUES (9, "Christina", 65438, "NY");

-- INVOICE INSERTS
INSERT INTO Invoice (invoice_id, track, customer, quantity, unit_price) VALUES (1,1,1,3,29.00);
INSERT INTO Invoice (invoice_id, track, customer, quantity, unit_price) VALUES (2,1,2,100,29.00);
INSERT INTO Invoice (invoice_id, track, customer, quantity, unit_price) VALUES (3,2,1,8,30.59);
INSERT INTO Invoice (invoice_id, track, customer, quantity, unit_price) VALUES (4,3,1,24,9.00);
INSERT INTO Invoice (invoice_id, track, customer, quantity, unit_price) VALUES (5,4,2,1,17.00);
INSERT INTO Invoice (invoice_id, track, customer, quantity, unit_price) VALUES (6,1,1,5,29.00);
INSERT INTO Invoice (invoice_id, track, customer, quantity, unit_price) VALUES (7,1,1,78,29.00);
INSERT INTO Invoice (invoice_id, track, customer, quantity, unit_price) VALUES (8,10,3,5,15.99);
INSERT INTO Invoice (invoice_id, track, customer, quantity, unit_price) VALUES (9,10,5,12,15.99);
INSERT INTO Invoice (invoice_id, track, customer, quantity, unit_price) VALUES (10,10,6,34,15.99);
INSERT INTO Invoice (invoice_id, track, customer, quantity, unit_price) VALUES (11,6,3,2,4.99);
INSERT INTO Invoice (invoice_id, track, customer, quantity, unit_price) VALUES (12,6,9,1,4.99);
INSERT INTO Invoice (invoice_id, track, customer, quantity, unit_price) VALUES (13,8,4,1,12.87);
INSERT INTO Invoice (invoice_id, track, customer, quantity, unit_price) VALUES (14,12,4,1,23.99);
INSERT INTO Invoice (invoice_id, track, customer, quantity, unit_price) VALUES (15,14,6,9,11.99);
INSERT INTO Invoice (invoice_id, track, customer, quantity, unit_price) VALUES (16,12,2,10,23.99);
INSERT INTO Invoice (invoice_id, track, customer, quantity, unit_price) VALUES (17,14,3,4,11.99);
INSERT INTO Invoice (invoice_id, track, customer, quantity, unit_price) VALUES (18,7,3,6,15.99);
INSERT INTO Invoice (invoice_id, track, customer, quantity, unit_price) VALUES (19,7,3,8,15.99);
INSERT INTO Invoice (invoice_id, track, customer, quantity, unit_price) VALUES (20,9,7,2,4.99);

