-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Spotify
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Spotify
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Spotify` DEFAULT CHARACTER SET utf8 ;
USE `Spotify` ;

-- -----------------------------------------------------
-- Table `Spotify`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Usuario` (
  `id_Usuario` INT NOT NULL,
  `e-mail` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `fechaNacimiento` DATE NOT NULL,
  `sexo` VARCHAR(2) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `codigoPostal` INT NOT NULL,
  PRIMARY KEY (`id_Usuario`),
  UNIQUE INDEX `e-mail_UNIQUE` (`e-mail` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`UsuarioPremiun`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`UsuarioPremiun` (
  `id_UsuarioPremiun` INT NOT NULL,
  `id_Usuario` INT NOT NULL,
  `fecha_inicio_suscripcion` DATE NOT NULL,
  `fecha_renovacion` DATE NOT NULL,
  `forma_pago` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_UsuarioPremiun`),
  INDEX `id_Usuario_idx` (`id_Usuario` ASC) VISIBLE,
  CONSTRAINT `id_Usuario`
    FOREIGN KEY (`id_Usuario`)
    REFERENCES `Spotify`.`Usuario` (`id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`TarjetaCredito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`TarjetaCredito` (
  `id_TarjetaCredito` INT NOT NULL,
  `id_UsuarioPremiun` INT NOT NULL,
  `numero_tarjeta` INT NOT NULL,
  `mes_caducidad` INT NOT NULL,
  `año_caducidad` INT NOT NULL,
  `codigo_seguridad` INT NOT NULL,
  PRIMARY KEY (`id_TarjetaCredito`),
  INDEX `id_UsuarioPremiun_idx` (`id_UsuarioPremiun` ASC) VISIBLE,
  CONSTRAINT `id_UsuarioPremiun`
    FOREIGN KEY (`id_UsuarioPremiun`)
    REFERENCES `Spotify`.`UsuarioPremiun` (`id_UsuarioPremiun`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`PayPal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`PayPal` (
  `id_PayPal` INT NOT NULL,
  `nombreUsuario` VARCHAR(45) NOT NULL,
  `id_UsuarioPremiun` INT NOT NULL,
  PRIMARY KEY (`id_PayPal`),
  INDEX `id_UsuarioPremiun_idx` (`id_UsuarioPremiun` ASC) VISIBLE,
  CONSTRAINT `id_UsuarioPremiun`
    FOREIGN KEY (`id_UsuarioPremiun`)
    REFERENCES `Spotify`.`UsuarioPremiun` (`id_UsuarioPremiun`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`RegistroDePagos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`RegistroDePagos` (
  `id_Pagos` INT NOT NULL,
  `id_UsuarioPremiun` INT NOT NULL,
  `numero_orden` INT NOT NULL,
  `fecha` INT NOT NULL,
  `total_pago` INT NOT NULL,
  PRIMARY KEY (`id_Pagos`),
  INDEX `id_UsuarioPremiun_idx` (`id_UsuarioPremiun` ASC) VISIBLE,
  CONSTRAINT `id_UsuarioPremiun`
    FOREIGN KEY (`id_UsuarioPremiun`)
    REFERENCES `Spotify`.`UsuarioPremiun` (`id_UsuarioPremiun`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`PlayLists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`PlayLists` (
  `id_PlayLists` INT NOT NULL,
  `id_Usuario` INT NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `num_canciones` INT NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  PRIMARY KEY (`id_PlayLists`),
  INDEX `id_Usuario_idx` (`id_Usuario` ASC) VISIBLE,
  CONSTRAINT `id_Usuario`
    FOREIGN KEY (`id_Usuario`)
    REFERENCES `Spotify`.`Usuario` (`id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`PlaylistEliminada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`PlaylistEliminada` (
  `id_PlaylistEliminada` INT NOT NULL,
  `id_PlayLists` INT NOT NULL,
  `fecha_eliminada` INT NOT NULL,
  PRIMARY KEY (`id_PlaylistEliminada`),
  INDEX `id_PlayLists_idx` (`id_PlayLists` ASC) VISIBLE,
  CONSTRAINT `id_PlayLists`
    FOREIGN KEY (`id_PlayLists`)
    REFERENCES `Spotify`.`PlayLists` (`id_PlayLists`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`PlaylistsCompartidas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`PlaylistsCompartidas` (
  `id_PlaylistsCompartidas` INT NOT NULL,
  `id_PlayLists` INT NOT NULL,
  `id_Usuario` INT NOT NULL,
  `fecha_agrega` DATE NOT NULL,
  PRIMARY KEY (`id_PlaylistsCompartidas`),
  CONSTRAINT `id_PlayLists`
    FOREIGN KEY ()
    REFERENCES `Spotify`.`PlayLists` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_Usuario`
    FOREIGN KEY ()
    REFERENCES `Spotify`.`Usuario` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Artista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Artista` (
  `id_Artista` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `imagen_artista` BLOB NOT NULL,
  PRIMARY KEY (`id_Artista`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Album` (
  `id_Album` INT NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `año_publicacion` INT NOT NULL,
  `portada_imagen` BLOB NOT NULL,
  `id_Artista` INT NOT NULL,
  PRIMARY KEY (`id_Album`),
  INDEX `id_Artista_idx` (`id_Artista` ASC) VISIBLE,
  CONSTRAINT `id_Artista`
    FOREIGN KEY (`id_Artista`)
    REFERENCES `Spotify`.`Artista` (`id_Artista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Canciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Canciones` (
  `id_Canciones` INT NOT NULL,
  `id_Album` INT NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `duracion` TIME NOT NULL,
  `reproduciones` INT NOT NULL,
  PRIMARY KEY (`id_Canciones`),
  INDEX `id_Album_idx` (`id_Album` ASC) VISIBLE,
  CONSTRAINT `id_Album`
    FOREIGN KEY (`id_Album`)
    REFERENCES `Spotify`.`Album` (`id_Album`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Seguidores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Seguidores` (
  `id_Seguidores` INT NOT NULL,
  `id_Usuario` INT NOT NULL,
  `id_Artista` INT NOT NULL,
  PRIMARY KEY (`id_Seguidores`),
  INDEX `id_Usuario_idx` (`id_Usuario` ASC) VISIBLE,
  INDEX `id_Artista_idx` (`id_Artista` ASC) VISIBLE,
  CONSTRAINT `id_Usuario`
    FOREIGN KEY (`id_Usuario`)
    REFERENCES `Spotify`.`Usuario` (`id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_Artista`
    FOREIGN KEY (`id_Artista`)
    REFERENCES `Spotify`.`Artista` (`id_Artista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`ArtistasRelacionados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`ArtistasRelacionados` (
  `id_ArtistasRelacionados` INT NOT NULL,
  `id_Artista` INT NOT NULL,
  PRIMARY KEY (`id_ArtistasRelacionados`),
  INDEX `id_Artista_idx` (`id_Artista` ASC) VISIBLE,
  CONSTRAINT `id_Artista`
    FOREIGN KEY (`id_Artista`)
    REFERENCES `Spotify`.`Artista` (`id_Artista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`FavoritosAlbumes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`FavoritosAlbumes` (
  `id_FavoritosAlbumes` INT NOT NULL,
  `id_Usuario` INT NOT NULL,
  `id_Album` INT NOT NULL,
  PRIMARY KEY (`id_FavoritosAlbumes`),
  INDEX `id_Usuario_idx` (`id_Usuario` ASC) VISIBLE,
  INDEX `id_Album_idx` (`id_Album` ASC) VISIBLE,
  CONSTRAINT `id_Usuario`
    FOREIGN KEY (`id_Usuario`)
    REFERENCES `Spotify`.`Usuario` (`id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_Album`
    FOREIGN KEY (`id_Album`)
    REFERENCES `Spotify`.`Album` (`id_Album`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`FavoritosCanciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`FavoritosCanciones` (
  `id_FavoritosCanciones` INT NOT NULL,
  `id_Usuario` INT NOT NULL,
  `id_Canciones` INT NOT NULL,
  PRIMARY KEY (`id_FavoritosCanciones`),
  INDEX `id_Usuario_idx` (`id_Usuario` ASC) VISIBLE,
  INDEX `id_Canciones_idx` (`id_Canciones` ASC) VISIBLE,
  CONSTRAINT `id_Usuario`
    FOREIGN KEY (`id_Usuario`)
    REFERENCES `Spotify`.`Usuario` (`id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_Canciones`
    FOREIGN KEY (`id_Canciones`)
    REFERENCES `Spotify`.`Canciones` (`id_Canciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`CancionesPlaylists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`CancionesPlaylists` (
  `id_CancionesPlaylists` INT NOT NULL,
  `id_Canciones` INT NOT NULL,
  `id_PlayLists` INT NOT NULL,
  `fecha_agreda` DATE NOT NULL,
  PRIMARY KEY (`id_CancionesPlaylists`),
  INDEX `id_Canciones_idx` (`id_Canciones` ASC) VISIBLE,
  INDEX `id_PlayLists_idx` (`id_PlayLists` ASC) VISIBLE,
  CONSTRAINT `id_Canciones`
    FOREIGN KEY (`id_Canciones`)
    REFERENCES `Spotify`.`Canciones` (`id_Canciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_PlayLists`
    FOREIGN KEY (`id_PlayLists`)
    REFERENCES `Spotify`.`PlayLists` (`id_PlayLists`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
