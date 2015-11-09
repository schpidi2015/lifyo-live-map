-- --------------------------------------------------------
-- Host:                         95.172.92.239
-- Server Version:               5.5.43-MariaDB - mariadb.org binary distribution
-- Server Betriebssystem:        Win64
-- HeidiSQL Version:             8.3.0.4694
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Exportiere Struktur von Tabelle lif_1.$lt_t_session_log
DROP TABLE IF EXISTS `$lt_t_session_log`;
CREATE TABLE IF NOT EXISTS `$lt_t_session_log` (
  `SessionID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CharacterID` int(10) unsigned NOT NULL,
  `LoginTimestamp` timestamp NULL DEFAULT NULL,
  `MoveTimestamp` timestamp NULL DEFAULT NULL,
  `BuildTimestamp` timestamp NULL DEFAULT NULL,
  `EatTimestamp` timestamp NULL DEFAULT NULL,
  `InventoryTimestamp` timestamp NULL DEFAULT NULL,
  `SkillTimestamp` timestamp NULL DEFAULT NULL,
  `LogoutTimestamp` timestamp NULL DEFAULT NULL,
  `LastActionTimestamp` timestamp NULL DEFAULT NULL,
  KEY `$lt_t_session_log_IDX1` (`LastActionTimestamp`,`LogoutTimestamp`),
  KEY `PK` (`SessionID`),
  KEY `$lt_t_session_log_FK1` (`CharacterID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AVG_ROW_LENGTH=101;

-- Daten Export vom Benutzer nicht ausgewählt
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
