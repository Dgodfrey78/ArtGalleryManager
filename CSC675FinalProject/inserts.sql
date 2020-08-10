USE ArtGalleryManagementDB;

-- Script Name: inserts.sql
-- Author: Daniel Godfrey
-- Purpose: used to add information to the database in order
-- if its working

-- User table inserts
INSERT INTO User (userid, Name, Email) VALUES (1,'Danny','dang@mail.com'), (2,'Micheal','miup@gmail.com'), (3,'Kim','kim@mail.com'),(4,'john','john@mail.com');

-- session table inserts
INSERT INTO session(sessionId,userSessionId,expires) VALUES (1,1,'2000-01-01'),(2,1,'1900-03-12'),(3,2,'2000-07-12');

-- paymentType table inserts
INSERT INTO paymentType (typeId, country, zipcode, city, state) VALUES (1, 'US', 94403, 'San Francisco', 'California'),(2,'US',94122,'San Mateo','California');

-- billingInfo Table inserts
INSERT INTO billingInfo (billingId,paymentType,amount,user) VALUES (1,1,25,1), (2,1,10,2) ,(3,1,32,3),(4,1,23,4);

-- accountType table inserts
INSERT INTO accountType (acctTypeId, description) VALUES (1,'manager'), (2,'visitor');

-- Account table inserts
INSERT INTO Account (acctId, username, acctType, password, userId) VALUES (1, 'DantheMan', 1, 'letsgo',1),(2,'MikeNike',2,'hithere',2), (3,'Kimmie',1,'passwords',3),(4,'johnboy',1,'gooddie',4);

-- address table inserts
INSERT INTO address (addressId, country,city,streetNumber,streetName) VALUES (1, 'US','San Mateo',2627,'Sunset Ter'),(2,'US','Redwood City',135,'Positano'),(3,'US','Portland',3222,'Walker');

-- gallery table inserts
INSERT INTO gallery (galleryId,name,manager) VALUES (1, 'Q Gallery', 'John Mac'),(2,'Nice gallery','Michelle Willis'),(3,'Art Art','LeAnne Rhymes');

-- manage table inserts
INSERT INTO manage (managerid, user,galleryId) VALUES (1,1,1),(2,2,2),(3,3,3);


-- creditCard table inserts
INSERT INTO creditCard (cardNumber, Expiration, cvv, paymentType) VALUES(2344234, '2023-03-02 00:00:00',323,1),(246425,'2021-04-05',321,1);
 
-- bankAccount table inserts
INSERT INTO bankAccount (accountNumber, paymentType, bank, routingNumber) VALUES (123423, 1, 'wells fargo', 242343),(352442,1,'bofa',645332),(574532,1,'bofa',645432);

-- feature table inserts
INSERT INTO feature (featureId, tables, permission) VALUES (1, 'Artist','Read'),(2,'Gallery','Read'),(3,'Artwork','Read'),(4,'Artist','Write'),(5,'Gallery','Write'),(6,'Artwork','Write'),(7,'owner','Read'),(8,'owner','Write'),(9,'manager','Read'),(10,'manager','Write'),(11,'artManager','Read'),(12,'artManager','Write');

-- accountFeatures inserts
INSERT INTO accountFeatures (acctfeatureId, accountType, feature) VALUES (1, 1, 1), (2,1,2),(3,1,3),(4,2,1),(5,2,2),(6,2,3),(7,2,4),(8,2,5),(9,2,6),(10,2,7),(11,2,8),(12,2,9),(13,2,10),(14,2,11),(15,2,12);

-- exhibit table inserts
INSERT INTO exhibit (exhibitId, name, dateTo, galleryId) VALUES (1, 'Monets greatest hits','2021-03-30 00:00:00',1),(2,'Van gogh home','2021-01-21',2),(3,'All about France','2021-04-07',3);

-- collection table inserts
INSERT INTO collection (collectionId, workCount, galleryId) VALUES (1, 12,1),(2,3,2),(3,43,3);

-- owner table inserts 
INSERT INTO owner (ownerId, name) VALUES (1,'Annie Hall'),(2,'Annie News'),(3,'John Cage');

-- artwork table inserts
INSERT INTO artwork (artworkId, price, title, exhibitId, collectionId, artworkOwnerId) VALUES (1,1000,'Person sitting',1,1,1),(2,1200,'Person Running',1,1,1),(3,3200,'Guy Jumping',2,2,2);

-- view table inserts
INSERT INTO view (userId, artwork, viewId) VALUES (1,1,1),(2,2,3);

-- buy table inserts
INSERT INTO buy (userID, artwork, offer, date, purchaseId) VALUES (1,1,1000,'2020-02-04',1),(2,2,3230,'2022-11-12',2),(3,3,3000,'2021-04-02',3);

-- manager table inserts
INSERT INTO manager(managerId, email, name, galleryExhibitId) VALUES (1,'danny@mail.com', 'Danny Godfrey',1),(2,'hello@mail.com','Megan Hoff',2),(3,'chrimstamas@mail.com','Nick Cranston',3);

-- theme table inserts
INSERT INTO theme (themeId, description, curratorName, exhibitId) VALUES(1,'Pop Art', 'Kyle Owen', 1),(2,'MidCenter Stuff','Mary Tanner',2),(3,'Wood','Hannah Wu',3);

-- medium table inserts
INSERT INTO medium (mediumId, description) VALUES ( 1, 'Oil on canvas'),(2,'water colors'),(3,'sculpture');

-- artMedium table inserts
INSERT INTO artMedium (artMediumId, artwork, medium) VALUES (1,1,1),(2,2,2),(3,3,3);

-- style table inserts
INSERT INTO style(styleId,description) VALUES (1,"impressionism"),(2,'renaissance'),(3,'new wave');

-- artStyle table inserts
INSERT INTO artStyle(artStyleId,artwork,style) VALUES (1,1,1),(2,2,2),(3,3,3);

-- artPhoto table inserts
INSERT INTO artPhoto(photoId, photographerName, artworkId) VALUES(1,'Nancy Cramer',1),(2,'Mark Strong',2),(3,'Henry Howell',3);

-- CDN table inserts
INSERT INTO CDN (cdnId,description) VALUE (1,'halo'),(2,'new mexico'),(3,'neveda');

-- imageHosted table inserts
INSERT INTO imageHosetd(imageHostedId,artPhoto, CDN) VALUES (1,1,1),(2,2,2),(3,3,3);

-- artManager table inserts
INSERT INTO artManager (artManagerId, name, email, artist) VALUES (1, 'Mary West', 'mwest@mail.com',1),(2,'Colleen Nickles','cchi@mail.com',2),(3,'Dan Brown','dessert@mail.com',3);

-- artist table inserts
INSERT INTO artist (artistId, name, DOB, artManager) VALUES (1,'Mark Wood', '1967-02-07',1),(2,'SallyMay','1980-04-11',2),(3,'Jow Ever','1940-03-03',3);


-- ownerBankInfo inserts
INSERT INTO ownerBankInfo(ownerBankInfoId, bankAccountId, owner) VALUES (1,123423,1),(2,352442,2),(3,574532,3);

-- profile table inserts
INSERT INTO profile (profileId, artist, introduction) VALUES ( 1, 1, 'She was educated in London under the most talented artists int the world'),(2,2,'He was educated in New York in street art.'),(3,3,'He has no formal education but doesnt need it');

-- artistPic table inserts
INSERT INTO artistPic (artistPicId, profile, dateAdded, CDN) VALUES (1,1,'2020-05-12',1),(2,2,'2021-04-20',2),(3,3,'2020-03-20',3);

-- school table inserts
INSERT INTO school (schoolId, schoolName) VALUES(1,'NYU'),(2,'SFSU'),(3,'NSU');

-- educated table inserts
INSERT INTO educated(educatedId, artist, artInstitute, yearofGraduation) VALUES (1,1,1,2012),(2,2,2,2014),(3,3,3,2014);

-- degree table inserts
INSERT INTO degree(degreeId,title) VALUES (1,'Bachelors Degree in Arts'),(2,'Masters Degree in Arts'),(3,'AA in Arts');

-- degreeRecieved table inserts
INSERT INTO degreeRecieved ( degreeRecievedId, degree, artist) VALUES (1,1,1),(2,2,2),(3,3,3);






