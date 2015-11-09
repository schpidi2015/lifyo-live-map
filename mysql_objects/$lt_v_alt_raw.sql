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

-- Exportiere Struktur von View lif_883350.$lt_v_alt_raw
DROP VIEW IF EXISTS `$lt_v_alt_raw`;
-- Entferne temporäre Tabelle und erstelle die eigentliche View
DROP TABLE IF EXISTS `$lt_v_alt_raw`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `$lt_v_alt_raw` AS select `gp`.`GeoDataID` AS `GeoDataID`,`gp`.`Altitude` AS `Altitude` from `geo_patch` `gp` union select `mo`.`GeoDataID` AS `GeoDataID`,`mo`.`Altitude` AS `Altitude` from `movable_objects` `mo` union select `$lt_t_character_position_log`.`GeoID` AS `GeoID`,`$lt_t_character_position_log`.`GeoAlt` AS `GeoAlt` from `$lt_t_character_position_log` union select `$lt_t_alt_raw_import`.`GeoDataID` AS `GeoDataID`,`$lt_t_alt_raw_import`.`Altitude` AS `Altitude` from `$lt_t_alt_raw_import`;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
