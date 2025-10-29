-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema spotify
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema spotify
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `spotify` DEFAULT CHARACTER SET utf8 ;
USE `spotify` ;

-- -----------------------------------------------------
-- Table `spotify`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `users_email` VARCHAR(255) NOT NULL,
  `users_password_sha` VARCHAR(255) NOT NULL,
  `users_username` VARCHAR(45) NOT NULL,
  `users_birthdate` DATE NOT NULL,
  `users_gender` ENUM('M', 'F', 'N/A') NOT NULL,
  `users_country` VARCHAR(45) NOT NULL,
  `users_postalcode` VARCHAR(10) NOT NULL,
  `users_type` ENUM('Free', 'Premium') NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_email_UNIQUE` (`users_email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`subscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`subscriptions` (
  `subscriptions_id` INT NOT NULL AUTO_INCREMENT,
  `users_user_id` INT NOT NULL,
  `subscriptions_starts_on` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `subscriptions_finishes_on` DATETIME NOT NULL,
  `subscriptions_payment_method` ENUM('Card', 'Paypal') NOT NULL,
  PRIMARY KEY (`subscriptions_id`),
  INDEX `fk_subscriptions_users1_idx` (`users_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_subscriptions_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `spotify`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`subscribed_by_paypayl`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`subscribed_by_paypayl` (
  `users_user_id` INT NOT NULL,
  `subscriptions_subscriptions_id` INT NOT NULL,
  `subscribed_by_paypayl_paypal_username` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`users_user_id`, `subscriptions_subscriptions_id`),
  INDEX `fk_subscribed_by_papayl_subscriptions1_idx` (`subscriptions_subscriptions_id` ASC) VISIBLE,
  CONSTRAINT `fk_subscribed_by_papayl_users`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `spotify`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_subscribed_by_papayl_subscriptions1`
    FOREIGN KEY (`subscriptions_subscriptions_id`)
    REFERENCES `spotify`.`subscriptions` (`subscriptions_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`subscribed_by_card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`subscribed_by_card` (
  `users_user_id` INT NOT NULL,
  `subscriptions_subscriptions_id` INT NOT NULL,
  `subscribed_by_card_card_number` VARCHAR(19) NOT NULL,
  `subscribed_by_card_card_expiry_month` VARCHAR(2) NOT NULL,
  `subscribed_by_card_card_expiry_year` VARCHAR(4) NOT NULL,
  `subscribed_by_card_card_cvv` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`users_user_id`, `subscriptions_subscriptions_id`),
  INDEX `fk_subscribed_by_card_subscriptions1_idx` (`subscriptions_subscriptions_id` ASC) VISIBLE,
  CONSTRAINT `fk_subscribed_by_card_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `spotify`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_subscribed_by_card_subscriptions1`
    FOREIGN KEY (`subscriptions_subscriptions_id`)
    REFERENCES `spotify`.`subscriptions` (`subscriptions_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`subscription_payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`subscription_payment` (
  `subscription_payment_id` INT NOT NULL AUTO_INCREMENT,
  `subscriptions_subscriptions_id` INT NOT NULL,
  `subscription_payment_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `subscription_payment_total` DECIMAL(5,2) UNSIGNED NOT NULL,
  PRIMARY KEY (`subscription_payment_id`),
  INDEX `fk_subscription_payment_subscriptions1_idx` (`subscriptions_subscriptions_id` ASC) VISIBLE,
  CONSTRAINT `fk_subscription_payment_subscriptions1`
    FOREIGN KEY (`subscriptions_subscriptions_id`)
    REFERENCES `spotify`.`subscriptions` (`subscriptions_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlists` (
  `playlists_id` INT NOT NULL AUTO_INCREMENT,
  `users_user_id` INT NOT NULL,
  `playlists_name` VARCHAR(45) NOT NULL,
  `playlists_created_on` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `playlists_total_songs` INT NOT NULL,
  `playlists_status` ENUM('Deleted', 'Active') NOT NULL,
  `playlists_deleted_on` DATETIME NULL,
  PRIMARY KEY (`playlists_id`),
  INDEX `fk_playlists_users1_idx` (`users_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlists_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `spotify`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`artists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artists` (
  `artists_id` INT NOT NULL AUTO_INCREMENT,
  `artists_name` VARCHAR(45) NOT NULL,
  `artists_image` MEDIUMBLOB NOT NULL,
  PRIMARY KEY (`artists_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`albums`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`albums` (
  `albums_id` INT NOT NULL AUTO_INCREMENT,
  `artists_artists_id` INT NOT NULL,
  `albums_title` VARCHAR(65) NOT NULL,
  `albums_released_in` DATE NOT NULL,
  `albums_cover` MEDIUMBLOB NOT NULL,
  PRIMARY KEY (`albums_id`),
  INDEX `fk_albums_artists1_idx` (`artists_artists_id` ASC) VISIBLE,
  CONSTRAINT `fk_albums_artists1`
    FOREIGN KEY (`artists_artists_id`)
    REFERENCES `spotify`.`artists` (`artists_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`songs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`songs` (
  `songs_id` INT NOT NULL AUTO_INCREMENT,
  `songs_title` VARCHAR(45) NOT NULL,
  `songs_length` TIME NOT NULL,
  `songs_total_reproductions` BIGINT NOT NULL,
  `albums_albums_id` INT NOT NULL,
  PRIMARY KEY (`songs_id`),
  INDEX `fk_songs_albums1_idx` (`albums_albums_id` ASC) VISIBLE,
  CONSTRAINT `fk_songs_albums1`
    FOREIGN KEY (`albums_albums_id`)
    REFERENCES `spotify`.`albums` (`albums_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`playlists_has_songs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlists_has_songs` (
  `playlists_has_songs_id` INT NOT NULL AUTO_INCREMENT,
  `playlists_playlists_id` INT NOT NULL,
  `songs_songs_id` INT NOT NULL,
  `users_user_id` INT NOT NULL,
  `playlists_has_songs_song_position` BIGINT NOT NULL,
  `playlists_has_songs_added_on` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_playlists_has_songs_playlists1_idx` (`playlists_playlists_id` ASC) VISIBLE,
  INDEX `fk_playlists_has_songs_songs1_idx` (`songs_songs_id` ASC) VISIBLE,
  PRIMARY KEY (`playlists_has_songs_id`),
  INDEX `fk_playlists_has_songs_users1_idx` (`users_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlists_has_songs_playlists1`
    FOREIGN KEY (`playlists_playlists_id`)
    REFERENCES `spotify`.`playlists` (`playlists_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlists_has_songs_songs1`
    FOREIGN KEY (`songs_songs_id`)
    REFERENCES `spotify`.`songs` (`songs_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlists_has_songs_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `spotify`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`playlist_is_shared`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlist_is_shared` (
  `playlists_playlists_id` INT NOT NULL,
  `users_user_id` INT NOT NULL,
  PRIMARY KEY (`playlists_playlists_id`, `users_user_id`),
  INDEX `fk_playlist_is_shared_users1_idx` (`users_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_is_shared_playlists1`
    FOREIGN KEY (`playlists_playlists_id`)
    REFERENCES `spotify`.`playlists` (`playlists_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlist_is_shared_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `spotify`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`user_likes_song`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`user_likes_song` (
  `users_user_id` INT NOT NULL,
  `songs_songs_id` INT NOT NULL,
  PRIMARY KEY (`users_user_id`, `songs_songs_id`),
  INDEX `fk_users_has_songs_songs1_idx` (`songs_songs_id` ASC) VISIBLE,
  INDEX `fk_users_has_songs_users1_idx` (`users_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_songs_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `spotify`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_has_songs_songs1`
    FOREIGN KEY (`songs_songs_id`)
    REFERENCES `spotify`.`songs` (`songs_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`user_likes_album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`user_likes_album` (
  `users_user_id` INT NOT NULL,
  `albums_albums_id` INT NOT NULL,
  PRIMARY KEY (`users_user_id`, `albums_albums_id`),
  INDEX `fk_users_has_albums_albums1_idx` (`albums_albums_id` ASC) VISIBLE,
  INDEX `fk_users_has_albums_users1_idx` (`users_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_albums_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `spotify`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_has_albums_albums1`
    FOREIGN KEY (`albums_albums_id`)
    REFERENCES `spotify`.`albums` (`albums_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`artist_like_artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artist_like_artist` (
  `artists_artists_id` INT NOT NULL,
  `artists_artists_id1` INT NOT NULL,
  PRIMARY KEY (`artists_artists_id`, `artists_artists_id1`),
  INDEX `fk_artist_like_artist_artists2_idx` (`artists_artists_id1` ASC) VISIBLE,
  CONSTRAINT `fk_artist_like_artist_artists1`
    FOREIGN KEY (`artists_artists_id`)
    REFERENCES `spotify`.`artists` (`artists_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_artist_like_artist_artists2`
    FOREIGN KEY (`artists_artists_id1`)
    REFERENCES `spotify`.`artists` (`artists_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`user_follows_artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`user_follows_artist` (
  `users_user_id` INT NOT NULL,
  `artists_artists_id` INT NOT NULL,
  PRIMARY KEY (`users_user_id`, `artists_artists_id`),
  INDEX `fk_users_has_artists_artists1_idx` (`artists_artists_id` ASC) VISIBLE,
  INDEX `fk_users_has_artists_users1_idx` (`users_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_artists_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `spotify`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_has_artists_artists1`
    FOREIGN KEY (`artists_artists_id`)
    REFERENCES `spotify`.`artists` (`artists_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `spotify`;

DELIMITER $$
USE `spotify`$$
CREATE DEFINER = CURRENT_USER TRIGGER `spotify`.`playlists_has_songs_AFTER_INSERT` AFTER INSERT ON `playlists_has_songs` FOR EACH ROW
BEGIN
UPDATE playlists
SET playlists_total_songs = playlists_total_songs + 1
WHERE playlists_id = NEW.playlists_playlists_id;
END$$

USE `spotify`$$
CREATE DEFINER = CURRENT_USER TRIGGER `spotify`.`playlists_has_songs_AFTER_DELETE` AFTER DELETE ON `playlists_has_songs` FOR EACH ROW
BEGIN
UPDATE playlists
SET playlists_total_songs = playlists_total_songs - 1
WHERE playlists_id = OLD.playlists_playlists_id;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
