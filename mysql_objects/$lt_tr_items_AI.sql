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

-- Exportiere Struktur von Trigger lif_1.$lt_tr_items_AI
DROP TRIGGER IF EXISTS `$lt_tr_items_AI`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `$lt_tr_items_AI` AFTER INSERT ON `items` FOR EACH ROW BEGIN
   
   declare l_ContainerObjectTypeID int unsigned;
   declare l_CharID int unsigned;
   
   /* try to find container type */
	select ObjectTypeID
	  from `containers`
	 where ID = new.ContainerID
	  into l_ContainerObjectTypeID;
	  
   if (l_ContainerObjectTypeID = 3) then -- Player Inventory
   
	   /* try to find character by its inventory */
		select ID
		  from `character`
		 where RootContainerID = new.ContainerID
		  into l_CharID;   
   
      call $lt_p_session_log_IU(l_CharID, 'INVENTORY');
      
   end if;
   
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
