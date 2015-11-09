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

-- Exportiere Struktur von View lif_883350.$lt_v_sessions_by_day_char
DROP VIEW IF EXISTS `$lt_v_sessions_by_day_char`;
-- Entferne temporäre Tabelle und erstelle die eigentliche View
DROP TABLE IF EXISTS `$lt_v_sessions_by_day_char`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `$lt_v_sessions_by_day_char` AS select cast(`$lt_t_session_log`.`LoginTimestamp` as date) AS `Day`,`$lt_t_session_log`.`CharacterID` AS `CharacterID`,`$lt_f_get_CharNameFull`(`$lt_t_session_log`.`CharacterID`) AS `CharFullName` from `$lt_t_session_log` group by cast(`$lt_t_session_log`.`LoginTimestamp` as date),`$lt_t_session_log`.`CharacterID`;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
