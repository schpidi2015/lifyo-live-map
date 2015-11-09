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

-- Exportiere Struktur von Prozedur lif_1.$lt_pB_session_logout
DROP PROCEDURE IF EXISTS `$lt_pB_session_logout`;
DELIMITER //
CREATE PROCEDURE `$lt_pB_session_logout`()
BEGIN

   declare l_cnt int unsigned;

   -- call $lt_p_action_log_I('$lt_pB_auto_logout', 'start'); 
   
   /* auto-logout all characters which has to long idle time */
   UPDATE $lt_t_session_log
      SET LogoutTimestamp = LastActionTimestamp
	 WHERE LogoutTimestamp is null
	   AND LastActionTimestamp + interval 15 minute < current_timestamp;
	SELECT ROW_COUNT() into l_cnt;

	if l_cnt > 0 then
	   call $lt_p_action_log_I('$lt_pB_auto_logout', concat('Auto logout player count = ', l_cnt) );
	end if;
	
   -- call $lt_p_action_log_I('$lt_pB_auto_logout', 'done'); 

END//
DELIMITER ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
