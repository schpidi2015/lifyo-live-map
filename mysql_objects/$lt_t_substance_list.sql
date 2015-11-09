-- --------------------------------------------------------
-- Host:                         mariadb01.nitrado.net
-- Server Version:               5.5.43-MariaDB-1ubuntu0.14.04.2 - (Ubuntu)
-- Server Betriebssystem:        debian-linux-gnu
-- HeidiSQL Version:             8.3.0.4694
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Exportiere Struktur von Tabelle lif_883350.$lt_t_substance_list
DROP TABLE IF EXISTS `$lt_t_substance_list`;
CREATE TABLE IF NOT EXISTS `$lt_t_substance_list` (
  `ID` tinyint(3) unsigned NOT NULL,
  `Name` char(50) NOT NULL,
  `Cat1` char(10) DEFAULT NULL,
  `Cat2` char(10) DEFAULT NULL,
  `Cat3` char(10) DEFAULT NULL,
  `FlagLoose` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `FlagFertile` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Size` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `$lt_t_substance_list_IDX1` (`Cat1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Exportiere Daten aus Tabelle lif_883350.$lt_t_substance_list: ~77 rows (ungefähr)
DELETE FROM `$lt_t_substance_list`;
/*!40000 ALTER TABLE `$lt_t_substance_list` DISABLE KEYS */;
INSERT INTO `$lt_t_substance_list` (`ID`, `Name`, `Cat1`, `Cat2`, `Cat3`, `FlagLoose`, `FlagFertile`, `Size`) VALUES
	(0, 'Air', 'SPECIAL', '', '', 0, 0, 0),
	(1, 'Soil', 'SOIL', 'SOIL', '', 0, 0, 0),
	(2, 'Sand', 'FLOOR', '', '', 0, 0, 0),
	(3, 'Rock', 'ROCK', 'ROCK', '', 0, 0, 0),
	(4, 'Iron Vein', 'METAL', 'IRON', '', 0, 0, 0),
	(5, 'Gold Vein', 'METAL', 'GOLD', '', 0, 0, 0),
	(6, 'Soil Loose', 'SOIL', 'SOIL', NULL, 1, 0, 0),
	(7, 'Forest Soil', 'SOIL', 'FOREST', NULL, 0, 0, 0),
	(8, 'Forest Soil Loose', 'SOIL', 'FOREST', NULL, 1, 0, 0),
	(9, 'Steppe Soil', 'SOIL', 'STEPPE', NULL, 0, 0, 0),
	(10, 'Steppe Soil Loose', 'SOIL', 'STEPPE', NULL, 1, 0, 0),
	(11, 'Rock Fragments', 'ROCK', 'ROCK', NULL, 1, 0, 0),
	(12, 'Granite', 'ROCK', 'GRANITE', NULL, 0, 0, 0),
	(13, 'Granite Fragments', 'ROCK', 'GRANITE', NULL, 1, 0, 0),
	(14, 'Marble', 'ROCK', 'MARBLE', NULL, 0, 0, 0),
	(15, 'Marble Fragments', 'ROCK', 'MARBLE', NULL, 1, 0, 0),
	(16, 'Slate', 'ROCK', 'SLATE', NULL, 0, 0, 0),
	(17, 'Slate Fragments', 'ROCK', 'SLATE', NULL, 1, 0, 0),
	(18, 'Gold Ore', 'METAL', 'GOLD', '', 1, 0, 0),
	(19, 'Clay', 'FLOOR', NULL, NULL, 0, 0, 0),
	(20, 'Iron Ore', 'METAL', 'IRON', '', 1, 0, 0),
	(21, 'Silver Vein', 'METAL', 'SILVER', '', 0, 0, 0),
	(22, 'Silver Ore', 'METAL', 'SILVER', '', 1, 0, 0),
	(23, 'Copper Vein', 'METAL', 'COPPER', '', 0, 0, 0),
	(24, 'Copper Ore', 'METAL', 'COPPER', '', 1, 0, 0),
	(25, 'Snow', 'FLOOR', NULL, NULL, 0, 0, 0),
	(26, 'Swamp', 'FLOOR', NULL, NULL, 0, 0, 0),
	(27, 'River Rock', 'FLOOR', NULL, NULL, 0, 0, 0),
	(101, 'Fertile Wheat Small', 'FARM', 'WHEAT', NULL, 0, 1, 1),
	(102, 'Non Fertile Wheat Small', 'FARM', 'WHEAT', NULL, 0, 0, 1),
	(103, 'Fertile Wheat Normal', 'FARM', 'WHEAT', NULL, 0, 1, 2),
	(104, 'Non Fertile Wheat Normal', 'FARM', 'WHEAT', NULL, 0, 0, 2),
	(105, 'Fertile Wheat Big', 'FARM', 'WHEAT', NULL, 0, 1, 3),
	(106, 'Non Fertile Wheat Big', 'FARM', 'WHEAT', NULL, 0, 0, 3),
	(111, 'Fertile Pea Small', 'FARM', 'PEA', NULL, 0, 1, 1),
	(112, 'Non Fertile Pea Small', 'FARM', 'PEA', NULL, 0, 0, 1),
	(113, 'Fertile Pea Normal', 'FARM', 'PEA', NULL, 0, 1, 2),
	(114, 'Non Fertile Pea Normal', 'FARM', 'PEA', NULL, 0, 0, 2),
	(115, 'Fertile Pea Big', 'FARM', 'PEA', NULL, 0, 1, 3),
	(116, 'Non Fertile Pea Big', 'FARM', 'PEA', NULL, 0, 0, 3),
	(121, 'Fertile Cabbage Small', 'FARM', 'CABBAGE', NULL, 0, 1, 1),
	(122, 'Non Fertile Cabbage Small', 'FARM', 'CABBAGE', NULL, 0, 0, 1),
	(123, 'Fertile Cabbage Normal', 'FARM', 'CABBAGE', NULL, 0, 1, 2),
	(124, 'Non Fertile Cabbage Normal', 'FARM', 'CABBAGE', NULL, 0, 0, 2),
	(125, 'Fertile Cabbage Big', 'FARM', 'CABBAGE', NULL, 0, 1, 3),
	(126, 'Non Fertile Cabbage Big', 'FARM', 'CABBAGE', NULL, 0, 0, 3),
	(131, 'Fertile Onion Small', 'FARM', 'ONION', NULL, 0, 1, 1),
	(132, 'Non Fertile Onion Small', 'FARM', 'ONION', NULL, 0, 0, 1),
	(133, 'Fertile Onion Normal', 'FARM', 'ONION', NULL, 0, 1, 2),
	(134, 'Non Fertile Onion Normal', 'FARM', 'ONION', NULL, 0, 0, 2),
	(135, 'Fertile Onion Big', 'FARM', 'ONION', NULL, 0, 1, 3),
	(136, 'Non Fertile Onion Big', 'FARM', 'ONION', NULL, 0, 0, 3),
	(141, 'Fertile Carrot Small', 'FARM', 'CARROT', NULL, 0, 1, 1),
	(142, 'Non Fertile Carrot Small', 'FARM', 'CARROT', NULL, 0, 0, 1),
	(143, 'Fertile Carrot Normal', 'FARM', 'CARROT', NULL, 0, 1, 2),
	(144, 'Non Fertile Carrot Normal', 'FARM', 'CARROT', NULL, 0, 0, 2),
	(145, 'Fertile Carrot Big', 'FARM', 'CARROT', NULL, 0, 1, 3),
	(146, 'Non Fertile Carrot Big', 'FARM', 'CARROT', NULL, 0, 0, 3),
	(151, 'Fertile Flax Small', 'FARM', 'FLAX', NULL, 0, 1, 1),
	(152, 'Non Fertile Flax Small', 'FARM', 'FLAX', NULL, 0, 0, 1),
	(153, 'Fertile Flax Normal', 'FARM', 'FLAX', NULL, 0, 1, 2),
	(154, 'Non Fertile Flax Normal', 'FARM', 'FLAX', NULL, 0, 0, 2),
	(155, 'Fertile Flax Big', 'FARM', 'FLAX', NULL, 0, 1, 3),
	(156, 'Non Fertile Flax Big', 'FARM', 'FLAX', NULL, 0, 0, 3),
	(161, 'Fertile Grape Small', 'FARM', 'GRAPE', NULL, 0, 1, 1),
	(162, 'Non Fertile Grape Small', 'FARM', 'GRAPE', NULL, 0, 0, 1),
	(163, 'Fertile Grape Normal', 'FARM', 'GRAPE', NULL, 0, 1, 2),
	(164, 'Non Fertile Grape Normal', 'FARM', 'GRAPE', NULL, 0, 0, 2),
	(165, 'Fertile Grape Big', 'FARM', 'GRAPE', NULL, 0, 1, 3),
	(166, 'Non Fertile Grape Big', 'FARM', 'GRAPE', NULL, 0, 0, 3),
	(171, 'Fertile Potato Small', 'FARM', 'POTATO', NULL, 0, 1, 1),
	(172, 'Non Fertile Potato Small', 'FARM', 'POTATO', NULL, 0, 0, 1),
	(173, 'Fertile Potato Normal', 'FARM', 'POTATO', NULL, 0, 1, 2),
	(174, 'Non Fertile Potato Normal', 'FARM', 'POTATO', NULL, 0, 0, 2),
	(175, 'Fertile Potato Big', 'FARM', 'POTATO', NULL, 0, 1, 3),
	(176, 'Non Fertile Potato Big', 'FARM', 'POTATO', NULL, 0, 0, 3),
	(177, 'Stone Road', 'FOOR', NULL, NULL, 0, 0, 0);
/*!40000 ALTER TABLE `$lt_t_substance_list` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
