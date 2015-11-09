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

-- Exportiere Struktur von Prozedur lif_1.$lt_p_session_log_IU
DROP PROCEDURE IF EXISTS `$lt_p_session_log_IU`;
DELIMITER //
CREATE PROCEDURE `$lt_p_session_log_IU`(IN `in_CharacterID` INT, IN `in_TimestampType` CHAR(50))
BEGIN

	declare l_SessionID INT UNSIGNED default NULL;
	declare l_currTimestamp TIMESTAMP default CURRENT_TIMESTAMP;
	declare l_notFound BOOLEAN DEFAULT 0;
   DECLARE CONTINUE HANDLER FOR 1329 SET l_notFound = 1;
   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET l_notFound = 1;  
   DECLARE CONTINUE HANDLER FOR SQLWARNING  SET l_notFound = 1;  

	/* try to find log entry */
	select SessionID
	  from $lt_t_session_log
	 where CharacterID = in_CharacterID
	   and LogoutTimestamp IS NULL
	   and LastActionTimestamp + interval 15 minute > current_timestamp
    order by SessionID DESC
	 limit 1
		into l_SessionID;
		
	/* insert if not notFound WAS RAISED, we found an OLD session or we found NO session */
	if(l_notFound or l_SessionID is null) then
		insert into $lt_t_session_log
		   ( CharacterID, 
			  LoginTimestamp, 
			  MoveTimestamp, 
			  BuildTimestamp, 
			  InventoryTimestamp,
			  EatTimestamp, 
			  SkillTimestamp, 
			  LogoutTimestamp, 
			  LastActionTimestamp )
		values
		   ( in_CharacterID, 
			  l_currTimestamp,
			  if(in_TimestampType='MOVE',l_currTimestamp,NULL),
			  if(in_TimestampType='BUILD',l_currTimestamp,NULL),
			  if(in_TimestampType='INVENTORY',l_currTimestamp,NULL),
			  if(in_TimestampType='EAT',l_currTimestamp,NULL), 
			  if(in_TimestampType='SKILL',l_currTimestamp,NULL),
			  if(in_TimestampType='LOGOUT',l_currTimestamp,NULL),
			  l_currTimestamp
			);
		-- if a new player logs in then close all OLD sessions
		call $lt_pB_session_logout();
	else
	   update $lt_t_session_log
		   set MoveTimestamp = if(in_TimestampType='MOVE',l_currTimestamp,MoveTimestamp),
				 BuildTimestamp = if(in_TimestampType='BUILD',l_currTimestamp,BuildTimestamp),
				 EatTimestamp = if(in_TimestampType='EAT',l_currTimestamp,EatTimestamp),
				 InventoryTimestamp = if(in_TimestampType='INVENTORY',l_currTimestamp,InventoryTimestamp),
				 SkillTimestamp = if(in_TimestampType='SKILL',l_currTimestamp,SkillTimestamp),
				 LogoutTimestamp = if(in_TimestampType='LOGOUT',l_currTimestamp,LogoutTimestamp),
				 LastActionTimestamp = l_currTimestamp
		 where SessionID = l_SessionID;				 		
	end if;
	
END//
DELIMITER ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
