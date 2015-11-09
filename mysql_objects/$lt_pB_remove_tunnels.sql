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

-- Exportiere Struktur von Prozedur lif_883350.$lt_pB_remove_tunnels
DROP PROCEDURE IF EXISTS `$lt_pB_remove_tunnels`;
DELIMITER //
CREATE PROCEDURE `$lt_pB_remove_tunnels`()
BEGIN

   declare currTerID INT DEFAULT 442;
   declare currVersion INT;
   declare currChgIdx INT;
   DECLARE currID INT;
   declare exitLoop BOOL DEFAULT FALSE;
   DECLARE l_cGeoVersion
	   CURSOR FOR 
			SELECT TerID, Version
			  FROM geo_patch fp
			 group by TerID, version
			 having count(ChangeIndex) <> Max(ChangeIndex)
			 ORDER BY TerID, Version;
   DECLARE l_cGeoChgIdx
      CURSOR FOR
			SELECT ID
			  FROM geo_patch fp
			 WHERE TerID = currTerID
			   and Version = currVersion
			 order by ChangeIndex;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET exitLoop = TRUE;
   
   -- find the tunnels
   
   -- check tunnel not in claim area?

   -- delete all tunnels
   DELETE From geo_patch where substance in (1,6);
   
   -- correct version sequence
   UPDATE geo_patch gp JOIN
       (select terid, version, (@ver := @ver + 1) as newver
        from (select distinct terid, version from geo_patch) gp2 cross join
             (select @ver := 1) vars
        order by terid, version
       ) gp2
       ON gp.version = gp2.version and gp.terid = gp2.terid
    set gp.Version = gp2.newver;
   
   -- correct change index
   OPEN l_cGeoVersion;
	loop_geo_version: LOOP

		-- fetch next row - if not found close and exit
		FETCH l_cGeoVersion INTO currTerID, currVersion;
		if exitLoop then
		   CLOSE l_cGeoVersion;
			leave loop_geo_version;   
		end if;   

		-- reset loop variables for chilc level

		set currChgIdx = 1;
		
	   -- loop all change index for the current version to correct the sequence
	   OPEN l_cGeoChgIdx;
		loop_geo_chg_idx: LOOP
		
			-- fetch next row - if not found close and exit
			FETCH l_cGeoChgIdx INTO currID;
			if exitLoop then
			   CLOSE l_cGeoChgIdx;
			        set exitLoop = FALSE;
				leave loop_geo_chg_idx;   
			end if; 
			
			-- update the current row with the corrected change index (without empty wholes)
			UPDATE geo_patch SET ChangeIndex = currChgIdx WHERE ID = currID;
			 
			-- prep next change index
			set currChgIdx = currChgIdx + 1;
			
	   END LOOP loop_geo_chg_idx;
		
	END LOOP loop_geo_version;
      
   -- write max geo version to terrain block
	update terrain_blocks tb
	set geoversion = (select max(version) from geo_patch gp where TerID = tb.ID),
	    cachedgeoversion = (select max(version) from geo_patch gp where TerID = tb.ID);

END//
DELIMITER ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
