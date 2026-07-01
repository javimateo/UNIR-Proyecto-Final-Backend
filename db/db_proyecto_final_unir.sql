CREATE DATABASE  IF NOT EXISTS `db_proyecto_final_unir` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_proyecto_final_unir`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: db_proyecto_final_unir
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brands` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `logo_url` varchar(500) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brands`
--

LOCK TABLES `brands` WRITE;
/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
INSERT INTO `brands` VALUES (1,'Samsung','samsung',NULL,'2026-06-18 08:44:32'),(2,'LG','lg',NULL,'2026-06-18 08:44:32'),(3,'Sony','sony',NULL,'2026-06-18 08:44:32'),(4,'Xiaomi','xiaomi',NULL,'2026-06-18 08:44:32'),(5,'TCL','tcl',NULL,'2026-06-18 08:44:32'),(6,'Philips','philips',NULL,'2026-06-18 08:44:32'),(7,'Hisense','hisense',NULL,'2026-06-18 08:44:32'),(8,'Panasonic','panasonic',NULL,'2026-06-18 08:44:32');
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Pantallas pequeñas (hasta 32\")','pantallas-pequenas','2026-06-18 08:44:32'),(2,'Pantallas medianas (33\" - 50\")','pantallas-medianas','2026-06-18 08:44:32'),(3,'Pantallas grandes (51\" - 65\")','pantallas-grandes','2026-06-18 08:44:32'),(4,'Pantallas extra grandes (66\"+)','pantallas-extra-grandes','2026-06-18 08:44:32');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conversations`
--

DROP TABLE IF EXISTS `conversations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conversations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int unsigned NOT NULL,
  `buyer_id` int unsigned NOT NULL,
  `seller_id` int unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_conversation` (`item_id`,`buyer_id`),
  KEY `buyer_id` (`buyer_id`),
  KEY `seller_id` (`seller_id`),
  CONSTRAINT `conversations_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conversations_ibfk_2` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conversations_ibfk_3` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversations`
--

LOCK TABLES `conversations` WRITE;
/*!40000 ALTER TABLE `conversations` DISABLE KEYS */;
INSERT INTO `conversations` VALUES (1,1,4,3,'2026-06-18 08:44:32'),(2,2,4,5,'2026-06-18 08:44:32'),(3,5,6,5,'2026-06-18 08:44:32'),(4,6,3,6,'2026-06-18 08:44:32'),(5,9,5,3,'2026-06-18 08:44:32'),(6,10,9,4,'2026-06-18 08:44:32'),(7,12,7,8,'2026-06-18 08:44:32'),(8,13,3,5,'2026-06-18 08:44:32');
/*!40000 ALTER TABLE `conversations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `item_id` int unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_favorite` (`user_id`,`item_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `favorites_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
INSERT INTO `favorites` VALUES (1,3,1,'2026-06-18 08:44:32'),(2,9,1,'2026-06-18 08:44:32'),(3,7,2,'2026-06-18 08:44:32'),(4,4,5,'2026-06-18 08:44:32'),(5,5,6,'2026-06-18 08:44:32'),(6,8,6,'2026-06-18 08:44:32'),(7,3,9,'2026-06-18 08:44:32'),(8,9,9,'2026-06-18 08:44:32'),(9,3,10,'2026-06-18 08:44:32'),(10,6,12,'2026-06-18 08:44:32'),(11,8,12,'2026-06-18 08:44:32'),(12,5,13,'2026-06-18 08:44:32'),(13,7,13,'2026-06-18 08:44:32'),(14,4,14,'2026-06-18 08:44:32'),(15,4,15,'2026-06-18 08:44:32');
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_photos`
--

DROP TABLE IF EXISTS `item_photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_photos` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int unsigned NOT NULL,
  `url` varchar(500) NOT NULL,
  `is_main` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` tinyint unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `item_photos_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_photos`
--

LOCK TABLES `item_photos` WRITE;
/*!40000 ALTER TABLE `item_photos` DISABLE KEYS */;
INSERT INTO `item_photos` VALUES (1,1,'https://via.placeholder.com/800x500?text=Xiaomi+32',1,0),(2,2,'https://via.placeholder.com/800x500?text=Samsung+32',1,0),(3,3,'https://via.placeholder.com/800x500?text=LG+24',1,0),(4,4,'https://via.placeholder.com/800x500?text=Hisense+32',1,0),(5,5,'https://via.placeholder.com/800x500?text=Samsung+43',1,0),(6,6,'https://via.placeholder.com/800x500?text=LG+50',1,0),(7,7,'https://via.placeholder.com/800x500?text=TCL+43',1,0),(8,9,'https://via.placeholder.com/800x500?text=Sony+55',1,0),(9,10,'https://via.placeholder.com/800x500?text=Philips+65',1,0),(10,11,'https://via.placeholder.com/800x500?text=Samsung+55',1,0),(11,12,'https://via.placeholder.com/800x500?text=LG+55',1,0),(12,13,'https://via.placeholder.com/800x500?text=Samsung+75',1,0),(13,14,'https://via.placeholder.com/800x500?text=TCL+85',1,0),(14,15,'https://via.placeholder.com/800x500?text=Hisense+75',1,0),(15,16,'https://via.placeholder.com/800x500?text=Sony+65',1,0);
/*!40000 ALTER TABLE `item_photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `category_id` int unsigned NOT NULL,
  `brand_id` int unsigned DEFAULT NULL,
  `title` varchar(150) NOT NULL,
  `model` varchar(150) DEFAULT NULL,
  `description` text,
  `specs` json DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `item_condition` enum('new','like_new','good','fair','poor') NOT NULL,
  `status` enum('draft','published','under_review','removed','sold') NOT NULL DEFAULT 'draft',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `category_id` (`category_id`),
  KEY `brand_id` (`brand_id`),
  CONSTRAINT `items_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `items_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `items_ibfk_3` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,3,1,4,'Xiaomi Smart TV F2 32\"','L32M7-F2EN','Pantalla Fire TV integrada, resolución HD, sonido Dolby Audio y control por voz Alexa.','{\"hdr\": \"No\", \"hdmi\": \"3\", \"panel\": \"LED\", \"pulgadas\": \"32\", \"smart_tv\": \"Fire TV\", \"resolucion\": \"HD 720p\"}',179.00,'like_new','published','2026-06-18 08:44:32','2026-06-18 08:44:32'),(2,4,1,1,'Samsung T4305 32\"','UE32T4305AKXXC','Smart TV ideal para cocina o dormitorio secundario. HDR y PurColor.','{\"hdr\": \"HDR10\", \"hdmi\": \"2\", \"panel\": \"LED\", \"pulgadas\": \"32\", \"smart_tv\": \"Tizen\", \"resolucion\": \"FHD 1080p\"}',195.00,'good','published','2026-06-18 08:44:32','2026-06-18 08:44:32'),(3,7,1,2,'LG Smart TV 24\" Monitor-TV','24TQ510S-WZ','Combo monitor y televisión con webOS22, color blanco, ideal para espacios reducidos.','{\"hdr\": \"No\", \"hdmi\": \"1\", \"panel\": \"LED-IPS\", \"pulgadas\": \"24\", \"smart_tv\": \"webOS\", \"resolucion\": \"HD 720p\"}',120.00,'good','published','2026-06-18 08:44:32','2026-06-18 08:44:32'),(4,8,1,7,'Hisense 32A4K','32A4K','Televisor básico con sistema VIDAA, modo juego y optimizador de color natural.','{\"hdr\": \"No\", \"hdmi\": \"2\", \"panel\": \"LED\", \"pulgadas\": \"32\", \"smart_tv\": \"VIDAA\", \"resolucion\": \"HD 720p\"}',140.00,'like_new','published','2026-06-18 08:44:32','2026-06-18 08:44:32'),(5,5,2,1,'Samsung Crystal UHD 43\"','TU43CU7105','Procesador Crystal 4K, gran contraste. Un año de uso. Vendo por mudanza.','{\"hdr\": \"HDR10+\", \"hdmi\": \"3\", \"panel\": \"LED\", \"pulgadas\": \"43\", \"smart_tv\": \"Tizen\", \"resolucion\": \"4K UHD\"}',290.00,'like_new','published','2026-06-18 08:44:32','2026-06-18 08:44:32'),(6,6,2,2,'LG NanoCell 50\"','50NANO766QA','Colores puros gracias a NanoCell, Smart TV webOS 22 con perfiles de usuario.','{\"hdr\": \"HDR10 Pro\", \"hdmi\": \"3\", \"panel\": \"NanoCell\", \"pulgadas\": \"50\", \"smart_tv\": \"webOS\", \"resolucion\": \"4K UHD\"}',360.00,'like_new','published','2026-06-18 08:44:32','2026-06-18 08:44:32'),(7,9,2,5,'TCL 43\" 4K Google TV','43P635','Diseño sin bordes metálico, Google TV con control por voz manos libres, Dolby Audio.','{\"hdr\": \"HDR10\", \"hdmi\": \"3\", \"panel\": \"LED\", \"pulgadas\": \"43\", \"smart_tv\": \"Google TV\", \"resolucion\": \"4K UHD\"}',230.00,'good','published','2026-06-18 08:44:32','2026-06-18 08:44:32'),(8,3,2,1,'Samsung OLED 48\" (Borrador)','QE48S90C','Pendiente de verificar fotos del panel para descartar quemados antes de publicar.','{\"hdr\": \"Quantum HDR\", \"hdmi\": \"4\", \"panel\": \"OLED\", \"pulgadas\": \"48\", \"smart_tv\": \"Tizen\", \"resolucion\": \"4K UHD\"}',890.00,'like_new','draft','2026-06-18 08:44:32','2026-06-18 08:44:32'),(9,3,3,3,'Sony BRAVIA XR OLED 55\"','XR-55A80L','Pantalla acústica, negros perfectos, perfecta para PlayStation 5 con HDMI 2.1.','{\"hdr\": \"Dolby Vision\", \"hdmi\": \"4\", \"panel\": \"OLED\", \"pulgadas\": \"55\", \"smart_tv\": \"Google TV\", \"resolucion\": \"4K UHD\"}',1150.00,'new','published','2026-06-18 08:44:32','2026-06-18 08:44:32'),(10,4,3,6,'Philips Ambilight 65\"','65PUS8517','Sistema Ambilight de 3 lados que ilumina la pared. Panel de gran nitidez.','{\"hdr\": \"Dolby Vision\", \"hdmi\": \"4\", \"panel\": \"LED\", \"pulgadas\": \"65\", \"smart_tv\": \"Android TV\", \"resolucion\": \"4K UHD\"}',620.00,'good','published','2026-06-18 08:44:32','2026-06-18 08:44:32'),(11,7,3,1,'Samsung QLED 55\"','QE55Q60B','100% Volumen de color con Quantum Dot. Estado impecable con caja original.','{\"hdr\": \"HDR10+\", \"hdmi\": \"3\", \"panel\": \"QLED\", \"pulgadas\": \"55\", \"smart_tv\": \"Tizen\", \"resolucion\": \"4K UHD\"}',450.00,'good','published','2026-06-18 08:44:32','2026-06-18 08:44:32'),(12,8,3,2,'LG OLED EVO 55\"','OLED55C26LD','El mejor panel para gaming y cine, 120Hz nativos, procesador inteligente a9 Gen5.','{\"hdr\": \"Dolby Vision IQ\", \"hdmi\": \"4\", \"panel\": \"OLED EVO\", \"pulgadas\": \"55\", \"smart_tv\": \"webOS\", \"resolucion\": \"4K UHD\"}',790.00,'new','published','2026-06-18 08:44:32','2026-06-18 08:44:32'),(13,5,4,1,'Samsung Neo QLED 75\" 8K','QE75QN700B','Resolución 8K real con Mini LED. Comprada hace 6 meses. Una experiencia de cine.','{\"hdr\": \"Quantum HDR 2000\", \"hdmi\": \"4\", \"panel\": \"Mini LED\", \"pulgadas\": \"75\", \"smart_tv\": \"Tizen\", \"resolucion\": \"8K UHD\"}',1850.00,'like_new','published','2026-06-18 08:44:32','2026-06-18 08:44:32'),(14,6,4,5,'TCL 85\" QLED 4K 144Hz','85C745','Gigante pantalla gaming con tasa de refresco alta, Full Array Local Dimming.','{\"hdr\": \"Dolby Vision IQ\", \"hdmi\": \"4\", \"panel\": \"QLED\", \"pulgadas\": \"85\", \"smart_tv\": \"Google TV\", \"resolucion\": \"4K UHD\"}',1100.00,'good','published','2026-06-18 08:44:32','2026-06-18 08:44:32'),(15,9,4,7,'Hisense 75\" Mini-LED','75U7KQ','Tecnología Mini-LED ULED, 144Hz, ideal para salón grande. Sin marcas ni arañazos.','{\"hdr\": \"HDR10+ Adaptive\", \"hdmi\": \"4\", \"panel\": \"Mini-LED\", \"pulgadas\": \"75\", \"smart_tv\": \"VIDAA\", \"resolucion\": \"4K UHD\"}',780.00,'like_new','published','2026-06-18 08:44:32','2026-06-18 08:44:32'),(16,11,3,3,'Sony BRAVIA LED 65\" 4K','KD-65X75K','Televisor impecable con Google TV. Muy poco uso, lo vendo con su mando original y patas.','{\"hdr\": \"HDR10\", \"hdmi\": \"3\", \"panel\": \"LED\", \"pulgadas\": \"65\", \"smart_tv\": \"Google TV\", \"resolucion\": \"4K UHD\"}',540.00,'like_new','published','2026-06-18 08:44:32','2026-06-18 08:44:32');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `conversation_id` int unsigned NOT NULL,
  `sender_id` int unsigned NOT NULL,
  `content` text NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `sent_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `conversation_id` (`conversation_id`),
  KEY `sender_id` (`sender_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,1,4,'¡Hola! ¿Sigue disponible la Xiaomi de 32\"?',1,'2026-05-10 07:00:00'),(2,1,3,'Sí, disponible. ¿Tienes alguna duda?',1,'2026-05-10 07:15:00'),(3,1,4,'¿Viene con el sistema Fire TV fluido o se encalla en Netflix?',1,'2026-05-10 07:20:00'),(4,1,3,'Va perfecto, está actualizado a la última versión del sistema.',1,'2026-05-10 08:00:00'),(5,1,4,'¿Harías un poco de descuento si recojo en mano?',0,'2026-05-10 08:30:00'),(6,2,4,'Buenas, ¿tiene algún arañazo o golpe en la pantalla?',1,'2026-05-11 09:00:00'),(7,2,5,'No, está perfecta. Siempre colgada en pared sin peligro de niños.',1,'2026-05-11 09:30:00'),(8,2,4,'¿Podría bajar a 250 euros?',0,'2026-05-11 09:45:00'),(9,3,6,'Hola, ¿la pantalla ha sufrido quemados o tiene efecto fantasma?',1,'2026-05-12 15:00:00'),(10,3,5,'No, nunca. Es un panel Mini LED, no sufre de retenciones térmicas.',1,'2026-05-12 15:30:00'),(11,3,6,'¿Conservas la caja original para transportarla?',1,'2026-05-12 16:00:00'),(12,3,5,'Sí, tengo la caja gigante, la factura y los dos mandos.',0,'2026-05-12 16:15:00'),(13,4,3,'¿Funcionan bien todos los LEDs traseros del sistema Ambilight?',0,'2026-05-13 08:00:00'),(14,5,5,'¿Tiene puerto HDMI 2.1 para conectar la PlayStation 5 a 120Hz?',1,'2026-05-14 06:00:00'),(15,5,3,'Sí, tiene 2 puertos HDMI 2.1 con soporte 4K a 120Hz.',0,'2026-05-14 06:20:00'),(16,6,9,'Hola, ¿el panel tiene problemas de fugas de luz en las esquinas?',1,'2026-05-19 13:00:00'),(17,6,4,'Mínimo, lo habitual en paneles LED básicos, imperceptible con luz.',1,'2026-05-19 13:30:00'),(18,6,9,'¿La dejarías en 580 euros?',0,'2026-05-19 14:00:00'),(19,7,7,'Hola, ¿la televisión tiene algún píxel muerto o vago?',1,'2026-05-17 10:00:00'),(20,7,8,'Ninguno. Pasé un test de colores antes de empaquetarla.',0,'2026-05-17 10:30:00'),(21,8,3,'¿Cuántos metros mide la caja de largo? Para ver si cabe en mi coche.',1,'2026-05-20 09:00:00'),(22,8,5,'Mide casi 2 metros. Hace falta furgoneta para transportarla.',0,'2026-05-20 09:30:00');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int unsigned NOT NULL,
  `reporter_id` int unsigned NOT NULL,
  `moderator_id` int unsigned DEFAULT NULL,
  `reason` varchar(255) NOT NULL,
  `status` enum('pending','resolved_active','resolved_removed') NOT NULL DEFAULT 'pending',
  `moderator_note` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `resolved_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`),
  KEY `reporter_id` (`reporter_id`),
  KEY `moderator_id` (`moderator_id`),
  CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reports_ibfk_2` FOREIGN KEY (`reporter_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reports_ibfk_3` FOREIGN KEY (`moderator_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
INSERT INTO `reports` VALUES (1,13,3,NULL,'Intento de fraude. El vendedor pide el pago fuera de la plataforma mediante Bizum.','pending',NULL,'2026-05-18 10:00:00',NULL),(2,9,5,NULL,'Anuncio engañoso. Las fotos muestran una pantalla con el cristal líquido dañado.','pending',NULL,'2026-05-20 08:00:00',NULL),(3,14,7,NULL,'Precio falsificado. Indica 1100€ en el título pero en la descripción exige 1800€.','pending',NULL,'2026-05-21 07:30:00',NULL),(4,1,5,2,'El artículo recibido no coincide. Es un modelo más antiguo sin Smart TV.','resolved_removed','Verificado: el modelo publicado falsificaba el número de serie. Artículo eliminado.','2026-05-15 06:00:00','2026-05-16 08:30:00'),(5,12,4,2,'Sospecho que las imágenes son robadas de internet y no corresponden al producto.','resolved_active','Revisión completada. El vendedor aportó fotos adicionales con papel firmado. Artículo legítimo.','2026-05-12 12:00:00','2026-05-13 07:00:00'),(6,6,9,2,'El precio es sospechosamente bajo para una LG NanoCell en ese estado.','resolved_active','Precio competitivo pero razonable dado el desgaste visible en la carcasa trasera. Sin acciones.','2026-05-17 14:00:00','2026-05-18 07:00:00');
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `avatar_url` varchar(500) DEFAULT NULL,
  `role` enum('user','moderator','admin') NOT NULL DEFAULT 'user',
  `status` enum('active','blocked','deleted') NOT NULL DEFAULT 'active',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin_laura','laura.admin@example.com','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','https://i.pravatar.cc/150?u=1','admin','active','2026-06-18 08:44:32'),(2,'mod_carlos','carlos.mod@example.com','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','https://i.pravatar.cc/150?u=2','moderator','active','2026-06-18 08:44:32'),(3,'user_sofia','sofia@example.com','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','https://i.pravatar.cc/150?u=3','user','active','2026-06-18 08:44:32'),(4,'user_miguel','miguel@example.com','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','https://i.pravatar.cc/150?u=4','user','active','2026-06-18 08:44:32'),(5,'user_elena','elena@example.com','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','https://i.pravatar.cc/150?u=5','user','active','2026-06-18 08:44:32'),(6,'user_pablo','pablo@example.com','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','https://i.pravatar.cc/150?u=6','user','active','2026-06-18 08:44:32'),(7,'user_ana','ana@example.com','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','https://i.pravatar.cc/150?u=7','user','active','2026-06-18 08:44:32'),(8,'user_jorge','jorge@example.com','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','https://i.pravatar.cc/150?u=8','user','active','2026-06-18 08:44:32'),(9,'user_marta','marta@example.com','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','https://i.pravatar.cc/150?u=9','user','active','2026-06-18 08:44:32'),(10,'user_blocked','blocked@example.com','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',NULL,'user','blocked','2026-06-18 08:44:32'),(11,'user_ramon','ramon@example.com','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','https://i.pravatar.cc/150?u=11','user','active','2026-06-18 08:44:32');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `valuations`
--

DROP TABLE IF EXISTS `valuations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `valuations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `reviewer_id` int unsigned NOT NULL,
  `reviewed_id` int unsigned NOT NULL,
  `item_id` int unsigned NOT NULL,
  `score` tinyint unsigned NOT NULL,
  `comment` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_valuation` (`reviewer_id`,`item_id`),
  KEY `reviewed_id` (`reviewed_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `valuations_ibfk_1` FOREIGN KEY (`reviewer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `valuations_ibfk_2` FOREIGN KEY (`reviewed_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `valuations_ibfk_3` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `valuations_chk_1` CHECK ((`score` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `valuations`
--

LOCK TABLES `valuations` WRITE;
/*!40000 ALTER TABLE `valuations` DISABLE KEYS */;
INSERT INTO `valuations` VALUES (1,4,3,1,5,'Televisión compacta tal como se describía. Vendedora muy atenta y puntual en el punto de encuentro.','2026-06-18 08:44:32'),(2,3,5,13,4,'El pantallón de 75 pulgadas llegó con su embalaje original. Funciona perfecto y gran trato.','2026-06-18 08:44:32'),(3,5,4,2,5,'La Samsung de 32\" estaba impecable para la cocina. Transacción transparente.','2026-06-18 08:44:32'),(4,6,5,5,3,'La televisión de 65\" tenía un pequeño arañazo en el marco que omitió en la descripción.','2026-06-18 08:44:32'),(5,4,6,12,5,'Panel OLED en perfecto estado, sin quemados. Pablo fue muy amable y me ayudó a cargarla.','2026-06-18 08:44:32'),(6,7,8,6,4,'La LG de 50\" venía muy bien protegida. Calidad de imagen perfecta, sin píxeles defectuosos.','2026-06-18 08:44:32'),(7,9,4,2,5,'Todo perfecto. El televisor está nuevo y Miguel contestó a todas mis dudas técnicas al instante.','2026-06-18 08:44:32');
/*!40000 ALTER TABLE `valuations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'db_proyecto_final_unir'
--

--
-- Dumping routines for database 'db_proyecto_final_unir'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-18  8:55:16
