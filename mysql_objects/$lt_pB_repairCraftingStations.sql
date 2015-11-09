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

-- Exportiere Struktur von Prozedur lif_883350.$lt_pB_repairCraftingStations
DROP PROCEDURE IF EXISTS `$lt_pB_repairCraftingStations`;
DELIMITER //
CREATE PROCEDURE `$lt_pB_repairCraftingStations`()
BEGIN
	UPDATE unmovable_objects     
	   SET durability = 65535, CreatedDurability = 65535
	 WHERE $lt_f_get_ObjTypeParentID(ObjectTypeID) = 64 OR $lt_f_get_ObjTypeParentID($lt_f_get_ObjTypeParentID(ObjectTypeID)) = 64;
END//
DELIMITER ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
