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

-- Exportiere Struktur von Funktion lif_1.$lt_f_calc_dist_CartXY
DELIMITER //
CREATE FUNCTION `$lt_f_calc_dist_CartXY`(`in_x1` INT, `in_y1` INT, `in_x2` INT, `in_y2` INT) RETURNS int(11)
    DETERMINISTIC
BEGIN
   declare l_dist int;
   set l_dist = round(SQRT(pow(in_x1-in_x2,2)+pow(in_y1-in_y2,2)),2);
   return l_dist;
END//
DELIMITER ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
