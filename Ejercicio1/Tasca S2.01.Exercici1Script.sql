-- MySQL Script generated by MySQL Workbench
-- Mon May  06 10:21:13 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema opticadb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema opticadb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `opticadb` DEFAULT CHARACTER SET utf8 ;
USE `opticadb` ;

-- -----------------------------------------------------
-- Table `opticadb`.`Providers_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `opticadb`.`Providers_address` (
  `idAdress` INT NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `number` INT(5) NOT NULL,
  `floor` INT(5) NULL,
  `door` INT(5) NULL,
  `city` VARCHAR(45) NOT NULL,
  `postal code` INT(10) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAdress`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opticadb`.`Providers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `opticadb`.`Providers` (
  `idProveidor` INT NOT NULL AUTO_INCREMENT,
  `Providers_address_idAdress` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `phone` INT(15) NOT NULL,
  `fax` INT(15) NULL,
  `nif` VARCHAR(10) NOT NULL,
  `Proveidor_phone` INT(15) NOT NULL,
  PRIMARY KEY (`idProveidor`, `Providers_address_idAdress`),
  INDEX `fk_Providers_Providers_address1_idx` (`Providers_address_idAdress` ASC) VISIBLE,
  CONSTRAINT `fk_Providers_Providers_address1`
    FOREIGN KEY (`Providers_address_idAdress`)
    REFERENCES `opticadb`.`Providers_address` (`idAdress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opticadb`.`Glasses_brands`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `opticadb`.`Glasses_brands` (
  `idGlasses_brand` INT NOT NULL AUTO_INCREMENT,
  `brand` VARCHAR(45) NOT NULL,
  `Providers_idProveidor` INT NOT NULL,
  PRIMARY KEY (`idGlasses_brand`, `Providers_idProveidor`),
  INDEX `fk_Glasses_brands_Providers1_idx` (`Providers_idProveidor` ASC) VISIBLE,
  CONSTRAINT `fk_Glasses_brands_Providers1`
    FOREIGN KEY (`Providers_idProveidor`)
    REFERENCES `opticadb`.`Providers` (`idProveidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opticadb`.`Glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `opticadb`.`Glasses` (
  `idGlasses` INT NOT NULL AUTO_INCREMENT,
  `brand` INT NOT NULL,
  `grade` DECIMAL NOT NULL,
  `typeOfBase` ENUM("metal", "floating", "paste") NOT NULL,
  `base_color` VARCHAR(45) NULL,
  `glass_color` VARCHAR(45) NULL,
  `price` DECIMAL NOT NULL,
  PRIMARY KEY (`idGlasses`),
  INDEX `idGlasses_idx` (`brand` ASC) VISIBLE,
  CONSTRAINT `idGlasses`
    FOREIGN KEY (`brand`)
    REFERENCES `opticadb`.`Glasses_brands` (`idGlasses_brand`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opticadb`.`Factures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `opticadb`.`Factures` (
  `idfactura` INT NOT NULL,
  `idClientFacura` INT NOT NULL,
  `idGlassesFactura` INT NOT NULL,
  `dateTime` DATETIME(6) NOT NULL,
  `nameClient` VARCHAR(45) NOT NULL,
  `adressClient` VARCHAR(45) NULL,
  PRIMARY KEY (`idfactura`),
  INDEX `fk_factura_Glasses1_idx` (`idGlassesFactura` ASC) VISIBLE,
  INDEX `idClient` (`idClientFacura` ASC) VISIBLE,
  CONSTRAINT `idGlassesFactura`
    FOREIGN KEY (`idGlassesFactura`)
    REFERENCES `opticadb`.`Glasses` (`idGlasses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opticadb`.`Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `opticadb`.`Clients` (
  `idClient` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `adress` VARCHAR(45) NOT NULL,
  `phone` INT NULL,
  `email` VARCHAR(45) NULL,
  `date_registry` DATETIME NULL,
  `refered_by_client` INT NULL,
  `Glasses_ID` INT NOT NULL,
  `attended_by` INT NOT NULL,
  PRIMARY KEY (`idClient`, `Glasses_ID`, `attended_by`),
  INDEX `fk_Client_individual_Glasses1_idx` (`Glasses_ID` ASC) VISIBLE,
  INDEX `attended_by` (`attended_by` ASC) VISIBLE,
  CONSTRAINT `idGlassesClient`
    FOREIGN KEY (`Glasses_ID`)
    REFERENCES `opticadb`.`Glasses` (`idGlasses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idClient`
    FOREIGN KEY (`idClient`)
    REFERENCES `opticadb`.`Factures` (`idClientFacura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opticadb`.`factures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `opticadb`.`factures` (
  `idfactures` INT NOT NULL,
  PRIMARY KEY (`idfactures`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;