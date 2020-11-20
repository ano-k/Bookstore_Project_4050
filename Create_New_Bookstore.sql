CREATE DATABASE  IF NOT EXISTS `Bookstore` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `Bookstore`;
-- MySQL dump 10.13  Distrib 8.0.18, for macos10.14 (x86_64)
--
-- Host: localhost    Database: Bookstore
-- ------------------------------------------------------
-- Server version	8.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Address`
--
DROP TABLE IF EXISTS `Address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Address` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `User` varchar(150) NOT NULL,
  `Street` varchar(150) DEFAULT NULL,
  `City` varchar(100) DEFAULT NULL,
  `State` varchar(100) DEFAULT NULL,
  `Zipcode` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserEmail_idx` (`User`),
  CONSTRAINT `UserEmail` FOREIGN KEY (`User`) REFERENCES `users` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Address`
--

LOCK TABLES `Address` WRITE;
/*!40000 ALTER TABLE `Address` DISABLE KEYS */;
INSERT INTO `Address` VALUES (15,'anoboii@gmail.com','N/A','N/A','N/A','N/A'),(16,'anokara98@gmail.com','N/A','N/A','N/A','N/A');
/*!40000 ALTER TABLE `Address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Books`
--

DROP TABLE IF EXISTS `Books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Books` (
  `Quantity` int NOT NULL DEFAULT '1',
  `ISBN` varchar(13) NOT NULL,
  `Title` varchar(250) NOT NULL,
  `Author` varchar(150) NOT NULL,
  `Edition` int NOT NULL DEFAULT '1',
  `Publisher` varchar(150) NOT NULL,
  `Year` varchar(4) NOT NULL,
  `Genre` int NOT NULL,
  `Image` varchar(500) NOT NULL,
  `MinThreshold` double(6,2) NOT NULL,
  `BuyPrice` double(6,2) NOT NULL,
  `SellPrice` double(6,2) NOT NULL,
  `IsArchived` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ISBN`),
  UNIQUE KEY `ISBN_UNIQUE` (`ISBN`),
  KEY `Genre_idx` (`Genre`),
  CONSTRAINT `Genre` FOREIGN KEY (`Genre`) REFERENCES `categories` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Books`
--

LOCK TABLES `Books` WRITE;
/*!40000 ALTER TABLE `Books` DISABLE KEYS */;
INSERT INTO `Books` VALUES (20,'9780062667632','Leave the World Behind: A Novel (Hardcover)','Cinelle Barnes',1,'Hub City Press','2020',3,'https://images.booksense.com/images/books/632/667/FC9780062667632.JPG',12.95,7.95,17.95,0),
	(10,'9781938235719','A Measure of Belonging: Twenty-One Writers of Color on the New American South (Paperback)','Ruuman Alam',1,'Ecco','2020',1,'https://images.booksense.com/images/books/719/235/FC9781938235719.JPG',22.95,17.95,27.95,0),
    (5,'9780441172719','Dune','Frank Herbert',25,'Penguin','2019',11,'https://prodimage.images-bn.com/pimages/9780441172719_p0_v6_s550x406.jpg',10,9.99,9.99,0),
	(12,'9781133187790','Introduction to the Theory of Computation','Michael Sipser',3,'Cengage Learning','2012',3,'https://prodimage.images-bn.com/pimages/9781133187790_p0_v1_s550x406.jpg',5,149.99,149.99,0),
	(20,'9780547928227','The Hobbit','J.R.R. Tolkien',75,'HMH Books','2012',5,'https://prodimage.images-bn.com/pimages/9780547928227_p0_v2_s550x406.jpg',10,14.99,14.99,0),
    (15,'9780439023528','The Hunger Games','Suzanne Collins',1,'Scholastic, Inc.','2010',2,'https://prodimage.images-bn.com/pimages/9780439023528_p0_v1_s550x406.jpg',50,11.69,11.69,0),
    (25,'9780441569595','Neuromancer','William Gibson',2,'Penguin','1986',11,'https://prodimage.images-bn.com/pimages/9780441569595_p0_v2_s550x406.jpg',5,8.99,8.99,0),
	(8,'9780345404473','Do Androids Dream of Electric Sheep?','Philip K. Dick',3,'Random House Publishing Group','1996',11,'https://prodimage.images-bn.com/pimages/9780345404473_p0_v4_s550x406.jpg',8,14.50,14.50,0),
    (10,'9780590353427','Harry Potter and the Sorcerer\'s Stone','J.K. Rowling',10,'Scholastic, Inc.','1999',5,'https://prodimage.images-bn.com/pimages/9780590353427_p0_v2_s550x406.jpg',30,8.99,8.99,0),
    (13,'9780810993136','Diary of a Wimpy Kid','Jeff Kinney',1,'Amulet Books','2007',2,'https://prodimage.images-bn.com/pimages/9780810993136_p0_v4_s550x406.jpg',5,12.45,12.45,0),
	(30,'9780316029186','The Last Wish: Introducing the Witcher','Andrezj Sapkowski',2,'Orbit','2008',5,'https://prodimage.images-bn.com/pimages/9780316029186_p0_v3_s550x406.jpg',2,8.99,8.99,0),
    (25,'9780743477116','Romeo and Juliet','William Shakespeare',50,'Simon & Schuster','2004',10,'https://prodimage.images-bn.com/pimages/9780743477116_p0_v2_s550x406.jpg',4,6.99,6.99,0),
    (10,'9781506721729','The Search Omnibus (Avatar: The Last Airbender)','Frank Herbert',1,'Dark Horse Comics','2020',6,'https://prodimage.images-bn.com/pimages/9781506721729_p0_v2_s550x406.jpg',1,24.99,24.99,0),
    (10,'9780141182346','The Call of Cthulhu and Other Weird Stories','H.P. Lovecraft',3,'Penguin','1999',7,'https://prodimage.images-bn.com/pimages/9780141182346_p0_v1_s550x406.jpg',5,16.50,16.50,0),
    (14,'9781434103567','The Complete Sherlock Holmes','Arthur Conan Doyle',4,'The Editorium','2012',8,'https://prodimage.images-bn.com/pimages/9781434103567_p0_v1_s550x406.jpg',5,29.95,29.95,0),
	(10,'9781524763138','Becoming','Michelle Obama',1,'Crown Publishing Group','2018',9,'https://prodimage.images-bn.com/pimages/9781524763138_p0_v6_s550x406.jpg',5,26.99,26.99,0),
    (40,'9780743477109','Macbeth','William Shakespeare',50,'Simon & Schuster','2003',4,'https://prodimage.images-bn.com/pimages/9780743477109_p0_v3_s550x406.jpg',10,6.99,6.99,0),
    (7,'9781402794629','Treasure Island','Robert Louis Stevenson',5,'Sterling Children\'s Books','2019',1,'https://prodimage.images-bn.com/pimages/9781402794629_p0_v1_s550x406.jpg',2,6.95,6.95,0),
    (10,'9780593098233','Dune Messiah','Frank Herbert',25,'Penguin','2019',11,'https://prodimage.images-bn.com/pimages/9780593098233_p0_v1_s550x406.jpg',10,9.99,9.99,0),
    (10,'9780593098240','Children of Dune','Frank Herbert',25,'Penguin','2019',11,'https://prodimage.images-bn.com/pimages/9780593098240_p0_v1_s550x406.jpg',10,9.99,9.99,0),
	(10,'9780593098257','God Emperor of Dune','Frank Herbert',25,'Penguin','2019',11,'https://prodimage.images-bn.com/pimages/9780593098257_p0_v1_s550x406.jpg',10,9.99,9.99,0),
    (10,'9780593098264','Heretics of Dune','Frank Herbert',25,'Penguin','2019',11,'https://prodimage.images-bn.com/pimages/9780593098264_p0_v1_s550x406.jpg',10,9.99,9.99,0),
    (10,'9780593098271','Chapterhouse: Dune','Frank Herbert',25,'Penguin','2019',11,'https://prodimage.images-bn.com/pimages/9780593098271_p0_v2_s550x406.jpg',10,9.99,9.99,0);
/*!40000 ALTER TABLE `Books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cart`
--

DROP TABLE IF EXISTS `Cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cart` (
  `User` int NOT NULL,
  `Book` varchar(13) NOT NULL,
  `Quantity` int NOT NULL DEFAULT '1',
  KEY `BookID_idx` (`Book`),
  KEY `UserID(fk)_idx` (`User`),
  KEY `UserID(cart)_idx` (`User`),
  CONSTRAINT `BookID` FOREIGN KEY (`Book`) REFERENCES `books` (`ISBN`),
  CONSTRAINT `UserID(cart)` FOREIGN KEY (`User`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cart`
--

LOCK TABLES `Cart` WRITE;
/*!40000 ALTER TABLE `Cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `Cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Categories`
--

DROP TABLE IF EXISTS `Categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Categories` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Genre` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Categories`
--

LOCK TABLES `Categories` WRITE;
/*!40000 ALTER TABLE `Categories` DISABLE KEYS */;
INSERT INTO `Categories` VALUES (1,'Action & Adventure'),(2,'Children\'s'),(3,'Classic'),(4,'Drama'),(5,'Fantasy'),(6,'Graphic Novel'),(7,'Horror'),(8,'Mystery & Crime'),(9,'Non-Fiction'),(10,'Romance'),(11,'Science Fiction');
/*!40000 ALTER TABLE `Categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Orders`
--

DROP TABLE IF EXISTS `Orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Orders` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `User` int NOT NULL COMMENT 'Use user ID to get —> books from cart table, , you can select all books from cart table where user is equal to current user',
  `Address` int NOT NULL,
  `Payment` int NOT NULL,
  `Confirmation` int NOT NULL,
  `Total` decimal(6,2) NOT NULL,
  `Date` varchar(20) NOT NULL,
  `Status` int NOT NULL DEFAULT '0' COMMENT '0 —> Not yet shipped, 1 —> shipped,  2 —> delivered ',
  PRIMARY KEY (`ID`),
  KEY `PaymentID(Order)_idx` (`Payment`),
  KEY `AddressID(Order)_idx` (`Address`),
  KEY `UserID(Order)_idx` (`User`),
  CONSTRAINT `AddressID(Order)` FOREIGN KEY (`Address`) REFERENCES `address` (`ID`),
  CONSTRAINT `PaymentID(Order)` FOREIGN KEY (`Payment`) REFERENCES `payment` (`ID`),
  CONSTRAINT `UserID(Order)` FOREIGN KEY (`User`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orders`
--

LOCK TABLES `Orders` WRITE;
/*!40000 ALTER TABLE `Orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `Orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Payment`
--

DROP TABLE IF EXISTS `Payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Payment` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `User` varchar(150) NOT NULL,
  `Type` varchar(20) DEFAULT NULL COMMENT 'Amex, Visa, etc.',
  `Number` varchar(250) DEFAULT NULL,
  `Expiration` varchar(20) DEFAULT NULL,
  `CVV` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserID_idx` (`User`),
  CONSTRAINT `UserId(fk)` FOREIGN KEY (`User`) REFERENCES `users` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Payment`
--

LOCK TABLES `Payment` WRITE;
/*!40000 ALTER TABLE `Payment` DISABLE KEYS */;
INSERT INTO `Payment` VALUES (7,'anoboii@gmail.com','N/A','N/A','N/A','N/A'),(8,'anokara98@gmail.com','N/A','N/A','N/A','N/A');
/*!40000 ALTER TABLE `Payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Promotions`
--

DROP TABLE IF EXISTS `Promotions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Promotions` (
  `Code` varchar(16) NOT NULL,
  `Message` varchar(100) NOT NULL,
  `Discount` int NOT NULL COMMENT 'Use numbers 0 - 99 for discount percentage',
  `Start` varchar(20) NOT NULL,
  `End` varchar(20) NOT NULL,
  PRIMARY KEY (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Promotions`
--

LOCK TABLES `Promotions` WRITE;
/*!40000 ALTER TABLE `Promotions` DISABLE KEYS */;
INSERT INTO `Promotions` VALUES ('A121B312C123','Happy Halloween!',50,'10-28-2020','11-01-2020'),('AXYFB213E312','Get your Thanksgiving reading in!',25,'11-24-2020','11-27-2020');
/*!40000 ALTER TABLE `Promotions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sales`
--

DROP TABLE IF EXISTS `Sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sales` (
  `OrderID` int NOT NULL,
  `Book` varchar(13) NOT NULL,
  `Quantity` int NOT NULL DEFAULT '1',
  KEY `BookID(Sales)_idx` (`Book`),
  KEY `OrderID(Sales)_idx` (`OrderID`),
  CONSTRAINT `BookID(Sales)` FOREIGN KEY (`Book`) REFERENCES `books` (`ISBN`),
  CONSTRAINT `OrderID(Sales)` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sales`
--

LOCK TABLES `Sales` WRITE;
/*!40000 ALTER TABLE `Sales` DISABLE KEYS */;
/*!40000 ALTER TABLE `Sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `Type` int NOT NULL DEFAULT '0' COMMENT '0 —> User 1 —> Employee  2 —> Admin   3 —> System Administrator',
  `Status` int NOT NULL DEFAULT '0' COMMENT '0 —> inactive 1 —> active(after email confirm) 2 —> suspended',
  `Email` varchar(150) NOT NULL,
  `Password` varchar(200) NOT NULL,
  `ID` int DEFAULT NULL COMMENT 'Assigned after email verification',
  `FirstName` varchar(100) NOT NULL,
  `LastName` varchar(100) NOT NULL,
  `Phone` varchar(20) NOT NULL,
  `Notifications` int DEFAULT NULL COMMENT 'Signed up for emails? 0 -> NO 1 -> YES',
  PRIMARY KEY (`Email`),
  UNIQUE KEY `email_UNIQUE` (`Email`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (2,0,'anoboii@gmail.com','42c13d905f2fa471066f528f279994778ca30e2ffde844a191d8b932885ae1ba',NULL,'Admin','Test','444-111-2222',NULL),(0,0,'anokara98@gmail.com','42c13d905f2fa471066f528f279994778ca30e2ffde844a191d8b932885ae1ba',NULL,'Example','User','123-123-1233',NULL),(0,1,'jason.c.wahl@gmail.com','42c13d905f2fa471066f528f279994778ca30e2ffde844a191d8b932885ae1ba',NULL,'Jason','Wahl','123-123-1233',1);
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-11 19:22:02
