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

-- Exportiere Struktur von View lif_883350.$lt_v_dist_char_obj
DROP VIEW IF EXISTS `$lt_v_dist_char_obj`;
-- Entferne temporäre Tabelle und erstelle die eigentliche View
DROP TABLE IF EXISTS `$lt_v_dist_char_obj`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `$lt_v_dist_char_obj` AS select `c`.`ID` AS `CharID`,`c`.`Name` AS `Name`,`c`.`LastName` AS `LastName`,`uo`.`ID` AS `ObjID`,`uo`.`ObjectTypeID` AS `ObjectTypeID`,`$lt_f_get_ObjTypeName`(`uo`.`ObjectTypeID`) AS `ObjTypeName`,`$lt_f_calc_dist_GeoID`(`c`.`GeoID`,`uo`.`GeoDataID`) AS `Dist` from ((`$lt_v_unmov_obj_last_050` `uo` join `$lt_v_sessions_curr` `sc`) join `character` `c`) where (`sc`.`CharacterID` = `c`.`ID`);
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
