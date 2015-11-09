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

-- Exportiere Struktur von Tabelle lif_883350.$lt_t_character_position_log
DROP TABLE IF EXISTS `$lt_t_character_position_log`;
CREATE TABLE IF NOT EXISTS `$lt_t_character_position_log` (
  `CharacterID` int(10) unsigned NOT NULL,
  `MoveTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `GeoID` int(10) unsigned NOT NULL,
  `GeoAlt` smallint(5) NOT NULL,
  PRIMARY KEY (`CharacterID`,`MoveTimestamp`),
  CONSTRAINT `$lt_t_character_position_log_FK1` FOREIGN KEY (`CharacterID`) REFERENCES `character` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AVG_ROW_LENGTH=57;

-- Daten Export vom Benutzer nicht ausgewählt
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
