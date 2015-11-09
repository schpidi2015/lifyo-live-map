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

-- Exportiere Struktur von Tabelle lif_883350.$lt_t_unmov_obj_dur_log
DROP TABLE IF EXISTS `$lt_t_unmov_obj_dur_log`;
CREATE TABLE IF NOT EXISTS `$lt_t_unmov_obj_dur_log` (
  `LogId` int(11) NOT NULL AUTO_INCREMENT,
  `UnmovObjID` int(10) unsigned NOT NULL,
  `Description` char(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DurTimestamp` timestamp NULL DEFAULT NULL,
  `Durability` int(11) DEFAULT NULL,
  `CreatedDurability` int(11) DEFAULT NULL,
  PRIMARY KEY (`LogId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AVG_ROW_LENGTH=1638;

-- Daten Export vom Benutzer nicht ausgewählt
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
