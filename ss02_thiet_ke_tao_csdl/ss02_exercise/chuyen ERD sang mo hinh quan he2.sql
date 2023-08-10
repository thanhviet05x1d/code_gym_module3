-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: mo_hinh_quan_he
-- ------------------------------------------------------
-- Server version	8.0.34

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
-- Table structure for table `chi_tiet_dat_hang`
--

DROP TABLE IF EXISTS `chi_tiet_dat_hang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chi_tiet_dat_hang` (
  `SoDH` int NOT NULL AUTO_INCREMENT,
  `MaVTU` varchar(20) NOT NULL,
  PRIMARY KEY (`SoDH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chi_tiet_dat_hang`
--

LOCK TABLES `chi_tiet_dat_hang` WRITE;
/*!40000 ALTER TABLE `chi_tiet_dat_hang` DISABLE KEYS */;
/*!40000 ALTER TABLE `chi_tiet_dat_hang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chi_tiet_phieu_nhap`
--

DROP TABLE IF EXISTS `chi_tiet_phieu_nhap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chi_tiet_phieu_nhap` (
  `SoPN` int NOT NULL AUTO_INCREMENT,
  `MaVTU` varchar(20) NOT NULL,
  `DGNhatp` double NOT NULL,
  `SLNhap` int NOT NULL,
  PRIMARY KEY (`SoPN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chi_tiet_phieu_nhap`
--

LOCK TABLES `chi_tiet_phieu_nhap` WRITE;
/*!40000 ALTER TABLE `chi_tiet_phieu_nhap` DISABLE KEYS */;
/*!40000 ALTER TABLE `chi_tiet_phieu_nhap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chi_tiet_phieu_xuat`
--

DROP TABLE IF EXISTS `chi_tiet_phieu_xuat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chi_tiet_phieu_xuat` (
  `SoPX` int NOT NULL AUTO_INCREMENT,
  `MaVTU` varchar(20) NOT NULL,
  `DGXuat` double NOT NULL,
  `SLXuat` int NOT NULL,
  PRIMARY KEY (`SoPX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chi_tiet_phieu_xuat`
--

LOCK TABLES `chi_tiet_phieu_xuat` WRITE;
/*!40000 ALTER TABLE `chi_tiet_phieu_xuat` DISABLE KEYS */;
/*!40000 ALTER TABLE `chi_tiet_phieu_xuat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cung_cap`
--

DROP TABLE IF EXISTS `cung_cap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cung_cap` (
  `SoDH` int NOT NULL AUTO_INCREMENT,
  `MaNCC` varchar(20) NOT NULL,
  PRIMARY KEY (`SoDH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cung_cap`
--

LOCK TABLES `cung_cap` WRITE;
/*!40000 ALTER TABLE `cung_cap` DISABLE KEYS */;
/*!40000 ALTER TABLE `cung_cap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `don_dat_hang`
--

DROP TABLE IF EXISTS `don_dat_hang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `don_dat_hang` (
  `SoDH` int NOT NULL AUTO_INCREMENT,
  `NgayDH` date NOT NULL,
  `MaVTU` varchar(20) NOT NULL,
  `MaNCC` varchar(20) NOT NULL,
  PRIMARY KEY (`SoDH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `don_dat_hang`
--

LOCK TABLES `don_dat_hang` WRITE;
/*!40000 ALTER TABLE `don_dat_hang` DISABLE KEYS */;
/*!40000 ALTER TABLE `don_dat_hang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nha_cung_cap`
--

DROP TABLE IF EXISTS `nha_cung_cap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nha_cung_cap` (
  `MaNCC` varchar(20) NOT NULL,
  `TenNCC` varchar(20) NOT NULL,
  `DiaChi` varchar(45) NOT NULL,
  `SDT` int NOT NULL,
  `SoDH` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`MaNCC`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nha_cung_cap`
--

LOCK TABLES `nha_cung_cap` WRITE;
/*!40000 ALTER TABLE `nha_cung_cap` DISABLE KEYS */;
/*!40000 ALTER TABLE `nha_cung_cap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phieu_nhap`
--

DROP TABLE IF EXISTS `phieu_nhap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phieu_nhap` (
  `SoPN` int NOT NULL AUTO_INCREMENT,
  `NgayNhap` date NOT NULL,
  `SLNhap` int NOT NULL,
  `DGNhap` double NOT NULL,
  PRIMARY KEY (`SoPN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phieu_nhap`
--

LOCK TABLES `phieu_nhap` WRITE;
/*!40000 ALTER TABLE `phieu_nhap` DISABLE KEYS */;
/*!40000 ALTER TABLE `phieu_nhap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phieu_xuat`
--

DROP TABLE IF EXISTS `phieu_xuat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phieu_xuat` (
  `SoPX` int NOT NULL AUTO_INCREMENT,
  `NgayXuat` date NOT NULL,
  `DGXuat` double NOT NULL,
  `SLXuat` int NOT NULL,
  `MaVTU` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`SoPX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phieu_xuat`
--

LOCK TABLES `phieu_xuat` WRITE;
/*!40000 ALTER TABLE `phieu_xuat` DISABLE KEYS */;
/*!40000 ALTER TABLE `phieu_xuat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `so_dien_thoai`
--

DROP TABLE IF EXISTS `so_dien_thoai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `so_dien_thoai` (
  `MaNCC` varchar(20) NOT NULL,
  `SDT` int NOT NULL,
  PRIMARY KEY (`MaNCC`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `so_dien_thoai`
--

LOCK TABLES `so_dien_thoai` WRITE;
/*!40000 ALTER TABLE `so_dien_thoai` DISABLE KEYS */;
/*!40000 ALTER TABLE `so_dien_thoai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vat_tu`
--

DROP TABLE IF EXISTS `vat_tu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vat_tu` (
  `MaVTU` int NOT NULL AUTO_INCREMENT,
  `TenVTU` varchar(25) NOT NULL,
  `SoPX` int DEFAULT NULL,
  `SoPN` int DEFAULT NULL,
  `SoDH` int DEFAULT NULL,
  PRIMARY KEY (`MaVTU`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vat_tu`
--

LOCK TABLES `vat_tu` WRITE;
/*!40000 ALTER TABLE `vat_tu` DISABLE KEYS */;
/*!40000 ALTER TABLE `vat_tu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'mo_hinh_quan_he'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-10 15:16:46
