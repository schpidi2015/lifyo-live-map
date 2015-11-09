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

-- Exportiere Struktur von View lif_883350.$lt_v_coords_guild_lands
DROP VIEW IF EXISTS `$lt_v_coords_guild_lands`;
-- Entferne temporäre Tabelle und erstelle die eigentliche View
DROP TABLE IF EXISTS `$lt_v_coords_guild_lands`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `$lt_v_coords_guild_lands` AS select 'gl' AS `Source`,`gl`.`ID` AS `ID`,`g`.`Name` AS `Name`,`g`.`GuildTypeID` AS `TypeID`,`gl`.`CenterGeoID` AS `CenterGeoID`,`$lt_f_conv_GeoID_to_CartX`(`gl`.`CenterGeoID`) AS `PosX`,`$lt_f_conv_GeoID_to_CartY`(`gl`.`CenterGeoID`) AS `PosY`,`gl`.`Radius` AS `Radius` from ((`guild_lands` `gl` join `guilds` `g`) join `guild_types` `gt`) where ((`gl`.`GuildID` = `g`.`ID`) and (`gt`.`ID` = `g`.`GuildTypeID`));
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
