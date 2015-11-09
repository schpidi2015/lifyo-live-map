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

-- Exportiere Struktur von Funktion lif_883350.$lt_f_calc_Lvl_from_Alt
DROP FUNCTION IF EXISTS `$lt_f_calc_Lvl_from_Alt`;
DELIMITER //
CREATE FUNCTION `$lt_f_calc_Lvl_from_Alt`(`inAlt` INT) RETURNS tinyint(4)
BEGIN
   declare l_Alt int default inAlt - 5000;
   declare l_Lvl tinyint unsigned;
   set l_Alt = l_Alt * 2; -- more realistic -4000 up to 5600 meters
   if l_Alt > 5000 then
      set l_Lvl = 16;
   elseif l_Alt > 4000 then
      set l_Lvl = 15;
   elseif l_Alt > 3000 then
      set l_Lvl = 14;
   elseif l_Alt > 2000 then
      set l_Lvl = 13;
   elseif l_Alt > 1750 then
      set l_Lvl = 12;
   elseif l_Alt > 1500 then
      set l_Lvl = 11;
   elseif l_Alt > 1250 then
      set l_Lvl = 10;
   elseif l_Alt > 1000 then
      set l_Lvl = 9;
   elseif l_Alt > 750 then
      set l_Lvl = 8;
   elseif l_Alt > 500 then
      set l_Lvl = 7;
   elseif l_Alt > 300 then
      set l_Lvl = 6;
   elseif l_Alt > 150 then
      set l_Lvl = 5;
   elseif l_Alt > 0 then
      set l_Lvl = 4;
   elseif l_Alt > -250 then
      set l_Lvl = 3;
   elseif l_Alt > -500 then
      set l_Lvl = 2;
   else
		set l_Lvl = 1;   
   end if;   
   return l_Lvl;   
END//
DELIMITER ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
