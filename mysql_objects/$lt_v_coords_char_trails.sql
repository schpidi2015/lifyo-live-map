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

-- Exportiere Struktur von View lif_883350.$lt_v_coords_char_trails
DROP VIEW IF EXISTS `$lt_v_coords_char_trails`;
-- Entferne temporäre Tabelle und erstelle die eigentliche View
DROP TABLE IF EXISTS `$lt_v_coords_char_trails`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `$lt_v_coords_char_trails` AS select 'ct' AS `Source`,`cpl`.`CharacterID` AS `ID`,`cpl`.`MoveTimestamp` AS `MoveTimestamp`,`$lt_f_get_CharNameFull`(`cpl`.`CharacterID`) AS `Name`,`cpl`.`GeoID` AS `GeoID`,`$lt_f_conv_GeoID_to_CartX`(`cpl`.`GeoID`) AS `PosX`,`$lt_f_conv_GeoID_to_CartY`(`cpl`.`GeoID`) AS `PosY` from `$lt_t_character_position_log` `cpl` order by `cpl`.`CharacterID`,`cpl`.`MoveTimestamp` desc;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
