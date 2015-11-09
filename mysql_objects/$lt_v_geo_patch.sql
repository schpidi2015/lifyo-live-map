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

-- Exportiere Struktur von View lif_883350.$lt_v_geo_patch
DROP VIEW IF EXISTS `$lt_v_geo_patch`;
-- Entferne temporäre Tabelle und erstelle die eigentliche View
DROP TABLE IF EXISTS `$lt_v_geo_patch`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `$lt_v_geo_patch` AS select `gp`.`ID` AS `ID`,`gp`.`TerID` AS `TerID`,`gp`.`Version` AS `Version`,`gp`.`ChangeIndex` AS `ChangeIndex`,`gp`.`IsServerOnly` AS `IsServerOnly`,`gp`.`Action` AS `Action`,`gp`.`GeoDataID` AS `GeoDataID`,`gp`.`Altitude` AS `Altitude`,`gp`.`Substance` AS `Substance`,`gp`.`LevelFlags` AS `LevelFlags`,`gp`.`Quantity` AS `Quantity`,`gp`.`Quality` AS `Quality`,`sl`.`Name` AS `Name`,`sl`.`Cat1` AS `Cat1`,`sl`.`Cat2` AS `Cat2`,`sl`.`Cat3` AS `Cat3`,`sl`.`FlagLoose` AS `FlagLoose`,`sl`.`FlagFertile` AS `FlagFertile`,`sl`.`Size` AS `Size` from (`geo_patch` `gp` join `$lt_t_substance_list` `sl`) where (`sl`.`ID` = `gp`.`Substance`);
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
