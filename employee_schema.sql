-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
-- -----------------------------------------------------
-- Schema employee
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `employee` ;
USE `employee` ;

-- -----------------------------------------------------
-- Table `employee`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `employee`.`employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `employee_first_name` VARCHAR(45) NOT NULL,
  `employee_last_name` VARCHAR(45) NOT NULL,
  `designation` VARCHAR(45) NOT NULL,
  `salary` INT NOT NULL,
  `workingexpincompany` INT NOT NULL,
  `created_date` DATETIME NOT NULL,
  `created_by_id` INT NOT NULL,
  `modified_by_id` INT NULL DEFAULT NULL,
  `last_updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`employee_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `employee`.`reporting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `employee`.`reporting` (
  `reporting_person_id` INT NOT NULL UNIQUE,
  `reporter_person_id` INT NOT NULL,
  `report` VARCHAR(45) NOT NULL,
  `feedback` VARCHAR(45) NOT NULL,
  `created_date` DATETIME NOT NULL,
  `created_by_id` INT NOT NULL,
  `modified_by_id` INT NULL DEFAULT NULL,
  `last_updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `fk_reporting_1_idx` (`reporting_person_id` ASC),
  INDEX `fk_reporting_2_idx` (`reporter_person_id` ASC),
  CONSTRAINT `fk_reporting_1`
    FOREIGN KEY (`reporting_person_id`)
    REFERENCES `employee`.`employee` (`employee_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_reporting_2`
    FOREIGN KEY (`reporter_person_id`)
    REFERENCES `employee`.`employee` (`employee_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `employee`.`project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `employee`.`project` (
  `project_id` INT NOT NULL AUTO_INCREMENT,
  `project_name` VARCHAR(15) NOT NULL,
  `project_duration` INT NOT NULL,
  `project_starting_date` DATETIME NOT NULL,
  `project_place` VARCHAR(15) NOT NULL,
  `created_date` DATETIME NOT NULL,
  `created_by_id` INT NOT NULL,
  `modified_by_id` INT NULL DEFAULT NULL,
  `last_updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`project_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `employee`.`projectemployee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `employee`.`projectemployee` (
  `project_id` INT NOT NULL,
  `employee_id` INT NOT NULL UNIQUE,
  `created_date` DATETIME NOT NULL,
  `created_by_id` INT NOT NULL,
  `modified_by_id` INT NULL DEFAULT NULL,
  `last_updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE INDEX `employee_id_UNIQUE` (`employee_id` ASC),
  INDEX `fk_projectemployee_2_idx` (`project_id` ASC),
  CONSTRAINT `fk_projectemployee_1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `employee`.`employee` (`employee_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_projectemployee_2`
    FOREIGN KEY (`project_id`)
    REFERENCES `employee`.`project` (`project_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
