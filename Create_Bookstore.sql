-- MySQL dump 10.13  Distrib 8.0.18, for macos10.14 (x86_64)
--
-- Host: localhost    Database: Bookstore
-- ------------------------------------------------------
-- Server version	8.0.18

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
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `User` varchar(150) NOT NULL,
  `Street` varchar(150) NOT NULL,
  `City` varchar(100) NOT NULL,
  `State` varchar(100) NOT NULL,
  `Zipcode` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserEmail_idx` (`User`),
  CONSTRAINT `UserEmail` FOREIGN KEY (`User`) REFERENCES `users` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Address`
--

LOCK TABLES `Address` WRITE;
/*!40000 ALTER TABLE `Address` DISABLE KEYS */;
INSERT INTO `Address` VALUES (1,'Employee@gmail.com','105 Morton Walk Drive','Johns Creek','GA',30022),(2,'SystemAdmin@books.com','394 Oconee Street','Athens','GA',30601);
/*!40000 ALTER TABLE `Address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Books`
--

DROP TABLE IF EXISTS `Books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Books` (
  `Quantity` int(11) NOT NULL DEFAULT '1',
  `ISBN` varchar(13) NOT NULL,
  `Title` varchar(250) NOT NULL,
  `Author` varchar(150) NOT NULL,
  `Edition` int(11) NOT NULL DEFAULT '1',
  `Publisher` varchar(150) NOT NULL,
  `Year` year(4) NOT NULL,
  `Genre` int(1) NOT NULL,
  `Image` varchar(150) NOT NULL,
  `MinThreshold` decimal(6,2) NOT NULL,
  `BuyPrice` decimal(6,2) NOT NULL,
  `SellPrice` decimal(6,2) NOT NULL,
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
INSERT INTO `Books` VALUES (1,'9780062667632','Leave the World Behind: A Novel (Hardcover)','Cinelle Barnes',1,'Hub City Press',2020,8,'https://images.booksense.com/images/books/719/235/FC9781938235719.JPG',12.95,7.95,17.95),(1,'9781938235719','A Measure of Belonging: Twenty-One Writers of Color on the New American South (Paperback)','Ruuman Alam',1,'Ecco',2020,1,'https://images.booksense.com/images/books/632/667/FC9780062667632.JPG',22.95,17.95,27.95);
/*!40000 ALTER TABLE `Books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cart`
--

DROP TABLE IF EXISTS `Cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cart` (
  `User` int(11) NOT NULL,
  `Book` varchar(13) NOT NULL,
  `Quantity` int(11) NOT NULL DEFAULT '1',
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
  `ID` int(11) NOT NULL AUTO_INCREMENT,
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
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `User` int(11) NOT NULL COMMENT 'Use user ID to get —> books from cart table, , you can select all books from cart table where user is equal to current user',
  `Address` int(11) NOT NULL,
  `Payment` int(11) NOT NULL,
  `Confirmation` int(11) NOT NULL,
  `Total` decimal(6,2) NOT NULL,
  `Date` datetime NOT NULL,
  `Status` int(11) NOT NULL DEFAULT '0' COMMENT '0 —> Not yet shipped, 1 —> shipped,  2 —> delivered ',
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
INSERT INTO `Orders` VALUES (1,234411,1,1,22146123,12.35,'2020-10-25 00:00:00',0),(2,234411,2,2,22146123,56.95,'2020-10-25 00:00:00',0);
/*!40000 ALTER TABLE `Orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Payment`
--

DROP TABLE IF EXISTS `Payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Payment` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `User` varchar(150) NOT NULL,
  `Type` varchar(20) NOT NULL COMMENT 'Amex, Visa, etc.',
  `Number` varchar(25) NOT NULL,
  `Expiration` date NOT NULL,
  `CCV` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserID_idx` (`User`),
  CONSTRAINT `UserId(fk)` FOREIGN KEY (`User`) REFERENCES `users` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Payment`
--

LOCK TABLES `Payment` WRITE;
/*!40000 ALTER TABLE `Payment` DISABLE KEYS */;
INSERT INTO `Payment` VALUES (1,'Admin@gmail.com','Visa','1234-2222-1245-3333','2022-10-01',637),(2,'Employee@gmail.com','Amex','5444111145212908','2025-08-01',910);
/*!40000 ALTER TABLE `Payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Promotions`
--

DROP TABLE IF EXISTS `Promotions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Promotions` (
  `User` int(11) NOT NULL,
  `Code` varchar(16) NOT NULL,
  `Message` varchar(100) NOT NULL,
  `Discount` int(11) NOT NULL COMMENT 'Use numbers 0 - 99 for discount percentage',
  `Start` date NOT NULL,
  `End` date NOT NULL,
  PRIMARY KEY (`Code`),
  KEY `UserId(promo)_idx` (`User`),
  CONSTRAINT `UserId(promo)` FOREIGN KEY (`User`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Promotions`
--

LOCK TABLES `Promotions` WRITE;
/*!40000 ALTER TABLE `Promotions` DISABLE KEYS */;
INSERT INTO `Promotions` VALUES (234411,'A124B245C222D111','Happy Halloween! 20% your next purchase!',20,'2020-10-01','2020-10-31'),(331412,'M234JULGYTRE','50% your next purchase!',10,'2020-09-01','2020-12-31');
/*!40000 ALTER TABLE `Promotions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sales`
--

DROP TABLE IF EXISTS `Sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sales` (
  `OrderID` int(11) NOT NULL,
  `Book` varchar(13) NOT NULL,
  `Quantity` int(11) NOT NULL DEFAULT '1',
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
INSERT INTO `Sales` VALUES (1,'9781938235719',1),(1,'9780062667632',1);
/*!40000 ALTER TABLE `Sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `Type` int(1) NOT NULL DEFAULT '0' COMMENT '0 —> User 1 —> Employee  2 —> Admin   3 —> System Administrator',
  `Status` int(1) NOT NULL DEFAULT '0' COMMENT '0 —> inactive 1 —> active(after email confirm) 2 —> suspended',
  `Email` varchar(150) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `ID` int(11) DEFAULT NULL COMMENT 'Assigned after email verification',
  `FirstName` varchar(100) NOT NULL,
  `LastName` varchar(100) NOT NULL,
  `Phone` varchar(20) NOT NULL,
  `Notifications` int(1) DEFAULT NULL COMMENT 'Signed up for emails?',
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
INSERT INTO `Users` VALUES (2,0,'Admin@gmail.com','!secretP@ss',234411,'Privileged','Admin','760-217-8632',NULL),(1,0,'Employee@gmail.com','P@ssw0rd',331412,'Chosen','Employee','4048882222',NULL),(3,0,'SystemAdmin@books.com','BooksRUs',40502020,'Store','Owner','404-888-2222',NULL),(0,0,'user@gmail.com','Test123',134,'Sacred','User','(678)456-3311',NULL);
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

-- Dump completed on 2020-10-26  5:10:37
