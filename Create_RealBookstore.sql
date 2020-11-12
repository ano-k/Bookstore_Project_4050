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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `Payment`
--

DROP TABLE IF EXISTS `Payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Payment` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `User` varchar(150) NOT NULL,
  `Type` varchar(20) DEFAULT NULL COMMENT 'Amex, Visa, etc.',
  `Number` varchar(25) DEFAULT NULL,
  `Expiration` varchar(20) DEFAULT NULL,
  `CVV` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserID_idx` (`User`),
  CONSTRAINT `UserId(fk)` FOREIGN KEY (`User`) REFERENCES `users` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `Notifications` int DEFAULT NULL COMMENT 'Signed up for emails?',
  PRIMARY KEY (`Email`),
  UNIQUE KEY `email_UNIQUE` (`Email`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-11 19:00:00
