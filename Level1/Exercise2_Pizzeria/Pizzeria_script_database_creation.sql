-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `Pizzeria` ;

-- -----------------------------------------------------
-- Table `Pizzeria`.`provinces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`provinces` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `indx_provinces_name` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`towns`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`towns` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `postal_code` VARCHAR(15) NOT NULL,
  `province_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `towns_postal_code_UNIQUE` (`postal_code` ASC) VISIBLE,
  INDEX `fk_towns_provinces_idx` (`province_id` ASC) INVISIBLE,
  INDEX `indx_towns_name` (`name` ASC) INVISIBLE,
  CONSTRAINT `fk_towns_provinces`
    FOREIGN KEY (`province_id`)
    REFERENCES `Pizzeria`.`provinces` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`customers` (
  `customers_id` INT NOT NULL AUTO_INCREMENT,
  `town_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `address` VARCHAR(80) NOT NULL,
  `created_on` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `fk_customers_towns1_idx` (`town_id` ASC) VISIBLE,
  PRIMARY KEY (`customers_id`),
  INDEX `indx_customers_name` (`name` ASC) INVISIBLE,
  INDEX `indx_customers_surname` (`surname` ASC) VISIBLE,
  CONSTRAINT `fk_customers_towns1`
    FOREIGN KEY (`town_id`)
    REFERENCES `Pizzeria`.`towns` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`restaurants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`restaurants` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(60) NOT NULL,
  `towns_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_restaurants_towns1_idx` (`towns_id` ASC) VISIBLE,
  CONSTRAINT `fk_restaurants_towns1`
    FOREIGN KEY (`towns_id`)
    REFERENCES `Pizzeria`.`towns` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`pizza_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`pizza_categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`sales_orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`sales_orders` (
  `sales_order_id` INT NOT NULL AUTO_INCREMENT,
  `restaurant_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `order_type` ENUM('Delivery', 'Restaurant') NOT NULL,
  `total_price` DECIMAL(6,2) NOT NULL,
  `date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sales_order_id`),
  INDEX `fk_sales_orders_customers1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_sales_orders_restaurants1_idx` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `fk_sales_orders_customers1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Pizzeria`.`customers` (`customers_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_sales_orders_restaurants1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `Pizzeria`.`restaurants` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(200) NULL,
  `image` MEDIUMBLOB NULL,
  `price` DECIMAL(4,2) NOT NULL,
  `type` ENUM('Pizza', 'Hamburguer', 'Beverages') NOT NULL,
  `created_on` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`order_details` (
  `sale_order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`sale_order_id`, `product_id`),
  INDEX `fk_order_details_products1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_details_sales_orders1`
    FOREIGN KEY (`sale_order_id`)
    REFERENCES `Pizzeria`.`sales_orders` (`sales_order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_details_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `Pizzeria`.`products` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`employees` (
  `employees_id` INT NOT NULL AUTO_INCREMENT,
  `restaurant_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `dni` VARCHAR(9) NOT NULL,
  `job_position` ENUM('Kitchen', 'Delivery') NOT NULL,
  `created_on` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`employees_id`),
  UNIQUE INDEX `employees_DNI_UNIQUE` (`dni` ASC) INVISIBLE,
  INDEX `indx_employees_name` (`name` ASC) INVISIBLE,
  INDEX `indx_employees_surname` (`surname` ASC) INVISIBLE,
  INDEX `fk_employees_restaurants1_idx` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `fk_employees_restaurants1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `Pizzeria`.`restaurants` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`pizzas_has_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`pizzas_has_category` (
  `product_id` INT NOT NULL,
  `pizza_category_id` INT NOT NULL,
  PRIMARY KEY (`product_id`, `pizza_category_id`),
  INDEX `fk_pizzas_has_category_pizza_categories1_idx` (`pizza_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_pizzas_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `Pizzeria`.`products` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pizzas_has_category_pizza_categories1`
    FOREIGN KEY (`pizza_category_id`)
    REFERENCES `Pizzeria`.`pizza_categories` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`delivery` (
  `sales_order_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  `delivered_on` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sales_order_id`, `employee_id`),
  INDEX `fk_delivery_employees1_idx` (`employee_id` ASC) VISIBLE,
  INDEX `fk_delivery_sales_orders1_idx` (`sales_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_delivery_employees1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `Pizzeria`.`employees` (`employees_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_delivery_sales_orders1`
    FOREIGN KEY (`sales_order_id`)
    REFERENCES `Pizzeria`.`sales_orders` (`sales_order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
