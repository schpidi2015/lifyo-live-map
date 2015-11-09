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

-- Exportiere Struktur von Funktion lif_1.$lt_f_conv_CartXY_to_GeoID
DELIMITER //
CREATE FUNCTION `$lt_f_conv_CartXY_to_GeoID`(`in_x` INT, `in_y` INT) RETURNS int(11)
    DETERMINISTIC
BEGIN
   
	declare l_CartX int default in_x;
   declare l_CartY int default in_y;
   declare l_BlockID int; 
   declare l_BlockX int; 
   declare l_BlockY int; 
   declare l_TerainID int; 
   declare l_GeoID int; 
   declare l_TerWidth int default 511;
   declare l_TerIDMin int default 441;
	
	set l_BlockID = ceil(l_CartX/l_TerWidth) + (ceil(l_CartY/l_TerWidth)-1) * 3;
	set l_BlockX = mod(l_CartX,l_TerWidth);
	set l_BlockY = mod(l_CartY,l_TerWidth);
	set l_TerainID = l_BlockID + l_TerIDMin;
	set l_GeoID = ((l_TerainID << 18) | (l_BlockY << 9) | l_BlockX);
	
	return l_GeoID;

END//
DELIMITER ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
