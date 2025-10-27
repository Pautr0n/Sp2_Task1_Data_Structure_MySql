-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Cull_Dampolla
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Cull_Dampolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Cull_Dampolla` DEFAULT CHARACTER SET utf8 ;
USE `Cull_Dampolla` ;

-- -----------------------------------------------------
-- Table `Cull_Dampolla`.`suppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cull_Dampolla`.`suppliers` (
  `suppliers_id` INT NOT NULL AUTO_INCREMENT,
  `suppliers_name` VARCHAR(45) NOT NULL,
  `suppliers_vat` VARCHAR(45) NOT NULL,
  `suppliers_phone` VARCHAR(45) NULL,
  `suppliers_email` VARCHAR(255) NULL,
  `suppliers_lastupdate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `suppliers_created` DATETIME NULL,
  PRIMARY KEY (`suppliers_id`),
  UNIQUE INDEX `suppliers_vat_UNIQUE` (`suppliers_vat` ASC) INVISIBLE,
  INDEX `indx_name` (`suppliers_name` ASC) INVISIBLE,
  INDEX `indx_email` (`suppliers_email` ASC) INVISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cull_Dampolla`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cull_Dampolla`.`addresses` (
  `addresses_id` INT NOT NULL AUTO_INCREMENT,
  `addresses_street` VARCHAR(60) NULL,
  `addresses_str_number` INT NULL,
  `addresses_dpt_floor` VARCHAR(45) NULL,
  `addresses_dpt_number` INT NULL,
  `addresses_postalcode` VARCHAR(10) NOT NULL,
  `addresses_city` VARCHAR(45) NULL,
  `addresses_country` VARCHAR(45) NULL,
  PRIMARY KEY (`addresses_id`),
  INDEX `indx_addresses_country` (`addresses_country` ASC) INVISIBLE,
  INDEX `indx_addresses_city` (`addresses_city` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cull_Dampolla`.`supplier_has_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cull_Dampolla`.`supplier_has_address` (
  `suppliers_suppliers_id` INT NOT NULL,
  `addresses_addresses_id` INT NOT NULL,
  PRIMARY KEY (`suppliers_suppliers_id`, `addresses_addresses_id`),
  INDEX `fk_supplier_has_address_suppliers1_idx` (`suppliers_suppliers_id` ASC) INVISIBLE,
  INDEX `fk_supplier_has_address_addresses1_idx` (`addresses_addresses_id` ASC) VISIBLE,
  CONSTRAINT `fk_supplier_has_address_suppliers1`
    FOREIGN KEY (`suppliers_suppliers_id`)
    REFERENCES `Cull_Dampolla`.`suppliers` (`suppliers_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_supplier_has_address_addresses1`
    FOREIGN KEY (`addresses_addresses_id`)
    REFERENCES `Cull_Dampolla`.`addresses` (`addresses_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cull_Dampolla`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cull_Dampolla`.`customers` (
  `customers_id` INT NOT NULL AUTO_INCREMENT,
  `customers_name` VARCHAR(45) NOT NULL,
  `customers_phone` VARCHAR(45) NULL,
  `customers_email` VARCHAR(255) NULL,
  `customers_reffered_by_customers_id` INT NULL COMMENT 'This column identifies which other customer has recommended our company to this customer.',
  `customers_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `customers_lastupdate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`customers_id`),
  INDEX `indx_name` (`customers_name` ASC) VISIBLE,
  INDEX `indx_email` (`customers_email` ASC) VISIBLE,
  INDEX `fk_customers_customers1_idx` (`customers_reffered_by_customers_id` ASC) INVISIBLE,
  CONSTRAINT `fk_customers_customers1`
    FOREIGN KEY (`customers_reffered_by_customers_id`)
    REFERENCES `Cull_Dampolla`.`customers` (`customers_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cull_Dampolla`.`customer_has_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cull_Dampolla`.`customer_has_address` (
  `customers_customers_id` INT NOT NULL,
  `addresses_addresses_id` INT NOT NULL,
  PRIMARY KEY (`customers_customers_id`, `addresses_addresses_id`),
  INDEX `fk_customer_has_address_customers1_idx` (`customers_customers_id` ASC) VISIBLE,
  INDEX `fk_customer_has_address_addresses1_idx` (`addresses_addresses_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_has_address_customers1`
    FOREIGN KEY (`customers_customers_id`)
    REFERENCES `Cull_Dampolla`.`customers` (`customers_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_customer_has_address_addresses1`
    FOREIGN KEY (`addresses_addresses_id`)
    REFERENCES `Cull_Dampolla`.`addresses` (`addresses_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cull_Dampolla`.`glasses_brands`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cull_Dampolla`.`glasses_brands` (
  `glasses_brands_id` INT NOT NULL AUTO_INCREMENT,
  `glasses_brands_name` VARCHAR(80) NULL,
  `suppliers_suppliers_id` INT NOT NULL,
  PRIMARY KEY (`glasses_brands_id`),
  INDEX `fk_glasses_brands_suppliers1_idx` (`suppliers_suppliers_id` ASC) VISIBLE,
  INDEX `indx_glasses_brands_name` (`glasses_brands_name` ASC) VISIBLE,
  CONSTRAINT `fk_glasses_brands_suppliers1`
    FOREIGN KEY (`suppliers_suppliers_id`)
    REFERENCES `Cull_Dampolla`.`suppliers` (`suppliers_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cull_Dampolla`.`eyeglasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cull_Dampolla`.`eyeglasses` (
  `eyeglasses_id` INT NOT NULL AUTO_INCREMENT,
  `glasses_brands_glasses_brands_id` INT NOT NULL,
  `eyeglasses_right_glass_graduation` DECIMAL(4,2) NULL,
  `eyeglasses_left_glass_graduation` DECIMAL(4,2) NULL,
  `eyeglasses_frame` ENUM('FLOATING', 'METALLIC', 'PLASTIC') NULL,
  `eyeglasses_frame_color` VARCHAR(45) NOT NULL,
  `eyeglasses_right_glass_color` VARCHAR(45) NULL,
  `eyeglasses_left_glass_color` VARCHAR(45) NULL,
  `eyeglasses_price` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`eyeglasses_id`),
  INDEX `indx_frame` (`eyeglasses_frame` ASC) INVISIBLE,
  INDEX `indx_frame_color` (`eyeglasses_frame_color` ASC) INVISIBLE,
  INDEX `indx_glass_color` (`eyeglasses_left_glass_color` ASC) INVISIBLE,
  INDEX `indx_price` (`eyeglasses_price` ASC) VISIBLE,
  INDEX `fk_eyeglasses_glasses_brands1_idx` (`glasses_brands_glasses_brands_id` ASC) VISIBLE,
  CONSTRAINT `fk_eyeglasses_glasses_brands1`
    FOREIGN KEY (`glasses_brands_glasses_brands_id`)
    REFERENCES `Cull_Dampolla`.`glasses_brands` (`glasses_brands_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cull_Dampolla`.`sales_force`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cull_Dampolla`.`sales_force` (
  `sales_force_id` INT NOT NULL AUTO_INCREMENT,
  `sales_force_full_name` VARCHAR(100) NULL,
  PRIMARY KEY (`sales_force_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cull_Dampolla`.`sales_orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cull_Dampolla`.`sales_orders` (
  `sales_orders_id` INT NOT NULL AUTO_INCREMENT,
  `customers_customers_id` INT NOT NULL,
  `sales_orders_total_amount` DECIMAL(8,2) NULL COMMENT 'This attribute comes from the addition of each order_details.item_price',
  `sales_orders_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sales_orders_id`),
  INDEX `fk_sales_orders_customers1_idx` (`customers_customers_id` ASC) VISIBLE,
  CONSTRAINT `fk_sales_orders_customers1`
    FOREIGN KEY (`customers_customers_id`)
    REFERENCES `Cull_Dampolla`.`customers` (`customers_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cull_Dampolla`.`order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cull_Dampolla`.`order_details` (
  `order_details_eyeglasses_id` INT NOT NULL,
  `sales_orders_sales_orders_id` INT NOT NULL,
  `sales_force_sales_force_id` INT NOT NULL,
  INDEX `fk_sf_sold_eyeglass_eyeglasses1_idx` (`order_details_eyeglasses_id` ASC) VISIBLE,
  PRIMARY KEY (`order_details_eyeglasses_id`, `sales_orders_sales_orders_id`),
  INDEX `fk_order_details_sales_orders1_idx` (`sales_orders_sales_orders_id` ASC) VISIBLE,
  INDEX `fk_order_details_sales_force1_idx` (`sales_force_sales_force_id` ASC) VISIBLE,
  CONSTRAINT `fk_sf_sold_eyeglass_eyeglasses1`
    FOREIGN KEY (`order_details_eyeglasses_id`)
    REFERENCES `Cull_Dampolla`.`eyeglasses` (`eyeglasses_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_details_sales_orders1`
    FOREIGN KEY (`sales_orders_sales_orders_id`)
    REFERENCES `Cull_Dampolla`.`sales_orders` (`sales_orders_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_details_sales_force1`
    FOREIGN KEY (`sales_force_sales_force_id`)
    REFERENCES `Cull_Dampolla`.`sales_force` (`sales_force_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
