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

-- Exportiere Struktur von View lif_883350.$lt_v_sessions_list_hours
DROP VIEW IF EXISTS `$lt_v_sessions_list_hours`;
-- Entferne temporäre Tabelle und erstelle die eigentliche View
DROP TABLE IF EXISTS `$lt_v_sessions_list_hours`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `$lt_v_sessions_list_hours` AS select 0 AS `Hour` union select 1 AS `1` union select 2 AS `2` union select 3 AS `3` union select 4 AS `4` union select 5 AS `5` union select 6 AS `6` union select 7 AS `7` union select 8 AS `8` union select 9 AS `9` union select 10 AS `10` union select 11 AS `11` union select 12 AS `12` union select 13 AS `13` union select 14 AS `14` union select 15 AS `15` union select 16 AS `16` union select 17 AS `17` union select 18 AS `18` union select 19 AS `19` union select 20 AS `20` union select 21 AS `21` union select 22 AS `22` union select 23 AS `23`;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
