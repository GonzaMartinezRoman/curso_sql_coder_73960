CREATE DATABASE  IF NOT EXISTS `suminet_erp` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `suminet_erp`;
-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: suminet_erp
-- ------------------------------------------------------
-- Server version	8.0.43-0ubuntu0.24.04.1

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
-- Table structure for table `Actividad_Categoria`
--

DROP TABLE IF EXISTS `Actividad_Categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Actividad_Categoria` (
  `id_actividad` int NOT NULL,
  `id_categoria` int NOT NULL,
  `fecha_asociacion` date DEFAULT (curdate()),
  `estado` enum('Activo','Inactivo') DEFAULT 'Activo',
  PRIMARY KEY (`id_actividad`,`id_categoria`),
  KEY `id_categoria` (`id_categoria`),
  KEY `idx_fecha_asociacion` (`fecha_asociacion`),
  KEY `idx_estado_ac` (`estado`),
  CONSTRAINT `Actividad_Categoria_ibfk_1` FOREIGN KEY (`id_actividad`) REFERENCES `Alcance_Actividad` (`id_actividad`) ON DELETE CASCADE,
  CONSTRAINT `Actividad_Categoria_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `Categorias_Materiales` (`id_categoria`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Actividad_Categoria`
--

LOCK TABLES `Actividad_Categoria` WRITE;
/*!40000 ALTER TABLE `Actividad_Categoria` DISABLE KEYS */;
INSERT INTO `Actividad_Categoria` VALUES (1,1000,'2025-09-03','Activo'),(2,2000,'2025-09-03','Activo'),(2,3000,'2025-09-03','Activo'),(3,6000,'2025-09-03','Activo'),(4,4000,'2025-09-03','Activo'),(5,5000,'2025-09-03','Activo'),(6,5000,'2025-09-03','Activo'),(7,6000,'2025-09-03','Activo'),(8,1000,'2025-09-03','Activo'),(9,8000,'2025-09-03','Activo'),(10,2000,'2025-09-03','Activo'),(10,3000,'2025-09-03','Activo'),(10,4000,'2025-09-03','Activo'),(11,6000,'2025-09-03','Activo'),(12,1000,'2025-09-03','Activo'),(13,2000,'2025-09-03','Activo'),(14,3000,'2025-09-03','Activo'),(15,7000,'2025-09-03','Activo'),(16,1000,'2025-09-03','Activo'),(16,2000,'2025-09-03','Activo'),(16,6000,'2025-09-03','Activo'),(17,6000,'2025-09-03','Activo'),(18,5000,'2025-09-03','Activo'),(19,6000,'2025-09-03','Activo');
/*!40000 ALTER TABLE `Actividad_Categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Alcance_Actividad`
--

DROP TABLE IF EXISTS `Alcance_Actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Alcance_Actividad` (
  `id_actividad` int NOT NULL AUTO_INCREMENT,
  `nombre_actividad` varchar(100) NOT NULL,
  `descripcion` text,
  `tipo_actividad` enum('Manufactura','Comercialización','Servicios','Ingeniería') NOT NULL,
  `nivel_especialización` enum('Commodities','Crítico','Especializado') DEFAULT 'Commodities',
  `criticidad` enum('Baja','Media','Alta') DEFAULT 'Alta',
  `certificaciones_requeridas` text COMMENT 'API, ATEX, ISO9001, ASME U, ASME UM, etc.',
  `estado` enum('Activo','Inactivo') DEFAULT 'Activo',
  `fecha_creacion` date DEFAULT (curdate()),
  PRIMARY KEY (`id_actividad`),
  KEY `idx_tipo_actividad` (`tipo_actividad`),
  KEY `idx_nivel_especialización` (`nivel_especialización`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Alcance_Actividad`
--

LOCK TABLES `Alcance_Actividad` WRITE;
/*!40000 ALTER TABLE `Alcance_Actividad` DISABLE KEYS */;
INSERT INTO `Alcance_Actividad` VALUES (1,'Fabricación de Válvulas API','Manufactura de válvulas según normas API 6A, API 598, API 600 para aplicaciones críticas en Oil & Gas','Manufactura','Crítico','Alta','API 6A, API 598, ISO 9001, ATEX (si aplica)','Activo','2025-09-03'),(2,'Fabricación de Recipientes a Presión ASME','Manufactura de equipos a presión certificados ASME VIII Div.1 y Div.2','Manufactura','Crítico','Alta','ASME U, ASME U2, ISO 9001, ATEX','Activo','2025-09-03'),(3,'Fabricación de Instrumentación Ex','Manufactura de instrumentos para áreas clasificadas con certificación ATEX/IECEx','Manufactura','Especializado','Alta','ATEX, IECEx, ISO 9001, SIL','Activo','2025-09-03'),(4,'Fabricación de Estructuras Metálicas','Soldadura y fabricación de estructuras según AWS D1.1','Manufactura','Commodities','Media','AWS D1.1, ISO 9001','Activo','2025-09-03'),(5,'Fabricación de Tableros Eléctricos','Manufactura de tableros según normas IEC 61439','Manufactura','Especializado','Alta','IEC 61439, ISO 9001, Certificación electricista','Activo','2025-09-03'),(6,'Distribución de Materiales Eléctricos','Comercialización de componentes eléctricos industriales','Comercialización','Commodities','Baja','Representación de marcas reconocidas','Activo','2025-09-03'),(7,'Distribución de Instrumentación Industrial','Comercialización de instrumentos de medición y control','Comercialización','Especializado','Media','Certificación técnica del fabricante, Representación autorizada','Activo','2025-09-03'),(8,'Distribución de Válvulas Industriales','Comercialización de válvulas para procesos industriales','Comercialización','Especializado','Media','Representación autorizada, Conocimiento técnico','Activo','2025-09-03'),(9,'Distribución de Químicos Industriales','Comercialización de productos químicos para procesos','Comercialización','Crítico','Alta','Habilitación ANMAT, Transporte de cargas peligrosas','Activo','2025-09-03'),(10,'Distribución de Cañerías y Accesorios','Comercialización de tuberías y fitting industriales','Comercialización','Commodities','Baja','Stock permanente, Servicio de corte','Activo','2025-09-03'),(11,'Calibración de Instrumentos','Servicios de calibración trazable de instrumentos de medición','Servicios','Crítico','Alta','ISO 17025, OAA, Trazabilidad INTI','Activo','2025-09-03'),(12,'Reparación de Válvulas en Sitio','Servicios de mantenimiento y reparación in-situ','Servicios','Especializado','Media','Personal certificado, Herramientas especializadas','Activo','2025-09-03'),(13,'Pruebas Hidrostáticas','Servicios de testing de presión según ASME y API','Servicios','Especializado','Alta','Procedimientos certificados, Personal calificado','Activo','2025-09-03'),(14,'Tratamiento Térmico','Servicios de stress relief y tratamientos térmicos PWHT','Servicios','Crítico','Alta','ASME IX, AWS, Procedimientos calificados','Activo','2025-09-03'),(15,'Análisis de Fluidos','Servicios de análisis químico de aceites y fluidos industriales','Servicios','Especializado','Media','Laboratorio acreditado, ISO 17025','Activo','2025-09-03'),(16,'Ingeniería de Procesos','Diseño y optimización de procesos industriales','Ingeniería','Crítico','Alta','Matrícula profesional, Experiencia en industria','Activo','2025-09-03'),(17,'Ingeniería de Instrumentación','Diseño de sistemas de control y automatización','Ingeniería','Crítico','Alta','ISA, Certificación en sistemas de control','Activo','2025-09-03'),(18,'Ingeniería Eléctrica Industrial','Diseño de instalaciones eléctricas industriales','Ingeniería','Especializado','Alta','Matrícula profesional, IEC 61511','Activo','2025-09-03'),(19,'Estudios de Seguridad Funcional','Análisis SIL y estudios HAZOP','Ingeniería','Crítico','Alta','IEC 61508, IEC 61511, Certificación SIL','Activo','2025-09-03');
/*!40000 ALTER TABLE `Alcance_Actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Auditoria_Proveedores`
--

DROP TABLE IF EXISTS `Auditoria_Proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Auditoria_Proveedores` (
  `id_auditoria` int NOT NULL AUTO_INCREMENT,
  `id_proveedor` int NOT NULL,
  `id_actividad` int NOT NULL,
  `fecha_auditoria` date NOT NULL,
  `resultado` enum('Aceptado','No aceptado','Condicional') NOT NULL,
  `auditor` varchar(100) NOT NULL,
  `comentarios` text,
  `tipo_auditoria` enum('Inicial','Renovación','Extraordinaria') DEFAULT 'Inicial',
  `vigencia_meses` int DEFAULT '12',
  `fecha_vencimiento` date GENERATED ALWAYS AS ((`fecha_auditoria` + interval `vigencia_meses` month)) STORED,
  PRIMARY KEY (`id_auditoria`),
  KEY `id_actividad` (`id_actividad`),
  KEY `idx_fecha_auditoria` (`fecha_auditoria`),
  KEY `idx_resultado` (`resultado`),
  KEY `idx_proveedor_actividad` (`id_proveedor`,`id_actividad`),
  KEY `idx_fecha_vencimiento` (`fecha_vencimiento`),
  CONSTRAINT `Auditoria_Proveedores_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `Registro_Proveedores` (`id_proveedor`) ON DELETE CASCADE,
  CONSTRAINT `Auditoria_Proveedores_ibfk_2` FOREIGN KEY (`id_actividad`) REFERENCES `Alcance_Actividad` (`id_actividad`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Auditoria_Proveedores`
--

LOCK TABLES `Auditoria_Proveedores` WRITE;
/*!40000 ALTER TABLE `Auditoria_Proveedores` DISABLE KEYS */;
INSERT INTO `Auditoria_Proveedores` (`id_auditoria`, `id_proveedor`, `id_actividad`, `fecha_auditoria`, `resultado`, `auditor`, `comentarios`, `tipo_auditoria`, `vigencia_meses`) VALUES (1,1,5,'2023-02-15','Aceptado','Ing. Roberto Martínez','Proveedor con amplia experiencia en tableros industriales. Instalaciones adecuadas y personal calificado.','Inicial',18),(2,1,6,'2023-02-20','Aceptado','Ing. Roberto Martínez','Distribución autorizada de marcas reconocidas. Buen stock y tiempos de entrega.','Inicial',12),(3,2,1,'2023-07-10','Aceptado','Ing. Patricia González','Fabricante certificado API. Excelente calidad y cumplimiento de especificaciones técnicas.','Inicial',24),(4,2,8,'2023-07-15','Aceptado','Ing. Patricia González','Amplio catálogo de válvulas industriales. Servicio técnico competente.','Inicial',18),(5,2,12,'2023-08-20','Condicional','Ing. Carlos Ruiz','Servicio técnico adecuado pero requiere mejorar tiempos de respuesta para emergencias.','Inicial',12),(6,3,4,'2023-05-10','Aceptado','Ing. Ana López','Taller de soldadura bien equipado. Personal certificado AWS D1.1.','Inicial',15),(7,3,10,'2023-05-15','Aceptado','Ing. Ana López','Buen stock de cañerías y accesorios. Servicio de corte disponible.','Inicial',12),(8,4,3,'2023-10-05','Aceptado','Ing. Miguel Torres','Fabricante especializado en instrumentos Ex. Certificaciones vigentes y control de calidad riguroso.','Inicial',24),(9,4,7,'2023-10-10','Aceptado','Ing. Miguel Torres','Distribución autorizada de marcas premium. Excelente soporte técnico.','Inicial',18),(10,4,11,'2023-10-15','Aceptado','Ing. Miguel Torres','Laboratorio acreditado ISO 17025. Trazabilidad completa y certificados válidos.','Inicial',18),(11,5,9,'2024-02-20','Aceptado','Ing. Laura Fernández','Distribución autorizada con todas las habilitaciones requeridas. Manejo seguro de productos.','Inicial',12),(12,1,5,'2024-08-15','Aceptado','Ing. Roberto Martínez','Renovación satisfactoria. Mantiene estándares de calidad.','Renovación',18);
/*!40000 ALTER TABLE `Auditoria_Proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Categorias_Materiales`
--

DROP TABLE IF EXISTS `Categorias_Materiales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Categorias_Materiales` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nombre_categoria` varchar(50) DEFAULT NULL,
  `descripcion` text,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=8001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Categorias_Materiales`
--

LOCK TABLES `Categorias_Materiales` WRITE;
/*!40000 ALTER TABLE `Categorias_Materiales` DISABLE KEYS */;
INSERT INTO `Categorias_Materiales` VALUES (1000,'Válvulas Industriales','Válvulas de control, seguridad y corte para instalaciones industriales.'),(2000,'Cañería de conducción','Tuberías metálicas y no metálicas para conducción de fluidos'),(3000,'Accesorios de cañería','Accesorios de unión para cañerías: tees, codos, uniones.'),(4000,'Tubos y perfiles','Tubos de uso mecánico: redondo, cuadrado, rectangular, chapa, planchuelas, flejes, perfiles estructurales'),(5000,'Materiales Eléctricos','Conductores eléctricos, accesorios de conexionado, cajas, gabinetes, conduit, protecciones y elementos de maniobra'),(6000,'Instrumentación','Sensores, transmisores, medidores y otros instrumentos.'),(7000,'Lubricantes y Fluidos','Aceites, grasas y líquidos industriales.'),(8000,'Químicos','Productos químicos');
/*!40000 ALTER TABLE `Categorias_Materiales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Certificaciones_Proveedor`
--

DROP TABLE IF EXISTS `Certificaciones_Proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Certificaciones_Proveedor` (
  `id_certificacion` int NOT NULL AUTO_INCREMENT,
  `id_proveedor` int NOT NULL,
  `tipo_certificacion` varchar(50) NOT NULL,
  `numero_certificado` varchar(50) DEFAULT NULL,
  `organismo_certificador` varchar(100) DEFAULT NULL,
  `alcance` text COMMENT 'Descripción del alcance de la certificación',
  `fecha_emision` date DEFAULT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `estado` enum('Vigente','Vencido','Suspendido','En Trámite') DEFAULT 'En Trámite',
  PRIMARY KEY (`id_certificacion`),
  KEY `idx_tipo_certificacion` (`tipo_certificacion`),
  KEY `idx_fecha_vencimiento_cert` (`fecha_vencimiento`),
  KEY `idx_estado_cert` (`estado`),
  KEY `idx_proveedor_cert` (`id_proveedor`),
  CONSTRAINT `Certificaciones_Proveedor_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `Registro_Proveedores` (`id_proveedor`) ON DELETE CASCADE,
  CONSTRAINT `chk_fechas_cert` CHECK ((`fecha_vencimiento` >= `fecha_emision`))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Certificaciones_Proveedor`
--

LOCK TABLES `Certificaciones_Proveedor` WRITE;
/*!40000 ALTER TABLE `Certificaciones_Proveedor` DISABLE KEYS */;
INSERT INTO `Certificaciones_Proveedor` VALUES (1,1,'ISO 9001','ISO-9001-2023-ETI-001','IRAM','Fabricación de tableros eléctricos industriales','2023-01-15','2026-01-15','Vigente'),(2,1,'IEC 61439','IEC-61439-ETI-2023','TÜV Rheinland','Tableros de distribución de baja tensión','2023-03-20','2025-03-20','Vigente'),(3,1,'Habilitación Electricista','DPEI-2024-1145','DPE CABA','Instalaciones eléctricas industriales','2024-02-10','2025-02-10','Vigente'),(4,2,'API 6A','API-6A-2023-VAN-078','API','Válvulas para equipos de cabeza de pozo','2023-06-15','2026-06-15','Vigente'),(5,2,'API 598','API-598-VAN-2023','API','Inspección y testing de válvulas','2023-07-20','2026-07-20','Vigente'),(6,2,'ISO 9001','ISO-9001-2022-VAN','Bureau Veritas','Fabricación y distribución de válvulas industriales','2022-11-10','2025-11-10','Vigente'),(7,3,'ISO 9001','ISO-9001-2023-DM-445','SGS','Distribución de materiales para construcción industrial','2023-04-12','2026-04-12','Vigente'),(8,3,'AWS D1.1','AWS-D1.1-DM-2024','AWS','Soldadura de estructuras de acero','2024-01-25','2025-01-25','Vigente'),(9,4,'ISO 17025','ISO-17025-2023-IPL','OAA','Calibración de instrumentos de medición industrial','2023-08-15','2026-08-15','Vigente'),(10,4,'ATEX','ATEX-IPL-2023-CE-789','TÜV SÜD','Equipos para atmósferas explosivas Zona 1','2023-09-10','2025-09-10','Vigente'),(11,4,'IECEx','IECEx-IPL-2023-456','IECEx','Instrumentos Ex ia para Zona 0','2023-09-15','2026-09-15','Vigente'),(12,4,'SIL 2','SIL2-IPL-2024-112','TÜV Rheinland','Instrumentos de seguridad funcional','2024-03-05','2027-03-05','Vigente'),(13,5,'ANMAT','ANMAT-QIS-2024-5567','ANMAT','Comercialización de productos químicos industriales','2024-01-20','2025-01-20','Vigente'),(14,5,'Transporte Cargas Peligrosas','TCP-QIS-2023-889','CNRT','Transporte de sustancias químicas clase 8','2023-12-10','2024-12-10','Vigente'),(15,5,'ISO 9001','ISO-9001-2023-QIS','IRAM','Distribución de productos químicos industriales','2023-05-30','2026-05-30','Vigente');
/*!40000 ALTER TABLE `Certificaciones_Proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `Consulta_Materiales`
--

DROP TABLE IF EXISTS `Consulta_Materiales`;
/*!50001 DROP VIEW IF EXISTS `Consulta_Materiales`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `Consulta_Materiales` AS SELECT 
 1 AS `Categoria`,
 1 AS `Nro.Material`,
 1 AS `Texto breve`,
 1 AS `Texto de compras`,
 1 AS `Unidad de medida base`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Contactos_Proveedor`
--

DROP TABLE IF EXISTS `Contactos_Proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Contactos_Proveedor` (
  `id_contacto` int NOT NULL AUTO_INCREMENT,
  `id_proveedor` int NOT NULL,
  `nombre_contacto` varchar(100) NOT NULL,
  `cargo` varchar(50) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `area_responsabilidad` enum('Ventas','Técnico','Administración','Gerencia') DEFAULT 'Ventas',
  `es_contacto_principal` tinyint(1) DEFAULT '0',
  `estado` enum('Activo','Obsoleto') DEFAULT 'Activo',
  `fecha_alta` date DEFAULT (curdate()),
  PRIMARY KEY (`id_contacto`),
  KEY `idx_proveedor_contacto` (`id_proveedor`),
  KEY `idx_contacto_principal` (`es_contacto_principal`),
  CONSTRAINT `Contactos_Proveedor_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `Registro_Proveedores` (`id_proveedor`) ON DELETE CASCADE,
  CONSTRAINT `chk_contacto_email` CHECK ((`email` like _utf8mb4'%@%.%'))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Contactos_Proveedor`
--

LOCK TABLES `Contactos_Proveedor` WRITE;
/*!40000 ALTER TABLE `Contactos_Proveedor` DISABLE KEYS */;
INSERT INTO `Contactos_Proveedor` VALUES (1,1,'Carlos Mendoza','Gerente Comercial','011-4567-8901','cmendoza@electrotecnica.com.ar','Ventas',1,'Activo','2025-09-03'),(2,1,'Ing. Sofia Ramírez','Jefe Técnico','011-4567-8902','sramirez@electrotecnica.com.ar','Técnico',0,'Activo','2025-09-03'),(3,1,'María Vega','Administración','011-4567-8903','mvega@electrotecnica.com.ar','Administración',0,'Activo','2025-09-03'),(4,2,'Ing. Ricardo Paz','Director General','0299-456-7891','rpaz@valvulasnorte.com.ar','Gerencia',1,'Activo','2025-09-03'),(5,2,'Laura Jiménez','Jefe de Ventas','0299-456-7892','ljimenez@valvulasnorte.com.ar','Ventas',0,'Activo','2025-09-03'),(6,2,'Ing. Pedro Morales','Servicio Técnico','0299-456-7893','pmorales@valvulasnorte.com.ar','Técnico',0,'Activo','2025-09-03'),(7,3,'Alejandro Castro','Gerente Comercial','0261-789-0124','acastro@dismateriales.com.ar','Ventas',1,'Activo','2025-09-03'),(8,3,'Ing. Claudia Torres','Responsable Técnico','0261-789-0125','ctorres@dismateriales.com.ar','Técnico',0,'Activo','2025-09-03'),(9,4,'Ing. Fernando López','Gerente General','0291-234-5679','flopez@instrumentos.com.ar','Gerencia',1,'Activo','2025-09-03'),(10,4,'Gabriela Ruiz','Jefe Comercial','0291-234-5680','gruiz@instrumentos.com.ar','Ventas',0,'Activo','2025-09-03'),(11,4,'Ing. Daniel Herrera','Jefe de Calibraciones','0291-234-5681','dherrera@instrumentos.com.ar','Técnico',0,'Activo','2025-09-03'),(12,5,'Patricia Sandoval','Gerente de Ventas','0297-345-6790','psandoval@quimicasur.com.ar','Ventas',1,'Activo','2025-09-03'),(13,5,'Ing. Martín Silva','Responsable Técnico','0297-345-6791','msilva@quimicasur.com.ar','Técnico',0,'Activo','2025-09-03'),(14,5,'Andrea Campos','Administración','0297-345-6792','acampos@quimicasur.com.ar','Administración',0,'Activo','2025-09-03');
/*!40000 ALTER TABLE `Contactos_Proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Desempeno_Proveedores`
--

DROP TABLE IF EXISTS `Desempeno_Proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Desempeno_Proveedores` (
  `id_evaluacion` int NOT NULL AUTO_INCREMENT,
  `id_orden` int NOT NULL,
  `id_proveedor` int NOT NULL,
  `id_actividad` int NOT NULL,
  `fecha_evaluacion` date NOT NULL,
  `evaluador` varchar(100) NOT NULL,
  `competencia_tecnica` decimal(5,2) DEFAULT NULL,
  `cumplimiento_plazo_entrega` decimal(5,2) DEFAULT NULL,
  `servicio_post_venta` decimal(5,2) DEFAULT NULL,
  `calidad_de_producto` decimal(5,2) DEFAULT NULL,
  `puntaje_general` decimal(5,2) GENERATED ALWAYS AS (((((`competencia_tecnica` + `cumplimiento_plazo_entrega`) + `servicio_post_venta`) + `calidad_de_producto`) / 4)) STORED,
  `comentarios` text,
  PRIMARY KEY (`id_evaluacion`),
  KEY `id_actividad` (`id_actividad`),
  KEY `idx_fecha_evaluacion` (`fecha_evaluacion`),
  KEY `idx_puntaje_general` (`puntaje_general`),
  KEY `idx_proveedor_actividad_eval` (`id_proveedor`,`id_actividad`),
  CONSTRAINT `Desempeno_Proveedores_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `Registro_Proveedores` (`id_proveedor`) ON DELETE CASCADE,
  CONSTRAINT `Desempeno_Proveedores_ibfk_2` FOREIGN KEY (`id_actividad`) REFERENCES `Alcance_Actividad` (`id_actividad`) ON DELETE CASCADE,
  CONSTRAINT `Desempeno_Proveedores_chk_1` CHECK ((`competencia_tecnica` between 0 and 100)),
  CONSTRAINT `Desempeno_Proveedores_chk_2` CHECK ((`cumplimiento_plazo_entrega` between 0 and 100)),
  CONSTRAINT `Desempeno_Proveedores_chk_3` CHECK ((`servicio_post_venta` between 0 and 100)),
  CONSTRAINT `Desempeno_Proveedores_chk_4` CHECK ((`calidad_de_producto` between 0 and 100))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Desempeno_Proveedores`
--

LOCK TABLES `Desempeno_Proveedores` WRITE;
/*!40000 ALTER TABLE `Desempeno_Proveedores` DISABLE KEYS */;
INSERT INTO `Desempeno_Proveedores` (`id_evaluacion`, `id_orden`, `id_proveedor`, `id_actividad`, `fecha_evaluacion`, `evaluador`, `competencia_tecnica`, `cumplimiento_plazo_entrega`, `servicio_post_venta`, `calidad_de_producto`, `comentarios`) VALUES (1,1,1,5,'2024-07-25','Juan Pérez',95.00,90.00,88.00,92.00,'Excelente calidad de tableros. Entrega con 2 días de retraso por modificaciones solicitadas.'),(2,1,1,6,'2024-07-25','Juan Pérez',88.00,95.00,90.00,90.00,'Materiales eléctricos conformes a especificación. Entrega puntual.'),(3,2,2,1,'2024-07-28','María González',98.00,85.00,92.00,96.00,'Válvulas API de excelente calidad. Retraso de 5 días por pruebas adicionales solicitadas.'),(4,2,2,8,'2024-07-28','María González',90.00,88.00,85.00,91.00,'Válvulas según especificación. Documentación completa.'),(5,3,3,10,'2024-07-20','Carlos Rodríguez',85.00,100.00,80.00,88.00,'Entrega perfecta en tiempo. Calidad estándar cumplida. Servicio post-venta mejorable.'),(6,4,4,3,'2024-08-02','Ana Martínez',96.00,92.00,94.00,95.00,'Instrumentos de alta precisión. Certificaciones completas. Excelente soporte técnico.'),(7,4,4,7,'2024-08-02','Ana Martínez',92.00,90.00,91.00,93.00,'Instrumentos según especificación con documentación técnica completa.'),(8,6,1,6,'2024-08-05','Roberto Silva',90.00,88.00,92.00,89.00,'Materiales urgentes entregados según cronograma. Calidad consistente.'),(9,3,3,4,'2024-06-15','Carlos Rodríguez',92.00,95.00,87.00,90.00,'Trabajo de soldadura de estructuras según AWS D1.1. Excelente cumplimiento.'),(10,2,2,12,'2024-05-20','María González',88.00,75.00,82.00,85.00,'Servicio de reparación in-situ. Demora en respuesta pero trabajo final satisfactorio.'),(11,4,4,11,'2024-04-10','Ana Martínez',98.00,100.00,96.00,97.00,'Calibración de instrumentos con trazabilidad INTI. Servicio excepcional.'),(12,5,5,9,'2024-03-25','Luis Fernández',85.00,90.00,88.00,87.00,'Productos químicos según especificación. Documentación de seguridad completa.');
/*!40000 ALTER TABLE `Desempeno_Proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Detalle_Orden_Compra`
--

DROP TABLE IF EXISTS `Detalle_Orden_Compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Detalle_Orden_Compra` (
  `id_detalle` int NOT NULL AUTO_INCREMENT,
  `id_orden` int NOT NULL,
  `id_material` int NOT NULL,
  `cantidad_solicitada` decimal(10,2) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(15,2) GENERATED ALWAYS AS ((`cantidad_solicitada` * `precio_unitario`)) STORED,
  `cantidad_recibida` decimal(10,2) DEFAULT '0.00',
  `fecha_recepcion` date DEFAULT NULL,
  `observaciones` text,
  PRIMARY KEY (`id_detalle`),
  KEY `idx_orden` (`id_orden`),
  KEY `idx_material` (`id_material`),
  CONSTRAINT `Detalle_Orden_Compra_ibfk_1` FOREIGN KEY (`id_orden`) REFERENCES `Ordenes_Compra` (`id_orden`) ON DELETE CASCADE,
  CONSTRAINT `Detalle_Orden_Compra_ibfk_2` FOREIGN KEY (`id_material`) REFERENCES `Materiales` (`id_material`),
  CONSTRAINT `chk_cantidad_positiva` CHECK ((`cantidad_solicitada` > 0)),
  CONSTRAINT `chk_cantidad_recibida_valida` CHECK (((`cantidad_recibida` >= 0) and (`cantidad_recibida` <= `cantidad_solicitada`))),
  CONSTRAINT `chk_precio_positivo` CHECK ((`precio_unitario` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Detalle_Orden_Compra`
--

LOCK TABLES `Detalle_Orden_Compra` WRITE;
/*!40000 ALTER TABLE `Detalle_Orden_Compra` DISABLE KEYS */;
INSERT INTO `Detalle_Orden_Compra` (`id_detalle`, `id_orden`, `id_material`, `cantidad_solicitada`, `precio_unitario`, `cantidad_recibida`, `fecha_recepcion`, `observaciones`) VALUES (1,1,1,100.00,85.50,80.00,'2024-07-16','Cable THHN para instalación principal'),(2,1,2,5.00,1250.00,5.00,'2024-07-16','Interruptores para tablero general'),(3,1,11,10.00,890.00,0.00,NULL,'Breakers de respaldo'),(4,2,116,2.00,45000.00,0.00,NULL,'Válvulas para línea principal'),(5,2,117,3.00,32000.00,0.00,NULL,'Válvulas mariposa sector B'),(6,2,120,4.00,18500.00,0.00,NULL,'Válvulas de bola uso general'),(7,3,61,50.00,1250.00,50.00,'2024-07-12','Tubería acero para reemplazo'),(8,3,81,20.00,450.00,20.00,'2024-07-12','Codos 90° para conexiones'),(9,3,82,15.00,680.00,15.00,'2024-07-12','Tees para derivaciones'),(10,4,36,3.00,28000.00,0.00,NULL,'Transmisores de presión'),(11,4,38,5.00,15600.00,0.00,NULL,'Termopares tipo K'),(12,4,39,2.00,8900.00,0.00,NULL,'Manómetros industriales'),(13,5,141,10.00,2800.00,0.00,NULL,'Ácido sulfúrico para proceso'),(14,5,142,25.00,1950.00,0.00,NULL,'Hidróxido de sodio'),(15,6,21,8.00,12500.00,0.00,NULL,'Luminarias LED exteriores'),(16,6,3,75.00,125.00,0.00,NULL,'Canaletas metálicas'),(17,7,123,1.00,95000.00,0.00,NULL,'Válvula de seguridad alta presión'),(18,8,102,25.00,850.00,0.00,NULL,'Tubos cuadrados estructurales'),(19,8,103,30.00,650.00,0.00,NULL,'Planchuelas de acero');
/*!40000 ALTER TABLE `Detalle_Orden_Compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Estados_Orden`
--

DROP TABLE IF EXISTS `Estados_Orden`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Estados_Orden` (
  `id_estado` int NOT NULL,
  `descripcion_estado` varchar(50) NOT NULL,
  PRIMARY KEY (`id_estado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Estados_Orden`
--

LOCK TABLES `Estados_Orden` WRITE;
/*!40000 ALTER TABLE `Estados_Orden` DISABLE KEYS */;
INSERT INTO `Estados_Orden` VALUES (1,'Borrador'),(2,'Enviada'),(3,'Recibida'),(4,'Cancelada');
/*!40000 ALTER TABLE `Estados_Orden` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Log_Stock`
--

DROP TABLE IF EXISTS `Log_Stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Log_Stock` (
  `id_log` int NOT NULL AUTO_INCREMENT,
  `id_material` int NOT NULL,
  `id_ubicacion` int NOT NULL,
  `cantidad_anterior` int DEFAULT NULL,
  `cantidad_nueva` int DEFAULT NULL,
  `usuario` varchar(50) DEFAULT NULL,
  `fecha_modificacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_log`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Log_Stock`
--

LOCK TABLES `Log_Stock` WRITE;
/*!40000 ALTER TABLE `Log_Stock` DISABLE KEYS */;
INSERT INTO `Log_Stock` VALUES (1,145,3,22,26,'root@localhost','2025-08-18 23:09:36'),(2,1,1,1250,1300,'root@localhost','2025-09-09 00:22:06');
/*!40000 ALTER TABLE `Log_Stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Materiales`
--

DROP TABLE IF EXISTS `Materiales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Materiales` (
  `id_material` int NOT NULL AUTO_INCREMENT,
  `nombre_material` varchar(100) DEFAULT NULL,
  `descripcion` text,
  `unidad_base` varchar(10) DEFAULT NULL,
  `id_categoria` int DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_material`),
  KEY `unidad_base` (`unidad_base`),
  KEY `id_categoria` (`id_categoria`),
  CONSTRAINT `Materiales_ibfk_1` FOREIGN KEY (`unidad_base`) REFERENCES `Unidades_Medida` (`id_unidad`),
  CONSTRAINT `Materiales_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `Categorias_Materiales` (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Materiales`
--

LOCK TABLES `Materiales` WRITE;
/*!40000 ALTER TABLE `Materiales` DISABLE KEYS */;
INSERT INTO `Materiales` VALUES (1,'Cable THHN 2.5mm² negro','Conductor de cobre estañado 600V, aislamiento THHN','M',5000,'Activo'),(2,'Interruptor termomagnético 20A 2P','Disyuntor bipolar 20A curva C','PZA',5000,'Activo'),(3,'Canaleta metálica 40x40mm','Canaleta para instalaciones eléctricas, acero galvanizado','M',5000,'Activo'),(4,'Tubo conduit PVC 20mm','Tubo rígido de PVC para instalaciones eléctricas','M',5000,'Activo'),(5,'Portalámparas E27 porcelana','Portalámparas rosca Edison 27mm, material porcelana','PZA',5000,'Activo'),(6,'Pulsador NO 22mm rojo','Pulsador normalmente abierto para panel 22mm','PZA',5000,'Activo'),(7,'Contactor 25A 220V','Contactor magnético 3 polos 25A','PZA',5000,'Activo'),(8,'Relé térmico 18-25A','Relé de sobrecarga ajustable para motor','PZA',5000,'Activo'),(9,'Tablero eléctrico 12 módulos','Tablero plástico para instalación de módulos DIN','PZA',5000,'Activo'),(10,'Base enchufe 2P+T 20A','Toma corriente industrial 20A con tierra','PZA',5000,'Activo'),(11,'Breaker 16A 1P','Interruptor termomagnético unipolar 16A','PZA',5000,'Activo'),(12,'Cable SY 5x2.5mm²','Cable blindado para instrumentación 5 conductores','M',5000,'Activo'),(13,'Transformador 380/220V 5kVA','Transformador trifásico de aislamiento','PZA',5000,'Activo'),(14,'Barrera de seguridad Ex i','Barrera intrínsecamente segura para áreas clasificadas','PZA',5000,'Activo'),(15,'Fusible NH 160A','Portafusible NH con fusible 160A','PZA',5000,'Activo'),(16,'Terminal ojalado 16mm²','Terminal de compresión para cable 16mm²','PZA',5000,'Activo'),(17,'Conector MC4 par','Conector solar para paneles fotovoltaicos','PZA',5000,'Activo'),(18,'Variador de frecuencia 5HP','Variador de velocidad para motor trifásico','PZA',5000,'Activo'),(19,'Batería 12V 7Ah','Batería de gel para sistemas de respaldo','PZA',5000,'Activo'),(20,'Sensor fotoeléctrico 10-30VDC','Sensor de barrera fotoeléctrica','PZA',5000,'Activo'),(21,'Luminaria LED 50W IP65','Luminaria industrial estanca 50W','PZA',5000,'Activo'),(22,'Cable UTP Cat6','Cable de red categoría 6','M',5000,'Activo'),(23,'Tapa ciega para caja 4x2\"','Tapa plástica para cajas de derivación','PZA',5000,'Activo'),(24,'Interruptor crepuscular','Interruptor automático activado por luz ambiental','PZA',5000,'Activo'),(25,'Regleta de terminales 12 polos','Regleta para conexión de conductores','PZA',5000,'Activo'),(26,'Transformador corriente 100/5A','Transformador de corriente para medición','PZA',5000,'Activo'),(27,'Contador energía activa','Medidor de energía eléctrica monofásico','PZA',5000,'Activo'),(28,'Base enchufe USB 2.1A','Toma corriente con puertos USB integrados','PZA',5000,'Activo'),(29,'Protector sobretensión 40kA','Descargador de sobretensiones para tableros','PZA',5000,'Activo'),(30,'Candado seguridad 10mm','Candado para tableros eléctricos','PZA',5000,'Activo'),(31,'Guía cables perforada','Guía metálica para organización de cables','M',5000,'Activo'),(32,'Bandeja portacables 100mm','Bandeja metálica para tendido de cables','M',5000,'Activo'),(33,'Cable flexible 3G1.5mm²','Cable para conexión de equipos móviles','M',5000,'Activo'),(34,'Prensaestopa PG9','Prensaestopa metálico para entrada de cables','PZA',5000,'Activo'),(35,'Caja derivación 8x8x6\"','Caja estanca para empalmes eléctricos','PZA',5000,'Inactivo'),(36,'Transmisor presión 0-10bar','Transmisor de presión industrial 4-20mA','PZA',6000,'Activo'),(37,'Indicador temperatura digital','Visualizador digital para termopar o RTD','PZA',6000,'Activo'),(38,'Termopar tipo K 500mm','Sonda termopar tipo K con conector','PZA',6000,'Activo'),(39,'Manómetro 0-25bar 4\"','Manómetro de bourdon carátula 100mm','PZA',6000,'Activo'),(40,'Switch nivel flotador','Interruptor de nivel por flotador','PZA',6000,'Activo'),(41,'Caudalímetro turbina 1\"','Medidor de caudal por turbina, salida pulso','PZA',6000,'Activo'),(42,'Transmisor nivel radar','Sensor de nivel sin contacto tecnología radar','PZA',6000,'Activo'),(43,'Analizador pH industrial','Sistema de medición de pH en línea','PZA',6000,'Activo'),(44,'Célula carga 500kg','Célula de carga para básculas industriales','PZA',6000,'Activo'),(45,'Presostato 0.5-10bar','Interruptor de presión ajustable','PZA',6000,'Activo'),(46,'Termorresistencia PT100','Sonda RTD PT100 3 hilos','PZA',6000,'Activo'),(47,'Convertidor señal I/P','Convertidor corriente neumática 4-20mA a 3-15psi','PZA',6000,'Activo'),(48,'Panel indicador 96x96mm','Panel montaje frontal para instrumentos','PZA',6000,'Activo'),(49,'Transmisor diferencial','Transmisor de presión diferencial','PZA',6000,'Activo'),(50,'Válvula solenoide 1/2\"','Válvula solenoide para instrumentación','PZA',6000,'Activo'),(51,'Fuente alimentación 24VDC','Fuente regulada para instrumentos','PZA',6000,'Activo'),(52,'Caja conexiones Ex d','Caja a prueba de explosión para instrumentos','PZA',6000,'Activo'),(53,'Cable compensado 2x1.5mm²','Cable para termopares blindado','M',6000,'Activo'),(54,'Conector M12 5 polos','Conector circular para sensores','PZA',6000,'Activo'),(55,'Solenoide 24VDC','Actuador solenoide para válvulas','PZA',6000,'Activo'),(56,'Convertidor USB-RS485','Interface conversión USB a RS485','PZA',6000,'Activo'),(57,'Switch posición inductivo','Sensor inductivo de posición','PZA',6000,'Activo'),(58,'Termómetro bimetálico 6\"','Termómetro de varilla bimetálica','PZA',6000,'Activo'),(59,'Registrador 4 canales','Registrador gráfico multiparámetro','PZA',6000,'Activo'),(60,'Soporte montaje panel','Soporte para instalación en panel','PZA',6000,'Inactivo'),(61,'Tubo acero SCH40 1/2\"','Tubería de acero al carbono sin costura','M',2000,'Activo'),(62,'Tubería PVC presión 3\"','Tubería de PVC para agua a presión','M',2000,'Activo'),(63,'Tubo cobre tipo L 3/4\"','Tubería de cobre para instalaciones sanitarias','M',2000,'Activo'),(64,'Tubería HDPE PN10 4\"','Tubería polietileno alta densidad','M',2000,'Activo'),(65,'Tubo acero inox 316 2\"','Tubería sanitaria de acero inoxidable','M',2000,'Activo'),(66,'Tubería fibrocemento 6\"','Tubería para conducción de agua','M',2000,'Activo'),(67,'Tubo galvanizado 1\"','Tubería roscable acero galvanizado','M',2000,'Activo'),(68,'Tubería PP-R 20mm','Tubería polipropileno random para agua caliente','M',2000,'Activo'),(69,'Tubo conduit EMT 3/4\"','Tubería metálica para instalaciones eléctricas','M',2000,'Activo'),(70,'Tubería CPVC 1/2\"','Tubería clorada para agua caliente','M',2000,'Activo'),(71,'Tubo multicapa 16mm','Tubería multicapa para instalaciones sanitarias','M',2000,'Activo'),(72,'Tubería hierro dúctil 8\"','Tubería para conducción de agua potable','M',2000,'Activo'),(73,'Tubo acero SCH80 4\"','Tubería de acero para alta presión','M',2000,'Activo'),(74,'Tubería ABS 2\"','Tubería para desagües','M',2000,'Activo'),(75,'Tubo PEAD 110mm','Tubería para redes de gas','M',2000,'Activo'),(76,'Tubería vidrio 50mm','Tubería de borosilicato para químicos','M',2000,'Activo'),(77,'Tubo acero API 5L 6\"','Tubería para conducción de hidrocarburos','M',2000,'Activo'),(78,'Tubería PEX 3/4\"','Tubería polietileno reticulado','M',2000,'Activo'),(79,'Tubo acero al carbono 1.1/4\"','Tubería para vapor baja presión','M',2000,'Activo'),(80,'Tubería PE100 SDR11 2\"','Tubería polietileno alta densidad','M',2000,'Inactivo'),(81,'Codo 90° 1/2\" SCH40','Codo soldable acero al carbono','PZA',3000,'Activo'),(82,'Tee 1\" x 1/2\" roscada','Tee reductora hierro maleable','PZA',3000,'Activo'),(83,'Unión universal 2\"','Unión rápida para tuberías','PZA',3000,'Activo'),(84,'Reducción concéntrica 3\" a 2\"','Reducción para cambio de diámetro','PZA',3000,'Activo'),(85,'Cople roscado 3/4\"','Conexión para unión de tuberías','PZA',3000,'Activo'),(86,'Tapón macho 1/2\"','Tapón para cierre de líneas','PZA',3000,'Activo'),(87,'Niple 1\" x 150mm','Niple de acero roscado','PZA',3000,'Activo'),(88,'Brida deslizante 4\" 150#','Brida para unión de tuberías','PZA',3000,'Activo'),(89,'Codo 45° 2\" SCH80','Codo para alta presión','PZA',3000,'Activo'),(90,'Tapa ciega 6\" 300#','Tapa para cierre de bridas','PZA',3000,'Activo'),(91,'Unión dresser 1.1/2\"','Unión flexible para reparaciones','PZA',3000,'Activo'),(92,'Válvula check 1.1/4\"','Válvula de retención tipo clapeta','PZA',3000,'Activo'),(93,'Reducción excéntrica 8\" a 6\"','Reducción para líneas de succión','PZA',3000,'Activo'),(94,'Cruce 3\" x 2\"','Conexión para derivaciones','PZA',3000,'Activo'),(95,'Brida ciega 10\"','Brida para aislamiento de líneas','PZA',3000,'Activo'),(96,'Junta espiral 4\"','Junta para bridas de acero inox','PZA',3000,'Activo'),(97,'Tee soldable 3\" SCH40','Tee de igual diámetro para soldar','PZA',3000,'Activo'),(98,'Codo largo radio 6\"','Codo para flujo con baja pérdida','PZA',3000,'Activo'),(99,'Abrazadera reparación 2\"','Abrazadera para reparación emergencia','PZA',3000,'Activo'),(100,'Codo PVC 90° 3\"','Codo para tuberías de PVC','PZA',3000,'Inactivo'),(101,'Perfil UPN 80','Perfil estructural acero laminado','M',4000,'Activo'),(102,'Tubo cuadrado 40x40x2mm','Tubo estructural de acero','M',4000,'Activo'),(103,'Planchuela 1/4\" x 4\"','Planchuela de acero A36','M',4000,'Activo'),(104,'Ángulo igual 2\" x 1/4\"','Ángulo estructural de acero','M',4000,'Activo'),(105,'Tubo redondo 2\" SCH40','Tubo de acero para uso mecánico','M',4000,'Activo'),(106,'Perfil IPN 120','Viga I normal de acero','M',4000,'Activo'),(107,'Fleje acero 50x3mm','Fleje de acero al carbono','M',4000,'Activo'),(108,'Tubo rectangular 60x30x2mm','Tubo para estructuras metálicas','M',4000,'Activo'),(109,'Barra redonda 20mm','Barra de acero mecanizable','M',4000,'Activo'),(110,'Perfil T 50x50x5mm','Perfil T estructural','M',4000,'Activo'),(111,'Planchuela galvanizada 3/16\"x6\"','Planchuela para exteriores','M',4000,'Activo'),(112,'Tubo ovalado 30x15mm','Tubo para mobiliario industrial','M',4000,'Activo'),(113,'Varilla roscada 12mm','Varilla para anclajes estructurales','M',4000,'Activo'),(114,'Perfil HEA 100','Perfil H laminado en caliente','M',4000,'Activo'),(115,'Tubo redondo inox 1.1/2\"','Tubo de acero inoxidable','M',4000,'Inactivo'),(116,'Válvula compuerta 2\" 150#','Válvula de compuerta bridada','PZA',1000,'Activo'),(117,'Válvula mariposa 6\" lug','Válvula mariposa tipo wafer','PZA',1000,'Activo'),(118,'Válvula globo 1.1/2\" 300#','Válvula de globo para vapor','PZA',1000,'Activo'),(119,'Válvula retención 3\" swing','Válvula check tipo clapeta','PZA',1000,'Activo'),(120,'Válvula bola 1\" 600#','Válvula de bola full port','PZA',1000,'Activo'),(121,'Válvula diafragma 1.1/2\"','Válvula para fluidos corrosivos','PZA',1000,'Activo'),(122,'Válvula aguja 1/2\"','Válvula para regulación fina','PZA',1000,'Activo'),(123,'Válvula seguridad 3/4\" 10bar','Válvula de alivio de presión','PZA',1000,'Activo'),(124,'Válvula piezoeléctrica 24VDC','Válvula actuada eléctricamente','PZA',1000,'Activo'),(125,'Válvula neumática 3/2 vías','Válvula direccional neumática','PZA',1000,'Activo'),(126,'Válvula esférica 4\" 150#','Válvula esférica para gas','PZA',1000,'Activo'),(127,'Válvula purga rápida 1/4\"','Válvula para purga de aire','PZA',1000,'Activo'),(128,'Válvula reguladora presión','Reguladora de presión aguas abajo','PZA',1000,'Activo'),(129,'Válvula solenoide 3/4\" AC','Válvula actuada eléctricamente','PZA',1000,'Activo'),(130,'Válvula guillotina 8\"','Válvula para sólidos en suspensión','PZA',1000,'Inactivo'),(131,'Aceite ISO 68','Aceite hidráulico anti-desgaste','LT',7000,'Activo'),(132,'Grasa NLGI 2','Grasa multipropósito litio','KG',7000,'Activo'),(133,'Fluido hidráulico HLP 46','Fluido para sistemas hidráulicos','LT',7000,'Activo'),(134,'Aceite compresor 100','Aceite para compresores de tornillo','LT',7000,'Activo'),(135,'Desengrasante industrial','Limpiador para maquinaria','LT',7000,'Activo'),(136,'Aceite cadena SAE 80W','Aceite para cadenas de transmisión','LT',7000,'Activo'),(137,'Refrigerante R134a','Gas refrigerante para sistemas HVAC','KG',7000,'Activo'),(138,'Aceite turbina ISO 32','Aceite para turbinas de vapor','LT',7000,'Activo'),(139,'Fluido corte soluble','Fluido para máquinas herramienta','LT',7000,'Activo'),(140,'Grasa alimentaria NSF','Grasa para industria alimenticia','KG',7000,'Inactivo'),(141,'Ácido sulfúrico 98%','Ácido para baterías y procesos','LT',8000,'Activo'),(142,'Hidróxido sodio 50%','Soda cáustica solución','KG',8000,'Activo'),(143,'Inhibidor corrosión','Aditivo para protección metales','LT',8000,'Activo'),(144,'Desincrustante calderas','Producto para limpieza de calderas','KG',8000,'Activo'),(145,'Resina intercambio iónico','Resina catiónica para desmineralización','KG',8000,'Activo'),(146,'Biocida no oxidante','Control de microorganismos en agua','LT',8000,'Activo'),(147,'Antiespumante industrial','Control de espuma en procesos','LT',8000,'Activo'),(148,'Detergente enzimático','Limpiador para industria alimentaria','LT',8000,'Activo'),(149,'Desengrasante alcalino','Limpiador para talleres mecánicos','LT',8000,'Activo'),(150,'Neutralizador pH','Regulador de pH para efluentes','KG',8000,'Inactivo'),(151,'Válvula Esférica flotante 2\" A351CF8M RPTFE','Válvula esferica, esfera flotante, cuerpo y esfera en acero inoxidable ASTM A351 CF8M, asiento de RPTFE','UN',3000,NULL);
/*!40000 ALTER TABLE `Materiales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Movimientos`
--

DROP TABLE IF EXISTS `Movimientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Movimientos` (
  `id_movimiento` int NOT NULL AUTO_INCREMENT,
  `fecha_movimiento` date DEFAULT NULL,
  `tipo_movimiento` int DEFAULT NULL,
  `cantidad` decimal(10,2) DEFAULT NULL,
  `id_material` int DEFAULT NULL,
  `id_ubicacion` int DEFAULT NULL,
  `observaciones` text,
  PRIMARY KEY (`id_movimiento`),
  KEY `tipo_movimiento` (`tipo_movimiento`),
  KEY `id_material` (`id_material`),
  KEY `id_ubicacion` (`id_ubicacion`),
  CONSTRAINT `Movimientos_ibfk_1` FOREIGN KEY (`tipo_movimiento`) REFERENCES `Tipos_Movimiento` (`id_tipo_mov`),
  CONSTRAINT `Movimientos_ibfk_2` FOREIGN KEY (`id_material`) REFERENCES `Materiales` (`id_material`),
  CONSTRAINT `Movimientos_ibfk_3` FOREIGN KEY (`id_ubicacion`) REFERENCES `Ubicaciones` (`id_ubicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Movimientos`
--

LOCK TABLES `Movimientos` WRITE;
/*!40000 ALTER TABLE `Movimientos` DISABLE KEYS */;
INSERT INTO `Movimientos` VALUES (1,'2023-03-15',101,500.00,1,1,'Compra a proveedor Cablesur S.A.'),(2,'2023-06-22',102,300.00,1,1,'Consumo obra Refinería Luján'),(3,'2024-01-10',101,800.00,1,1,'Reposición stock según plan anual'),(4,'2022-09-05',101,30.00,2,1,'Compra inicial stock seguridad'),(5,'2023-11-18',102,12.00,2,1,'Reemplazo tablero Planta Añelo'),(6,'2024-05-30',101,50.00,3,1,'Compra para proyecto ampliación'),(7,'2023-07-12',102,25.00,3,1,'Instalación canalizaciones'),(8,'2022-07-12',101,40.00,5,1,'Stock inicial mantenimiento'),(9,'2024-02-28',102,15.00,5,1,'Reemplazo luminarias sector B'),(10,'2023-01-15',101,10.00,7,2,'Compra según plan mantenimiento'),(11,'2023-08-22',102,4.00,7,2,'Falla equipo compresor 3'),(12,'2024-04-05',103,2.00,7,2,'Ajuste positivo por inventario'),(13,'2022-11-30',101,15.00,10,2,'Compra inicial para almacén'),(14,'2023-05-18',101,40.00,12,3,'Compra para proyecto automatización'),(15,'2024-03-12',102,25.00,12,3,'Instalación nuevos sensores'),(16,'2023-02-10',101,5.00,13,1,'Compra transformadores'),(17,'2024-06-20',102,3.00,15,3,'Mantenimiento preventivo tableros'),(18,'2023-09-15',101,20.00,16,4,'Stock para obra externa'),(19,'2022-08-10',101,2.00,18,1,'Compra para modernización'),(20,'2023-02-15',102,1.00,18,1,'Instalación en bomba principal'),(21,'2024-01-22',101,1.00,18,1,'Reposición stock crítico'),(22,'2022-12-05',101,6.00,20,1,'Compra para sistema seguridad'),(23,'2023-04-10',101,8.00,21,1,'Reposición luminarias'),(24,'2023-07-30',101,10.00,25,2,'Reposición consumo habitual'),(25,'2024-05-15',102,3.00,25,2,'Reparación tablero auxiliar'),(26,'2023-11-05',101,2.00,26,3,'Compra para calibración'),(27,'2024-02-20',101,5.00,27,3,'Reposición instrumentación'),(28,'2024-07-10',101,8.00,30,4,'Compra para mantenimiento anual'),(29,'2023-08-12',101,30.00,31,1,'Compra bandejas portacables'),(30,'2024-01-15',102,12.00,31,1,'Instalación nueva línea'),(31,'2022-10-15',101,3.00,40,2,'Compra inicial stock'),(32,'2023-06-05',102,1.00,40,2,'Reemplazo switch nivel'),(33,'2022-06-20',101,2.00,45,3,'Implementación sistema pesaje'),(34,'2023-03-10',102,1.00,45,3,'Falla en báscula recepción'),(35,'2024-01-05',103,1.00,45,3,'Ajuste por calibración'),(36,'2023-12-18',101,4.00,46,3,'Compra PT100 repuestos'),(37,'2024-06-05',101,3.00,50,4,'Compra para proyecto control'),(38,'2022-09-28',101,5.00,55,1,'Stock para mantenimiento predictivo'),(39,'2023-05-22',102,2.00,55,1,'Reemplazo válvulas control'),(40,'2024-03-15',101,3.00,56,3,'Reposición post-mantenimiento'),(41,'2023-08-15',101,30.00,61,1,'Compra para mantenimiento general'),(42,'2024-03-22',102,18.00,61,1,'Reparaciones línea vapor'),(43,'2022-05-10',101,25.00,62,1,'Compra inicial tuberías'),(44,'2023-11-20',102,10.00,62,1,'Reparación línea proceso'),(45,'2024-04-18',101,15.00,70,3,'Compra para instalaciones sanitarias'),(46,'2022-07-30',101,2.00,75,1,'Compra para laboratorio químico'),(47,'2023-10-12',101,20.00,82,1,'Reposición stock mínimo'),(48,'2024-02-05',102,12.00,82,1,'Reparación línea proceso'),(49,'2023-04-18',101,15.00,83,1,'Compra accesorios mantenimiento'),(50,'2024-05-20',101,8.00,90,3,'Compra para sistema drenaje'),(51,'2023-01-20',101,15.00,101,1,'Compra para estructura soporte'),(52,'2023-11-15',102,10.00,101,1,'Construcción plataforma'),(53,'2022-08-22',101,5.00,110,3,'Compra para proyecto especial'),(54,'2023-07-10',102,3.00,110,3,'Fabricación equipo especial'),(55,'2024-02-28',101,4.00,111,4,'Reposición planchuelas'),(56,'2022-12-10',101,6.00,116,1,'Stock seguridad válvulas'),(57,'2023-07-18',102,2.00,116,1,'Reemplazo línea principal'),(58,'2024-01-30',105,1.00,116,1,'Devolución por defecto fabricación'),(59,'2024-06-15',101,3.00,125,4,'Compra para automatización'),(60,'2023-02-28',101,15.00,131,1,'Compra plan anual lubricantes'),(61,'2024-01-10',102,8.00,131,1,'Cambio aceite equipos'),(62,'2022-10-05',101,3.00,140,2,'Compra inicial para planta alimentos'),(63,'2023-09-15',101,10.00,145,3,'Reposición tratamiento agua'),(64,'2024-04-05',102,6.00,145,3,'Regeneración plantas'),(65,'2024-07-05',101,5.00,150,2,'Compra para tratamiento efluentes'),(66,'2023-05-10',101,12.00,4,1,'Compra conduit PVC'),(67,'2024-01-18',102,8.00,4,1,'Instalación eléctrica'),(68,'2022-11-15',101,30.00,6,2,'Compra pulsadores'),(69,'2023-08-05',102,10.00,6,2,'Modernización paneles'),(70,'2023-12-10',101,5.00,8,2,'Reposición contactores'),(71,'2024-03-22',102,2.00,8,2,'Reparación equipos'),(72,'2022-09-10',101,20.00,9,2,'Compra tableros'),(73,'2023-06-15',102,5.00,9,2,'Ampliación capacidad'),(74,'2023-10-20',101,15.00,11,3,'Reposición breakers'),(75,'2024-02-10',102,6.00,11,3,'Mantenimiento preventivo'),(76,'2022-12-18',101,3.00,14,3,'Compra fusibles'),(77,'2023-09-05',102,1.00,14,3,'Reemplazo protección'),(78,'2023-04-15',101,8.00,17,4,'Compra conectores'),(79,'2024-01-05',102,3.00,17,4,'Instalación campo'),(80,'2022-10-20',101,10.00,19,4,'Compra baterías'),(81,'2023-07-12',102,4.00,19,4,'Reemplazo sistema UPS'),(82,'2023-11-25',101,6.00,22,1,'Reposición cable UTP'),(83,'2024-04-15',102,3.00,22,1,'Ampliación red datos'),(84,'2022-08-15',101,25.00,23,1,'Compra tapas cajas'),(85,'2023-05-20',102,10.00,23,1,'Instalaciones nuevas'),(86,'2023-03-15',1,500.00,1,1,'Compra a proveedor Cablesur S.A.'),(87,'2023-06-22',2,300.00,1,1,'Consumo obra Refinería Luján'),(88,'2024-01-10',1,800.00,1,1,'Reposición stock según plan anual'),(89,'2022-09-05',1,30.00,2,1,'Compra inicial stock seguridad'),(90,'2023-11-18',2,12.00,2,1,'Reemplazo tablero Planta Añelo'),(91,'2024-05-30',1,50.00,3,1,'Compra para proyecto ampliación'),(92,'2023-07-12',2,25.00,3,1,'Instalación canalizaciones'),(93,'2022-07-12',1,40.00,5,1,'Stock inicial mantenimiento'),(94,'2024-02-28',2,15.00,5,1,'Reemplazo luminarias sector B'),(95,'2023-01-15',1,10.00,7,2,'Compra según plan mantenimiento'),(96,'2023-08-22',2,4.00,7,2,'Falla equipo compresor 3'),(97,'2024-04-05',3,2.00,7,2,'Ajuste positivo por inventario'),(98,'2022-11-30',1,15.00,10,2,'Compra inicial para almacén'),(99,'2023-05-18',1,40.00,12,3,'Compra para proyecto automatización'),(100,'2024-03-12',2,25.00,12,3,'Instalación nuevos sensores'),(101,'2023-02-10',1,5.00,13,1,'Compra transformadores'),(102,'2024-06-20',2,3.00,15,3,'Mantenimiento preventivo tableros'),(103,'2023-09-15',1,20.00,16,4,'Stock para obra externa'),(104,'2022-08-10',1,2.00,18,1,'Compra para modernización'),(105,'2023-02-15',2,1.00,18,1,'Instalación en bomba principal'),(106,'2024-01-22',1,1.00,18,1,'Reposición stock crítico'),(107,'2022-12-05',1,6.00,20,1,'Compra para sistema seguridad'),(108,'2023-04-10',1,8.00,21,1,'Reposición luminarias'),(109,'2023-07-30',1,10.00,25,2,'Reposición consumo habitual'),(110,'2024-05-15',2,3.00,25,2,'Reparación tablero auxiliar'),(111,'2023-11-05',1,2.00,26,3,'Compra para calibración'),(112,'2024-02-20',1,5.00,27,3,'Reposición instrumentación'),(113,'2024-07-10',1,8.00,30,4,'Compra para mantenimiento anual'),(114,'2023-08-12',1,30.00,31,1,'Compra bandejas portacables'),(115,'2024-01-15',2,12.00,31,1,'Instalación nueva línea'),(116,'2022-10-15',1,3.00,40,2,'Compra inicial stock'),(117,'2023-06-05',2,1.00,40,2,'Reemplazo switch nivel'),(118,'2022-06-20',1,2.00,45,3,'Implementación sistema pesaje'),(119,'2023-03-10',2,1.00,45,3,'Falla en báscula recepción'),(120,'2024-01-05',3,1.00,45,3,'Ajuste por calibración'),(121,'2023-12-18',1,4.00,46,3,'Compra PT100 repuestos'),(122,'2024-06-05',1,3.00,50,4,'Compra para proyecto control'),(123,'2022-09-28',1,5.00,55,1,'Stock para mantenimiento predictivo'),(124,'2023-05-22',2,2.00,55,1,'Reemplazo válvulas control'),(125,'2024-03-15',1,3.00,56,3,'Reposición post-mantenimiento'),(126,'2023-08-15',1,30.00,61,1,'Compra para mantenimiento general'),(127,'2024-03-22',2,18.00,61,1,'Reparaciones línea vapor'),(128,'2022-05-10',1,25.00,62,1,'Compra inicial tuberías'),(129,'2023-11-20',2,10.00,62,1,'Reparación línea proceso'),(130,'2024-04-18',1,15.00,70,3,'Compra para instalaciones sanitarias'),(131,'2022-07-30',1,2.00,75,1,'Compra para laboratorio químico'),(132,'2023-10-12',1,20.00,82,1,'Reposición stock mínimo'),(133,'2024-02-05',2,12.00,82,1,'Reparación línea proceso'),(134,'2023-04-18',1,15.00,83,1,'Compra accesorios mantenimiento'),(135,'2024-05-20',1,8.00,90,3,'Compra para sistema drenaje'),(136,'2023-01-20',1,15.00,101,1,'Compra para estructura soporte'),(137,'2023-11-15',2,10.00,101,1,'Construcción plataforma'),(138,'2022-08-22',1,5.00,110,3,'Compra para proyecto especial'),(139,'2023-07-10',2,3.00,110,3,'Fabricación equipo especial'),(140,'2024-02-28',1,4.00,111,4,'Reposición planchuelas'),(141,'2022-12-10',1,6.00,116,1,'Stock seguridad válvulas'),(142,'2023-07-18',2,2.00,116,1,'Reemplazo línea principal'),(143,'2024-01-30',5,1.00,116,1,'Devolución por defecto fabricación'),(144,'2024-06-15',1,3.00,125,4,'Compra para automatización'),(145,'2023-02-28',1,15.00,131,1,'Compra plan anual lubricantes'),(146,'2024-01-10',2,8.00,131,1,'Cambio aceite equipos'),(147,'2022-10-05',1,3.00,140,2,'Compra inicial para planta alimentos'),(148,'2023-09-15',1,10.00,145,3,'Reposición tratamiento agua'),(149,'2024-04-05',2,6.00,145,3,'Regeneración plantas'),(150,'2024-07-05',1,5.00,150,2,'Compra para tratamiento efluentes'),(151,'2023-05-10',1,12.00,4,1,'Compra conduit PVC'),(152,'2024-01-18',2,8.00,4,1,'Instalación eléctrica'),(153,'2022-11-15',1,30.00,6,2,'Compra pulsadores'),(154,'2023-08-05',2,10.00,6,2,'Modernización paneles'),(155,'2023-12-10',1,5.00,8,2,'Reposición contactores'),(156,'2024-03-22',2,2.00,8,2,'Reparación equipos'),(157,'2022-09-10',1,20.00,9,2,'Compra tableros'),(158,'2023-06-15',2,5.00,9,2,'Ampliación capacidad'),(159,'2023-10-20',1,15.00,11,3,'Reposición breakers'),(160,'2024-02-10',2,6.00,11,3,'Mantenimiento preventivo'),(161,'2022-12-18',1,3.00,14,3,'Compra fusibles'),(162,'2023-09-05',2,1.00,14,3,'Reemplazo protección'),(163,'2023-04-15',1,8.00,17,4,'Compra conectores'),(164,'2024-01-05',2,3.00,17,4,'Instalación campo'),(165,'2022-10-20',1,10.00,19,4,'Compra baterías'),(166,'2023-07-12',2,4.00,19,4,'Reemplazo sistema UPS'),(167,'2023-11-25',1,6.00,22,1,'Reposición cable UTP'),(168,'2024-04-15',2,3.00,22,1,'Ampliación red datos'),(169,'2022-08-15',1,25.00,23,1,'Compra tapas cajas'),(170,'2023-05-20',2,10.00,23,1,'Instalaciones nuevas'),(171,'2025-09-08',101,50.00,1,1,'Entrada inicial de stock para prueba'),(173,'2025-09-08',101,50.00,1,1,'Entrada inicial de stock para prueba'),(174,'2025-09-08',101,50.00,1,1,'Entrada inicial de stock para prueba');
/*!40000 ALTER TABLE `Movimientos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `sincronizar_stock_movimiento` AFTER INSERT ON `Movimientos` FOR EACH ROW BEGIN
    DECLARE v_delta DECIMAL(10,2) DEFAULT 0;

    -- Determinar el signo según el código de tipo_movimiento
    IF NEW.tipo_movimiento IN (101, 104) THEN
        -- Entrada por compra o Ajuste positivo
        SET v_delta = NEW.cantidad;

    ELSEIF NEW.tipo_movimiento IN (102, 105, 106) THEN
        -- Salida por consumo, Ajuste negativo o Devolución al proveedor
        SET v_delta = -NEW.cantidad;

    ELSE
        -- Otros movimientos (ej. transferencias) no afectan stock
        SET v_delta = 0;
    END IF;

    -- Aplicar cambios si corresponde
    IF v_delta <> 0 THEN
        IF EXISTS (
            SELECT 1 FROM Stock
            WHERE id_material = NEW.id_material
              AND id_ubicacion = NEW.id_ubicacion
        ) THEN
            UPDATE Stock
            SET cantidad_actual   = COALESCE(cantidad_actual, 0) + v_delta,
                fecha_actualizacion = CURRENT_DATE()
            WHERE id_material = NEW.id_material
              AND id_ubicacion = NEW.id_ubicacion;
        ELSE
            -- Solo insertamos si el delta es positivo (no creamos stock negativo desde cero)
            IF v_delta > 0 THEN
                INSERT INTO Stock (id_material, id_ubicacion, cantidad_actual, fecha_actualizacion)
                VALUES (NEW.id_material, NEW.id_ubicacion, v_delta, CURRENT_DATE());
            END IF;
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Ordenes_Compra`
--

DROP TABLE IF EXISTS `Ordenes_Compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ordenes_Compra` (
  `id_orden` int NOT NULL AUTO_INCREMENT,
  `numero_orden` varchar(20) NOT NULL,
  `id_proveedor` int NOT NULL,
  `fecha_orden` date NOT NULL,
  `fecha_entrega_solicitada` date DEFAULT NULL,
  `id_estado` int NOT NULL DEFAULT '1',
  `total` decimal(15,2) DEFAULT '0.00',
  `observaciones` text,
  `solicitante` varchar(100) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_orden`),
  UNIQUE KEY `numero_orden` (`numero_orden`),
  KEY `id_estado` (`id_estado`),
  KEY `idx_numero_orden` (`numero_orden`),
  KEY `idx_proveedor` (`id_proveedor`),
  KEY `idx_fecha_orden` (`fecha_orden`),
  CONSTRAINT `Ordenes_Compra_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `Registro_Proveedores` (`id_proveedor`),
  CONSTRAINT `Ordenes_Compra_ibfk_2` FOREIGN KEY (`id_estado`) REFERENCES `Estados_Orden` (`id_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ordenes_Compra`
--

LOCK TABLES `Ordenes_Compra` WRITE;
/*!40000 ALTER TABLE `Ordenes_Compra` DISABLE KEYS */;
INSERT INTO `Ordenes_Compra` VALUES (1,'OC-2024-001',1,'2024-07-01','2024-07-15',2,0.00,'Materiales para mantenimiento preventivo','Juan Pérez','2025-09-02 00:21:17'),(2,'OC-2024-002',2,'2024-07-03','2024-07-20',2,0.00,'Válvulas para proyecto ampliación','María González','2025-09-02 00:21:17'),(3,'OC-2024-003',3,'2024-07-05','2024-07-12',3,0.00,'Reposición stock cañerías','Carlos Rodríguez','2025-09-02 00:21:17'),(4,'OC-2024-004',4,'2024-07-08','2024-07-25',2,0.00,'Instrumentos para nueva línea','Ana Martínez','2025-09-02 00:21:17'),(5,'OC-2024-005',5,'2024-07-10','2024-07-18',1,0.00,'Químicos para tratamiento agua','Luis Fernández','2025-09-02 00:21:17'),(6,'OC-2024-006',1,'2024-07-12','2024-07-30',2,0.00,'Materiales eléctricos urgentes','Roberto Silva','2025-09-02 00:21:17'),(7,'OC-2024-007',2,'2024-07-15','2024-08-01',1,0.00,'Válvulas de seguridad','Elena Castro','2025-09-02 00:21:17'),(8,'OC-2024-008',3,'2024-07-18','2024-08-05',2,0.00,'Tubos y accesorios','Diego Morales','2025-09-02 00:21:17');
/*!40000 ALTER TABLE `Ordenes_Compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Registro_Proveedores`
--

DROP TABLE IF EXISTS `Registro_Proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Registro_Proveedores` (
  `id_proveedor` int NOT NULL AUTO_INCREMENT,
  `razon_social` varchar(100) NOT NULL,
  `cuit` varchar(15) NOT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  `provincia` varchar(50) DEFAULT NULL,
  `tipo_pais` enum('Nacional','Extranjero') DEFAULT 'Nacional',
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `sitio_web` varchar(100) DEFAULT NULL,
  `estado` enum('Activo','Inactivo','Bloqueado') DEFAULT 'Activo',
  `fecha_alta` date DEFAULT (curdate()),
  `fecha_baja` date DEFAULT NULL,
  PRIMARY KEY (`id_proveedor`),
  UNIQUE KEY `cuit` (`cuit`),
  CONSTRAINT `chk_cuit_formato` CHECK (regexp_like(`cuit`,_utf8mb4'^[0-9]{2}-[0-9]{8}-[0-9]{1}$')),
  CONSTRAINT `chk_email_formato` CHECK ((`email` like _utf8mb4'%@%.%'))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Registro_Proveedores`
--

LOCK TABLES `Registro_Proveedores` WRITE;
/*!40000 ALTER TABLE `Registro_Proveedores` DISABLE KEYS */;
INSERT INTO `Registro_Proveedores` VALUES (1,'Electrotécnica Industrial S.A.','30-12345678-9','Av. Corrientes 1234','CABA','CABA','Nacional','011-4567-8900','ventas@electrotecnica.com.ar',NULL,'Activo','2025-09-01',NULL),(2,'Válvulas y Accesorios del Norte','30-87654321-0','Ruta 22 Km 15','Neuquén','Neuquén','Nacional','0299-456-7890','comercial@valvulasnorte.com.ar',NULL,'Activo','2025-09-01',NULL),(3,'Distribuidora de Materiales S.R.L.','30-11223344-5','Parque Industrial Oeste','Mendoza','Mendoza','Nacional','0261-789-0123','compras@dismateriales.com.ar',NULL,'Activo','2025-09-01',NULL),(4,'Instrumentos de Precisión Ltda.','30-55667788-9','Zona Franca Área 2','Bahía Blanca','Buenos Aires','Nacional','0291-234-5678','info@instrumentos.com.ar',NULL,'Activo','2025-09-01',NULL),(5,'Química Industrial del Sur','30-99887766-3','Polo Petroquímico','Comodoro Rivadavia','Chubut','Nacional','0297-345-6789','ventas@quimicasur.com.ar',NULL,'Activo','2025-09-01',NULL),(7,'Nuevos Suministros S.A.','30-12350078-9','Av. Santa Fe 1023','Buenos Aires','CABA','Nacional','011-1234-5678','ventas@nuevossuministros.com.ar','www.nuevossuministros.com.ar','Activo','2025-09-08',NULL);
/*!40000 ALTER TABLE `Registro_Proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `Reporte_Ordenes_Compra`
--

DROP TABLE IF EXISTS `Reporte_Ordenes_Compra`;
/*!50001 DROP VIEW IF EXISTS `Reporte_Ordenes_Compra`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `Reporte_Ordenes_Compra` AS SELECT 
 1 AS `Número Orden`,
 1 AS `Proveedor`,
 1 AS `Material`,
 1 AS `Cant. Solicitada`,
 1 AS `Precio Unit.`,
 1 AS `Subtotal`,
 1 AS `Cant. Recibida`,
 1 AS `Estado Recepción`,
 1 AS `Fecha Recepción`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Stock`
--

DROP TABLE IF EXISTS `Stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Stock` (
  `id_stock` int NOT NULL AUTO_INCREMENT,
  `id_material` int DEFAULT NULL,
  `id_ubicacion` int DEFAULT NULL,
  `cantidad_actual` decimal(10,2) DEFAULT NULL,
  `stock_minimo` decimal(10,2) DEFAULT NULL,
  `stock_maximo` decimal(10,2) DEFAULT NULL,
  `fecha_actualizacion` date DEFAULT NULL,
  PRIMARY KEY (`id_stock`),
  KEY `id_material` (`id_material`),
  KEY `id_ubicacion` (`id_ubicacion`),
  CONSTRAINT `Stock_ibfk_1` FOREIGN KEY (`id_material`) REFERENCES `Materiales` (`id_material`),
  CONSTRAINT `Stock_ibfk_2` FOREIGN KEY (`id_ubicacion`) REFERENCES `Ubicaciones` (`id_ubicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Stock`
--

LOCK TABLES `Stock` WRITE;
/*!40000 ALTER TABLE `Stock` DISABLE KEYS */;
INSERT INTO `Stock` VALUES (1,1,1,1300.00,500.00,2000.00,'2025-09-08'),(2,2,1,48.00,20.00,100.00,'2025-07-18'),(3,3,1,85.00,30.00,150.00,'2025-07-18'),(4,4,1,320.00,100.00,500.00,'2025-07-18'),(5,5,1,72.00,30.00,120.00,'2025-07-18'),(6,6,2,35.00,10.00,50.00,'2025-07-18'),(7,7,2,18.00,5.00,30.00,'2025-07-18'),(8,8,2,12.00,5.00,20.00,'2025-07-18'),(9,9,2,8.00,3.00,15.00,'2025-07-18'),(10,10,2,25.00,10.00,40.00,'2025-07-18'),(11,11,3,42.00,15.00,60.00,'2025-07-18'),(12,12,3,65.00,20.00,100.00,'2025-07-18'),(13,13,3,3.00,1.00,5.00,'2025-07-18'),(14,14,3,7.00,2.00,10.00,'2025-07-18'),(15,15,3,15.00,5.00,25.00,'2025-07-18'),(16,16,4,120.00,50.00,200.00,'2025-07-18'),(17,17,4,28.00,10.00,50.00,'2025-07-18'),(18,18,4,1.00,0.00,3.00,'2025-07-18'),(19,19,4,6.00,2.00,10.00,'2025-07-18'),(20,20,1,9.00,3.00,15.00,'2025-07-18'),(21,21,1,14.00,5.00,25.00,'2025-07-18'),(22,22,1,210.00,50.00,300.00,'2025-07-18'),(23,23,1,45.00,20.00,80.00,'2025-07-18'),(24,24,2,12.00,5.00,20.00,'2025-07-18'),(25,25,2,22.00,10.00,40.00,'2025-07-18'),(26,26,2,4.00,1.00,6.00,'2025-07-18'),(27,27,3,7.00,3.00,12.00,'2025-07-18'),(28,28,3,18.00,5.00,30.00,'2025-07-18'),(29,29,3,5.00,2.00,8.00,'2025-07-18'),(30,30,4,11.00,5.00,20.00,'2025-07-18'),(31,31,4,38.00,15.00,60.00,'2025-07-18'),(32,32,1,0.00,0.00,50.00,'2025-07-18'),(33,33,1,75.00,30.00,120.00,'2025-07-18'),(34,34,2,24.00,10.00,40.00,'2025-07-18'),(35,35,3,0.00,0.00,10.00,'2025-07-18'),(36,36,1,8.00,3.00,15.00,'2025-07-18'),(37,37,1,5.00,2.00,10.00,'2025-07-18'),(38,38,1,12.00,5.00,20.00,'2025-07-18'),(39,39,1,7.00,3.00,12.00,'2025-07-18'),(40,40,2,9.00,4.00,15.00,'2025-07-18'),(41,41,2,3.00,1.00,5.00,'2025-07-18'),(42,42,2,2.00,1.00,4.00,'2025-07-18'),(43,43,2,1.00,0.00,2.00,'2025-07-18'),(44,44,3,4.00,2.00,8.00,'2025-07-18'),(45,45,3,6.00,3.00,10.00,'2025-07-18'),(46,46,3,11.00,5.00,20.00,'2025-07-18'),(47,47,3,0.00,0.00,5.00,'2025-07-18'),(48,48,4,8.00,3.00,15.00,'2025-07-18'),(49,49,4,3.00,1.00,6.00,'2025-07-18'),(50,50,4,5.00,2.00,10.00,'2025-07-18'),(51,51,1,7.00,3.00,12.00,'2025-07-18'),(52,52,1,12.00,5.00,20.00,'2025-07-18'),(53,53,2,45.00,20.00,80.00,'2025-07-18'),(54,54,2,9.00,4.00,15.00,'2025-07-18'),(55,55,3,6.00,3.00,10.00,'2025-07-18'),(56,56,3,0.00,0.00,8.00,'2025-07-18'),(57,57,4,4.00,2.00,8.00,'2025-07-18'),(58,58,4,3.00,1.00,5.00,'2025-07-18'),(59,59,1,2.00,1.00,4.00,'2025-07-18'),(60,60,2,0.00,0.00,3.00,'2025-07-18'),(61,61,1,85.00,30.00,150.00,'2025-07-18'),(62,62,1,42.00,15.00,80.00,'2025-07-18'),(63,63,1,28.00,10.00,50.00,'2025-07-18'),(64,64,1,65.00,20.00,100.00,'2025-07-18'),(65,65,2,12.00,5.00,25.00,'2025-07-18'),(66,66,2,8.00,3.00,15.00,'2025-07-18'),(67,67,2,35.00,10.00,60.00,'2025-07-18'),(68,68,2,18.00,5.00,30.00,'2025-07-18'),(69,69,3,24.00,10.00,40.00,'2025-07-18'),(70,70,3,7.00,3.00,15.00,'2025-07-18'),(71,71,3,0.00,0.00,20.00,'2025-07-18'),(72,72,3,9.00,4.00,20.00,'2025-07-18'),(73,73,4,15.00,5.00,30.00,'2025-07-18'),(74,74,4,6.00,2.00,10.00,'2025-07-18'),(75,75,4,3.00,1.00,5.00,'2025-07-18'),(76,76,1,0.00,0.00,8.00,'2025-07-18'),(77,77,1,22.00,10.00,40.00,'2025-07-18'),(78,78,2,14.00,5.00,25.00,'2025-07-18'),(79,79,3,1.00,0.00,3.00,'2025-07-18'),(80,80,4,5.00,2.00,10.00,'2025-07-18'),(81,81,1,48.00,20.00,80.00,'2025-07-18'),(82,82,1,35.00,15.00,60.00,'2025-07-18'),(83,83,1,28.00,10.00,50.00,'2025-07-18'),(84,84,1,15.00,5.00,30.00,'2025-07-18'),(85,85,2,42.00,15.00,70.00,'2025-07-18'),(86,86,2,18.00,5.00,30.00,'2025-07-18'),(87,87,2,9.00,3.00,15.00,'2025-07-18'),(88,88,2,6.00,2.00,10.00,'2025-07-18'),(89,89,3,24.00,10.00,40.00,'2025-07-18'),(90,90,3,12.00,5.00,25.00,'2025-07-18'),(91,91,3,0.00,0.00,15.00,'2025-07-18'),(92,92,3,8.00,3.00,15.00,'2025-07-18'),(93,93,4,22.00,10.00,40.00,'2025-07-18'),(94,94,4,7.00,3.00,15.00,'2025-07-18'),(95,95,4,3.00,1.00,5.00,'2025-07-18'),(96,96,1,1.00,0.00,3.00,'2025-07-18'),(97,97,1,14.00,5.00,25.00,'2025-07-18'),(98,98,2,0.00,0.00,10.00,'2025-07-18'),(99,99,3,5.00,2.00,10.00,'2025-07-18'),(100,100,4,11.00,5.00,20.00,'2025-07-18'),(101,101,1,28.00,10.00,50.00,'2025-07-18'),(102,102,1,15.00,5.00,30.00,'2025-07-18'),(103,103,1,42.00,15.00,70.00,'2025-07-18'),(104,104,1,24.00,10.00,40.00,'2025-07-18'),(105,105,2,18.00,5.00,30.00,'2025-07-18'),(106,106,2,9.00,3.00,15.00,'2025-07-18'),(107,107,2,6.00,2.00,10.00,'2025-07-18'),(108,108,3,12.00,5.00,25.00,'2025-07-18'),(109,109,3,8.00,3.00,15.00,'2025-07-18'),(110,110,3,0.00,0.00,10.00,'2025-07-18'),(111,111,4,22.00,10.00,40.00,'2025-07-18'),(112,112,4,7.00,3.00,15.00,'2025-07-18'),(113,113,1,1.00,0.00,3.00,'2025-07-18'),(114,114,2,5.00,2.00,10.00,'2025-07-18'),(115,115,3,0.00,0.00,5.00,'2025-07-18'),(116,116,1,12.00,5.00,25.00,'2025-07-18'),(117,117,1,8.00,3.00,15.00,'2025-07-18'),(118,118,1,6.00,2.00,10.00,'2025-07-18'),(119,119,2,9.00,3.00,15.00,'2025-07-18'),(120,120,2,4.00,1.00,8.00,'2025-07-18'),(121,121,2,3.00,1.00,5.00,'2025-07-18'),(122,122,3,7.00,3.00,15.00,'2025-07-18'),(123,123,3,2.00,1.00,4.00,'2025-07-18'),(124,124,3,1.00,0.00,2.00,'2025-07-18'),(125,125,4,5.00,2.00,10.00,'2025-07-18'),(126,126,4,0.00,0.00,5.00,'2025-07-18'),(127,127,1,11.00,5.00,20.00,'2025-07-18'),(128,128,2,8.00,3.00,15.00,'2025-07-18'),(129,129,3,4.00,2.00,8.00,'2025-07-18'),(130,130,4,0.00,0.00,3.00,'2025-07-18'),(131,131,1,25.00,10.00,50.00,'2025-07-18'),(132,132,1,18.00,5.00,30.00,'2025-07-18'),(133,133,2,12.00,5.00,25.00,'2025-07-18'),(134,134,2,8.00,3.00,15.00,'2025-07-18'),(135,135,3,6.00,2.00,10.00,'2025-07-18'),(136,136,3,0.00,0.00,8.00,'2025-07-18'),(137,137,4,15.00,5.00,30.00,'2025-07-18'),(138,138,4,7.00,3.00,15.00,'2025-07-18'),(139,139,1,1.00,0.00,3.00,'2025-07-18'),(140,140,2,4.00,2.00,8.00,'2025-07-18'),(141,141,1,8.00,3.00,15.00,'2025-07-18'),(142,142,1,12.00,5.00,25.00,'2025-07-18'),(143,143,2,6.00,2.00,10.00,'2025-07-18'),(144,144,2,0.00,0.00,5.00,'2025-07-18'),(145,145,3,26.00,5.00,30.00,'2025-07-18'),(146,146,3,4.00,2.00,8.00,'2025-07-18'),(147,147,4,9.00,3.00,15.00,'2025-07-18'),(148,148,4,3.00,1.00,5.00,'2025-07-18'),(149,149,1,1.00,0.00,3.00,'2025-07-18'),(150,150,2,7.00,3.00,15.00,'2025-07-18');
/*!40000 ALTER TABLE `Stock` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `log_cambios_stock` AFTER UPDATE ON `Stock` FOR EACH ROW BEGIN
    IF OLD.cantidad_actual <> NEW.cantidad_actual OR OLD.id_ubicacion <> NEW.id_ubicacion THEN
        INSERT INTO Log_Stock (id_material, id_ubicacion, cantidad_anterior, cantidad_nueva, usuario)
        VALUES (NEW.id_material, NEW.id_ubicacion, OLD.cantidad_actual, NEW.cantidad_actual, USER());
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `Stock_Materiales`
--

DROP TABLE IF EXISTS `Stock_Materiales`;
/*!50001 DROP VIEW IF EXISTS `Stock_Materiales`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `Stock_Materiales` AS SELECT 
 1 AS `Nro.Material`,
 1 AS `Texto breve`,
 1 AS `Texto de compras`,
 1 AS `Stock disponible`,
 1 AS `Unidad de medida base`,
 1 AS `Sector de guarda`,
 1 AS `Ubicación física`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `Stock_Materiales_Resumen`
--

DROP TABLE IF EXISTS `Stock_Materiales_Resumen`;
/*!50001 DROP VIEW IF EXISTS `Stock_Materiales_Resumen`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `Stock_Materiales_Resumen` AS SELECT 
 1 AS `Nro.Material`,
 1 AS `Texto breve`,
 1 AS `Texto de compras`,
 1 AS `Unidad de medida base`,
 1 AS `Stock total`,
 1 AS `Ubicaciones`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Tipos_Movimiento`
--

DROP TABLE IF EXISTS `Tipos_Movimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Tipos_Movimiento` (
  `id_tipo_mov` int NOT NULL AUTO_INCREMENT,
  `descripcion_tipo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_tipo_mov`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tipos_Movimiento`
--

LOCK TABLES `Tipos_Movimiento` WRITE;
/*!40000 ALTER TABLE `Tipos_Movimiento` DISABLE KEYS */;
INSERT INTO `Tipos_Movimiento` VALUES (101,'Entrada por compra'),(102,'Salida por consumo'),(103,'Ajuste positivo'),(104,'Ajuste negativo'),(105,'Devolución al proveedor');
/*!40000 ALTER TABLE `Tipos_Movimiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ubicaciones`
--

DROP TABLE IF EXISTS `Ubicaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ubicaciones` (
  `id_ubicacion` int NOT NULL AUTO_INCREMENT,
  `nombre_ubicacion` varchar(50) DEFAULT NULL,
  `tipo_ubicacion` varchar(30) DEFAULT NULL,
  `descripcion` text,
  PRIMARY KEY (`id_ubicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ubicaciones`
--

LOCK TABLES `Ubicaciones` WRITE;
/*!40000 ALTER TABLE `Ubicaciones` DISABLE KEYS */;
INSERT INTO `Ubicaciones` VALUES (1,'Almacén CABA','Almacén','Almacén sede central CABA'),(2,'Zona Técnica - Planta Añelo','Zona','Área operativa post-venta Añelo'),(3,'Zona Técnica - Planta Neuquén','Zona','Área operativa post-venta Neuquén Capital'),(4,'Contenedor Externo 01 - Refinería Lujan de Cuyo','Contenedor','Almacén móvil Obra Revamping Topping C, Luján de Cuyo ');
/*!40000 ALTER TABLE `Ubicaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Unidades_Medida`
--

DROP TABLE IF EXISTS `Unidades_Medida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Unidades_Medida` (
  `id_unidad` varchar(10) NOT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_unidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Unidades_Medida`
--

LOCK TABLES `Unidades_Medida` WRITE;
/*!40000 ALTER TABLE `Unidades_Medida` DISABLE KEYS */;
INSERT INTO `Unidades_Medida` VALUES ('KG','Kilogramo'),('LT','Litro'),('M','Metro lineal'),('M3','Metro cúbico'),('PZA','Pieza'),('UN','Unidad');
/*!40000 ALTER TABLE `Unidades_Medida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `Vendor_Pool_List`
--

DROP TABLE IF EXISTS `Vendor_Pool_List`;
/*!50001 DROP VIEW IF EXISTS `Vendor_Pool_List`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `Vendor_Pool_List` AS SELECT 
 1 AS `Actividad`,
 1 AS `Tipo Actividad`,
 1 AS `Nivel Especialización`,
 1 AS `Criticidad`,
 1 AS `Categoría Material`,
 1 AS `ID Proveedor`,
 1 AS `Proveedor`,
 1 AS `Ciudad`,
 1 AS `Provincia`,
 1 AS `Estado Auditoria`,
 1 AS `Vencimiento Auditoria`,
 1 AS `Puntaje Promedio`,
 1 AS `Contacto Principal`,
 1 AS `Estado Proveedor`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'suminet_erp'
--

--
-- Dumping routines for database 'suminet_erp'
--
/*!50003 DROP FUNCTION IF EXISTS `calcular_rotacion_material` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calcular_rotacion_material`(
    p_id_material INT, 
    p_meses INT
) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
    DECLARE v_total_salidas DECIMAL(10,2) DEFAULT 0;
    DECLARE v_stock_promedio DECIMAL(10,2) DEFAULT 0;
    DECLARE v_rotacion DECIMAL(10,2) DEFAULT 0;
    DECLARE v_fecha_inicio DATE;
    
    -- Calcular fecha de inicio del período
    SET v_fecha_inicio = DATE_SUB(CURDATE(), INTERVAL p_meses MONTH);
    
    -- Calcular total de salidas en el período (tipo_movimiento = 2 es "Salida por consumo")
    SELECT COALESCE(SUM(cantidad), 0)
    INTO v_total_salidas
    FROM Movimientos
    WHERE id_material = p_id_material
      AND tipo_movimiento = 102
      AND fecha_movimiento >= v_fecha_inicio;
    
    -- Calcular stock promedio actual (suma de todas las ubicaciones)
    SELECT COALESCE(AVG(cantidad_actual), 0)
    INTO v_stock_promedio
    FROM Stock
    WHERE id_material = p_id_material
      AND cantidad_actual > 0;
    
    -- Si no hay stock promedio, evitar división por cero
    IF v_stock_promedio > 0 THEN
        SET v_rotacion = v_total_salidas / v_stock_promedio;
    ELSE
        SET v_rotacion = 0;
    END IF;
    
    RETURN v_rotacion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `calcular_stock_disponible` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calcular_stock_disponible`(p_id_material INT) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE v_stock_total INT;

    SELECT COALESCE(SUM(cantidad_actual), 0)
    INTO v_stock_total
    FROM Stock
    WHERE id_material = p_id_material;

    RETURN v_stock_total;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `crear_material` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_material`(
    IN p_nombre_material VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_unidad_base VARCHAR(20),
    IN p_categoria_id INT
)
BEGIN
    -- Validar si ya existe un material con el mismo nombre
    IF EXISTS (SELECT 1 FROM Materiales WHERE nombre_material = p_nombre_material) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El material ya existe en el maestro.';
    ELSE
        INSERT INTO Materiales (nombre_material, descripcion, unidad_base, id_categoria)
        VALUES (p_nombre_material, p_descripcion, p_unidad_base, p_categoria_id);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `registrar_nuevo_proveedor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `registrar_nuevo_proveedor`(
    IN p_razon_social VARCHAR(100),
    IN p_cuit VARCHAR(15),
    IN p_direccion VARCHAR(150),
    IN p_ciudad VARCHAR(50),
    IN p_provincia VARCHAR(50),
    IN p_tipo_pais ENUM('Nacional','Extranjero'),
    IN p_telefono VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_sitio_web VARCHAR(100)
)
BEGIN
    INSERT INTO Registro_Proveedores (
        razon_social, cuit, direccion, ciudad, provincia, 
        tipo_pais, telefono, email, sitio_web
    )
    VALUES (
        p_razon_social, p_cuit, p_direccion, p_ciudad, p_provincia,
        p_tipo_pais, p_telefono, p_email, p_sitio_web
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `Consulta_Materiales`
--

/*!50001 DROP VIEW IF EXISTS `Consulta_Materiales`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Consulta_Materiales` AS select `cmat`.`nombre_categoria` AS `Categoria`,`m`.`id_material` AS `Nro.Material`,`m`.`nombre_material` AS `Texto breve`,`m`.`descripcion` AS `Texto de compras`,`m`.`unidad_base` AS `Unidad de medida base` from (`Materiales` `m` join `Categorias_Materiales` `cmat` on((`m`.`id_categoria` = `cmat`.`id_categoria`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Reporte_Ordenes_Compra`
--

/*!50001 DROP VIEW IF EXISTS `Reporte_Ordenes_Compra`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Reporte_Ordenes_Compra` AS select `oc`.`numero_orden` AS `Número Orden`,`rp`.`razon_social` AS `Proveedor`,`m`.`nombre_material` AS `Material`,`doc`.`cantidad_solicitada` AS `Cant. Solicitada`,`doc`.`precio_unitario` AS `Precio Unit.`,`doc`.`subtotal` AS `Subtotal`,`doc`.`cantidad_recibida` AS `Cant. Recibida`,(case when (`doc`.`cantidad_recibida` = 0) then 'Pendiente' when (`doc`.`cantidad_recibida` < `doc`.`cantidad_solicitada`) then 'Parcial' else 'Completo' end) AS `Estado Recepción`,`doc`.`fecha_recepcion` AS `Fecha Recepción` from (((`Detalle_Orden_Compra` `doc` join `Ordenes_Compra` `oc` on((`doc`.`id_orden` = `oc`.`id_orden`))) join `Registro_Proveedores` `rp` on((`oc`.`id_proveedor` = `rp`.`id_proveedor`))) join `Materiales` `m` on((`doc`.`id_material` = `m`.`id_material`))) order by `oc`.`fecha_orden` desc,`doc`.`id_detalle` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Stock_Materiales`
--

/*!50001 DROP VIEW IF EXISTS `Stock_Materiales`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Stock_Materiales` AS select `m`.`id_material` AS `Nro.Material`,`m`.`nombre_material` AS `Texto breve`,`m`.`descripcion` AS `Texto de compras`,`s`.`cantidad_actual` AS `Stock disponible`,`m`.`unidad_base` AS `Unidad de medida base`,`u`.`tipo_ubicacion` AS `Sector de guarda`,`u`.`descripcion` AS `Ubicación física` from ((`Materiales` `m` join `Stock` `s` on((`m`.`id_material` = `s`.`id_material`))) join `Ubicaciones` `u` on((`s`.`id_ubicacion` = `u`.`id_ubicacion`))) order by `m`.`id_material` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Stock_Materiales_Resumen`
--

/*!50001 DROP VIEW IF EXISTS `Stock_Materiales_Resumen`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Stock_Materiales_Resumen` AS select `m`.`id_material` AS `Nro.Material`,`m`.`nombre_material` AS `Texto breve`,`m`.`descripcion` AS `Texto de compras`,`m`.`unidad_base` AS `Unidad de medida base`,sum(`s`.`cantidad_actual`) AS `Stock total`,group_concat(distinct concat(`u`.`tipo_ubicacion`,' - ',`u`.`descripcion`) separator '; ') AS `Ubicaciones` from ((`Materiales` `m` join `Stock` `s` on((`m`.`id_material` = `s`.`id_material`))) join `Ubicaciones` `u` on((`s`.`id_ubicacion` = `u`.`id_ubicacion`))) group by `m`.`id_material`,`m`.`nombre_material`,`m`.`descripcion`,`m`.`unidad_base` order by `m`.`id_material` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Vendor_Pool_List`
--

/*!50001 DROP VIEW IF EXISTS `Vendor_Pool_List`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Vendor_Pool_List` AS select distinct `aa`.`nombre_actividad` AS `Actividad`,`aa`.`tipo_actividad` AS `Tipo Actividad`,`aa`.`nivel_especialización` AS `Nivel Especialización`,`aa`.`criticidad` AS `Criticidad`,`cm`.`nombre_categoria` AS `Categoría Material`,`rp`.`id_proveedor` AS `ID Proveedor`,`rp`.`razon_social` AS `Proveedor`,`rp`.`ciudad` AS `Ciudad`,`rp`.`provincia` AS `Provincia`,(select `ap`.`resultado` from `Auditoria_Proveedores` `ap` where ((`ap`.`id_proveedor` = `rp`.`id_proveedor`) and (`ap`.`id_actividad` = `aa`.`id_actividad`)) order by `ap`.`fecha_auditoria` desc limit 1) AS `Estado Auditoria`,(select `ap`.`fecha_vencimiento` from `Auditoria_Proveedores` `ap` where ((`ap`.`id_proveedor` = `rp`.`id_proveedor`) and (`ap`.`id_actividad` = `aa`.`id_actividad`)) order by `ap`.`fecha_auditoria` desc limit 1) AS `Vencimiento Auditoria`,(select round(avg(`dp`.`puntaje_general`),1) from `Desempeno_Proveedores` `dp` where ((`dp`.`id_proveedor` = `rp`.`id_proveedor`) and (`dp`.`id_actividad` = `aa`.`id_actividad`))) AS `Puntaje Promedio`,(select concat(`cp`.`nombre_contacto`,' - ',`cp`.`telefono`) from `Contactos_Proveedor` `cp` where ((`cp`.`id_proveedor` = `rp`.`id_proveedor`) and (`cp`.`es_contacto_principal` = true)) limit 1) AS `Contacto Principal`,`rp`.`estado` AS `Estado Proveedor` from ((((`Registro_Proveedores` `rp` join `Auditoria_Proveedores` `ap` on((`rp`.`id_proveedor` = `ap`.`id_proveedor`))) join `Alcance_Actividad` `aa` on((`ap`.`id_actividad` = `aa`.`id_actividad`))) join `Actividad_Categoria` `ac` on((`aa`.`id_actividad` = `ac`.`id_actividad`))) join `Categorias_Materiales` `cm` on((`ac`.`id_categoria` = `cm`.`id_categoria`))) where ((`rp`.`estado` = 'Activo') and (`aa`.`estado` = 'Activo') and (`ac`.`estado` = 'Activo')) order by `cm`.`nombre_categoria`,`aa`.`criticidad` desc,`aa`.`nivel_especialización` desc,`rp`.`razon_social` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-19 19:35:25
