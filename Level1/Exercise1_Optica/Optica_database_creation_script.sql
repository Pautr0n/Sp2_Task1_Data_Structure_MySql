-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Cul_Dampolla
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Cul_Dampolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Cul_Dampolla` DEFAULT CHARACTER SET utf8 ;
USE `Cul_Dampolla` ;

-- -----------------------------------------------------
-- Table `Cul_Dampolla`.`suppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_Dampolla`.`suppliers` (
  `suppliers_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `vat` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `lastupdate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`suppliers_id`),
  UNIQUE INDEX `suppliers_vat_UNIQUE` (`vat` ASC) INVISIBLE,
  INDEX `indx_name` (`name` ASC) INVISIBLE,
  INDEX `indx_email` (`email` ASC) INVISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul_Dampolla`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_Dampolla`.`addresses` (
  `addresses_id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(60) NOT NULL,
  `str_number` INT NOT NULL,
  `floor` VARCHAR(45) NULL,
  `door` INT NULL,
  `postalcode` VARCHAR(10) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`addresses_id`),
  INDEX `indx_addresses_country` (`country` ASC) INVISIBLE,
  INDEX `indx_addresses_city` (`city` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul_Dampolla`.`supplier_has_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_Dampolla`.`supplier_has_address` (
  `suppliers_id` INT NOT NULL,
  `addresses_id` INT NOT NULL,
  PRIMARY KEY (`suppliers_id`, `addresses_id`),
  INDEX `fk_supplier_has_address_suppliers1_idx` (`suppliers_id` ASC) INVISIBLE,
  INDEX `fk_supplier_has_address_addresses1_idx` (`addresses_id` ASC) VISIBLE,
  CONSTRAINT `fk_supplier_has_address_suppliers1`
    FOREIGN KEY (`suppliers_id`)
    REFERENCES `Cul_Dampolla`.`suppliers` (`suppliers_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_supplier_has_address_addresses1`
    FOREIGN KEY (`addresses_id`)
    REFERENCES `Cul_Dampolla`.`addresses` (`addresses_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul_Dampolla`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_Dampolla`.`customers` (
  `customers_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `email` VARCHAR(255) NULL,
  `reffered_by` INT NULL COMMENT 'This column identifies which other customer has recommended our company to this customer.',
  `created_on` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `lastupdate_on` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`customers_id`),
  INDEX `indx_name` (`name` ASC) VISIBLE,
  INDEX `indx_email` (`email` ASC) VISIBLE,
  INDEX `fk_customers_customers1_idx` (`reffered_by` ASC) INVISIBLE,
  CONSTRAINT `fk_customers_customers1`
    FOREIGN KEY (`reffered_by`)
    REFERENCES `Cul_Dampolla`.`customers` (`customers_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul_Dampolla`.`customer_has_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_Dampolla`.`customer_has_address` (
  `customers_id` INT NOT NULL,
  `addresses_id` INT NOT NULL,
  PRIMARY KEY (`customers_id`, `addresses_id`),
  INDEX `fk_customer_has_address_customers1_idx` (`customers_id` ASC) VISIBLE,
  INDEX `fk_customer_has_address_addresses1_idx` (`addresses_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_has_address_customers1`
    FOREIGN KEY (`customers_id`)
    REFERENCES `Cul_Dampolla`.`customers` (`customers_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_customer_has_address_addresses1`
    FOREIGN KEY (`addresses_id`)
    REFERENCES `Cul_Dampolla`.`addresses` (`addresses_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul_Dampolla`.`eyeglasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_Dampolla`.`eyeglasses` (
  `eyeglasses_id` INT NOT NULL AUTO_INCREMENT,
  `suppliers_id` INT NOT NULL,
  `glasses_brands_glasses_brands_id` INT NOT NULL,
  `right_glass_graduation` DECIMAL(4,2) NOT NULL,
  `left_glass_graduation` DECIMAL(4,2) NOT NULL,
  `frame_type` ENUM('FLOATING', 'METALLIC', 'PLASTIC') NOT NULL,
  `frame_color` VARCHAR(45) NOT NULL,
  `right_glass_color` VARCHAR(45) NOT NULL,
  `left_glass_color` VARCHAR(45) NOT NULL,
  `price` DECIMAL(6,2) NOT NULL,
  `brand` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`eyeglasses_id`),
  INDEX `indx_frame` (`frame_type` ASC) INVISIBLE,
  INDEX `indx_frame_color` (`frame_color` ASC) INVISIBLE,
  INDEX `indx_glass_color` (`left_glass_color` ASC) INVISIBLE,
  INDEX `indx_price` (`price` ASC) VISIBLE,
  INDEX `fk_eyeglasses_suppliers1_idx` (`suppliers_id` ASC) VISIBLE,
  CONSTRAINT `fk_eyeglasses_suppliers1`
    FOREIGN KEY (`suppliers_id`)
    REFERENCES `Cul_Dampolla`.`suppliers` (`suppliers_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul_Dampolla`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_Dampolla`.`employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`employee_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul_Dampolla`.`sales_orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_Dampolla`.`sales_orders` (
  `sales_orders_id` INT NOT NULL AUTO_INCREMENT,
  `customers_id` INT NOT NULL,
  `total_amount` DECIMAL(8,2) NOT NULL COMMENT 'This attribute comes from the addition of each order_details.item_price',
  `date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sales_orders_id`),
  INDEX `fk_sales_orders_customers1_idx` (`customers_id` ASC) VISIBLE,
  CONSTRAINT `fk_sales_orders_customers1`
    FOREIGN KEY (`customers_id`)
    REFERENCES `Cul_Dampolla`.`customers` (`customers_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul_Dampolla`.`order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_Dampolla`.`order_details` (
  `eyeglasses_id` INT NOT NULL,
  `sales_orders_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  INDEX `fk_sf_sold_eyeglass_eyeglasses1_idx` (`eyeglasses_id` ASC) VISIBLE,
  PRIMARY KEY (`eyeglasses_id`, `sales_orders_id`),
  INDEX `fk_order_details_sales_orders1_idx` (`sales_orders_id` ASC) VISIBLE,
  INDEX `fk_order_details_sales_force1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_sf_sold_eyeglass_eyeglasses1`
    FOREIGN KEY (`eyeglasses_id`)
    REFERENCES `Cul_Dampolla`.`eyeglasses` (`eyeglasses_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_details_sales_orders1`
    FOREIGN KEY (`sales_orders_id`)
    REFERENCES `Cul_Dampolla`.`sales_orders` (`sales_orders_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_details_sales_force1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `Cul_Dampolla`.`employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
