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

-- Exportiere Struktur von View lif_883350.$lt_v_unmov_obj_last_500
DROP VIEW IF EXISTS `$lt_v_unmov_obj_last_500`;
-- Entferne temporäre Tabelle und erstelle die eigentliche View
DROP TABLE IF EXISTS `$lt_v_unmov_obj_last_500`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `$lt_v_unmov_obj_last_500` AS select `uo`.`ID` AS `ID`,`uo`.`ObjectTypeID` AS `ObjectTypeID`,`$lt_f_get_ObjTypeName`(`uo`.`ObjectTypeID`) AS `ObjectTypeName`,`uo`.`TurnAngle` AS `TurnAngle`,`uo`.`RootContainerID` AS `RootContainerID`,`uo`.`Durability` AS `Durability`,`uo`.`CreatedDurability` AS `CreatedDurability`,`uo`.`IsComplete` AS `IsComplete`,`uo`.`GeoDataID` AS `GeoDataID`,`uo`.`Slope` AS `Slope`,`uo`.`OwnerID` AS `OwnerID`,`uo`.`DroppedTime` AS `DroppedTime` from `unmovable_objects` `uo` order by `uo`.`ID` desc limit 500;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
