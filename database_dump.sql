-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.44 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.15.0.7171
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for parking_machine_management_system
CREATE DATABASE IF NOT EXISTS `parking_machine_management_system` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `parking_machine_management_system`;

-- Dumping structure for table parking_machine_management_system.cash_collection
CREATE TABLE IF NOT EXISTS `cash_collection` (
  `CashCollectionID` int unsigned NOT NULL AUTO_INCREMENT,
  `MachineLocationID` int unsigned NOT NULL,
  `CashCollector` int unsigned NOT NULL,
  `Amount` decimal(8,2) unsigned NOT NULL DEFAULT (0),
  `Timestamp` datetime NOT NULL,
  `Completed` tinyint unsigned NOT NULL DEFAULT (0),
  PRIMARY KEY (`CashCollectionID`),
  KEY `CashCollection_MachineLocationID` (`MachineLocationID`),
  KEY `CashCollector_User` (`CashCollector`),
  CONSTRAINT `CashCollection_MachineLocationID` FOREIGN KEY (`MachineLocationID`) REFERENCES `machine_location` (`MachineLocationID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `CashCollector_User` FOREIGN KEY (`CashCollector`) REFERENCES `users` (`UserID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Completed` CHECK ((`Completed` in (0,1))),
  CONSTRAINT `NotCompleted,NoAmount` CHECK (((`Completed` <> 0) or (`Amount` <= 0)))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table parking_machine_management_system.cash_collection: ~6 rows (approximately)
INSERT INTO `cash_collection` (`CashCollectionID`, `MachineLocationID`, `CashCollector`, `Amount`, `Timestamp`, `Completed`) VALUES
	(1, 11, 9, 234.65, '2026-03-04 11:23:59', 1),
	(2, 53, 9, 0.00, '2026-03-04 11:28:44', 0),
	(3, 109, 9, 500.00, '2026-03-04 10:00:00', 1),
	(4, 110, 9, 465.00, '2026-03-04 10:23:32', 1),
	(5, 109, 9, 568.00, '2026-02-10 16:55:14', 1),
	(6, 110, 9, 345.00, '2026-02-10 16:59:17', 1);

-- Dumping structure for table parking_machine_management_system.issue
CREATE TABLE IF NOT EXISTS `issue` (
  `IssueID` int unsigned NOT NULL AUTO_INCREMENT,
  `DeploymentID` int unsigned NOT NULL,
  `UserID` int unsigned NOT NULL,
  `IssueType` enum('Fault','Vandalism','Other') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Description` varchar(500) DEFAULT NULL,
  `Severity` enum('Cosmetic','Partly operational','OOO','Other') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Timestamp` datetime NOT NULL,
  `Status` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`IssueID`),
  KEY `Issue_DeploymentID` (`DeploymentID`),
  KEY `Issue_UserID` (`UserID`),
  CONSTRAINT `Issue_DeploymentID` FOREIGN KEY (`DeploymentID`) REFERENCES `machine_deployment` (`DeploymentID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Issue_UserID` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Status` CHECK ((`Status` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table parking_machine_management_system.issue: ~3 rows (approximately)
INSERT INTO `issue` (`IssueID`, `DeploymentID`, `UserID`, `IssueType`, `Description`, `Severity`, `Timestamp`, `Status`) VALUES
	(1, 48, 9, 'Fault', 'Machine failed to enter cashcollection mode', 'Partly operational', '2026-03-04 11:30:40', 0),
	(2, 6, 2, 'Fault', 'Machine not accepting coins, card payment working', 'Partly operational', '2026-02-04 12:45:07', 1),
	(3, 6, 1, 'Vandalism', 'Grafitti on the side of machine', 'Cosmetic', '2026-03-01 09:55:57', 0);

-- Dumping structure for table parking_machine_management_system.issue_image
CREATE TABLE IF NOT EXISTS `issue_image` (
  `ImageID` int unsigned NOT NULL,
  `IssueID` int unsigned NOT NULL,
  `OriginalFileName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `URLPath` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `FileType` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`ImageID`),
  KEY `IssueImage_IssueID` (`IssueID`),
  CONSTRAINT `IssueImage_IssueID` FOREIGN KEY (`IssueID`) REFERENCES `issue` (`IssueID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table parking_machine_management_system.issue_image: ~0 rows (approximately)

-- Dumping structure for table parking_machine_management_system.machine
CREATE TABLE IF NOT EXISTS `machine` (
  `MachineID` int unsigned NOT NULL AUTO_INCREMENT,
  `ConfigID` int unsigned NOT NULL,
  PRIMARY KEY (`MachineID`),
  KEY `MachineConfig` (`ConfigID`),
  CONSTRAINT `MachineConfig` FOREIGN KEY (`ConfigID`) REFERENCES `machine_config` (`ConfigID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table parking_machine_management_system.machine: ~52 rows (approximately)
INSERT INTO `machine` (`MachineID`, `ConfigID`) VALUES
	(1, 6),
	(2, 7),
	(3, 7),
	(4, 7),
	(5, 6),
	(6, 3),
	(9, 7),
	(10, 2),
	(11, 1),
	(12, 1),
	(13, 2),
	(14, 1),
	(15, 2),
	(16, 2),
	(17, 1),
	(18, 3),
	(19, 2),
	(20, 1),
	(21, 2),
	(22, 3),
	(23, 2),
	(24, 3),
	(25, 2),
	(26, 2),
	(27, 1),
	(28, 1),
	(29, 1),
	(30, 3),
	(31, 3),
	(32, 2),
	(33, 1),
	(34, 1),
	(35, 1),
	(36, 2),
	(37, 3),
	(38, 6),
	(40, 5),
	(41, 7),
	(42, 2),
	(43, 6),
	(44, 7),
	(45, 3),
	(46, 7),
	(47, 3),
	(48, 7),
	(51, 3),
	(52, 2),
	(53, 7),
	(54, 2),
	(55, 2),
	(56, 3),
	(57, 3),
	(58, 3),
	(109, 3),
	(110, 3);

-- Dumping structure for table parking_machine_management_system.machine_config
CREATE TABLE IF NOT EXISTS `machine_config` (
  `ConfigID` int unsigned NOT NULL AUTO_INCREMENT,
  `MachineModel` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `MachineMake` varchar(50) NOT NULL,
  `Networked` tinyint unsigned NOT NULL COMMENT 'Whether the machine is Networked',
  `NetworkFreq` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Network Frequency of the machine, if networked',
  PRIMARY KEY (`ConfigID`),
  CONSTRAINT `Networked` CHECK ((`Networked` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table parking_machine_management_system.machine_config: ~8 rows (approximately)
INSERT INTO `machine_config` (`ConfigID`, `MachineModel`, `MachineMake`, `Networked`, `NetworkFreq`) VALUES
	(1, 'Evo 1', 'Strada', 1, '4G'),
	(2, 'Evo 2', 'Strada', 1, '4G'),
	(3, 'Evo 3', 'Strada', 1, '5G'),
	(4, 'Frib', 'Strada', 0, NULL),
	(5, 'Mk1', 'Stelio', 0, NULL),
	(6, 'Evo 1', 'Strada', 0, NULL),
	(7, 'Evo 2', 'Strada', 0, NULL),
	(8, 'Evo 3', 'Strada', 0, NULL);

-- Dumping structure for table parking_machine_management_system.machine_deployment
CREATE TABLE IF NOT EXISTS `machine_deployment` (
  `DeploymentID` int unsigned NOT NULL AUTO_INCREMENT,
  `MachineID` int unsigned NOT NULL DEFAULT '0',
  `MachineLocationID` int unsigned NOT NULL DEFAULT '0',
  `StartDate` date NOT NULL COMMENT 'Installation date',
  `EndDate` date DEFAULT NULL COMMENT 'Date machine removed from location',
  PRIMARY KEY (`DeploymentID`),
  KEY `MachineLocationID` (`MachineLocationID`),
  KEY `Deployment_MachineID` (`MachineID`),
  CONSTRAINT `Deployment_MachineID` FOREIGN KEY (`MachineID`) REFERENCES `machine` (`MachineID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Deployment_MachineLocationID` FOREIGN KEY (`MachineLocationID`) REFERENCES `machine_location` (`MachineLocationID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `EndDate>StartDate` CHECK (((`EndDate` is null) or (`EndDate` > `StartDate`)))
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table parking_machine_management_system.machine_deployment: ~55 rows (approximately)
INSERT INTO `machine_deployment` (`DeploymentID`, `MachineID`, `MachineLocationID`, `StartDate`, `EndDate`) VALUES
	(1, 1, 1, '2011-02-22', NULL),
	(2, 2, 2, '2011-02-18', NULL),
	(3, 3, 3, '2011-02-18', NULL),
	(4, 4, 4, '2015-11-06', NULL),
	(5, 5, 5, '2016-06-01', NULL),
	(6, 6, 6, '2010-01-20', NULL),
	(7, 9, 9, '2024-05-02', NULL),
	(8, 10, 10, '2011-02-22', NULL),
	(9, 11, 11, '2009-01-14', NULL),
	(10, 12, 12, '2009-01-15', NULL),
	(11, 13, 13, '2009-01-15', NULL),
	(12, 14, 14, '2010-01-20', NULL),
	(13, 15, 15, '2010-01-20', NULL),
	(14, 16, 16, '2011-02-22', NULL),
	(15, 17, 17, '2010-01-20', NULL),
	(16, 18, 18, '2024-05-02', NULL),
	(17, 19, 19, '2016-06-01', NULL),
	(18, 20, 20, '2008-11-25', NULL),
	(19, 21, 21, '2019-02-15', NULL),
	(20, 22, 22, '2024-05-02', NULL),
	(21, 23, 23, '2015-11-06', NULL),
	(22, 24, 24, '2023-08-02', NULL),
	(23, 25, 25, '2011-02-18', NULL),
	(24, 26, 26, '2015-11-06', NULL),
	(25, 27, 27, '2019-04-01', NULL),
	(26, 28, 28, '2009-01-14', NULL),
	(27, 29, 29, '2009-01-14', NULL),
	(28, 30, 30, '2023-05-04', NULL),
	(29, 31, 31, '2023-05-04', NULL),
	(30, 32, 32, '2011-02-22', NULL),
	(31, 33, 33, '2019-04-01', NULL),
	(32, 34, 34, '2009-01-15', NULL),
	(33, 35, 35, '2010-01-21', NULL),
	(34, 36, 36, '2011-02-18', NULL),
	(35, 37, 37, '2024-05-02', NULL),
	(36, 38, 38, '2009-01-15', NULL),
	(37, 40, 40, '2007-01-25', NULL),
	(38, 41, 41, '2011-11-01', NULL),
	(39, 42, 42, '2011-02-18', NULL),
	(40, 43, 43, '2011-02-18', NULL),
	(41, 44, 44, '2011-10-31', NULL),
	(42, 45, 45, '2022-07-21', NULL),
	(43, 46, 46, '2011-10-31', NULL),
	(44, 47, 47, '2024-05-03', NULL),
	(45, 48, 48, '2011-10-11', NULL),
	(46, 51, 51, '2024-05-03', NULL),
	(47, 52, 52, '2011-10-31', NULL),
	(48, 53, 53, '2009-01-14', NULL),
	(49, 54, 54, '2015-11-06', NULL),
	(50, 55, 55, '2015-11-06', NULL),
	(51, 56, 56, '2022-07-21', NULL),
	(52, 57, 57, '2022-07-21', NULL),
	(53, 58, 58, '2023-03-16', NULL),
	(54, 109, 109, '2023-03-16', NULL),
	(55, 110, 110, '2023-03-16', NULL);

-- Dumping structure for table parking_machine_management_system.machine_location
CREATE TABLE IF NOT EXISTS `machine_location` (
  `MachineLocationID` int unsigned NOT NULL,
  `ParkingAreaID` int unsigned NOT NULL,
  `LocationDescription` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `What3Words` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `AcceptsCoin` tinyint unsigned NOT NULL,
  `AcceptsCard` tinyint unsigned NOT NULL,
  PRIMARY KEY (`MachineLocationID`),
  KEY `Location_ParkingAreaID` (`ParkingAreaID`),
  CONSTRAINT `Location_ParkingAreaID` FOREIGN KEY (`ParkingAreaID`) REFERENCES `parking_area` (`ParkingAreaID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `AcceptsCard` CHECK ((`AcceptsCard` in (0,1))),
  CONSTRAINT `AcceptsCoin` CHECK ((`AcceptsCoin` in (0,1)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table parking_machine_management_system.machine_location: ~78 rows (approximately)
INSERT INTO `machine_location` (`MachineLocationID`, `ParkingAreaID`, `LocationDescription`, `What3Words`, `AcceptsCoin`, `AcceptsCard`) VALUES
	(1, 293, 'Beside No.2 Malden Road', 'length.rather.charmingly', 1, 1),
	(2, 294, 'Opposite No.1A', 'deputy.churn.again', 1, 1),
	(3, 295, 'Opposite No.23', 'elbow.enchantment.voter', 1, 1),
	(4, 296, 'Infront of No.8', 'tender.wooden.turned', 1, 1),
	(5, 296, 'Infront of Rutland Lodge, South end of street', 'range.falls.crib', 1, 1),
	(6, 297, 'Infront of St Micheals & All Angels Church, North end of street', 'stuff.woods.glad', 1, 1),
	(9, 299, 'Beside St Micheals & All Angels Church', 'vocal.modes.navy', 1, 1),
	(10, 14, 'Beside Watford Community Housing Trust', 'today.trade.gent', 1, 1),
	(11, 15, 'Adjacent to No.20', 'others.listed.formal', 1, 1),
	(12, 16, 'Outside No.16', 'vast.couches.mops', 1, 1),
	(13, 17, 'Outside No.6', 'waddle.bride.barks', 1, 1),
	(14, 11, 'Outside No.189, Junc with Orphanage road', 'lives.paths.wizard', 1, 1),
	(15, 12, 'Outside No.155', 'thanks.study.topped', 1, 1),
	(16, 13, 'Outside No.131', 'pass.tiles.event', 1, 1),
	(17, 300, 'Opposite No.61 Pointed Image Tattoo Shop', 'stow.body.nerve', 1, 1),
	(18, 301, 'Outside No.38 The Hyde building', 'healthier.sorters.lance', 1, 1),
	(19, 7, 'Outside No. 86 (Natural Beauty), Junc with Loates Lane', 'origin.flood.drives', 1, 1),
	(20, 8, 'Outside No.68 Polaris Fitness, Junc with Lord Street', 'spots.snow.bunny', 1, 1),
	(21, 9, 'Beside No.58 Laser & Skin Group', 'united.stove.bumpy', 1, 1),
	(22, 18, 'Beside the rear of Derby Road Baptist Church', 'hears.cups.puddles', 1, 1),
	(23, 2, 'Outside No. 72 CCC Launderette', 'twin.under.purely', 1, 1),
	(24, 5, 'Beside The Roof Gardens, 118 Exchange Road, Junc with Percy Road', 'sorry.mint.trick', 1, 1),
	(25, 3, 'Outside No. 40', 'guises.period.waddled', 1, 1),
	(26, 4, 'Outside No. 81 Afro Mini Mart, Junc with Francis Road', 'softly.legend.healers', 1, 1),
	(27, 19, 'Across the road from No.73 Dad\'s Garage', 'trains.scores.taped', 1, 1),
	(28, 20, 'Beside no. 14-16 Rio Grande Steak House', 'clocks.rats.index', 1, 1),
	(29, 21, 'Beside No.93 Vicarage Road Post Office', 'crash.scuba.bend', 1, 1),
	(30, 22, 'Outside No.58 The Hornets Shop', 'notion.asks.looked', 1, 1),
	(31, 23, 'Outside WFC Exit Gate 12, opposite No.109', 'king.pints.land', 1, 1),
	(32, 26, 'Opposite Jamia Mosque', 'copies.crab.hers', 1, 1),
	(33, 24, 'Outside rear entrance to No.12 (shuttered) Watford Probation Service', 'dark.status.dunes', 1, 1),
	(34, 10, 'Infront of Derby Road Baptist Church', 'quench.cargo.using', 1, 1),
	(35, 27, 'Adjacent to Lower High St. Station', 'flying.loves.washed', 1, 1),
	(36, 28, 'Outside No.184 (Dyson Court)', 'dragon.robe.Friday', 1, 1),
	(37, 302, 'Opposite No.2 Woodmans House', 'cherry.margin.names', 1, 1),
	(38, 303, 'Adjacent to Watford Fields Playground', 'monkey.wider.hiding', 1, 0),
	(40, 304, 'Beside Watford Skate Park', 'wacky.games.liner', 0, 0),
	(41, 305, 'Infront of No.42 Premier Express', 'rests.shells.master', 1, 0),
	(42, 25, 'Infront of No.1 Ormos Foods/Trades', 'groups.carry.price', 1, 1),
	(43, 306, 'Opposite No.2a', 'august.wages.cable', 1, 1),
	(44, 307, 'Beside No.57 St Albans Rd (Kwik-Fit)', 'cake.knots.feeds', 1, 0),
	(45, 29, 'Outside No.80 Axia IT Solutions', 'copy.limit.falls', 1, 1),
	(46, 30, 'Outside No.121 Mithunn Mini Mart', 'probe.beast.verbs', 1, 1),
	(47, 308, 'Outside No.23', 'clap.salsa.wiped', 1, 1),
	(48, 309, 'Outside No.2', 'judge.builds.straw', 1, 1),
	(51, 310, 'Beside No.45 Harwoods Road', 'drip.grew.logo', 1, 1),
	(52, 6, 'Beside Central Primary School', 'rank.miss.tidy', 1, 1),
	(53, 311, 'Beside No.40', 'panels.noise.credit', 1, 1),
	(54, 312, 'Infront of No.6', 'looked.order.total', 1, 1),
	(55, 313, 'Opposite No.27', 'rise.become.slimy', 1, 1),
	(56, 314, 'Opposite No.142 Whippendell Rd. Ian Andrew Estate Agent', 'trash.walks.camps', 1, 1),
	(57, 326, 'Infront of No.477 (Bluebell Place)', 'chops.into.value', 1, 1),
	(58, 315, 'Opposite No.66b', 'glitz.alien.intelligable', 1, 1),
	(59, 31, 'Outside No.278 Northwood Estate Agents', 'marble.swing.only', 1, 1),
	(61, 32, 'Outside No.249 Wenzel\'s', 'intend.super.smoke', 1, 1),
	(62, 33, 'Outside No.222 Watford School Uniforms', 'artist.racing.villa', 1, 1),
	(64, 34, 'Beside No.209 Jenny\'s Cafe', 'digs.king.motion', 1, 1),
	(65, 35, 'Infront of No.164 Coopers Estate Agents', 'bolts.heap.gloves', 1, 1),
	(66, 316, 'Beside No.510 Whippendell Road (Shamrock Bar)', 'shaped.else.cheer', 1, 1),
	(67, 293, 'Opposite Capel Carpets', 'began.divide.reds', 1, 1),
	(68, 317, 'Beside No.25 Queens Ave', 'taken.yappy.gangs', 1, 1),
	(69, 318, 'Opposite No.1a', 'coats.active.hurry', 1, 1),
	(70, 319, 'Infront of No.48-56 (Cassiobury Tennis Club)', 'hype.ashes.knots', 1, 1),
	(71, 320, 'Opposite No.37', 'table.rats.head', 1, 1),
	(72, 320, 'Opposite No.5 Parkside Drive', 'reds.palm.turned', 1, 1),
	(74, 321, 'Opposite No.6', 'mirror.coach.fades', 1, 1),
	(76, 322, 'Beside No.79', 'pretty.mental.happen', 1, 1),
	(77, 323, 'Infront of No.17', 'bride.dads.mobile', 1, 1),
	(78, 324, 'Opposite No.131', 'ranch.kinds.alert', 1, 1),
	(79, 325, 'Infront of No.39', 'skills.menu.laws', 1, 1),
	(80, 290, 'Opposite No.14 Parkside', 'behave.mobile.belt', 1, 1),
	(81, 290, 'Opposite Manning Court', 'meals.game.visa', 1, 1),
	(82, 290, 'Opposite No.13 Ivy House', 'belt.towers.stage', 1, 1),
	(83, 298, 'Infront of the old Police Station', 'acting.once.royal', 1, 1),
	(101, 291, 'Opposite Central Leisure Centre', 'rock.grit.kicks', 1, 1),
	(107, 292, 'Opposite Central Leisure Centre', 'poem.wheels.inner', 1, 1),
	(109, 1, 'Near Cycle stand', 'plug.singer.grow', 1, 1),
	(110, 1, 'Near Entrance', 'fires.froze.open', 1, 1);

-- Dumping structure for table parking_machine_management_system.machine_status_history
CREATE TABLE IF NOT EXISTS `machine_status_history` (
  `StatusEventID` int unsigned NOT NULL AUTO_INCREMENT,
  `DeploymentID` int unsigned NOT NULL,
  `ChangedBy` int unsigned NOT NULL,
  `Status` enum('Active','OOO','Pending repairs','Partly operational') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ChangedAt` datetime NOT NULL,
  PRIMARY KEY (`StatusEventID`),
  KEY `Status_DeploymentID` (`DeploymentID`),
  KEY `Status_UserID` (`ChangedBy`),
  CONSTRAINT `Status_DeploymentID` FOREIGN KEY (`DeploymentID`) REFERENCES `machine_deployment` (`DeploymentID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Status_UserID` FOREIGN KEY (`ChangedBy`) REFERENCES `users` (`UserID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table parking_machine_management_system.machine_status_history: ~1 rows (approximately)
INSERT INTO `machine_status_history` (`StatusEventID`, `DeploymentID`, `ChangedBy`, `Status`, `ChangedAt`) VALUES
	(1, 9, 9, 'OOO', '2026-03-04 12:00:02');

-- Dumping structure for table parking_machine_management_system.maintenance
CREATE TABLE IF NOT EXISTS `maintenance` (
  `RecordID` int unsigned NOT NULL AUTO_INCREMENT,
  `DeploymentID` int unsigned NOT NULL,
  `Technician` int unsigned NOT NULL,
  `IssueID` int unsigned NOT NULL,
  `Timestamp` datetime NOT NULL,
  `Description` varchar(500) NOT NULL DEFAULT '',
  `Outcome` enum('Resolved','Pending part','Pending engineer') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`RecordID`),
  KEY `Maintenance_DeploymentID` (`DeploymentID`),
  KEY `Maintenance_IssueID` (`IssueID`),
  KEY `Maintenance_UserID` (`Technician`),
  CONSTRAINT `Maintenance_DeploymentID` FOREIGN KEY (`DeploymentID`) REFERENCES `machine_deployment` (`DeploymentID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Maintenance_IssueID` FOREIGN KEY (`IssueID`) REFERENCES `issue` (`IssueID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Maintenance_UserID` FOREIGN KEY (`Technician`) REFERENCES `users` (`UserID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table parking_machine_management_system.maintenance: ~2 rows (approximately)
INSERT INTO `maintenance` (`RecordID`, `DeploymentID`, `Technician`, `IssueID`, `Timestamp`, `Description`, `Outcome`) VALUES
	(1, 6, 8, 3, '2026-03-04 12:22:27', 'Grafitti Removed', 'Resolved'),
	(2, 3, 8, 2, '2026-03-04 14:34:18', 'Replaced coin selector module', 'Resolved');

-- Dumping structure for table parking_machine_management_system.parking_area
CREATE TABLE IF NOT EXISTS `parking_area` (
  `ParkingAreaID` int unsigned NOT NULL AUTO_INCREMENT,
  `LocationName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `MapLocation` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Postcode` varchar(10) NOT NULL,
  `ParkingZone` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `RingGoLocationCode` int unsigned DEFAULT NULL,
  PRIMARY KEY (`ParkingAreaID`)
) ENGINE=InnoDB AUTO_INCREMENT=382 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table parking_machine_management_system.parking_area: ~72 rows (approximately)
INSERT INTO `parking_area` (`ParkingAreaID`, `LocationName`, `MapLocation`, `Postcode`, `ParkingZone`, `RingGoLocationCode`) VALUES
	(1, 'Cassiobury Car Park', 'https://www.google.com/maps/place/Cassiobury+Park/@51.6591754,-0.4209525,17.75z/data=!4m6!3m5!1s0x48766af2dd0e77c3:0x4fe752a4bd7ddd5f!8m2!3d51.6586771!4d-0.4109319!16zL20vMDlqYmwy?hl=en&entry=ttu', 'WD18 7LG', '', 26750),
	(2, 'Market Street (Cassio)', 'https://www.google.com/maps/@51.6538211,-0.4004564,72m/data=!3m1!1e3?hl=en&entry=ttu', 'WD18 0PX', 'G', 26752),
	(3, 'Market Street (o/s 40)', 'https://www.google.com/maps/place/40+Market+St,+Watford+WD18+0PY/@51.6543373,-0.3991369,19.75z/data=!4m6!3m5!1s0x48766ac3b264c045:0x9b1ef69d9206745!8m2!3d51.6544055!4d-0.3992976!16s%2Fg%2F11q2n989sx?hl=en&entry=ttu', 'WD18 0PY', 'G', 26753),
	(4, 'Market Street (Francis)', 'https://www.google.com/maps/@51.6539564,-0.3996771,19.25z?hl=en&entry=ttu', 'WD18 0PT', 'G', 26754),
	(5, 'Market Street (Percy)', 'https://www.google.com/maps/@51.6546925,-0.3982269,20z?hl=en&entry=ttu', 'WD18 0QU', 'G', 26755),
	(6, 'Derby Road', 'https://www.google.com/maps/@51.6556688,-0.3914187,18.75z?hl=en&entry=ttu', 'WD17 2LX', 'C', 26756),
	(7, 'Queens Rd Broadway (Loates)', 'https://www.google.com/maps/@51.6578159,-0.3921658,19.75z?hl=en&entry=ttu', 'WD17 2LA', 'C', 26757),
	(8, 'Queens Rd Broadway (Lord)', 'https://www.google.com/maps/@51.6571965,-0.3924178,19.75z?hl=en&entry=ttu', 'WD17 2LA', 'C', 26758),
	(9, 'Lord Street', 'https://www.google.com/maps/place/Sapphire+Court/@51.6569469,-0.3925359,18.25z/data=!4m6!3m5!1s0x48766b4296d2a76d:0x1da6c95ab38bbcfb!8m2!3d51.6569396!4d-0.3934653!16s%2Fg%2F11h3_f7bgj?hl=en&entry=ttu', 'WD17 2LA', 'C', 26759),
	(10, 'Derby Road Slip', 'https://www.google.com/maps/@51.6560921,-0.3931177,122m/data=!3m1!1e3?hl=en&entry=ttu', 'WD17 2LZ', 'C', 26760),
	(11, 'Queens Road (Orphanage)', 'https://www.google.com/maps/@51.6609776,-0.3930979,19.25z?hl=en&entry=ttu', 'WD17 2QH', 'B', 26761),
	(12, 'Queens Road (Sutton)', 'https://www.google.com/maps/@51.660299,-0.3927637,19.25z?hl=en&entry=ttu', 'WD17 2HA', 'B', 26762),
	(13, 'Queens Road (Radlett)', 'https://www.google.com/maps/@51.6597417,-0.3924889,19.5z?hl=en&entry=ttu', 'WD17 2QL', 'B', 26763),
	(14, 'St. Johns Road (West Clar)', 'https://www.google.com/maps/@51.6612779,-0.3964812,18.75z?hl=en&entry=ttu', 'WD17 1LA', 'A', 26764),
	(15, 'St. Johns Road (Westland)', 'https://www.google.com/maps/@51.6612779,-0.3964812,18.75z?hl=en&entry=ttu', 'WD17 1QA', 'A', 26765),
	(16, 'St. Johns Road (East Clar)', 'https://www.google.com/maps/@51.6611996,-0.3964785,19z?hl=en&entry=ttu', 'WD17 1PT', 'B', 26766),
	(17, 'St. Johns Road (Woodford)', 'https://www.google.com/maps/@51.6611996,-0.3964785,19z?hl=en&entry=ttu', 'WD17 1PT', 'B', 26767),
	(18, 'Grosvenor Road', 'https://www.google.com/maps/@51.6559763,-0.3920087,19z?hl=en&entry=ttu', 'WD17 2QS', 'C', 26768),
	(19, 'The Hornets', 'https://www.google.com/maps/@51.6525652,-0.3987304,18.25z?hl=en&entry=ttu', 'WD18 0EJ', 'G', 26769),
	(20, 'Wiggenhall Road', 'https://www.google.com/maps/place/14-16+Vicarage+Rd,+Watford+WD18+0EL/@51.652133,-0.3985085,19z/data=!4m6!3m5!1s0x48766ac32057bcfd:0x87890c07ed00b75a!8m2!3d51.6523529!4d-0.3994158!16s%2Fg%2F11c0vylv80?hl=en&entry=ttu', 'WD18 0EH', 'G', 26770),
	(21, 'Fearnley Street', 'https://www.google.com/maps/@51.6520344,-0.4003029,20z?hl=en&entry=ttu', 'WD18 0EB', 'G', 26771),
	(22, 'Vicarage Road (Occupation)', 'https://www.google.com/maps/@51.6509781,-0.4013212,19.5z?hl=en&entry=ttu', 'WD18 0ER', 'K', 26772),
	(23, 'Vicarage Road (Hospital)', 'https://www.google.com/maps/@51.6503379,-0.4022391,19.5z?hl=en&entry=ttu', 'WD18 0EY', 'K', 26773),
	(24, 'King Street', 'https://www.google.com/maps/place/Gloss+Bar/@51.653263,-0.3944492,19.21z/data=!3m1!5s0x48766ac48c002571:0x302a1e7735e2ace6!4m6!3m5!1s0x48766ac48ea7df09:0x7f858c433266f38a!8m2!3d51.653477!4d-0.3952916!16s%2Fg%2F11byz6g758?hl=en&entry=ttu', 'WD18 0BN', 'E', 26774),
	(25, 'The Crescent', 'https://www.google.com/maps/@51.6531456,-0.3947153,18.71z?hl=en&entry=ttu', 'WD18 0AG', 'E', 26775),
	(26, 'Cambridge Road', 'https://www.google.com/maps/@51.6527361,-0.3945413,18.71z?hl=en&entry=ttu', 'WD18 0GJ', 'E', 26776),
	(27, 'Lower High Street (Station)', 'https://www.google.com/maps/@51.6524796,-0.3906137,18.71z?hl=en&entry=ttu', 'WD17 2NW', 'F', 26778),
	(28, 'Lower High Street (Museum)', 'https://www.google.com/maps/@51.6524037,-0.3907289,19.21z?hl=en&entry=ttu', 'WD17 2NU', 'F', 26779),
	(29, 'St. Albans Road (Langley)', 'https://www.google.com/maps/@51.6642659,-0.3984577,18.71z?hl=en&entry=ttu', 'WD17 1DL', 'D', 26780),
	(30, 'St. Albans Road (Terrace)', 'https://www.google.com/maps/@51.6650788,-0.39841,19.21z?hl=en&entry=ttu', 'WD17 1RD', 'D', 26781),
	(31, 'St. Albans Road (Balmoral)', 'https://www.google.com/maps/@51.6727584,-0.3951105,18.46z?hl=en&entry=ttu', 'WD24 6PE', '', 26782),
	(32, 'St. Albans Road (Judge)', 'https://www.google.com/maps/place/249A+St+Albans+Rd,+Watford+WD24+5BQ/@51.6712935,-0.3956532,18.46z/data=!4m6!3m5!1s0x48766abca1aea09d:0x5f940e367045129c!8m2!3d51.6712408!4d-0.3968062!16s%2Fg%2F11cs83lfsz?hl=en&entry=ttu', 'WD24 5SD', '', 26783),
	(33, 'St. Albans Road (Yarmouth)', 'https://www.google.com/maps/place/Designer+Nailz/@51.6707752,-0.3960331,18.21z/data=!4m6!3m5!1s0x48766abb5ee556cd:0xee04c3f4c2367657!8m2!3d51.6711148!4d-0.3965299!16s%2Fg%2F1vnnhwzt?hl=en&entry=ttu', 'WD24 4AU', '', 26784),
	(34, 'St. Albans Road (Victoria)', 'https://www.google.com/maps/@51.6697453,-0.3977604,19.46z?hl=en&entry=ttu', 'WD24 5BH', '', 26785),
	(35, 'St. Albans Road (Hatfield)', 'https://www.google.com/maps/place/Coopers+Estate+Agents/@51.6697453,-0.3977604,19.46z/data=!4m6!3m5!1s0x48766abc84087415:0x630f45c327142e6b!8m2!3d51.6695433!4d-0.3974328!16s%2Fg%2F1x5qs89x?hl=en&entry=ttu', 'WD24 4AS', '', 26786),
	(290, 'Eastbury Road', 'https://www.google.com/maps/place/Eastbury+Rd,+Watford/@51.643831,-0.3917871,172m/data=!3m1!1e3!4m6!3m5!1s0x48766ad8fe0545b1:0xa209d6e432a53efb!8m2!3d51.6434784!4d-0.3928758!16s%2Fg%2F1tddx7x4?hl=en&entry=ttu', 'WD19 4PW', '', 26787),
	(291, 'The Avenue', 'https://www.google.com/maps/place/The+Avenue,+Watford/@51.6608352,-0.404106,145m/data=!3m1!1e3!4m6!3m5!1s0x48766aeaccc4b20d:0x684280a1bbd9be1e!8m2!3d51.6622819!4d-0.4058621!16s%2Fg%2F11_r0d5d2?hl=en&entry=ttu', 'WD17 4NR', '', 26788),
	(292, 'The Harebreakes Car Park', 'https://www.google.com/maps/place/The+Harebreaks,+Watford/@51.6727359,-0.3967236,172m/data=!3m1!1e3!4m6!3m5!1s0x48766aa2756474c5:0xc998c787204383b9!8m2!3d51.6760212!4d-0.4025307!16s%2Fg%2F1xgzb8bx?hl=en&entry=ttu', 'WD24 6PD', '', 26793),
	(293, 'Essex Road', 'https://www.google.com/maps/@51.6621499,-0.4015541,122m/data=!3m1!1e3?hl=en&entry=ttu', 'WD17 4EW', 'D', 26795),
	(294, 'Stamford Road', 'https://www.google.com/maps/@51.6647664,-0.4012117,122m/data=!3m1!1e3?hl=en&entry=ttu', 'WD17 4QS', 'D', 26796),
	(295, 'Park Road', 'https://www.google.com/maps/@51.6658791,-0.400699,122m/data=!3m1!1e3?hl=en&entry=ttu', 'WD17 4QN', 'D', 26797),
	(296, 'Nascot Road', 'https://www.google.com/maps/@51.6651098,-0.4011807,122m/data=!3m1!1e3?hl=en&entry=ttu', 'WD17 4UJ', 'D', 26798),
	(297, 'Mildred Avenue', 'https://www.google.com/maps/place/Mildred+Ave,+Watford/@51.6551262,-0.4094897,205m/data=!3m1!1e3!4m6!3m5!1s0x48766aeef1c98695:0xa29bf88a2b935c2a!8m2!3d51.6545648!4d-0.4107671!16s%2Fg%2F1tdk9kv2?hl=en&entry=ttu', 'WD18 7DY', 'S', 26799),
	(298, 'Shady Lane', 'https://www.google.com/maps/place/Shady+Ln,+Watford/@51.6615515,-0.3976229,290m/data=!3m1!1e3!4m6!3m5!1s0x48766abf594316ab:0xc130015905df93a7!8m2!3d51.6619681!4d-0.3977322!16s%2Fg%2F1tfcbnwg?hl=en&entry=ttu', 'WD17 1DD', '', 26800),
	(299, 'Durban Road West', 'https://www.google.com/maps/place/Durban+Rd+W,+Watford/@51.6547437,-0.4092739,145m/data=!3m1!1e3!4m6!3m5!1s0x48766ae933ded6b9:0x7be44a606fa7bcc0!8m2!3d51.6547422!4d-0.4075434!16s%2Fg%2F1v6l6_2d?hl=en&entry=ttu', 'WD18 7DY', 'S', 26801),
	(300, 'Sutton Road', 'https://www.google.com/maps/place/Sutton+Rd,+Watford/@51.6587478,-0.3942316,145m/data=!3m1!1e3!4m6!3m5!1s0x48766ac6fe239999:0x5288ce4fbd63568e!8m2!3d51.6589978!4d-0.3937671!16s%2Fg%2F1tfj2nqz?hl=en&entry=ttu', 'WD17 2QE', 'B', 26802),
	(301, 'Gartlet Road', 'https://www.google.com/maps/place/Sutton+Rd,+Watford/@51.6590409,-0.3962935,172m/data=!3m1!1e3!4m6!3m5!1s0x48766ac6fe239999:0x5288ce4fbd63568e!8m2!3d51.6589978!4d-0.3937671!16s%2Fg%2F1tfj2nqz?hl=en&entry=ttu', 'WD17 1HZ', 'B', 26803),
	(302, 'New Road', 'https://www.google.com/maps/place/New+Rd,+Watford/@51.6523341,-0.3904324,244m/data=!3m1!1e3!4m6!3m5!1s0x48766acf8b460c53:0x4b72d916b0c0b1b0!8m2!3d51.6523929!4d-0.3903633!16s%2Fg%2F11_pxnct3?hl=en&entry=ttu', 'WD17 2EP', '', 26804),
	(303, 'Watford Field Road', 'https://www.google.com/maps/place/Watford+Field+Rd,+Watford/@51.6506557,-0.3918433,205m/data=!3m1!1e3!4m6!3m5!1s0x48766adaa4e8e439:0xd8a1c5f73f77782a!8m2!3d51.6507103!4d-0.3913983!16s%2Fg%2F1tftql7p?hl=en&entry=ttu', 'WD18 0AZ', 'F', 26805),
	(304, 'Lower Derby Road', 'https://www.google.com/maps/place/Lower+Derby+Rd,+Watford+WD17+2NB/@51.6539923,-0.3908059,72m/data=!3m1!1e3!4m6!3m5!1s0x48766ac58088c929:0x32383b654ae0d6f0!8m2!3d51.6542733!4d-0.3905646!16s%2Fg%2F1tk1mh3z?hl=en&entry=ttu', 'WD17 2NB', 'C', 26806),
	(305, 'Lammas Road', 'https://www.google.com/maps/place/Lammas+Rd,+Watford/@51.6486234,-0.3936896,145m/data=!3m1!1e3!4m6!3m5!1s0x48766adb011265c9:0x3838bf16989f0703!8m2!3d51.648704!4d-0.3937451!16s%2Fg%2F1tgb6vls?hl=en&entry=ttu', 'WD18 0BA', 'F', 26807),
	(306, 'Alexandra Road', 'https://www.google.com/maps/place/Alexandra+Rd,+Watford/@51.6622881,-0.4049805,122m/data=!3m1!1e3!4m6!3m5!1s0x48766a959d878d7f:0x5fc6399b6a0589cf!8m2!3d51.6630478!4d-0.4043405!16s%2Fg%2F11g_f6yvs?hl=en&entry=ttu', 'WD17 4QY', 'D', 26808),
	(307, 'West Street', 'https://www.google.com/maps/@51.6634303,-0.4006861,145m/data=!3m1!1e3?hl=en&entry=ttu', 'WD17 1SJ', 'D', 26809),
	(308, 'Harwoods Road (Ed\'s Treads)', 'https://www.google.com/maps/place/Harwoods+Rd,+Watford/@51.6506003,-0.4049897,122m/data=!3m1!1e3!4m6!3m5!1s0x48766ae8c8ee0f5d:0x1001a121471de1c6!8m2!3d51.6526593!4d-0.4078292!16s%2Fg%2F1tnjj1sx?hl=en&entry=ttu', 'WD18 7RB', 'K', 26810),
	(309, 'Church Road', 'https://www.google.com/maps/place/2+Church+Rd,+Watford+WD17+4PU/@51.6660164,-0.4005875,145m/data=!3m1!1e3!4m15!1m8!3m7!1s0x48766a960c020d77:0xdf4791130aea280c!2sChurch+Rd,+Watford!3b1!8m2!3d51.6680138!4d-0.4036211!16s%2Fg%2F1tdqn4dy!3m5!1s0x48766abe8aff01bf:0xb84f67dad595b68a!8m2!3d51.6659423!4d-0.3993989!16s%2Fg%2F11cs90_cg6?hl=en&entry=ttu', 'WD17 4PU', 'D', 26811),
	(310, 'Brightwell Road', 'https://www.google.com/maps/place/Harwoods+Rd,+Watford/@51.6508642,-0.4059041,122m/data=!3m1!1e3!4m6!3m5!1s0x48766ae8c8ee0f5d:0x1001a121471de1c6!8m2!3d51.6526593!4d-0.4078292!16s%2Fg%2F1tnjj1sx?hl=en&entry=ttu', 'WD18 7RQ', 'K', 26813),
	(311, 'Durban Road East', 'https://www.google.com/maps/place/40+Durban+Rd+E,+Watford+WD18+0RP/@51.654308,-0.4057991,122m/data=!3m1!1e3!4m15!1m8!3m7!1s0x48766ae9acb81803:0x641c0850038dc954!2sDurban+Rd+E,+Watford!3b1!8m2!3d51.6539219!4d-0.4051598!16s%2Fg%2F1tdyf3k_!3m5!1s0x48766ae907780937:0x438e5803989310d4!8m2!3d51.6542354!4d-0.4054907!16s%2Fg%2F11t77074q3?hl=en&entry=ttu', 'WD18 0RP', 'L', 26814),
	(312, 'Park Avenue (Mildred)', 'https://www.google.com/maps/place/6+Park+Ave,+Watford+WD18+7HA/@51.6562805,-0.4070641,172m/data=!3m1!1e3!4m6!3m5!1s0x48766ae96002c573:0x6ffbe4be23cf3345!8m2!3d51.6562479!4d-0.4067249!16s%2Fg%2F11sfr5kq32?hl=en&entry=ttu', 'WD18 7HA', 'S', 26815),
	(313, 'Park Avenue (Whippendell)', 'https://www.google.com/maps/@51.6549462,-0.4061392,122m/data=!3m1!1e3?hl=en&entry=ttu', 'WD18 7HR', 'S', 26816),
	(314, 'Southsea Avenue', 'https://www.google.com/maps/@51.6535789,-0.4075046,102m/data=!3m1!1e3?hl=en&entry=ttu', 'WD18 7ND', 'S', 26817),
	(315, 'Sydney Road', 'https://www.google.com/maps/place/Sydney+Rd,+Watford/@51.650357,-0.4184888,122m/data=!3m1!1e3!4m6!3m5!1s0x48766afa7c50203b:0x5bdd09e3f0400f6f!8m2!3d51.6504026!4d-0.4181852!16s%2Fg%2F1tgclstq?hl=en&entry=ttu', 'WD18 7QX', 'T', 26818),
	(316, 'Cassiobridge Road', 'https://www.google.com/maps/@51.6516876,-0.422027,61m/data=!3m1!1e3?hl=en&entry=ttu', 'WD18 7QJ', 'T', 26819),
	(317, 'Belgrave Avenue', 'https://www.google.com/maps/place/Belgrave+Ave,+Watford/@51.6502007,-0.4110103,86m/data=!3m1!1e3!4m6!3m5!1s0x48766ae50c997a43:0xc2bb2bbb3227c6d1!8m2!3d51.6497591!4d-0.4116475!16s%2Fg%2F1v3kmkl5?hl=en&entry=ttu', 'WD18 7NP', '', 26820),
	(318, 'Clifton Road', 'https://www.google.com/maps/place/Clifton+Rd,+Watford/@51.6515205,-0.399622,172m/data=!3m1!1e3!4m6!3m5!1s0x48766ac2d32e8f99:0xad52aacb6fc271d0!8m2!3d51.6512732!4d-0.3998065!16s%2Fg%2F1ths8vqr?hl=en&entry=ttu', 'WD18 0DH', '', 26821),
	(319, 'The Gardens', 'https://www.google.com/maps/place/The+Gardens,+Watford/@51.663274,-0.416112,145m/data=!3m1!1e3!4m6!3m5!1s0x48766a9283e81d0d:0xfc62c3ac15cc2f76!8m2!3d51.6642531!4d-0.4143725!16s%2Fg%2F1vwlnmq1?hl=en&entry=ttu', 'WD17 3DW', 'V', 26822),
	(320, 'Parkside Drive', 'https://www.google.com/maps/@51.6612858,-0.4124107,19z?hl=en&entry=ttu', 'WD17 3AS', 'V', 26823),
	(321, 'Woodland Drive', 'https://www.google.com/maps/@51.6607169,-0.4085999,172m/data=!3m1!1e3?hl=en&entry=ttu', 'WD17 3BX', 'V', 26824),
	(322, 'Shaftsbury Road', 'https://www.google.com/maps/@51.6573538,-0.3898589,290m/data=!3m1!1e3?hl=en&entry=ttu', 'WD17 2RG', 'C', 26825),
	(323, 'Burton Avenue', 'https://www.google.com/maps/@51.6539284,-0.4068805,61m/data=!3m1!1e3?hl=en&entry=ttu', 'WD18 7NQ', 'S', 26826),
	(324, 'Harwoods Road (Tesco)', 'https://www.google.com/maps/@51.6529786,-0.4078944,172m/data=!3m1!1e3?hl=en&entry=ttu', 'WD18 7RP', 'S', 26827),
	(325, 'Queens Avenue', 'https://www.google.com/maps/place/39+Queens+Ave,+Watford+WD18+7NU/@51.651279,-0.412001,145m/data=!3m1!1e3!4m15!1m8!3m7!1s0x48766aef8ee5f0f7:0x1d2796a20c9f9699!2sQueens+Ave,+Watford!3b1!8m2!3d51.6513638!4d-0.4121176!16s%2Fg%2F1td1cxnp!3m5!1s0x48766aefee74fb63:0xcb7b3074923fe48a!8m2!3d51.6512228!4d-0.4120337!16s%2Fg%2F11c295yg0g?hl=en&entry=ttu', 'WD18 7NU', 'B', 26828),
	(326, 'Whippendell Road (Sydney)', 'https://www.google.com/maps/place/Whippendell+Rd,+Watford/@51.6511026,-0.4194544,19z/data=!4m6!3m5!1s0x48766aefc377210d:0x83e388f99b94a0a3!8m2!3d51.6508441!4d-0.4143666!16s%2Fg%2F1tcx6hv2?hl=en&entry=ttu', 'WD18 7PS', 'T', 26818);

-- Dumping structure for table parking_machine_management_system.parking_area_tariff
CREATE TABLE IF NOT EXISTS `parking_area_tariff` (
  `ParkingAreaTariffID` int unsigned NOT NULL AUTO_INCREMENT,
  `ParkingAreaID` int unsigned NOT NULL,
  `TariffID` int unsigned NOT NULL,
  `EffectiveFrom` datetime NOT NULL,
  `EffectiveTo` datetime DEFAULT NULL,
  PRIMARY KEY (`ParkingAreaTariffID`),
  KEY `ParkingAreaID` (`ParkingAreaID`),
  KEY `TariffID` (`TariffID`),
  CONSTRAINT `ParkingAreaID` FOREIGN KEY (`ParkingAreaID`) REFERENCES `parking_area` (`ParkingAreaID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `TariffID` FOREIGN KEY (`TariffID`) REFERENCES `tariff` (`TariffID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `EffectiveTo>EffectiveFrom` CHECK (((`EffectiveTo` is null) or (`EffectiveTo` > `EffectiveFrom`)))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table parking_machine_management_system.parking_area_tariff: ~11 rows (approximately)
INSERT INTO `parking_area_tariff` (`ParkingAreaTariffID`, `ParkingAreaID`, `TariffID`, `EffectiveFrom`, `EffectiveTo`) VALUES
	(1, 1, 3, '2025-03-03 08:00:00', NULL),
	(2, 24, 5, '2025-03-03 08:00:00', NULL),
	(3, 26, 5, '2025-03-03 08:00:00', NULL),
	(4, 25, 5, '2025-03-03 08:00:00', NULL),
	(5, 6, 2, '2024-03-03 08:00:00', '2025-03-02 18:30:00'),
	(6, 6, 1, '2025-03-03 08:00:00', NULL),
	(7, 10, 1, '2025-03-03 08:00:00', NULL),
	(8, 2, 1, '2025-03-03 08:00:00', NULL),
	(9, 4, 4, '2025-03-03 08:00:00', NULL),
	(10, 3, 4, '2025-03-03 08:00:00', NULL),
	(11, 5, 4, '2025-03-03 08:00:00', NULL);

-- Dumping structure for table parking_machine_management_system.service
CREATE TABLE IF NOT EXISTS `service` (
  `RecordID` int unsigned NOT NULL AUTO_INCREMENT,
  `DeploymentID` int unsigned NOT NULL,
  `Technician` int unsigned NOT NULL,
  `Timestamp` datetime NOT NULL,
  `OutsideClean` tinyint unsigned NOT NULL DEFAULT '0',
  `InsideClean` tinyint unsigned NOT NULL DEFAULT '0',
  `CoinSelectorCheck` tinyint unsigned NOT NULL DEFAULT '0',
  `BankingComsCheck` tinyint unsigned NOT NULL DEFAULT '0',
  `PrinterCheck` tinyint unsigned NOT NULL DEFAULT '0',
  `Comments` varchar(500) NOT NULL DEFAULT '',
  PRIMARY KEY (`RecordID`),
  KEY `Service_DeploymentID` (`DeploymentID`),
  KEY `Service_UserID` (`Technician`),
  CONSTRAINT `Service_DeploymentID` FOREIGN KEY (`DeploymentID`) REFERENCES `machine_deployment` (`DeploymentID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Service_UserID` FOREIGN KEY (`Technician`) REFERENCES `users` (`UserID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `BankingComsCheckBool` CHECK ((`BankingComsCheck` in (0,1))),
  CONSTRAINT `CoinSelectorCheckBool` CHECK ((`CoinSelectorCheck` in (0,1))),
  CONSTRAINT `InsideCleanBool` CHECK ((`InsideClean` in (0,1))),
  CONSTRAINT `OutsideCleanBool` CHECK ((`OutsideClean` in (0,1))),
  CONSTRAINT `PrinterCheckBool` CHECK ((`PrinterCheck` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table parking_machine_management_system.service: ~2 rows (approximately)
INSERT INTO `service` (`RecordID`, `DeploymentID`, `Technician`, `Timestamp`, `OutsideClean`, `InsideClean`, `CoinSelectorCheck`, `BankingComsCheck`, `PrinterCheck`, `Comments`) VALUES
	(3, 2, 8, '2026-03-04 12:18:00', 1, 1, 1, 1, 1, 'Fully operational'),
	(4, 1, 8, '2026-03-04 13:15:41', 1, 1, 1, 0, 1, 'Routine service: cleaned, coin path checked, printer tested.');

-- Dumping structure for table parking_machine_management_system.tariff
CREATE TABLE IF NOT EXISTS `tariff` (
  `TariffID` int unsigned NOT NULL AUTO_INCREMENT,
  `TariffName` varchar(100) NOT NULL,
  `Description` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `FromDay` enum('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Monday',
  `ToDay` enum('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Saturday',
  `FromTime` time NOT NULL DEFAULT '08:00:00',
  `ToTime` time NOT NULL DEFAULT '18:30:00',
  PRIMARY KEY (`TariffID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table parking_machine_management_system.tariff: ~5 rows (approximately)
INSERT INTO `tariff` (`TariffID`, `TariffName`, `Description`, `FromDay`, `ToDay`, `FromTime`, `ToTime`) VALUES
	(1, 'All Zone 4hr 2.0', 'Default Standard tariff for 4hr bays across all zones', 'Monday', 'Saturday', '08:00:00', '18:30:00'),
	(2, 'Zone C 4hr', 'Zone C tariff for 4hr bays (old)', 'Monday', 'Saturday', '08:00:00', '18:30:00'),
	(3, 'Casioburry CP 3.0', 'Updated Cassiburry CP Tariff', 'Monday', 'Sunday', '08:00:00', '22:00:00'),
	(4, 'All zone 1hr', 'Default Standard tariff for 1hr bays across all zones', 'Monday', 'Saturday', '08:00:00', '18:30:00'),
	(5, 'Zone E 1hr', 'Standard tarrif for 1hr bays in Zone E', 'Monday', 'Sunday', '08:00:00', '22:00:00');

-- Dumping structure for table parking_machine_management_system.tariff_step
CREATE TABLE IF NOT EXISTS `tariff_step` (
  `TariffStepID` int unsigned NOT NULL AUTO_INCREMENT,
  `TariffID` int unsigned NOT NULL,
  `DurationMinutes` int unsigned NOT NULL,
  `price` decimal(6,2) unsigned NOT NULL DEFAULT (0),
  PRIMARY KEY (`TariffStepID`),
  UNIQUE KEY `TariffID` (`TariffID`,`DurationMinutes`),
  CONSTRAINT `TariffStep_TariffID` FOREIGN KEY (`TariffID`) REFERENCES `tariff` (`TariffID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table parking_machine_management_system.tariff_step: ~39 rows (approximately)
INSERT INTO `tariff_step` (`TariffStepID`, `TariffID`, `DurationMinutes`, `price`) VALUES
	(1, 1, 12, 0.50),
	(2, 1, 24, 0.80),
	(3, 1, 36, 1.20),
	(4, 1, 48, 1.60),
	(5, 1, 60, 2.00),
	(6, 1, 72, 2.50),
	(7, 1, 84, 2.80),
	(8, 1, 96, 3.20),
	(9, 1, 108, 3.60),
	(10, 1, 120, 4.00),
	(11, 1, 132, 4.50),
	(12, 1, 144, 4.80),
	(13, 1, 156, 5.20),
	(14, 1, 168, 5.60),
	(15, 1, 180, 6.00),
	(16, 1, 192, 6.50),
	(17, 1, 204, 6.80),
	(18, 1, 216, 7.20),
	(19, 1, 228, 7.60),
	(20, 1, 240, 8.00),
	(21, 2, 60, 1.00),
	(22, 2, 120, 2.00),
	(23, 2, 180, 3.00),
	(24, 2, 240, 4.00),
	(25, 3, 120, 0.00),
	(26, 3, 180, 3.00),
	(27, 3, 240, 4.00),
	(28, 3, 300, 5.00),
	(29, 3, 360, 6.00),
	(30, 4, 12, 0.50),
	(31, 4, 24, 0.80),
	(32, 4, 36, 1.20),
	(33, 4, 48, 1.60),
	(34, 4, 60, 2.00),
	(35, 5, 12, 0.50),
	(36, 5, 24, 0.80),
	(37, 5, 36, 1.20),
	(38, 5, 48, 1.60),
	(39, 5, 60, 2.00);

-- Dumping structure for table parking_machine_management_system.users
CREATE TABLE IF NOT EXISTS `users` (
  `UserID` int unsigned NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Role` enum('Traffic Warden','Customer Service','Technician','Head Technician','Cash Collector','Manager') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Status` tinyint unsigned NOT NULL,
  PRIMARY KEY (`UserID`),
  CONSTRAINT `User_Status` CHECK ((`Status` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table parking_machine_management_system.users: ~10 rows (approximately)
INSERT INTO `users` (`UserID`, `FirstName`, `LastName`, `Role`, `Status`) VALUES
	(1, 'Oliver', 'Bennett', 'Traffic Warden', 1),
	(2, 'Amelia', 'Clarke', 'Traffic Warden', 1),
	(3, 'Ethan', 'Patel', 'Customer Service', 1),
	(4, 'Sophie', 'Mitchell', 'Customer Service', 1),
	(5, 'Daniel', 'Hughes', 'Traffic Warden', 0),
	(6, 'Chloe', 'Thompson', 'Manager', 1),
	(7, 'James', 'O’Connor', 'Head Technician', 1),
	(8, 'Aisha', 'Khan', 'Technician', 1),
	(9, 'Liam', 'Richardson', 'Cash Collector', 1),
	(10, 'Emily', 'Carter', 'Customer Service', 0);

-- Dumping structure for trigger parking_machine_management_system.cashcollector_user_insert_check
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `cashcollector_user_insert_check` BEFORE INSERT ON `cash_collection` FOR EACH ROW BEGIN
	IF NOT EXISTS (
        SELECT 1
        FROM users
        WHERE UserID = NEW.CashCollector
        AND Role = 'Cash Collector'
        AND Status = 1
   ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User must be an active Cash Collector';
   END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger parking_machine_management_system.cashcollector_user_update_check
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `cashcollector_user_update_check` BEFORE UPDATE ON `cash_collection` FOR EACH ROW BEGIN
	IF NOT EXISTS (
        SELECT 1
        FROM users
        WHERE UserID = NEW.CashCollector
        AND Role = 'Cash Collector'
        AND Status = 1
   ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User must be an active Cash Collector';
   END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger parking_machine_management_system.issue_active_user_insert_check
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `issue_active_user_insert_check` BEFORE INSERT ON `issue` FOR EACH ROW BEGIN
	IF NOT EXISTS (
        SELECT 1
        FROM users
        WHERE UserID = NEW.UserID
        AND Status = 1
   ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Inactive user can not create new issue';
   END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger parking_machine_management_system.issue_active_user_update_check
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `issue_active_user_update_check` BEFORE UPDATE ON `issue` FOR EACH ROW BEGIN
	IF NOT EXISTS (
        SELECT 1
        FROM users
        WHERE UserID = NEW.UserID
        AND Status = 1
   ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Inactive user can not create new issue';
   END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger parking_machine_management_system.machine_deployment_active_location_insert_chk
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `machine_deployment_active_location_insert_chk` BEFORE INSERT ON `machine_deployment` FOR EACH ROW BEGIN
	IF EXISTS (
      SELECT 1
      FROM machine_deployment md
      WHERE md.MachineLocationID = NEW.MachineLocationID
        	AND (
         	(md.EndDate IS NULL AND NEW.EndDate IS NULL)
            OR (md.EndDate IS NULL AND md.StartDate < NEW.EndDate)
            OR (NEW.EndDate IS NULL AND NEW.StartDate < md.EndDate)
            OR (md.EndDate IS NOT NULL AND NEW.EndDate IS NOT NULL
               AND NEW.StartDate < md.EndDate
               AND NEW.EndDate > md.StartDate)
        )
   ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A machine is already deployed at this location during the given period';
   END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger parking_machine_management_system.machine_deployment_active_location_update_chk
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `machine_deployment_active_location_update_chk` BEFORE INSERT ON `machine_deployment` FOR EACH ROW BEGIN
	IF EXISTS (
      SELECT 1
      FROM machine_deployment md
      WHERE md.MachineLocationID = NEW.MachineLocationID
      AND md.DeploymentID <> NEW.DeploymentID -- only in update
        	AND (
         	(md.EndDate IS NULL AND NEW.EndDate IS NULL)
            OR (md.EndDate IS NULL AND md.StartDate < NEW.EndDate)
            OR (NEW.EndDate IS NULL AND NEW.StartDate < md.EndDate)
            OR (md.EndDate IS NOT NULL AND NEW.EndDate IS NOT NULL
               AND NEW.StartDate < md.EndDate
               AND NEW.EndDate > md.StartDate)
        )
   ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A machine is already deployed at this location during the given period';
   END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger parking_machine_management_system.machine_deployment_active_machine_insert_chk
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `machine_deployment_active_machine_insert_chk` BEFORE INSERT ON `machine_deployment` FOR EACH ROW BEGIN
   IF EXISTS (
      SELECT 1
      FROM machine_deployment md
      WHERE md.MachineID = NEW.MachineID
         AND (
         	(md.EndDate IS NULL AND NEW.EndDate IS NULL)
            OR (md.EndDate IS NULL AND md.StartDate < NEW.EndDate)
            OR (NEW.EndDate IS NULL AND NEW.StartDate < md.EndDate)
            OR (md.EndDate IS NOT NULL AND NEW.EndDate IS NOT NULL
               AND NEW.StartDate < md.EndDate
               AND NEW.EndDate > md.StartDate)
         )
   ) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'This machine is already deployed during the given period';
   END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger parking_machine_management_system.machine_deployment_active_machine_update_chk
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `machine_deployment_active_machine_update_chk` BEFORE UPDATE ON `machine_deployment` FOR EACH ROW BEGIN
   IF EXISTS (
      SELECT 1
      FROM machine_deployment md
      WHERE md.MachineID = NEW.MachineID
	      AND md.DeploymentID <> NEW.DeploymentID
         AND (
         	(md.EndDate IS NULL AND NEW.EndDate IS NULL)
            OR (md.EndDate IS NULL AND md.StartDate < NEW.EndDate)
            OR (NEW.EndDate IS NULL AND NEW.StartDate < md.EndDate)
            OR (md.EndDate IS NOT NULL AND NEW.EndDate IS NOT NULL
               AND NEW.StartDate < md.EndDate
               AND NEW.EndDate > md.StartDate)
         )
   ) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'This machine is already deployed during the given period';
   END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger parking_machine_management_system.machine_status_history_user_insert_check
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `machine_status_history_user_insert_check` BEFORE INSERT ON `machine_status_history` FOR EACH ROW BEGIN
	IF NOT EXISTS (
        SELECT 1
        FROM users
        WHERE UserID = NEW.ChangedBy
        AND Role IN ('Traffic Warden', 'Technician', 'Head Technician', 'Cash Collector')
        AND Status = 1
   ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User does not have permission to add machine status history entries';
   END IF;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger parking_machine_management_system.machine_status_history_user_update_check
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `machine_status_history_user_update_check` BEFORE UPDATE ON `machine_status_history` FOR EACH ROW BEGIN
	IF NOT EXISTS (
        SELECT 1
        FROM users
        WHERE UserID = NEW.ChangedBy
        AND Role IN ('Traffic Warden', 'Technician', 'Head Technician', 'Cash Collector')
        AND Status = 1
   ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User does not have permission to modify machine status history entries';
   END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger parking_machine_management_system.maintenance_user_insert_check
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `maintenance_user_insert_check` BEFORE INSERT ON `maintenance` FOR EACH ROW BEGIN
	IF NOT EXISTS (
        SELECT 1
        FROM users
        WHERE UserID = NEW.Technician
        AND Role IN ('Technician', 'Head Technician')
        AND Status = 1
   ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User does not have permission to modify Service entries';
   END IF;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger parking_machine_management_system.maintenance_user_update_check
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `maintenance_user_update_check` BEFORE UPDATE ON `maintenance` FOR EACH ROW BEGIN
	IF NOT EXISTS (
        SELECT 1
        FROM users
        WHERE UserID = NEW.Technician
        AND Role IN ('Technician', 'Head Technician')
        AND Status = 1
   ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User does not have permission to modify Service entries';
   END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger parking_machine_management_system.service_user_insert_check
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `service_user_insert_check` BEFORE INSERT ON `service` FOR EACH ROW BEGIN
	IF NOT EXISTS (
        SELECT 1
        FROM users
        WHERE UserID = NEW.Technician
        AND Role IN ('Technician', 'Head Technician')
        AND Status = 1
   ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User does not have permission to modify Service entries';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger parking_machine_management_system.service_user_update_check
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `service_user_update_check` BEFORE UPDATE ON `service` FOR EACH ROW BEGIN
	IF NOT EXISTS (
        SELECT 1
        FROM users
        WHERE UserID = NEW.Technician
        AND Role IN ('Technician', 'Head Technician')
        AND Status = 1
   ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User does not have permission to modify Service entries';
   END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
