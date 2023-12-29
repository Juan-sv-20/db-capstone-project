-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDM
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDM
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDM` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDM` ;

-- -----------------------------------------------------
-- Table `LittleLemonDM`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDM`.`Employees` (
  `EmployeeID` INT NOT NULL AUTO_INCREMENT,
  `FullName` VARCHAR(255) NOT NULL,
  `Age` INT NOT NULL,
  `Role` VARCHAR(255) NOT NULL,
  `Salary` DECIMAL(2) NOT NULL,
  `Address` VARCHAR(255) NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  `ContactNumber` INT NOT NULL,
  `HireDate` DATE NOT NULL,
  `Birthday` DATE NOT NULL,
  `Gender` VARCHAR(255) NOT NULL,
  `MaritalStatus` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`EmployeeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDM`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDM`.`Customers` (
  `CustomerID` INT NOT NULL,
  `FirstName` VARCHAR(255) NOT NULL,
  `LastName` VARCHAR(255) NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  `ContactNumber` INT NOT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDM`.`Cousine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDM`.`Cousine` (
  `CouisineID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NOT NULL,
  `Description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`CouisineID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDM`.`MenuItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDM`.`MenuItem` (
  `MenuItemID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NOT NULL,
  `Description` VARCHAR(255) NOT NULL,
  `Cost` DECIMAL(2) NOT NULL,
  `Ingredients` JSON NOT NULL,
  `Type` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`MenuItemID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDM`.`Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDM`.`Course` (
  `CourseID` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `Description` VARCHAR(255) NOT NULL,
  `MenuItemID` INT NOT NULL,
  `Course_Item` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Course_Item`),
  INDEX `menuItem_id_fk_idx` (`MenuItemID` ASC) VISIBLE,
  UNIQUE INDEX `Course_Item_UNIQUE` (`Course_Item` ASC) VISIBLE,
  CONSTRAINT `menuItem_id_fk`
    FOREIGN KEY (`MenuItemID`)
    REFERENCES `LittleLemonDM`.`MenuItem` (`MenuItemID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDM`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDM`.`Menu` (
  `MenuID` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `Description` VARCHAR(255) NOT NULL,
  `DateCreated` DATE NOT NULL,
  `LastUpdate` DATE NOT NULL,
  `Course_item` VARCHAR(255) NOT NULL,
  `CousineID` INT NOT NULL,
  `Menu_Course` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Menu_Course`),
  INDEX `cousine_id_fk_idx` (`CousineID` ASC) VISIBLE,
  INDEX `course_id_fk_idx` (`Course_item` ASC) VISIBLE,
  UNIQUE INDEX `Menu_Course_UNIQUE` (`Menu_Course` ASC) VISIBLE,
  CONSTRAINT `cousine_id_fk`
    FOREIGN KEY (`CousineID`)
    REFERENCES `LittleLemonDM`.`Cousine` (`CouisineID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `course_id_fk`
    FOREIGN KEY (`Course_item`)
    REFERENCES `LittleLemonDM`.`Course` (`Course_Item`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDM`.`Tables`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDM`.`Tables` (
  `TableID` INT NOT NULL,
  `isBusy` TINYINT NOT NULL,
  `TimeSlot` DATETIME NOT NULL,
  `Date` DATE NOT NULL,
  `TablesNo` INT NOT NULL,
  PRIMARY KEY (`TableID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDM`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDM`.`Bookings` (
  `BookingID` INT NOT NULL,
  `DateCreated` DATETIME NOT NULL,
  `LastUpdate` DATETIME NOT NULL,
  `TableID` INT NOT NULL,
  `EmployeeID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `customer_id_fk_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `employee_id_fk_idx` (`EmployeeID` ASC) VISIBLE,
  INDEX `table_id_fk_idx` (`TableID` ASC) VISIBLE,
  CONSTRAINT `customer_id_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDM`.`Customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `employee_id_fk`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `LittleLemonDM`.`Employees` (`EmployeeID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `table_id_fk`
    FOREIGN KEY (`TableID`)
    REFERENCES `LittleLemonDM`.`Tables` (`TableID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDM`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDM`.`Orders` (
  `OrderID` INT NOT NULL,
  `BookingID` INT NOT NULL,
  `TotalCost` DECIMAL(2) NOT NULL,
  `Discount` DECIMAL(2) NOT NULL,
  `Tax` DECIMAL(2) NOT NULL,
  `OrderStatus` INT NOT NULL,
  `Menu_Course` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `booking_id_fk_idx` (`BookingID` ASC) VISIBLE,
  INDEX `menu_course_fk_idx` (`Menu_Course` ASC) VISIBLE,
  CONSTRAINT `booking_id_fk`
    FOREIGN KEY (`BookingID`)
    REFERENCES `LittleLemonDM`.`Bookings` (`BookingID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `menu_course_fk`
    FOREIGN KEY (`Menu_Course`)
    REFERENCES `LittleLemonDM`.`Menu` (`Menu_Course`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
