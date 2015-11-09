-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server Version:               5.5.39-MariaDB - mariadb.org binary distribution
-- Server Betriebssystem:        Win64
-- HeidiSQL Version:             8.3.0.4694
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Exportiere Struktur von View lif_1.$lt_v_char_items
-- Entferne temporäre Tabelle und erstelle die eigentliche View
DROP TABLE IF EXISTS `$lt_v_char_items`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `$lt_v_char_items` AS select `c`.`ID` AS `CharID`,`c`.`Name` AS `Name`,`c`.`LastName` AS `LastName`,`$lt_f_get_ObjTypeName`(`i`.`ObjectTypeID`) AS `ItemName`,`i`.`ID` AS `ID`,`i`.`ContainerID` AS `ContainerID`,`i`.`ObjectTypeID` AS `ObjectTypeID`,`i`.`Quality` AS `Quality`,`i`.`Quantity` AS `Quantity`,`i`.`Durability` AS `Durability`,`i`.`CreatedDurability` AS `CreatedDurability`,`i`.`FeatureID` AS `FeatureID` from ((`items` `i` join `containers` `cont`) join `character` `c`) where ((`i`.`ContainerID` = `cont`.`ID`) and (`cont`.`ID` = `c`.`RootContainerID`) and (`cont`.`ObjectTypeID` = 3));
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
