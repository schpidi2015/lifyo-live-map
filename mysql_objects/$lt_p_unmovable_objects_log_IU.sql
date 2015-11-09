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

-- Exportiere Struktur von Prozedur lif_950292.$lt_p_unmovable_objects_log_IU
DROP PROCEDURE IF EXISTS `$lt_p_unmovable_objects_log_IU`;
DELIMITER //
CREATE PROCEDURE `$lt_p_unmovable_objects_log_IU`(IN `in_UnmovableObjectID` INT, IN `in_GeoDataID` INT, IN `in_TimestampType` CHAR(50))
main: BEGIN

	declare l_unmovableObjectID INT UNSIGNED default NULL;
	declare l_currTimestamp TIMESTAMP default CURRENT_TIMESTAMP;
	declare l_charID INT UNSIGNED default NULL;
	declare l_Dummy INT;
   DECLARE continue HANDLER FOR 1329 SET l_Dummy = 1;
   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET l_Dummy = 1;  
   DECLARE CONTINUE HANDLER FOR SQLWARNING  SET l_Dummy = 1;  
   
	-- try to find correct player 
	select dco.CharID
     from $lt_v_dist_char_obj dco
    where ObjID = in_UnmovableObjectID 
      and dist < 500 
    order by dist asc
    limit 1
     into l_charID;

   if l_charID is null then
      leave main;
   end if;
   
	/* try to find log entry */
	select UnmovableObjectID
	  from $lt_t_unmovable_objects_log
	 where UnmovableObjectID = in_UnmovableObjectID
		into l_unmovableObjectID;
		
	/* insert if not exist */
	if(l_unmovableObjectID is null) then
		insert into $lt_t_unmovable_objects_log
		   ( UnmovableObjectID, 
			  CreatedTimestamp, 
			  CreatorCharID )
		values
		   ( in_UnmovableObjectID, 
			  l_currTimestamp,
			  l_charID );
	else
	   update $lt_t_unmovable_objects_log
		   set CompletedTimestamp = if(in_TimestampType='COMPLETE',l_currTimestamp,CompletedTimestamp),
				 CompleterCharID = if(in_TimestampType='COMPLETE',l_charID,CompleterCharID),
				 CompletingDuration = if(in_TimestampType='COMPLETE',timestampdiff(second,CreatedTimestamp,CompletedTimestamp),CompletingDuration),
				 RemovedTimestamp = if(in_TimestampType='REMOVE',l_currTimestamp,RemovedTimestamp),
				 RemoverCharID = if(in_TimestampType='REMOVE',l_charID,RemoverCharID)
		 where UnmovableObjectID = l_unmovableObjectID;				 		
	end if;
	
   call $lt_p_session_log_IU(l_charID, 'BUILD');
		
END main//
DELIMITER ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
