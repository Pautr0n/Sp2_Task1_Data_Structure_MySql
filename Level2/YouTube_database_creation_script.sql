-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `youtube` DEFAULT CHARACTER SET utf8 ;
USE `youtube` ;

-- -----------------------------------------------------
-- Table `youtube`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`users` (
  `users_id` INT NOT NULL AUTO_INCREMENT,
  `users_email` VARCHAR(255) NOT NULL,
  `users_password_hash` VARCHAR(255) NOT NULL,
  `users_name` VARCHAR(60) NOT NULL,
  `users_birth_date` DATE NULL,
  `users_gender` ENUM('M', 'F', 'N/A') NOT NULL,
  `users_country` VARCHAR(60) NULL,
  `users_postal_code` VARCHAR(20) NULL,
  PRIMARY KEY (`users_id`),
  UNIQUE INDEX `users_email_UNIQUE` (`users_email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`videos` (
  `videos_id` INT NOT NULL AUTO_INCREMENT,
  `users_users_id` INT NOT NULL,
  `videos_title` VARCHAR(80) NOT NULL,
  `videos_description` VARCHAR(255) NULL,
  `videos_size` BIGINT UNSIGNED NOT NULL,
  `videos_file_name` VARCHAR(255) NOT NULL,
  `videos_length` INT UNSIGNED NULL,
  `videos_reproductions` BIGINT UNSIGNED NOT NULL,
  `videos_thumbnail` MEDIUMBLOB NOT NULL,
  `videos_state` ENUM('Private', 'Public', 'Hidden') NOT NULL,
  `videos_publication_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`videos_id`),
  INDEX `fk_videos_users1_idx` (`users_users_id` ASC) VISIBLE,
  CONSTRAINT `fk_videos_users1`
    FOREIGN KEY (`users_users_id`)
    REFERENCES `youtube`.`users` (`users_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`video_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`video_tags` (
  `video_tags_id` INT NOT NULL AUTO_INCREMENT,
  `video_tags_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`video_tags_id`),
  UNIQUE INDEX `video_tags_name_UNIQUE` (`video_tags_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`channels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`channels` (
  `channels_id` INT NOT NULL AUTO_INCREMENT,
  `users_users_id` INT NOT NULL,
  `videos_videos_id` INT NOT NULL,
  `channels_name` VARCHAR(45) NOT NULL,
  `channels_description` VARCHAR(255) NULL,
  `channels_created_on` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`channels_id`),
  INDEX `fk_channels_users1_idx` (`users_users_id` ASC) VISIBLE,
  INDEX `fk_channels_videos1_idx` (`videos_videos_id` ASC) VISIBLE,
  CONSTRAINT `fk_channels_users1`
    FOREIGN KEY (`users_users_id`)
    REFERENCES `youtube`.`users` (`users_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_channels_videos1`
    FOREIGN KEY (`videos_videos_id`)
    REFERENCES `youtube`.`videos` (`videos_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`user_is_subscribed`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`user_is_subscribed` (
  `channels_channels_id` INT NOT NULL,
  `users_users_id` INT NOT NULL,
  PRIMARY KEY (`channels_channels_id`, `users_users_id`),
  INDEX `fk_user_is_subscribed_users1_idx` (`users_users_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_is_subscribed_channels1`
    FOREIGN KEY (`channels_channels_id`)
    REFERENCES `youtube`.`channels` (`channels_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_is_subscribed_users1`
    FOREIGN KEY (`users_users_id`)
    REFERENCES `youtube`.`users` (`users_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`user_playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`user_playlist` (
  `user_playlist_id` INT NOT NULL AUTO_INCREMENT,
  `user_playlist_name` VARCHAR(45) NOT NULL,
  `user_playlist_creation_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `user_playlist_state` ENUM('Public', 'Private') NOT NULL,
  `users_users_id` INT NOT NULL,
  PRIMARY KEY (`user_playlist_id`),
  INDEX `fk_user_playlist_users1_idx` (`users_users_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_playlist_users1`
    FOREIGN KEY (`users_users_id`)
    REFERENCES `youtube`.`users` (`users_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`playlist_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`playlist_details` (
  `videos_videos_id` INT NOT NULL,
  `user_playlist_user_playlist_id` INT NOT NULL,
  PRIMARY KEY (`videos_videos_id`, `user_playlist_user_playlist_id`),
  INDEX `fk_playlist_details_user_playlist1_idx` (`user_playlist_user_playlist_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_details_videos1`
    FOREIGN KEY (`videos_videos_id`)
    REFERENCES `youtube`.`videos` (`videos_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlist_details_user_playlist1`
    FOREIGN KEY (`user_playlist_user_playlist_id`)
    REFERENCES `youtube`.`user_playlist` (`user_playlist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`user_video_reactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`user_video_reactions` (
  `users_users_id` INT NOT NULL,
  `videos_videos_id` INT NOT NULL,
  `user_video_reactions_reaction` ENUM('Like', 'Dislike') NOT NULL,
  `user_video_reactions_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`users_users_id`, `videos_videos_id`),
  INDEX `fk_user_like_video_videos1_idx` (`videos_videos_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_like_video_users1`
    FOREIGN KEY (`users_users_id`)
    REFERENCES `youtube`.`users` (`users_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_like_video_videos1`
    FOREIGN KEY (`videos_videos_id`)
    REFERENCES `youtube`.`videos` (`videos_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`video_tags_has_videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`video_tags_has_videos` (
  `video_tags_video_tags_id` INT NOT NULL,
  `videos_videos_id` INT NOT NULL,
  PRIMARY KEY (`video_tags_video_tags_id`, `videos_videos_id`),
  INDEX `fk_video_tags_has_videos_videos1_idx` (`videos_videos_id` ASC) VISIBLE,
  INDEX `fk_video_tags_has_videos_video_tags_idx` (`video_tags_video_tags_id` ASC) VISIBLE,
  CONSTRAINT `fk_video_tags_has_videos_video_tags`
    FOREIGN KEY (`video_tags_video_tags_id`)
    REFERENCES `youtube`.`video_tags` (`video_tags_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_video_tags_has_videos_videos1`
    FOREIGN KEY (`videos_videos_id`)
    REFERENCES `youtube`.`videos` (`videos_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`video_comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`video_comments` (
  `video_comments_id` INT NOT NULL AUTO_INCREMENT,
  `users_users_id` INT NOT NULL,
  `videos_videos_id` INT NOT NULL,
  `video_comments_comment` VARCHAR(255) NOT NULL,
  `video_comments_created_on` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`video_comments_id`),
  INDEX `fk_video_comments_users1_idx` (`users_users_id` ASC) VISIBLE,
  INDEX `fk_video_comments_videos1_idx` (`videos_videos_id` ASC) VISIBLE,
  CONSTRAINT `fk_video_comments_users1`
    FOREIGN KEY (`users_users_id`)
    REFERENCES `youtube`.`users` (`users_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_video_comments_videos1`
    FOREIGN KEY (`videos_videos_id`)
    REFERENCES `youtube`.`videos` (`videos_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`user_comment_reactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`user_comment_reactions` (
  `users_users_id` INT NOT NULL,
  `video_comments_video_comments_id` INT NOT NULL,
  `user_comment_reaction_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_comment_reaction_reaction` ENUM('Like', 'Dislike') NOT NULL,
  PRIMARY KEY (`users_users_id`, `video_comments_video_comments_id`),
  INDEX `fk_user_comment_reaction_video_comments1_idx` (`video_comments_video_comments_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_comment_reaction_users1`
    FOREIGN KEY (`users_users_id`)
    REFERENCES `youtube`.`users` (`users_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_comment_reaction_video_comments1`
    FOREIGN KEY (`video_comments_video_comments_id`)
    REFERENCES `youtube`.`video_comments` (`video_comments_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
