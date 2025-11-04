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
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `password_sha` VARCHAR(255) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `birthdate` DATE NOT NULL,
  `gender` ENUM('M', 'F', 'N/A') NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `postalcode` VARCHAR(10) NOT NULL,
  `type` ENUM('Free', 'Premium') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `user_email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`subscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`subscriptions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `starts_on` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `finishes_on` DATETIME NOT NULL,
  `payment_method` ENUM('Card', 'Paypal') NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_subscriptions_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_subscriptions_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`subscribed_by_paypayl`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`subscribed_by_paypayl` (
  `user_id` INT NOT NULL,
  `subscription_id` INT NOT NULL,
  `paypal_username` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`, `subscription_id`),
  INDEX `fk_subscribed_by_papayl_subscriptions1_idx` (`subscription_id` ASC) VISIBLE,
  CONSTRAINT `fk_subscribed_by_papayl_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_subscribed_by_papayl_subscriptions1`
    FOREIGN KEY (`subscription_id`)
    REFERENCES `spotify`.`subscriptions` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`subscribed_by_card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`subscribed_by_card` (
  `user_id` INT NOT NULL,
  `subscription_id` INT NOT NULL,
  `card_number` VARCHAR(19) NOT NULL,
  `card_expiry_month` VARCHAR(2) NOT NULL,
  `card_expiry_year` VARCHAR(4) NOT NULL,
  `card_cvv` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`user_id`, `subscription_id`),
  INDEX `fk_subscribed_by_card_subscriptions1_idx` (`subscription_id` ASC) VISIBLE,
  CONSTRAINT `fk_subscribed_by_card_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_subscribed_by_card_subscriptions1`
    FOREIGN KEY (`subscription_id`)
    REFERENCES `spotify`.`subscriptions` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`payment_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`payment_details` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `subscription_id` INT NOT NULL,
  `date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `total` DECIMAL(5,2) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_subscription_payment_subscriptions1_idx` (`subscription_id` ASC) VISIBLE,
  CONSTRAINT `fk_subscription_payment_subscriptions1`
    FOREIGN KEY (`subscription_id`)
    REFERENCES `spotify`.`subscriptions` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlists` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `created_on` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `total_songs` INT NOT NULL,
  `status` ENUM('Deleted', 'Active') NOT NULL,
  `deleted_on` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_playlists_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlists_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`artists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artists` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `image` MEDIUMBLOB NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`albums`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`albums` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `artist_id` INT NOT NULL,
  `title` VARCHAR(65) NOT NULL,
  `released_in` DATE NOT NULL,
  `cover` MEDIUMBLOB NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_albums_artists1_idx` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_albums_artists1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `spotify`.`artists` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`songs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`songs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `length` TIME NOT NULL,
  `total_reproductions` BIGINT NOT NULL,
  `album_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_songs_albums1_idx` (`album_id` ASC) VISIBLE,
  CONSTRAINT `fk_songs_albums1`
    FOREIGN KEY (`album_id`)
    REFERENCES `spotify`.`albums` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`playlists_has_songs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlists_has_songs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `playlist_id` INT NOT NULL,
  `song_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `song_position` BIGINT NOT NULL,
  `added_on` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_playlists_has_songs_playlists1_idx` (`playlist_id` ASC) VISIBLE,
  INDEX `fk_playlists_has_songs_songs1_idx` (`song_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  INDEX `fk_playlists_has_songs_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlists_has_songs_playlists1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `spotify`.`playlists` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlists_has_songs_songs1`
    FOREIGN KEY (`song_id`)
    REFERENCES `spotify`.`songs` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlists_has_songs_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`playlist_is_shared`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlist_is_shared` (
  `playlist_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`playlist_id`, `user_id`),
  INDEX `fk_playlist_is_shared_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_is_shared_playlists1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `spotify`.`playlists` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlist_is_shared_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`user_likes_song`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`user_likes_song` (
  `user_id` INT NOT NULL,
  `song_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `song_id`),
  INDEX `fk_users_has_songs_songs1_idx` (`song_id` ASC) VISIBLE,
  INDEX `fk_users_has_songs_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_songs_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_has_songs_songs1`
    FOREIGN KEY (`song_id`)
    REFERENCES `spotify`.`songs` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`user_likes_album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`user_likes_album` (
  `user_id` INT NOT NULL,
  `album_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `album_id`),
  INDEX `fk_users_has_albums_albums1_idx` (`album_id` ASC) VISIBLE,
  INDEX `fk_users_has_albums_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_albums_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_has_albums_albums1`
    FOREIGN KEY (`album_id`)
    REFERENCES `spotify`.`albums` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`artist_like_artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artist_like_artist` (
  `artists_id` INT NOT NULL,
  `artist_id1` INT NOT NULL,
  PRIMARY KEY (`artists_id`, `artist_id1`),
  INDEX `fk_artist_like_artist_artists2_idx` (`artist_id1` ASC) VISIBLE,
  CONSTRAINT `fk_artist_like_artist_artists1`
    FOREIGN KEY (`artists_id`)
    REFERENCES `spotify`.`artists` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_artist_like_artist_artists2`
    FOREIGN KEY (`artist_id1`)
    REFERENCES `spotify`.`artists` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`user_follows_artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`user_follows_artist` (
  `user_id` INT NOT NULL,
  `artist_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `artist_id`),
  INDEX `fk_users_has_artists_artists1_idx` (`artist_id` ASC) VISIBLE,
  INDEX `fk_users_has_artists_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_artists_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_has_artists_artists1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `spotify`.`artists` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `spotify`;

DELIMITER $$
USE `spotify`$$
CREATE DEFINER = CURRENT_USER TRIGGER `spotify`.`playlists_has_songs_AFTER_INSERT` AFTER INSERT ON `playlists_has_songs` FOR EACH ROW
BEGIN
UPDATE playlists
SET total_songs = total_songs + 1
WHERE id = NEW.id;
END$$

USE `spotify`$$
CREATE DEFINER = CURRENT_USER TRIGGER `spotify`.`playlists_has_songs_AFTER_DELETE` AFTER DELETE ON `playlists_has_songs` FOR EACH ROW
BEGIN
UPDATE playlists
SET total_songs = total_songs - 1
WHERE id = OLD.id;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
