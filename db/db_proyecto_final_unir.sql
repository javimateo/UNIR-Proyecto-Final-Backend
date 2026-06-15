CREATE DATABASE  IF NOT EXISTS `proyecto_final_unir` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `proyecto_final_unir`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: proyecto_final_unir
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
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brand` (
  `id_marca` int NOT NULL AUTO_INCREMENT,
  `nombre_marca` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_marca`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
INSERT INTO `brand` VALUES (1,'Samsung'),(2,'LG'),(3,'Sony'),(4,'Xiaomi'),(5,'TCL'),(6,'Philips'),(7,'Hisense');
/*!40000 ALTER TABLE `brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nombre_categoria` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Pantallas Compactas (24\" - 32\")'),(2,'Pantallas Medianas (33\" - 50\")'),(3,'Pantallas Grandes (51\" - 65\")'),(4,'Pantallas Gigantes (66\" - 85\")');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conversations`
--

DROP TABLE IF EXISTS `conversations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conversations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_id` int NOT NULL,
  `buyer_id` int NOT NULL,
  `seller_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`),
  KEY `buyer_id` (`buyer_id`),
  KEY `seller_id` (`seller_id`),
  CONSTRAINT `conversations_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conversations_ibfk_2` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conversations_ibfk_3` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversations`
--

LOCK TABLES `conversations` WRITE;
/*!40000 ALTER TABLE `conversations` DISABLE KEYS */;
INSERT INTO `conversations` VALUES (1,1,4,3,'2026-06-08 15:47:27'),(2,5,4,5,'2026-06-08 15:47:27'),(3,13,6,5,'2026-06-08 15:47:27'),(4,10,3,6,'2026-06-08 15:47:27'),(5,12,4,6,'2026-06-08 15:47:27'),(6,14,3,6,'2026-06-08 15:47:27'),(7,9,5,3,'2026-06-08 15:47:27'),(8,6,7,4,'2026-06-08 15:47:27'),(9,15,8,3,'2026-06-08 15:47:27'),(10,2,9,4,'2026-06-08 15:47:27'),(11,7,3,9,'2026-06-08 15:47:27'),(12,3,6,9,'2026-06-08 15:47:27');
/*!40000 ALTER TABLE `conversations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites` (
  `user_id` int NOT NULL,
  `item_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`item_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `favorites_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
INSERT INTO `favorites` VALUES (3,1),(9,1),(7,2),(4,5),(5,6),(8,6),(3,9),(9,9),(3,10),(6,12),(8,12),(5,13),(7,13),(4,14),(4,15);
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_photos`
--

DROP TABLE IF EXISTS `item_photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_photos` (
  `id` int NOT NULL,
  `item_id` int NOT NULL,
  `photo_url` varchar(255) NOT NULL,
  `is_main` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `item_photos_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_photos`
--

LOCK TABLES `item_photos` WRITE;
/*!40000 ALTER TABLE `item_photos` DISABLE KEYS */;
INSERT INTO `item_photos` VALUES (1,1,'https://unsplash.com',1),(2,2,'https://unsplash.com',1),(3,3,'https://unsplash.com',1),(4,4,'https://unsplash.com',1),(5,5,'https://unsplash.com',1),(6,6,'https://unsplash.com',1),(7,7,'https://unsplash.com',1),(8,8,'https://unsplash.com',1),(9,9,'https://unsplash.com',1),(10,10,'https://unsplash.com',1),(11,11,'https://unsplash.com',1),(12,12,'https://unsplash.com',1),(13,13,'https://unsplash.com',1),(14,14,'https://unsplash.com',1),(15,15,'https://unsplash.com',1);
/*!40000 ALTER TABLE `item_photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `category_id` int NOT NULL,
  `brand_id` int NOT NULL,
  `title` varchar(150) NOT NULL,
  `model` varchar(100) DEFAULT NULL,
  `description` text,
  `specs` json DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `item_condition` enum('new','like_new','good','fair') NOT NULL,
  `status` enum('draft','published','sold','archived') DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `items_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,3,1,4,'Xiaomi Smart TV F2 32\"','L32M7-F2EN','Pantalla Fire TV integrada, resolución HD, sonido Dolby Audio y control por voz Alexa.','{\"hdr\": \"No\", \"hdmi\": \"3\", \"panel\": \"LED\", \"pulgadas\": \"32\", \"smart_tv\": \"Fire TV\", \"resolucion\": \"HD 720p\"}',179.00,'like_new','published','2026-06-08 15:45:28'),(2,4,1,1,'Samsung T4305 32\"','UE32T4305AKXXC','Smart TV ideal para cocina o dormitorio secundario. HDR y purcolor.','{\"hdr\": \"HDR10\", \"hdmi\": \"2\", \"panel\": \"LED\", \"pulgadas\": \"32\", \"smart_tv\": \"Tizen\", \"resolucion\": \"FHD 1080p\"}',195.00,'good','published','2026-06-08 15:45:28'),(3,7,1,2,'LG Smart TV 24\" Monitor-TV','24TQ510S-WZ','Combo monitor y televisión con webOS22, color blanco, ideal para espacios reducidos.','{\"hdr\": \"No\", \"hdmi\": \"1\", \"panel\": \"LED-IPS\", \"pulgadas\": \"24\", \"smart_tv\": \"webOS\", \"resolucion\": \"HD 720p\"}',120.00,'good','published','2026-06-08 15:45:28'),(4,8,1,7,'Hisense 32A4K','32A4K','Televisor básico con sistema VIDAA, modo juego y optimizador de color natural.','{\"hdr\": \"No\", \"hdmi\": \"2\", \"panel\": \"LED\", \"pulgadas\": \"32\", \"smart_tv\": \"VIDAA\", \"resolucion\": \"HD 720p\"}',140.00,'like_new','published','2026-06-08 15:45:28'),(5,5,2,1,'Samsung Crystal UHD 43\"','TU43CU7105','Procesador Crystal 4K, gran contraste. Un año de uso. Vendo por mudanza.','{\"hdr\": \"HDR10+\", \"hdmi\": \"3\", \"panel\": \"LED\", \"pulgadas\": \"43\", \"smart_tv\": \"Tizen\", \"resolucion\": \"4K UHD\"}',290.00,'like_new','published','2026-06-08 15:45:28'),(6,6,2,2,'LG NanoCell 50\"','50NANO766QA','Colores puros gracias a NanoCell, Smart TV webOS 22 con perfiles de usuario.','{\"hdr\": \"HDR10 Pro\", \"hdmi\": \"3\", \"panel\": \"NanoCell\", \"pulgadas\": \"50\", \"smart_tv\": \"webOS\", \"resolucion\": \"4K UHD\"}',360.00,'like_new','published','2026-06-08 15:45:28'),(7,9,2,5,'TCL 43\" 4K Google TV','43P635','Diseño sin bordes metálico, Google TV con control por voz manos libres, Dolby Audio.','{\"hdr\": \"HDR10\", \"hdmi\": \"3\", \"panel\": \"LED\", \"pulgadas\": \"43\", \"smart_tv\": \"Google TV\", \"resolucion\": \"4K UHD\"}',230.00,'good','published','2026-06-08 15:45:28'),(8,3,2,1,'Samsung OLED 48\" (Borrador)','QE48S90C','Pendiente de verificar fotos del panel para descartar quemados antes de publicar.','{\"hdr\": \"Quantum HDR\", \"hdmi\": \"4\", \"panel\": \"OLED\", \"pulgadas\": \"48\", \"smart_tv\": \"Tizen\", \"resolucion\": \"4K UHD\"}',890.00,'like_new','draft','2026-06-08 15:45:28'),(9,3,3,3,'Sony BRAVIA XR OLED 55\"','XR-55A80L','Pantalla acústica, negros perfectos, perfecta para PlayStation 5 con HDMI 2.1.','{\"hdr\": \"Dolby Vision\", \"hdmi\": \"4\", \"panel\": \"OLED\", \"pulgadas\": \"55\", \"smart_tv\": \"Google TV\", \"resolucion\": \"4K UHD\"}',1150.00,'new','published','2026-06-08 15:45:28'),(10,4,3,6,'Philips Ambilight 65\"','65PUS8517','Sistema Ambilight de 3 lados que ilumina la pared. Panel de gran nitidez.','{\"hdr\": \"Dolby Vision\", \"hdmi\": \"4\", \"panel\": \"LED\", \"pulgadas\": \"65\", \"smart_tv\": \"Android TV\", \"resolucion\": \"4K UHD\"}',620.00,'good','published','2026-06-08 15:45:28'),(11,7,3,1,'Samsung QLED 55\"','QE55Q60B','100% Volumen de color con Quantum dot. Estado impecable con caja original.','{\"hdr\": \"HDR10+\", \"hdmi\": \"3\", \"panel\": \"QLED\", \"pulgadas\": \"55\", \"smart_tv\": \"Tizen\", \"resolucion\": \"4K UHD\"}',450.00,'good','published','2026-06-08 15:45:28'),(12,8,3,2,'LG OLED EVO 55\"','OLED55C26LD','El mejor panel para gaming y cine, 120Hz nativos, procesador inteligente a9 Gen5.','{\"hdr\": \"Dolby Vision IQ\", \"hdmi\": \"4\", \"panel\": \"OLED EVO\", \"pulgadas\": \"55\", \"smart_tv\": \"webOS\", \"resolucion\": \"4K UHD\"}',790.00,'new','published','2026-06-08 15:45:28'),(13,5,4,1,'Samsung Neo QLED 75\" 8K','QE75QN700B','Resolución 8K real con Mini LED. Comprada hace 6 meses. Una experiencia de cine.','{\"hdr\": \"Quantum HDR 2000\", \"hdmi\": \"4\", \"panel\": \"Mini LED\", \"pulgadas\": \"75\", \"smart_tv\": \"Tizen\", \"resolucion\": \"8K UHD\"}',1850.00,'like_new','published','2026-06-08 15:45:28'),(14,6,4,5,'TCL 85\" QLED 4K 144Hz','85C745','Gigante pantalla gaming con tasa de refresco alta, Full Array Local Dimming.','{\"hdr\": \"Dolby Vision IQ\", \"hdmi\": \"4\", \"panel\": \"QLED\", \"pulgadas\": \"85\", \"smart_tv\": \"Google TV\", \"resolucion\": \"4K UHD\"}',1100.00,'good','published','2026-06-08 15:45:28'),(15,9,4,7,'Hisense 75\" Mini-LED','75U7KQ','Tecnología Mini-LED ULED, 144Hz, ideal para salón grande. Sin marcas ni arañazos.','{\"hdr\": \"HDR10+ Adaptive\", \"hdmi\": \"4\", \"panel\": \"Mini-LED\", \"pulgadas\": \"75\", \"smart_tv\": \"VIDAA\", \"resolucion\": \"4K UHD\"}',780.00,'like_new','published','2026-06-08 15:45:28'),(16,11,3,3,'Sony BRAVIA LED 65\" 4K','KD-65X75K','Televisor impecable con Google TV. Muy poco uso, lo vendo con su mando original y patas.','{\"hdr\": \"HDR10\", \"hdmi\": \"3\", \"panel\": \"LED\", \"pulgadas\": \"65\", \"smart_tv\": \"Google TV\", \"resolucion\": \"4K UHD\"}',540.00,'like_new','published','2026-06-08 16:28:14');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `conversation_id` int NOT NULL,
  `sender_id` int NOT NULL,
  `content` text NOT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `sent_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `conversation_id` (`conversation_id`),
  KEY `sender_id` (`sender_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,1,4,'¡Hola! ¿Sigue disponible la televisión Xiaomi de 32\"?',1,'2026-05-10 07:00:00'),(2,1,3,'Sí, disponible. ¿Tienes alguna duda?',1,'2026-05-10 07:15:00'),(3,1,4,'¿Viene con el sistema Fire TV fluido o se encalla en Netflix?',1,'2026-05-10 07:20:00'),(4,1,3,'Va perfecto, está actualizado a la última versión del sistema.',1,'2026-05-10 08:00:00'),(5,1,4,'Entendido. ¿Harías un poco de descuento si recojo en mano?',0,'2026-05-10 08:30:00'),(6,2,4,'Buenas, ¿tiene algún arañazo o golpe en la pantalla?',1,'2026-05-11 09:00:00'),(7,2,5,'No, está perfecta. Siempre colgada en pared sin peligro de niños.',1,'2026-05-11 09:30:00'),(8,2,4,'Genial. ¿Podría bajar a 250 euros?',0,'2026-05-11 09:45:00'),(9,3,6,'Hola, ¿la pantalla ha sufrido quemados o tiene efecto fantasma?',1,'2026-05-12 15:00:00'),(10,3,5,'No, nunca. Es un panel Mini LED, no sufre de retenciones térmicas.',1,'2026-05-12 15:30:00'),(11,3,6,'Perfecto. ¿Conservas la caja original para transportarla?',1,'2026-05-12 16:00:00'),(12,3,5,'Sí, tengo la caja gigante, la factura y los dos mandos.',0,'2026-05-12 16:15:00'),(13,4,3,'¿Funcionan bien todos los LEDs traseros del sistema Ambilight?',0,'2026-05-13 08:00:00'),(14,5,4,'¿Viene con la peana de mesa o solo el anclaje de pared?',1,'2026-05-14 06:00:00'),(15,5,6,'Sí, incluye la peana original metálica central sin estrenar.',1,'2026-05-14 06:20:00'),(16,5,4,'¿Tiene puerto HDMI 2.1 para conectar la PlayStation 5 a 120Hz?',0,'2026-05-14 07:00:00'),(17,6,3,'¿Cuántos metros mide la caja de largo? Para ver si cabe en mi coche.',1,'2026-05-15 17:00:00'),(18,6,6,'Mide casi 2 metros. Imposible en coche normal, hace falta furgoneta.',0,'2026-05-15 17:30:00'),(19,7,5,'¿Tienes la factura para comprobar los meses de garantía que quedan?',1,'2026-05-16 08:00:00'),(20,7,3,'Sí, la compré en tienda física oficial y le queda un año.',1,'2026-05-16 08:20:00'),(21,7,5,'Perfecto. ¿Puedes hacer el envío asegurado por la aplicación?',0,'2026-05-16 09:00:00'),(22,8,7,'Hola, ¿la televisión tiene algún píxel muerto o vago?',1,'2026-05-17 10:00:00'),(23,8,4,'Ninguno. Pasé un test de colores antes de empaquetarla.',0,'2026-05-17 10:30:00'),(24,9,8,'¿Incluye el mando a distancia inteligente con botones de acceso rápido?',0,'2026-05-18 07:00:00'),(25,10,9,'Hola, ¿el panel tiene problemas de fugas de luz en las esquinas?',1,'2026-05-19 13:00:00'),(26,10,4,'Mínimo, lo habitual en paneles LED básicos, imperceptible con luz.',1,'2026-05-19 13:30:00'),(27,10,9,'¿La dejarías en 150 euros?',0,'2026-05-19 14:00:00'),(28,11,3,'¿Qué tal funciona el sistema operativo Google TV en esta pantalla?',0,'2026-05-20 09:00:00'),(29,12,6,'Hola, ¿esta tele pequeña tiene sintonizador TDT2 integrado?',1,'2026-05-20 12:00:00'),(30,12,9,'Sí, es compatible con el nuevo estándar de canales en HD.',0,'2026-05-20 12:15:00'),(31,1,4,'¡Hola! ¿Sigue disponible la televisión Xiaomi de 32\"?',1,'2026-05-10 07:00:00'),(32,1,3,'Sí, disponible. ¿Tienes alguna duda?',1,'2026-05-10 07:15:00'),(33,1,4,'¿Viene con el sistema Fire TV fluido o se encalla en Netflix?',1,'2026-05-10 07:20:00'),(34,1,3,'Va perfecto, está actualizado a la última versión del sistema.',1,'2026-05-10 08:00:00'),(35,1,4,'Entendido. ¿Harías un poco de descuento si recojo en mano?',0,'2026-05-10 08:30:00'),(36,2,4,'Buenas, ¿tiene algún arañazo o golpe en la pantalla?',1,'2026-05-11 09:00:00'),(37,2,5,'No, está perfecta. Siempre colgada en pared sin peligro de niños.',1,'2026-05-11 09:30:00'),(38,2,4,'Genial. ¿Podría bajar a 250 euros?',0,'2026-05-11 09:45:00'),(39,3,6,'Hola, ¿la pantalla ha sufrido quemados o tiene efecto fantasma?',1,'2026-05-12 15:00:00'),(40,3,5,'No, nunca. Es un panel Mini LED, no sufre de retenciones térmicas.',1,'2026-05-12 15:30:00'),(41,3,6,'Perfecto. ¿Conservas la caja original para transportarla?',1,'2026-05-12 16:00:00'),(42,3,5,'Sí, tengo la caja gigante, la factura y los dos mandos.',0,'2026-05-12 16:15:00'),(43,4,3,'¿Funcionan bien todos los LEDs traseros del sistema Ambilight?',0,'2026-05-13 08:00:00'),(44,5,4,'¿Viene con la peana de mesa o solo el anclaje de pared?',1,'2026-05-14 06:00:00'),(45,5,6,'Sí, incluye la peana original metálica central sin estrenar.',1,'2026-05-14 06:20:00'),(46,5,4,'¿Tiene puerto HDMI 2.1 para conectar la PlayStation 5 a 120Hz?',0,'2026-05-14 07:00:00'),(47,6,3,'¿Cuántos metros mide la caja de largo? Para ver si cabe en mi coche.',1,'2026-05-15 17:00:00'),(48,6,6,'Mide casi 2 metros. Imposible en coche normal, hace falta furgoneta.',0,'2026-05-15 17:30:00'),(49,7,5,'¿Tienes la factura para comprobar los meses de garantía que quedan?',1,'2026-05-16 08:00:00'),(50,7,3,'Sí, la compré en tienda física oficial y le queda un año.',1,'2026-05-16 08:20:00'),(51,7,5,'Perfecto. ¿Puedes hacer el envío asegurado por la aplicación?',0,'2026-05-16 09:00:00'),(52,8,7,'Hola, ¿la televisión tiene algún píxel muerto o vago?',1,'2026-05-17 10:00:00'),(53,8,4,'Ninguno. Pasé un test de colores antes de empaquetarla.',0,'2026-05-17 10:30:00'),(54,9,8,'¿Incluye el mando a distancia inteligente con botones de acceso rápido?',0,'2026-05-18 07:00:00'),(55,10,9,'Hola, ¿el panel tiene problemas de fugas de luz en las esquinas?',1,'2026-05-19 13:00:00'),(56,10,4,'Mínimo, lo habitual en paneles LED básicos, imperceptible con luz.',1,'2026-05-19 13:30:00'),(57,10,9,'¿La dejarías en 150 euros?',0,'2026-05-19 14:00:00'),(58,11,3,'¿Qué tal funciona el sistema operativo Google TV en esta pantalla?',0,'2026-05-20 09:00:00'),(59,12,6,'Hola, ¿esta tele pequeña tiene sintonizador TDT2 integrado?',1,'2026-05-20 12:00:00'),(60,12,9,'Sí, es compatible con el nuevo estándar de canales en HD.',0,'2026-05-20 12:15:00'),(61,1,4,'¡Hola! ¿Sigue disponible la televisión Xiaomi de 32\"?',1,'2026-05-10 07:00:00'),(62,1,3,'Sí, disponible. ¿Tienes alguna duda?',1,'2026-05-10 07:15:00'),(63,1,4,'¿Viene con el sistema Fire TV fluido o se encalla en Netflix?',1,'2026-05-10 07:20:00'),(64,1,3,'Va perfecto, está actualizado a la última versión del sistema.',1,'2026-05-10 08:00:00'),(65,1,4,'Entendido. ¿Harías un poco de descuento si recojo en mano?',0,'2026-05-10 08:30:00'),(66,2,4,'Buenas, ¿tiene algún arañazo o golpe en la pantalla?',1,'2026-05-11 09:00:00'),(67,2,5,'No, está perfecta. Siempre colgada en pared sin peligro de niños.',1,'2026-05-11 09:30:00'),(68,2,4,'Genial. ¿Podría bajar a 250 euros?',0,'2026-05-11 09:45:00'),(69,3,6,'Hola, ¿la pantalla ha sufrido quemados o tiene efecto fantasma?',1,'2026-05-12 15:00:00'),(70,3,5,'No, nunca. Es un panel Mini LED, no sufre de retenciones térmicas.',1,'2026-05-12 15:30:00'),(71,3,6,'Perfecto. ¿Conservas la caja original para transportarla?',1,'2026-05-12 16:00:00'),(72,3,5,'Sí, tengo la caja gigante, la factura y los dos mandos.',0,'2026-05-12 16:15:00'),(73,4,3,'¿Funcionan bien todos los LEDs traseros del sistema Ambilight?',0,'2026-05-13 08:00:00'),(74,5,4,'¿Viene con la peana de mesa o solo el anclaje de pared?',1,'2026-05-14 06:00:00'),(75,5,6,'Sí, incluye la peana original metálica central sin estrenar.',1,'2026-05-14 06:20:00'),(76,5,4,'¿Tiene puerto HDMI 2.1 para conectar la PlayStation 5 a 120Hz?',0,'2026-05-14 07:00:00'),(77,6,3,'¿Cuántos metros mide la caja de largo? Para ver si cabe en mi coche.',1,'2026-05-15 17:00:00'),(78,6,6,'Mide casi 2 metros. Imposible en coche normal, hace falta furgoneta.',0,'2026-05-15 17:30:00'),(79,7,5,'¿Tienes la factura para comprobar los meses de garantía que quedan?',1,'2026-05-16 08:00:00'),(80,7,3,'Sí, la compré en tienda física oficial y le queda un año.',1,'2026-05-16 08:20:00'),(81,7,5,'Perfecto. ¿Puedes hacer el envío asegurado por la aplicación?',0,'2026-05-16 09:00:00'),(82,8,7,'Hola, ¿la televisión tiene algún píxel muerto o vago?',1,'2026-05-17 10:00:00'),(83,8,4,'Ninguno. Pasé un test de colores antes de empaquetarla.',0,'2026-05-17 10:30:00'),(84,9,8,'¿Incluye el mando a distancia inteligente con botones de acceso rápido?',0,'2026-05-18 07:00:00'),(85,10,9,'Hola, ¿el panel tiene problemas de fugas de luz en las esquinas?',1,'2026-05-19 13:00:00'),(86,10,4,'Mínimo, lo habitual en paneles LED básicos, imperceptible con luz.',1,'2026-05-19 13:30:00'),(87,10,9,'¿La dejarías en 150 euros?',0,'2026-05-19 14:00:00'),(88,11,3,'¿Qué tal funciona el sistema operativo Google TV en esta pantalla?',0,'2026-05-20 09:00:00'),(89,12,6,'Hola, ¿esta tele pequeña tiene sintonizador TDT2 integrado?',1,'2026-05-20 12:00:00'),(90,12,9,'Sí, es compatible con el nuevo estándar de canales en HD.',0,'2026-05-20 12:15:00');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_id` int NOT NULL,
  `reporter_id` int NOT NULL,
  `moderator_id` int DEFAULT NULL,
  `reason` text NOT NULL,
  `status` enum('pending','resolved_active','resolved_removed') DEFAULT 'pending',
  `moderator_note` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `resolved_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`),
  KEY `reporter_id` (`reporter_id`),
  KEY `moderator_id` (`moderator_id`),
  CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reports_ibfk_2` FOREIGN KEY (`reporter_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reports_ibfk_3` FOREIGN KEY (`moderator_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
INSERT INTO `reports` VALUES (1,13,3,NULL,'Intento de fraude. El vendedor pide realizar el pago fuera de la plataforma mediante Bizum.','pending',NULL,'2026-05-18 10:00:00',NULL),(2,9,5,NULL,'Anuncio engañoso. Las fotos muestran una pantalla rota con el cristal líquido estallado.','pending',NULL,'2026-05-20 08:00:00',NULL),(3,14,7,NULL,'Precio falsificado. Indica 1100€ pero en la descripción exige 1800€ o no la vende.','pending',NULL,'2026-05-21 07:30:00',NULL),(4,1,5,2,'El artículo recibido no coincide. Es un modelo mucho más antiguo sin Smart TV.','resolved_removed','Verificado: El modelo publicado falsificaba el número de serie. Artículo eliminado.','2026-05-15 06:00:00','2026-05-16 08:30:00'),(5,12,4,2,'Sospecho que las imágenes son robadas de internet y no corresponden al producto real.','resolved_active','Revisión completada. El vendedor aportó fotos adicionales con papel firmado. Artículo legítimo.','2026-05-12 12:00:00','2026-05-13 07:00:00'),(6,6,9,2,'El precio es sospechosamente bajo para una LG NanoCell.','resolved_active','Precio competitivo pero razonable debido al desgaste de la carcasa trasera. No se toman acciones.','2026-05-17 14:00:00','2026-05-18 07:00:00'),(7,13,3,NULL,'Intento de fraude. El vendedor pide realizar el pago fuera de la plataforma mediante Bizum.','pending',NULL,'2026-05-18 10:00:00',NULL),(8,9,5,NULL,'Anuncio engañoso. Las fotos muestran una pantalla rota con el cristal líquido estallado.','pending',NULL,'2026-05-20 08:00:00',NULL),(9,14,7,NULL,'Precio falsificado. Indica 1100€ pero en la descripción exige 1800€ o no la vende.','pending',NULL,'2026-05-21 07:30:00',NULL),(10,1,5,2,'El artículo recibido no coincide. Es un modelo mucho más antiguo sin Smart TV.','resolved_removed','Verificado: El modelo publicado falsificaba el número de serie. Artículo eliminado.','2026-05-15 06:00:00','2026-05-16 08:30:00'),(11,12,4,2,'Sospecho que las imágenes son robadas de internet y no corresponden al producto real.','resolved_active','Revisión completada. El vendedor aportó fotos adicionales con papel firmado. Artículo legítimo.','2026-05-12 12:00:00','2026-05-13 07:00:00'),(12,6,9,2,'El precio es sospechosamente bajo para una LG NanoCell.','resolved_active','Precio competitivo pero razonable debido al desgaste de la carcasa trasera. No se toman acciones.','2026-05-17 14:00:00','2026-05-18 07:00:00'),(13,13,3,NULL,'Intento de fraude. El vendedor pide realizar el pago fuera de la plataforma mediante Bizum.','pending',NULL,'2026-05-18 10:00:00',NULL),(14,9,5,NULL,'Anuncio engañoso. Las fotos muestran una pantalla rota con el cristal líquido estallado.','pending',NULL,'2026-05-20 08:00:00',NULL),(15,14,7,NULL,'Precio falsificado. Indica 1100€ pero en la descripción exige 1800€ o no la vende.','pending',NULL,'2026-05-21 07:30:00',NULL),(16,1,5,2,'El artículo recibido no coincide. Es un modelo mucho más antiguo sin Smart TV.','resolved_removed','Verificado: El modelo publicado falsificaba el número de serie. Artículo eliminado.','2026-05-15 06:00:00','2026-05-16 08:30:00'),(17,12,4,2,'Sospecho que las imágenes son robadas de internet y no corresponden al producto real.','resolved_active','Revisión completada. El vendedor aportó fotos adicionales con papel firmado. Artículo legítimo.','2026-05-12 12:00:00','2026-05-13 07:00:00'),(18,6,9,2,'El precio es sospechosamente bajo para una LG NanoCell.','resolved_active','Precio competitivo pero razonable debido al desgaste de la carcasa trasera. No se toman acciones.','2026-05-17 14:00:00','2026-05-18 07:00:00');
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `avatar_url` varchar(255) DEFAULT NULL,
  `role` enum('admin','moderator','user') DEFAULT 'user',
  `status` enum('active','blocked') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin_laura','laura.admin@example.com','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','https://i.pravatar.cc/150?u=1','admin','active','2026-06-08 15:42:47'),(2,'mod_carlos','carlos.mod@example.com','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','https://i.pravatar.cc/150?u=2','moderator','active','2026-06-08 15:42:47'),(3,'user_sofia','sofia@example.com','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','https://i.pravatar.cc/150?u=3','user','active','2026-06-08 15:42:47'),(4,'user_miguel','miguel@example.com','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','https://i.pravatar.cc/150?u=4','user','active','2026-06-08 15:42:47'),(5,'user_elena','elena@example.com','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','https://i.pravatar.cc/150?u=5','user','active','2026-06-08 15:42:47'),(6,'user_pablo','pablo@example.com','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','https://i.pravatar.cc/150?u=6','user','active','2026-06-08 15:42:47'),(7,'user_ana','ana@example.com','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','https://i.pravatar.cc/150?u=7','user','active','2026-06-08 15:42:47'),(8,'user_jorge','jorge@example.com','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','https://i.pravatar.cc/150?u=8','user','active','2026-06-08 15:42:47'),(9,'user_marta','marta@example.com','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','https://i.pravatar.cc/150?u=9','user','active','2026-06-08 15:42:47'),(10,'user_blocked','blocked@example.com','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',NULL,'user','blocked','2026-06-08 15:42:47'),(11,'user_ramon','ramon@example.com','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','https://pravatar.cc','user','active','2026-06-08 16:27:52');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `valuations`
--

DROP TABLE IF EXISTS `valuations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `valuations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reviewer_id` int NOT NULL,
  `reviewed_id` int NOT NULL,
  `item_id` int NOT NULL,
  `score` tinyint NOT NULL,
  `comment` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `reviewer_id` (`reviewer_id`),
  KEY `reviewed_id` (`reviewed_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `valuations_ibfk_1` FOREIGN KEY (`reviewer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `valuations_ibfk_2` FOREIGN KEY (`reviewed_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `valuations_ibfk_3` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `valuations_chk_1` CHECK ((`score` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `valuations`
--

LOCK TABLES `valuations` WRITE;
/*!40000 ALTER TABLE `valuations` DISABLE KEYS */;
INSERT INTO `valuations` VALUES (1,4,3,1,5,'Televisión compacta tal como se describía. Vendedora muy atenta y puntual en el punto de encuentro.','2026-06-08 15:50:23'),(2,3,5,13,4,'El pantallón de 75 pulgadas llegó con su embalaje original. Funciona perfecto y gran trato.','2026-06-08 15:50:23'),(3,5,4,2,5,'La tele Samsung de 32\" estaba impecable para la cocina. Transacción transparente.','2026-06-08 15:50:23'),(4,6,5,10,3,'La televisión de 65\" tenía un pequeño arañazo en el marco plástico que omitió en la descripción.','2026-06-08 15:50:23'),(5,4,6,12,5,'Panel OLED en perfecto estado, sin quemados. Pablo fue muy amable y me ayudó a cargarla.','2026-06-08 15:50:23'),(6,7,4,6,4,'La LG de 50\" venía muy bien protegida. Calidad de imagen perfecta, sin píxeles defectuosos.','2026-06-08 15:50:23'),(7,9,4,2,5,'Todo perfecto. El televisor está nuevo y Miguel contestó a todas mis dudas técnicas al instante.','2026-06-08 15:50:23'),(8,4,3,1,5,'Televisión compacta tal como se describía. Vendedora muy atenta y puntual en el punto de encuentro.','2026-06-08 15:50:27'),(9,3,5,13,4,'El pantallón de 75 pulgadas llegó con su embalaje original. Funciona perfecto y gran trato.','2026-06-08 15:50:27'),(10,5,4,2,5,'La tele Samsung de 32\" estaba impecable para la cocina. Transacción transparente.','2026-06-08 15:50:27'),(11,6,5,10,3,'La televisión de 65\" tenía un pequeño arañazo en el marco plástico que omitió en la descripción.','2026-06-08 15:50:27'),(12,4,6,12,5,'Panel OLED en perfecto estado, sin quemados. Pablo fue muy amable y me ayudó a cargarla.','2026-06-08 15:50:27'),(13,7,4,6,4,'La LG de 50\" venía muy bien protegida. Calidad de imagen perfecta, sin píxeles defectuosos.','2026-06-08 15:50:27'),(14,9,4,2,5,'Todo perfecto. El televisor está nuevo y Miguel contestó a todas mis dudas técnicas al instante.','2026-06-08 15:50:27'),(15,4,3,1,5,'Televisión compacta tal como se describía. Vendedora muy atenta y puntual en el punto de encuentro.','2026-06-08 15:50:29'),(16,3,5,13,4,'El pantallón de 75 pulgadas llegó con su embalaje original. Funciona perfecto y gran trato.','2026-06-08 15:50:29'),(17,5,4,2,5,'La tele Samsung de 32\" estaba impecable para la cocina. Transacción transparente.','2026-06-08 15:50:29'),(18,6,5,10,3,'La televisión de 65\" tenía un pequeño arañazo en el marco plástico que omitió en la descripción.','2026-06-08 15:50:29'),(19,4,6,12,5,'Panel OLED en perfecto estado, sin quemados. Pablo fue muy amable y me ayudó a cargarla.','2026-06-08 15:50:29'),(20,7,4,6,4,'La LG de 50\" venía muy bien protegida. Calidad de imagen perfecta, sin píxeles defectuosos.','2026-06-08 15:50:29'),(21,9,4,2,5,'Todo perfecto. El televisor está nuevo y Miguel contestó a todas mis dudas técnicas al instante.','2026-06-08 15:50:29');
/*!40000 ALTER TABLE `valuations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'proyecto_final_unir'
--

--
-- Dumping routines for database 'proyecto_final_unir'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-15 10:19:59
