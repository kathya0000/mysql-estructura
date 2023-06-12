-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema YouTube
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema YouTube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `YouTube` DEFAULT CHARACTER SET utf8 ;
USE `YouTube` ;

-- -----------------------------------------------------
-- Table `YouTube`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Usuario` (
  `id_User` INT NOT NULL,
  `e-mail` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `fechaNacimiento` DATE NOT NULL,
  `sexo` VARCHAR(1) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `codigoPostal` INT NOT NULL,
  PRIMARY KEY (`id_User`),
  UNIQUE INDEX `e-mail_UNIQUE` (`e-mail` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`EstadosDeVideo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`EstadosDeVideo` (
  `id_EstadosDeVideo` INT NOT NULL,
  `nombreEstado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_EstadosDeVideo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Video` (
  `id_Video` INT NOT NULL,
  `id_User` INT NOT NULL,
  `id_EstadosDeVideo` INT NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(255) NOT NULL,
  `tamano` INT NOT NULL,
  `nombreArchivo` VARCHAR(45) NOT NULL,
  `duracion` INT NOT NULL,
  `thumbanail` VARCHAR(225) NOT NULL,
  `numeroreproduciones` INT NOT NULL,
  `numeroLikes` INT NOT NULL,
  `numeroDislike` INT NOT NULL,
  `fechaPublicaciones` DATETIME NOT NULL,
  PRIMARY KEY (`id_Video`),
  INDEX `id_Usuario_idx` (`id_User` ASC) VISIBLE,
  INDEX `id_EstadosDeVideo_idx` (`id_EstadosDeVideo` ASC) VISIBLE,
  CONSTRAINT `id_User`
    FOREIGN KEY (`id_User`)
    REFERENCES `YouTube`.`Usuario` (`id_User`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_EstadosDeVideo`
    FOREIGN KEY (`id_EstadosDeVideo`)
    REFERENCES `YouTube`.`EstadosDeVideo` (`id_EstadosDeVideo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Etiqueta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Etiqueta` (
  `id_Etiqueta` INT NOT NULL,
  `nombreEtiqueta` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Etiqueta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`VideoEtiqueta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`VideoEtiqueta` (
  `id_VideoEtiqueta` INT NOT NULL,
  `id_Video` INT NOT NULL,
  `id_Etiqueta` INT NOT NULL,
  PRIMARY KEY (`id_VideoEtiqueta`),
  INDEX `id_Video_idx` (`id_Video` ASC) VISIBLE,
  INDEX `id_Etiqueta_idx` (`id_Etiqueta` ASC) VISIBLE,
  CONSTRAINT `id_Video`
    FOREIGN KEY (`id_Video`)
    REFERENCES `YouTube`.`Video` (`id_Video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_Etiqueta`
    FOREIGN KEY (`id_Etiqueta`)
    REFERENCES `YouTube`.`Etiqueta` (`id_Etiqueta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Canal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Canal` (
  `id_Canal` INT NOT NULL,
  `id_User` INT NOT NULL,
  `nombreCanal` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(225) NOT NULL,
  `fechaCreacion` DATE NOT NULL,
  PRIMARY KEY (`id_Canal`),
  INDEX `id_Usuario_idx` (`id_User` ASC) VISIBLE,
  CONSTRAINT `id_User`
    FOREIGN KEY (`id_User`)
    REFERENCES `YouTube`.`Usuario` (`id_User`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Suscripcion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Suscripcion` (
  `id_Suscripcion` INT NOT NULL,
  `id_User` INT NOT NULL,
  `id_Canal` INT NOT NULL,
  PRIMARY KEY (`id_Suscripcion`),
  INDEX `id_User_idx` (`id_User` ASC) VISIBLE,
  INDEX `id_Canal_idx` (`id_Canal` ASC) VISIBLE,
  CONSTRAINT `id_User`
    FOREIGN KEY (`id_User`)
    REFERENCES `YouTube`.`Usuario` (`id_User`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_Canal`
    FOREIGN KEY (`id_Canal`)
    REFERENCES `YouTube`.`Canal` (`id_Canal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`PlayList`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`PlayList` (
  `id_PlayList` INT NOT NULL,
  `id_User` INT NOT NULL,
  `nombrePlayList` VARCHAR(45) NOT NULL,
  `fechacreacion` INT NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_PlayList`),
  INDEX `id_User_idx` (`id_User` ASC) VISIBLE,
  CONSTRAINT `id_User`
    FOREIGN KEY (`id_User`)
    REFERENCES `YouTube`.`Usuario` (`id_User`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`VideoPlayList`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`VideoPlayList` (
  `id_VideoPlayList` INT NOT NULL,
  `id_Video` INT NOT NULL,
  `id_PlayList` INT NOT NULL,
  PRIMARY KEY (`id_VideoPlayList`),
  INDEX `id_Video_idx` (`id_Video` ASC) VISIBLE,
  INDEX `id_PlayList_idx` (`id_PlayList` ASC) VISIBLE,
  CONSTRAINT `id_Video`
    FOREIGN KEY (`id_Video`)
    REFERENCES `YouTube`.`Video` (`id_Video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_PlayList`
    FOREIGN KEY (`id_PlayList`)
    REFERENCES `YouTube`.`PlayList` (`id_PlayList`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Comentario` (
  `id_Comentario` INT NOT NULL,
  `id_Video` INT NOT NULL,
  `id_User` INT NOT NULL,
  `textoComentario` VARCHAR(225) NOT NULL,
  `fechaComentario` INT NOT NULL,
  PRIMARY KEY (`id_Comentario`),
  INDEX `id_Video_idx` (`id_Video` ASC) VISIBLE,
  INDEX `id_User_idx` (`id_User` ASC) VISIBLE,
  CONSTRAINT `id_Video`
    FOREIGN KEY (`id_Video`)
    REFERENCES `YouTube`.`Video` (`id_Video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_User`
    FOREIGN KEY (`id_User`)
    REFERENCES `YouTube`.`Usuario` (`id_User`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Like_dislike_Video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Like_dislike_Video` (
  `id_like_dislike_Video` INT NOT NULL,
  `id_User` INT NOT NULL,
  `id_Video` INT NOT NULL,
  `tipoMeGustaNoGusta` VARCHAR(45) NOT NULL,
  `fecha` DATE NOT NULL,
  PRIMARY KEY (`id_like_dislike_Video`),
  INDEX `id_User_idx` (`id_User` ASC) VISIBLE,
  INDEX `id_Video_idx` (`id_Video` ASC) VISIBLE,
  CONSTRAINT `id_User`
    FOREIGN KEY (`id_User`)
    REFERENCES `YouTube`.`Usuario` (`id_User`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_Video`
    FOREIGN KEY (`id_Video`)
    REFERENCES `YouTube`.`Video` (`id_Video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Like_Dislike_Comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Like_Dislike_Comentario` (
  `id_Like_dislike_Comentario` INT NOT NULL,
  `id_User` INT NOT NULL,
  `id_Video` INT NOT NULL,
  `Id_Comentario` INT NOT NULL,
  `tipoMeGustaNoGusta` VARCHAR(45) NOT NULL,
  `fecha` DATE NOT NULL,
  PRIMARY KEY (`id_Like_dislike_Comentario`),
  INDEX `id_User_idx` (`id_User` ASC) VISIBLE,
  INDEX `id_Video_idx` (`id_Video` ASC) VISIBLE,
  INDEX `id_Comentario_idx` (`Id_Comentario` ASC) VISIBLE,
  CONSTRAINT `id_User0`
    FOREIGN KEY (`id_User`)
    REFERENCES `YouTube`.`Usuario` (`id_User`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_Video0`
    FOREIGN KEY (`id_Video`)
    REFERENCES `YouTube`.`Video` (`id_Video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_Comentario0`
    FOREIGN KEY (`Id_Comentario`)
    REFERENCES `YouTube`.`Comentario` (`id_Comentario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
