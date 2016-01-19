-- --------------------------------------------------------
-- Host:                         95.172.92.239
-- Server Version:               5.5.43-MariaDB - mariadb.org binary distribution
-- Server Betriebssystem:        Win64
-- HeidiSQL Version:             8.3.0.4694
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Exportiere Struktur von Trigger lif_1.$lt_tr_unmovable_objects_BU
DROP TRIGGER IF EXISTS `$lt_tr_unmovable_objects_BU`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `$lt_tr_unmovable_objects_BU` BEFORE UPDATE ON `unmovable_objects` FOR EACH ROW BEGIN
   
   /* ONLY ACTIVATE IF YOU ARE SURE WHAT YOU DO !!

   -- here you can set how much durabilty loss of the game standard you want to take
   declare l_durabilityLossRate tinyint default 0;
   declare l_parentID int unsigned default 0;
   declare l_grandParentID int unsigned default 0;
 
   if (new.Durability <> old.Durability or new.CreatedDurability <> old.CreatedDurability) then
      -- get parent and grandparent
      set l_parentID = ifnull($lt_f_get_ObjTypeParentID(new.ObjectTypeID),0);
      set l_grandParentID = ifnull($lt_f_get_ObjTypeParentID(l_parentID),0);
      -- check if we have a processing item here
      if l_parentID in (64,65,69,70,71,454) or l_grandParentID in (64,65,69,70,71,454) then
         -- log original value
		   insert into $lt_t_unmov_obj_dur_log 
			   (UnmovObjID, DurTimestamp, Durability, CreatedDurability, Description)
		   values
			   (new.ID, current_timestamp, new.Durability, new.CreatedDurability, 'UPDATE by game engine');
			-- if game engine sets initial durability from 0 to x
			if old.Durability = 0 and new.Durability > 0 then
			   set new.durability = 50000;
            set new.CreatedDurability = 20000;
			end if;
	      -- overwrite the new durability with our reduced loss calculation
		   if new.Durability < old.Durability then
		      set new.Durability = old.Durability - round((old.Durability - new.Durability) * l_durabilityLossRate / 100);
		   end if;
		   if new.CreatedDurability < old.CreatedDurability then
		      set new.CreatedDurability = old.CreatedDurability - round((old.CreatedDurability - new.CreatedDurability) * l_durabilityLossRate / 100);
		   end if;
	      -- log new value set by trigger
		   insert into $lt_t_unmov_obj_dur_log 
			   (UnmovObjID, DurTimestamp, Durability, CreatedDurability, Description)
		   values 
			   (new.ID, current_timestamp, new.Durability, new.CreatedDurability, 'UPDATE by trigger');
      end if;
   end if;

   */

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
