-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pizzariadb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzariadb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzariadb` DEFAULT CHARACTER SET utf8mb3 ;
USE `pizzariadb` ;

-- -----------------------------------------------------
-- Table `pizzariadb`.`Burguers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzariadb`.`Burguers` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `desc` VARCHAR(45) NULL DEFAULT NULL,
  `image` VARCHAR(45) NULL DEFAULT NULL,
  `price` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzariadb`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzariadb`.`Orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `client_id` INT NOT NULL,
  `dateTime` DATETIME(6) NULL DEFAULT NULL,
  `deliver_pickup` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `client_id_UNIQUE` (`client_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzariadb`.`Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzariadb`.`Clients` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `adress` VARCHAR(45) NULL DEFAULT NULL,
  `zip_code` INT NULL DEFAULT NULL,
  `phone` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_client_order1`
    FOREIGN KEY (`id`)
    REFERENCES `pizzariadb`.`Orders` (`client_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzariadb`.`Cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzariadb`.`Cities` (
  `_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `client_id` INT NOT NULL,
  PRIMARY KEY (`_id`, `client_id`),
  INDEX `fk_city_client1_idx` (`client_id` ASC) VISIBLE,
  CONSTRAINT `fk_city_client1`
    FOREIGN KEY (`client_id`)
    REFERENCES `pizzariadb`.`Clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzariadb`.`Drinks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzariadb`.`Drinks` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `desc` VARCHAR(45) NULL DEFAULT NULL,
  `image` VARCHAR(45) NULL DEFAULT NULL,
  `price` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzariadb`.`pizza_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzariadb`.`pizza_categories` (
  `_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzariadb`.`Pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzariadb`.`Pizzas` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `desc` VARCHAR(45) NULL DEFAULT NULL,
  `image` VARCHAR(45) NULL DEFAULT NULL,
  `price` INT NULL DEFAULT NULL,
  `pizza_category_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `pizza_category_id`),
  INDEX `fk_pizza_pizza_category1_idx` (`pizza_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_pizza_pizza_category1`
    FOREIGN KEY (`pizza_category_id`)
    REFERENCES `pizzariadb`.`pizza_categories` (`_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzariadb`.`products_list`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzariadb`.`products_list` (
  `id_order` INT NOT NULL,
  `id_product` INT NOT NULL,
  `quantity` INT NOT NULL,
  INDEX `fk_products_list_drink2` (`id_product` ASC) VISIBLE,
  PRIMARY KEY (`id_order`),
  CONSTRAINT `fk_products_list_burguer1`
    FOREIGN KEY (`id_product`)
    REFERENCES `pizzariadb`.`Burguers` (`id`),
  CONSTRAINT `fk_products_list_drink2`
    FOREIGN KEY (`id_product`)
    REFERENCES `pizzariadb`.`Drinks` (`id`),
  CONSTRAINT `fk_products_list_pizza1`
    FOREIGN KEY (`id_product`)
    REFERENCES `pizzariadb`.`Pizzas` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzariadb`.`Provinces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzariadb`.`Provinces` (
  `_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `city_client_id` INT NOT NULL,
  PRIMARY KEY (`_id`, `city_client_id`),
  INDEX `fk_province_city1_idx` (`city_client_id` ASC) VISIBLE,
  CONSTRAINT `fk_province_city1`
    FOREIGN KEY (`city_client_id`)
    REFERENCES `pizzariadb`.`Cities` (`_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzariadb`.`Workers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzariadb`.`Workers` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `nif` INT NULL DEFAULT NULL,
  `phone` INT NULL DEFAULT NULL,
  `cook_delivery` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzariadb`.`Shops`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzariadb`.`Shops` (
  `id` INT NOT NULL,
  `orders` INT NOT NULL,
  `workers` INT NOT NULL,
  `zip_code` INT NULL DEFAULT NULL,
  `city` VARCHAR(45) NULL DEFAULT NULL,
  `provnice` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_shop_worker1` (`workers` ASC) VISIBLE,
  INDEX `fk_shop_order1` (`orders` ASC) VISIBLE,
  CONSTRAINT `fk_shop_order1`
    FOREIGN KEY (`orders`)
    REFERENCES `pizzariadb`.`Orders` (`id`),
  CONSTRAINT `fk_shop_worker1`
    FOREIGN KEY (`workers`)
    REFERENCES `pizzariadb`.`Workers` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
