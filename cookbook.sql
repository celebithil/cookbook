-- MySQL dump 10.13  Distrib 5.5.28, for Linux (x86_64)
--
-- Host: localhost    Database: cookbook
-- ------------------------------------------------------
-- Server version	5.5.28-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `recipes`
--

DROP TABLE IF EXISTS `recipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipes` (
  `recipe_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `recipe_name` varchar(100) DEFAULT NULL,
  `type_id` bigint(20) unsigned NOT NULL,
  `recipe` text,
  PRIMARY KEY (`recipe_id`),
  UNIQUE KEY `dish_id` (`recipe_id`),
  UNIQUE KEY `recipe_id` (`recipe_id`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `recipes_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `types` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipes`
--

LOCK TABLES `recipes` WRITE;
/*!40000 ALTER TABLE `recipes` DISABLE KEYS */;
INSERT INTO `recipes` VALUES (1,'Суп',1,'варим суп	  	  '),(2,'Котлета',2,'жарим котлету	  	  '),(3,'Арбуз',3,'режем арбуз	  '),(4,'Салат с маринованными опятами',4,'Ингредиенты:\r<br> 2 картофелины,\r<br> 1 морковь,\r<br> 5-7 перышек зеленого лука,\r<br> 50 г маринованных опят,\r<br> 50 г квашеной капусты,\r<br> растительное масло,\r<br> соль по вкусу.\r<br>\r<br>Приготовление:\r<br> Картофель и морковь отварить, почистить и нарезать кубиками. смешать в миске готовые овощи. Добавить грибы, квашеную капусту. Заправить салат маслом и перемешать. Посолить по вкусу. Выложить в салатник и посыпать нашинкованным зеленым луком.	  	  	  	  '),(5,'Салат с красной капустой',4,'Салат с красной капустой<br><br>Ингредиенты:<br> 150 г красной капусты,<br> 1 свежий огурец,<br> 1 морковь,<br> 1 луковица,<br> 2 ст. ложки растительного масла,<br> 1 ст. ложка соевого соуса,<br> 1/2 ч. ложки сахара,<br> 1 ч. ложка лимонного сока.<br><br>Приготовление:<br>Капусту нашинковать. Добавить соломкой порезанный огурец и тертую морковь.<br>Добавить лук порезанный полукольцами. Все перемешать. Добавить сахар, соевый соус, масло, сок лимона. Хорошо перемешать и дать настояться 30 минут.'),(6,'Салат из свёклы «Любимый»',4,'Салат из свёклы «Любимый»\r<br>\r<br>Ингредиенты:\r<br> 2 свёклы,\r<br> 2 моркови,\r<br> 100 г белого изюма,\r<br> 4 яйца,\r<br> 100 г сыра,\r<br> 2 зубчика чеснока,\r<br> майонез,\r<br> соль по вкусу.\r<br>\r<br>Приготовление:\r<br> Свёклу завернуть в фольгу и запечь в духовке до готовности. Остудить и очистить. Натереть на терке. Морковь очистить и натереть. Яйца отварить и натереть. Изюм замочить в теплой воде. Сыр натереть и смешать с майонезом и прессованным чесноком. Форму застелить пищевой пленкой выложить слой свеклы и промазать майонезом. Слой моркови и майонез. Слой сыра с чесноком, слой тертых яиц с майонезом. Слой изюма. Повторяем слой свеклы с майонезом. Слой моркови с майонезом и слой сыра, последним выкладываем слой яиц.\r<br>Даем настояться 2-3 часа в холодильнике и переворачиваем формочку на сервировочное блюдо.\r<br>Аккуратно убираем пищевую пленку и украшаем по желанию.	    '),(7,'Салат с помидорами и маслинами  ',4,'Салат с помидорами и маслинами<br><br><br><br>Ингредиенты:<br> 3 спелых помидора,<br> 8 маслин,<br> 1 луковица,<br> 2 ст. ложки растительного масла,<br> соль, перец по вкусу.<br><br>Приготовление:<br> Помидоры порезать ломтиками, маслины порезать на половинки.<br><br><br><br>Добавить лук порезанный полукольцами.<br><br><br><br>Посолить и поперчить. Заправить маслом и перемешать.<br><br><br><br>Выложить в салатницу и украсить листиками петрушки.'),(8,'Салат со стручковой фасолью и морковью',4,'Салат со стручковой фасолью и морковью<br><br>Ингредиенты:<br> 200 г стручковой фасоли (заморозка),<br> 1 крупная морковка,<br> 2 ст. ложки яблочного уксуса,<br> кунжут,<br> паприка,<br> растительное масло,<br> соль.<br><br>Приготовление:<br> Морковь натереть на терке, добавить паприку, немного соли и уксус. Хорошо помять руками. Дать постоять 30 минут.<br>Обжарить на растительном масле фасоль до готовности. При необходимости добавить немного воды. Остудить.<br>Перемешать в миске фасоль и морковь. Посолить по желанию.<br>Выложить в салатницу и украсить веточкой зелени. Посыпать сверху кунжутом.');
/*!40000 ALTER TABLE `recipes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `types`
--

DROP TABLE IF EXISTS `types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `types` (
  `type_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`type_id`),
  UNIQUE KEY `type_id` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `types`
--

LOCK TABLES `types` WRITE;
/*!40000 ALTER TABLE `types` DISABLE KEYS */;
INSERT INTO `types` VALUES (1,'первое'),(2,'второе'),(3,'десерт'),(4,'закуски');
/*!40000 ALTER TABLE `types` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-11-18 19:36:53
