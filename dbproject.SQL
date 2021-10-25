-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  `Address` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Min Kyung An','SHSU'),(2,'Joe Smith','123 Any Street'),(3,'Mike Brown','554 Your Lost');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_rates`
--

DROP TABLE IF EXISTS `daily_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_rates` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Publication_ID` int(11) NOT NULL,
  `Days_Per_Week` int(11) NOT NULL,
  `Rate` decimal(10,0) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_Daily_Rates_Publication1_idx` (`Publication_ID`),
  CONSTRAINT `fk_Daily_Rates_Publication1` FOREIGN KEY (`Publication_ID`) REFERENCES `publication` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_rates`
--

LOCK TABLES `daily_rates` WRITE;
/*!40000 ALTER TABLE `daily_rates` DISABLE KEYS */;
INSERT INTO `daily_rates` VALUES (1,2,2,20),(2,2,5,15),(3,2,7,25);
/*!40000 ALTER TABLE `daily_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frequency`
--

DROP TABLE IF EXISTS `frequency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frequency` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(45) NOT NULL,
  `UseDailyRate` tinyint(4) NOT NULL,
  `Number_of_Days` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frequency`
--

LOCK TABLES `frequency` WRITE;
/*!40000 ALTER TABLE `frequency` DISABLE KEYS */;
INSERT INTO `frequency` VALUES (1,'Daily',1,1),(2,'Weekly',0,7),(3,'Monthly',0,30),(4,'Quarterly',0,91);
/*!40000 ALTER TABLE `frequency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publication`
--

DROP TABLE IF EXISTS `publication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publication` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  `Type_ID` int(11) NOT NULL,
  `Frequency_ID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Name_UNIQUE` (`Name`),
  KEY `fk_Publication_Publication_TYPE1_idx` (`Type_ID`),
  KEY `fk_Publication_Frequency1_idx` (`Frequency_ID`),
  CONSTRAINT `fk_Publication_Frequency1` FOREIGN KEY (`Frequency_ID`) REFERENCES `frequency` (`ID`),
  CONSTRAINT `fk_Publication_Publication_TYPE1` FOREIGN KEY (`Type_ID`) REFERENCES `publication_type` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publication`
--

LOCK TABLES `publication` WRITE;
/*!40000 ALTER TABLE `publication` DISABLE KEYS */;
INSERT INTO `publication` VALUES (1,'Money',1,3),(2,'New York Times',2,1),(3,'National Enquirer',2,2);
/*!40000 ALTER TABLE `publication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publication_type`
--

DROP TABLE IF EXISTS `publication_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publication_type` (
  `ID` int(11) NOT NULL,
  `Description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publication_type`
--

LOCK TABLES `publication_type` WRITE;
/*!40000 ALTER TABLE `publication_type` DISABLE KEYS */;
INSERT INTO `publication_type` VALUES (1,'Magazine'),(2,'Newspaper'),(3,'Other');
/*!40000 ALTER TABLE `publication_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publication_type_frequency`
--

DROP TABLE IF EXISTS `publication_type_frequency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publication_type_frequency` (
  `Publication_Type_ID` int(11) NOT NULL,
  `Frequency_ID` int(11) NOT NULL,
  PRIMARY KEY (`Publication_Type_ID`,`Frequency_ID`),
  KEY `fk_Publication_Type_Frequency_Frequency1_idx` (`Frequency_ID`),
  CONSTRAINT `fk_Publication_Type_Frequency_Frequency1` FOREIGN KEY (`Frequency_ID`) REFERENCES `frequency` (`ID`),
  CONSTRAINT `fk_Publication_Type_Frequency_Publication_TYPE1` FOREIGN KEY (`Publication_Type_ID`) REFERENCES `publication_type` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publication_type_frequency`
--

LOCK TABLES `publication_type_frequency` WRITE;
/*!40000 ALTER TABLE `publication_type_frequency` DISABLE KEYS */;
INSERT INTO `publication_type_frequency` VALUES (2,1),(1,2),(2,2),(1,3),(1,4);
/*!40000 ALTER TABLE `publication_type_frequency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription`
--

DROP TABLE IF EXISTS `subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Customer_ID` int(11) NOT NULL,
  `Publication_ID` int(11) NOT NULL,
  `Rate_ID` int(11) NOT NULL,
  `Number_Of_Months` int(11) DEFAULT NULL,
  `Bill_Amount` decimal(10,0) NOT NULL,
  `Start_Date` date DEFAULT NULL,
  `End_Date` date DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_SUBSCRIPTION_CUSTOMER_idx` (`Customer_ID`),
  KEY `fk_SUBSCRIPTION_Publication1_idx` (`Publication_ID`),
  CONSTRAINT `fk_SUBSCRIPTION_CUSTOMER` FOREIGN KEY (`Customer_ID`) REFERENCES `customer` (`ID`),
  CONSTRAINT `fk_SUBSCRIPTION_Publication1` FOREIGN KEY (`Publication_ID`) REFERENCES `publication` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription`
--

LOCK TABLES `subscription` WRITE;
/*!40000 ALTER TABLE `subscription` DISABLE KEYS */;
INSERT INTO `subscription` VALUES (1,1,1,1,NULL,20,'2020-01-01','2020-12-31'),(2,1,2,2,6,90,'2020-01-01','2020-06-30'),(3,2,3,3,NULL,10,'2020-01-01','2020-02-01'),(4,3,3,5,NULL,50,'2020-01-01','2020-12-31');
/*!40000 ALTER TABLE `subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_rates`
--

DROP TABLE IF EXISTS `subscription_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription_rates` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Publication_ID` int(11) DEFAULT NULL,
  `Number_of_Issues` int(11) DEFAULT NULL,
  `Rate` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_Subscription_Rates_Publication1_idx` (`Publication_ID`),
  CONSTRAINT `fk_Subscription_Rates_Publication1` FOREIGN KEY (`Publication_ID`) REFERENCES `publication` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_rates`
--

LOCK TABLES `subscription_rates` WRITE;
/*!40000 ALTER TABLE `subscription_rates` DISABLE KEYS */;
INSERT INTO `subscription_rates` VALUES (1,1,12,20),(2,1,24,30),(3,3,4,10),(4,3,13,20),(5,3,52,50);
/*!40000 ALTER TABLE `subscription_rates` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-29 18:33:52
