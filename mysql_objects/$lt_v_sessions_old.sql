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

-- Exportiere Struktur von View lif_883350.$lt_v_sessions_old
DROP VIEW IF EXISTS `$lt_v_sessions_old`;
-- Entferne temporäre Tabelle und erstelle die eigentliche View
DROP TABLE IF EXISTS `$lt_v_sessions_old`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `$lt_v_sessions_old` AS select `sess`.`SessionID` AS `SessionID`,`sess`.`CharacterID` AS `CharacterID`,`$lt_f_get_CharNameFull`(`sess`.`CharacterID`) AS `CharFullName`,`sess`.`LoginTimestamp` AS `LoginTimestamp`,`sess`.`MoveTimestamp` AS `MoveTimestamp`,`sess`.`BuildTimestamp` AS `BuildTimestamp`,`sess`.`EatTimestamp` AS `EatTimestamp`,`sess`.`InventoryTimestamp` AS `InventoryTimestamp`,`sess`.`SkillTimestamp` AS `SkillTimestamp`,`sess`.`LogoutTimestamp` AS `LogoutTimestamp`,`sess`.`LastActionTimestamp` AS `LastActionTimestamp`,timestampdiff(MINUTE,`sess`.`LoginTimestamp`,`sess`.`LastActionTimestamp`) AS `Duration` from `$lt_t_session_log` `sess` where (`sess`.`LogoutTimestamp` is not null) order by `sess`.`SessionID` desc;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
