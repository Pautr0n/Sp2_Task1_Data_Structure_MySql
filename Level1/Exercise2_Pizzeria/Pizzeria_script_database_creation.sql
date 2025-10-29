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
  `provinces_id` INT NOT NULL AUTO_INCREMENT,
  `provinces_name` VARCHAR(45) NULL,
  PRIMARY KEY (`provinces_id`),
  INDEX `indx_provinces_name` (`provinces_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`towns`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`towns` (
  `towns_id` INT NOT NULL AUTO_INCREMENT,
  `towns_name` VARCHAR(60) NOT NULL,
  `towns_postal_code` VARCHAR(15) NOT NULL,
  `provinces_provinces_id` INT NOT NULL,
  PRIMARY KEY (`towns_id`),
  UNIQUE INDEX `towns_postal_code_UNIQUE` (`towns_postal_code` ASC) VISIBLE,
  INDEX `fk_towns_provinces_idx` (`provinces_provinces_id` ASC) INVISIBLE,
  INDEX `indx_towns_name` (`towns_name` ASC) INVISIBLE,
  CONSTRAINT `fk_towns_provinces`
    FOREIGN KEY (`provinces_provinces_id`)
    REFERENCES `Pizzeria`.`provinces` (`provinces_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`customers` (
  `customers_id` INT NOT NULL AUTO_INCREMENT,
  `towns_towns_id` INT NOT NULL,
  `customers_name` VARCHAR(45) NULL,
  `customers_surname` VARCHAR(45) NULL,
  `customers_address` VARCHAR(80) NULL,
  `customers_created_on` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `customers_last_update` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `fk_customers_towns1_idx` (`towns_towns_id` ASC) VISIBLE,
  PRIMARY KEY (`customers_id`),
  INDEX `indx_customers_name` (`customers_name` ASC) INVISIBLE,
  INDEX `indx_customers_surname` (`customers_surname` ASC) VISIBLE,
  CONSTRAINT `fk_customers_towns1`
    FOREIGN KEY (`towns_towns_id`)
    REFERENCES `Pizzeria`.`towns` (`towns_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`restaurants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`restaurants` (
  `restaurants_id` INT NOT NULL AUTO_INCREMENT,
  `restaurants_address` VARCHAR(60) NULL,
  `towns_towns_id` INT NOT NULL,
  PRIMARY KEY (`restaurants_id`),
  INDEX `fk_restaurants_towns1_idx` (`towns_towns_id` ASC) VISIBLE,
  CONSTRAINT `fk_restaurants_towns1`
    FOREIGN KEY (`towns_towns_id`)
    REFERENCES `Pizzeria`.`towns` (`towns_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`pizza_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`pizza_categories` (
  `pizza_categories_id` INT NOT NULL AUTO_INCREMENT,
  `pizza_categories_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pizza_categories_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`sales_orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`sales_orders` (
  `sales_orders_id` INT NOT NULL AUTO_INCREMENT,
  `restaurants_restaurants_id` INT NOT NULL,
  `customers_customers_id` INT NOT NULL,
  `sales_orders_type` ENUM('Delivery', 'Restaurant') NOT NULL,
  `sales_orders_total_price` DECIMAL(6,2) NOT NULL,
  `sales_orders_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sales_orders_id`),
  INDEX `fk_sales_orders_customers1_idx` (`customers_customers_id` ASC) VISIBLE,
  INDEX `fk_sales_orders_restaurants1_idx` (`restaurants_restaurants_id` ASC) VISIBLE,
  CONSTRAINT `fk_sales_orders_customers1`
    FOREIGN KEY (`customers_customers_id`)
    REFERENCES `Pizzeria`.`customers` (`customers_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_sales_orders_restaurants1`
    FOREIGN KEY (`restaurants_restaurants_id`)
    REFERENCES `Pizzeria`.`restaurants` (`restaurants_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`products` (
  `products_id` INT NOT NULL AUTO_INCREMENT,
  `products_name` VARCHAR(45) NOT NULL,
  `products_description` VARCHAR(200) NULL,
  `products_image` MEDIUMBLOB NULL,
  `products_price` DECIMAL(4,2) NOT NULL,
  `products_type` ENUM('Pizza', 'Hamburguer', 'Beverages') NOT NULL,
  `products_created_on` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `products_last_update` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`products_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`order_details` (
  `sales_orders_sales_orders_id` INT NOT NULL,
  `products_products_id` INT NOT NULL,
  `order_details_quantity` INT NULL,
  PRIMARY KEY (`sales_orders_sales_orders_id`, `products_products_id`),
  INDEX `fk_order_details_products1_idx` (`products_products_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_details_sales_orders1`
    FOREIGN KEY (`sales_orders_sales_orders_id`)
    REFERENCES `Pizzeria`.`sales_orders` (`sales_orders_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_details_products1`
    FOREIGN KEY (`products_products_id`)
    REFERENCES `Pizzeria`.`products` (`products_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`employees` (
  `employees_id` INT NOT NULL AUTO_INCREMENT,
  `restaurants_restaurants_id` INT NOT NULL,
  `employees_name` VARCHAR(45) NOT NULL,
  `employees_surname` VARCHAR(45) NOT NULL,
  `employees_DNI` VARCHAR(9) NOT NULL,
  `employees_job_position` ENUM('Kitchen', 'Delivery') NOT NULL,
  `employees_created_on` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `employees_last_update` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delivery_sales_orders_sales_orders_id` INT NOT NULL,
  `delivery_sales_orders_customers_customers_id` INT NOT NULL,
  PRIMARY KEY (`employees_id`, `delivery_sales_orders_sales_orders_id`, `delivery_sales_orders_customers_customers_id`),
  UNIQUE INDEX `employees_DNI_UNIQUE` (`employees_DNI` ASC) INVISIBLE,
  INDEX `indx_employees_name` (`employees_name` ASC) INVISIBLE,
  INDEX `indx_employees_surname` (`employees_surname` ASC) INVISIBLE,
  INDEX `fk_employees_restaurants1_idx` (`restaurants_restaurants_id` ASC) VISIBLE,
  CONSTRAINT `fk_employees_restaurants1`
    FOREIGN KEY (`restaurants_restaurants_id`)
    REFERENCES `Pizzeria`.`restaurants` (`restaurants_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`phones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`phones` (
  `phones_id` INT NOT NULL AUTO_INCREMENT,
  `phones_number` VARCHAR(45) NULL COMMENT 'VARCHAR as it may include + and ()',
  PRIMARY KEY (`phones_id`),
  INDEX `indx_phones_number` (`phones_number` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`employee_has_phone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`employee_has_phone` (
  `employees_employees_id` INT NOT NULL,
  `phones_phones_id` INT NOT NULL,
  PRIMARY KEY (`employees_employees_id`, `phones_phones_id`),
  INDEX `fk_employee_has_phone_employees1_idx` (`employees_employees_id` ASC) VISIBLE,
  INDEX `fk_employee_has_phone_phones1_idx` (`phones_phones_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_has_phone_employees1`
    FOREIGN KEY (`employees_employees_id`)
    REFERENCES `Pizzeria`.`employees` (`employees_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_employee_has_phone_phones1`
    FOREIGN KEY (`phones_phones_id`)
    REFERENCES `Pizzeria`.`phones` (`phones_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`customer_has_phone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`customer_has_phone` (
  `phones_phones_id` INT NOT NULL,
  `customers_customers_id` INT NOT NULL,
  PRIMARY KEY (`phones_phones_id`, `customers_customers_id`),
  INDEX `fk_customer_has_phone_customers1_idx` (`customers_customers_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_has_phone_phones1`
    FOREIGN KEY (`phones_phones_id`)
    REFERENCES `Pizzeria`.`phones` (`phones_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_customer_has_phone_customers1`
    FOREIGN KEY (`customers_customers_id`)
    REFERENCES `Pizzeria`.`customers` (`customers_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`pizzas_has_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`pizzas_has_category` (
  `products_products_id` INT NOT NULL,
  `pizza_categories_pizza_categories_id` INT NOT NULL,
  PRIMARY KEY (`products_products_id`, `pizza_categories_pizza_categories_id`),
  INDEX `fk_pizzas_has_category_pizza_categories1_idx` (`pizza_categories_pizza_categories_id` ASC) VISIBLE,
  CONSTRAINT `fk_pizzas_products1`
    FOREIGN KEY (`products_products_id`)
    REFERENCES `Pizzeria`.`products` (`products_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pizzas_has_category_pizza_categories1`
    FOREIGN KEY (`pizza_categories_pizza_categories_id`)
    REFERENCES `Pizzeria`.`pizza_categories` (`pizza_categories_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`delivery` (
  `sales_orders_sales_orders_id` INT NOT NULL,
  `employees_employees_id` INT NOT NULL,
  `delivery_time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sales_orders_sales_orders_id`, `employees_employees_id`),
  INDEX `fk_delivery_employees1_idx` (`employees_employees_id` ASC) VISIBLE,
  INDEX `fk_delivery_sales_orders1_idx` (`sales_orders_sales_orders_id` ASC) VISIBLE,
  CONSTRAINT `fk_delivery_employees1`
    FOREIGN KEY (`employees_employees_id`)
    REFERENCES `Pizzeria`.`employees` (`employees_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_delivery_sales_orders1`
    FOREIGN KEY (`sales_orders_sales_orders_id`)
    REFERENCES `Pizzeria`.`sales_orders` (`sales_orders_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
