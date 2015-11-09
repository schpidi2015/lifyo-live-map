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

-- Exportiere Struktur von View lif_1.$lt_v_objects_types
-- Entferne temporäre Tabelle und erstelle die eigentliche View
DROP TABLE IF EXISTS `$lt_v_objects_types`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `$lt_v_objects_types` AS select `ot1`.`ID` AS `ID`,`ot1`.`Name` AS `Name`,ifnull(`ot1`.`ParentID`,0) AS `ParentID`,ifnull((select `ot2`.`Name` from `objects_types` `ot2` where (`ot2`.`ID` = `ot1`.`ParentID`)),'ROOT') AS `ParentName`,(select count(`ot2`.`ID`) from `objects_types` `ot2` where (`ot2`.`ParentID` = `ot1`.`ID`)) AS `NoOfChildren`,(select count(`ot2`.`ID`) from `objects_types` `ot2` where (`ot2`.`ParentID` = `ot1`.`ParentID`)) AS `NoOfSiblings`,(select count(`rec`.`ID`) from `recipe` `rec` where (`rec`.`ResultObjectTypeID` = `ot1`.`ID`)) AS `NoOfRecipes`,(select count(`rr`.`ID`) from (`recipe` `rec` join `recipe_requirement` `rr`) where ((`rr`.`RecipeID` = `rec`.`ID`) and (`rec`.`ResultObjectTypeID` = `ot1`.`ID`))) AS `NoOfComponents`,(select count(`rr`.`ID`) from `recipe_requirement` `rr` where (`rr`.`MaterialObjectTypeID` = `ot1`.`ID`)) AS `NoOfUsages`,`ot1`.`UnitWeight` AS `UnitWeight`,`ot1`.`FaceImage` AS `FaceImage` from `objects_types` `ot1`;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
