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

-- Exportiere Struktur von Funktion lif_883350.$lt_f_conv_GeoID_to_CartX
DROP FUNCTION IF EXISTS `$lt_f_conv_GeoID_to_CartX`;
DELIMITER //
CREATE FUNCTION `$lt_f_conv_GeoID_to_CartX`(`in_GeoID` INT) RETURNS int(11)
    DETERMINISTIC
BEGIN

   declare l_GeoID int default in_GeoID;
   declare l_TerrainID int;
   declare l_BlockID int;
   declare l_BlockX int;
   declare l_BlockY int;
	declare l_CartX int default 0;
   declare l_CartY int default 0;
   declare l_TerWidth int default 511;
   declare l_TerIDMin int default 441;

   set l_TerrainID = (l_GeoID >> 18);
   set l_BlockID = l_TerrainID - l_TerIDMin;
   set l_BlockX = (l_GeoID & ((1 << 9) - 1));
   set l_BlockY = ((l_GeoID >> 9) & ((1 << (9)) - 1));
   set l_CartX = mod(l_BlockID-1,3)*l_TerWidth + l_BlockX;
   set l_CartY = floor((l_BlockID-1)/3)*l_TerWidth + l_BlockY;

   return l_CartX;
END//
DELIMITER ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
