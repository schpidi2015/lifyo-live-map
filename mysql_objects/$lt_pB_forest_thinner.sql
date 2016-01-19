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

-- Exportiere Struktur von Prozedur lif_883350.$lt_pB_forest_thinner
DROP PROCEDURE IF EXISTS `$lt_pB_forest_thinner`;
DELIMITER //
CREATE PROCEDURE `$lt_pB_forest_thinner`(IN `in_StumpsOnly` INT, IN `in_TerID` INT)
main: BEGIN

/* ONLY ACTIVATE IF YOU ARE SURE WHAT YOU DO !!

   declare l_delPercent INT UNSIGNED default 1;
   declare l_maxCountForest INT UNSIGNED default 15000 / if(in_TerID is null,1,9);
   declare l_currCountForest INT UNSIGNED;
   declare l_currCountChars INT UNSIGNED;
   declare l_stumpsOnly INT UNSIGNED default ifnull(in_StumpsOnly,0);
   declare l_id INT UNSIGNED;
   declare l_cnt1, l_cnt2, l_cnt3 INT UNSIGNED default 0;
   declare l_rnd FLOAT;
   declare l_exitLoop BOOLEAN;
   DECLARE l_cForestPatch
	   CURSOR FOR 
	      SELECT GeoDataId 
		     FROM forest_patch fp
			 WHERE TerID = ifnull(in_TerID,TerID)
			   AND fp.TreeHealth = if(l_stumpsOnly = 1,3,fp.TreeHealth);
			 
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET l_exitLoop = TRUE;

   call $lt_p_action_log_I('$lt_pB_forest_thinner', 'start');
   
   call $lt_p_action_log_I('$lt_pB_forest_thinner', concat('filter stumpsOnly = ', l_stumpsOnly));
   call $lt_p_action_log_I('$lt_pB_forest_thinner', concat('filter TerID = ', ifnull(in_TerID,'NULL(=all)')));   
   
   deletion: begin
   
	   -- check current number of trees 
	   SELECT count(GeoDataId) 
	     FROM forest_patch fp
	    WHERE TerID = ifnull(in_TerID,TerID)
	      AND fp.TreeHealth = if(l_stumpsOnly = 1,3,fp.TreeHealth)
		  INTO l_currCountForest;
	     
	   call $lt_p_action_log_I('$lt_pB_forest_thinner', concat(round(l_currCountForest), ' found. ', 
		                                                        round(l_MaxCountForest), ' allowed.') );
		                                                        
	   -- number of trees are ok - do nothing 
	   IF l_MaxCountForest > l_currCountForest THEN
	      call $lt_p_action_log_I('$lt_pB_forest_thinner', 'existing number is in allowed range - no deletion');
	      leave deletion;
	   end if;
		                                                        
	   -- check active sessions 
	   SELECT count(CharacterID)
	     FROM $lt_v_character_log_curr_sessions lcs
	    WHERE lcs.LoginTimestamp > lcs.LogoutTimestamp
	     INTO l_currCountChars;

	   -- we have active players - do nothing 
	   IF l_currCountChars > 0 THEN
	      call $lt_p_action_log_I('$lt_pB_forest_thinner', 'still players in game - no deletion');
	      leave deletion;
	   end if;
	
      call $lt_p_action_log_I('$lt_pB_forest_thinner', concat('around ', round(l_delPercent/100*l_currCountForest),
																				  ' (~', l_delPercent, '%) will be deleted now...' ));
	   
	   -- loop all forest info 
	   OPEN l_cForestPatch;
		forest_loop: LOOP
		   -- fetch next tree 
			FETCH l_cForestPatch INTO l_id;
			-- no data found handling 
			if l_exitLoop then
			   CLOSE l_cForestPatch;
				-- commit the last changes < 1000 
				IF l_cnt2 > 0 THEN
				   commit;
			      call $lt_p_action_log_I('$lt_pB_forest_thinner', concat(l_cnt1, ' (~', round(l_cnt1/l_currCountForest*100), '%) found. ',
																							  l_cnt2, ' (total: ', l_cnt3, ') deleted') );
			   END IF;		
				leave forest_loop;   
			end if;
			set l_cnt1 = l_cnt1 + 1;
		   -- get random and check if tree needs to be deleted 
		   set l_rnd = RAND() * 100;
		   IF l_rnd <= l_delPercent THEN 
				-- delete tree and increase del counter 
		      DELETE from forest_patch where GeoDataId = l_id;
		      DELETE from forest where GeoDataId = l_id;
		      set l_cnt2 = l_cnt2 + 1;
		      set l_cnt3 = l_cnt3 + 1;
		      -- commit all 1000 changes 
		      if l_cnt2 >= 1000 then
		         commit;
			      call $lt_p_action_log_I('$lt_pB_forest_thinner', concat(l_cnt1, ' (~', round(l_cnt1/l_currCountForest*100), '%) found. ',
																							  l_cnt2, ' (total: ', l_cnt3, ') deleted') );
		         set l_cnt2 = 0;
		      end if;
	      END IF;
		END LOOP forest_loop;
	   
   end deletion;
   
   upd_terrain: begin
   
      -- correct max version per TerID in terrain entity --
	   update terrain_blocks tb
	      set tb.ForestVersion = (select max(version)
		                             from forest_patch fp
		                            where fp.TerID = tb.ID)
	    where tb.ID = ifnull(in_TerID,tb.ID);
   
   end upd_terrain;
   
   call $lt_p_action_log_I('$lt_pB_forest_thinner', 'done');
   */
	
END//
DELIMITER ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
