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

-- Exportiere Struktur von View lif_883350.$lt_v_sessions_by_day_hour
DROP VIEW IF EXISTS `$lt_v_sessions_by_day_hour`;
-- Entferne temporäre Tabelle und erstelle die eigentliche View
DROP TABLE IF EXISTS `$lt_v_sessions_by_day_hour`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `$lt_v_sessions_by_day_hour` AS select `days`.`Day` AS `Day`,`hours`.`Hour` AS `Hour`,(`days`.`Day` + interval `hours`.`Hour` hour) AS `DayHourStart`,(((`days`.`Day` + interval `hours`.`Hour` hour) + interval 59 minute) + interval 59 second) AS `DayHourEnd`,(select count(`sl`.`SessionID`) from `$lt_t_session_log` `sl` where ((`sl`.`LoginTimestamp` between (`days`.`Day` + interval `hours`.`Hour` hour) and (((`days`.`Day` + interval `hours`.`Hour` hour) + interval 59 minute) + interval 59 second)) or (`sl`.`LastActionTimestamp` between (`days`.`Day` + interval `hours`.`Hour` hour) and (((`days`.`Day` + interval `hours`.`Hour` hour) + interval 59 minute) + interval 59 second)) or ((`days`.`Day` + interval `hours`.`Hour` hour) between `sl`.`LoginTimestamp` and `sl`.`LastActionTimestamp`) or ((((`days`.`Day` + interval `hours`.`Hour` hour) + interval 59 minute) + interval 59 second) between `sl`.`LoginTimestamp` and `sl`.`LastActionTimestamp`))) AS `SessionCount` from (`$lt_v_sessions_list_days` `days` join `$lt_v_sessions_list_hours` `hours`) group by `days`.`Day`,`hours`.`Hour`;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
