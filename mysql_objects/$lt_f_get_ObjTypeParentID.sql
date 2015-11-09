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

-- Exportiere Struktur von Funktion lif_883350.$lt_f_get_ObjTypeParentID
DROP FUNCTION IF EXISTS `$lt_f_get_ObjTypeParentID`;
DELIMITER //
CREATE FUNCTION `$lt_f_get_ObjTypeParentID`(`in_ObjTypeID` INT) RETURNS int(11)
BEGIN
   declare l_result int unsigned;
	declare l_Dummy INT;
   DECLARE continue HANDLER FOR 1329 SET l_Dummy = 1;
   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET l_Dummy = 1;  
   DECLARE CONTINUE HANDLER FOR SQLWARNING  SET l_Dummy = 1;  
   SELECT ParentID
     FROM objects_types ot
    WHERE ot.ID = in_ObjTypeID
     into l_result;
   return l_result;
END//
DELIMITER ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
