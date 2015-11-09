-- --------------------------------------------------------
-- Host:                         mariadb01.nitrado.net
-- Server Version:               5.5.41-MariaDB-1ubuntu0.14.04.1 - (Ubuntu)
-- Server Betriebssystem:        debian-linux-gnu
-- HeidiSQL Version:             8.3.0.4694
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Exportiere Struktur von View lif_883350.$lt_v_unmov_dur_log_parent_info
DROP VIEW IF EXISTS `$lt_v_unmov_dur_log_parent_info`;
-- Entferne temporäre Tabelle und erstelle die eigentliche View
DROP TABLE IF EXISTS `$lt_v_unmov_dur_log_parent_info`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `$lt_v_unmov_dur_log_parent_info` AS select `uo`.`ObjectTypeID` AS `ObjType`,`$lt_f_get_ObjTypeName`(`uo`.`ObjectTypeID`) AS `ObjTypName`,`$lt_f_get_ObjTypeParentID`(`uo`.`ObjectTypeID`) AS `ParentID`,`$lt_f_get_ObjTypeName`(`$lt_f_get_ObjTypeParentID`(`uo`.`ObjectTypeID`)) AS `ParentName`,`$lt_f_get_ObjTypeParentID`(`$lt_f_get_ObjTypeParentID`(`uo`.`ObjectTypeID`)) AS `GrandParentID`,`$lt_f_get_ObjTypeName`(`$lt_f_get_ObjTypeParentID`(`$lt_f_get_ObjTypeParentID`(`uo`.`ObjectTypeID`))) AS `GrandParentName`,`uod`.`LogId` AS `LogId`,`uod`.`UnmovObjID` AS `UnmovObjID`,`uod`.`Description` AS `Description`,`uod`.`DurTimestamp` AS `DurTimestamp`,`uod`.`Durability` AS `Durability`,`uod`.`CreatedDurability` AS `CreatedDurability` from (`$lt_t_unmov_obj_dur_log` `uod` join `unmovable_objects` `uo`) where (`uo`.`ID` = `uod`.`UnmovObjID`) order by `uod`.`DurTimestamp` desc;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
