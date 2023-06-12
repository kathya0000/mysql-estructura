-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bd_optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bd_optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bd_optica` DEFAULT CHARACTER SET utf8 ;
USE `bd_optica` ;

-- -----------------------------------------------------
-- Table `bd_optica`.`Direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_optica`.`Direccion` (
  `id_Direccion` INT NOT NULL,
  `calle` VARCHAR(45) NOT NULL,
  `numero` INT NOT NULL,
  `piso` INT NOT NULL,
  `puerta` VARCHAR(2) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `ciudad` VARCHAR(45) NOT NULL,
  `codigo_postal` INT NOT NULL,
  PRIMARY KEY (`id_Direccion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_optica`.`Provedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_optica`.`Provedor` (
  `id_Provedor` INT NOT NULL,
  `id_Direccion` INT NOT NULL,
  `telefono` INT NOT NULL,
  `fax` INT NOT NULL,
  `nif` INT NOT NULL,
  PRIMARY KEY (`id_Provedor`),
  INDEX `id_Direccion_idx` (`id_Direccion` ASC) VISIBLE,
  CONSTRAINT `id_Direccion`
    FOREIGN KEY (`id_Direccion`)
    REFERENCES `bd_optica`.`Direccion` (`id_Direccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_optica`.`Tipo_montura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_optica`.`Tipo_montura` (
  `id_` INT NOT NULL,
  `flotante` VARCHAR(45) NOT NULL,
  `pasta` VARCHAR(45) NOT NULL,
  `metalica` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_optica`.`Graduacion_cristales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_optica`.`Graduacion_cristales` (
  `id_Graduacion_cristales` INT NOT NULL,
  `cristal_izquierdo` VARCHAR(45) NOT NULL,
  `cristal_derecho` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Graduacion_cristales`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_optica`.`Gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_optica`.`Gafas` (
  `id_Gafas` INT NOT NULL,
  `id_Graduacion` INT NOT NULL,
  `id_Montura` INT NOT NULL,
  `id_Provedor` INT NOT NULL,
  `color_montura` VARCHAR(45) NOT NULL,
  `color_vidrio` VARCHAR(45) NOT NULL,
  `precio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Gafas`),
  INDEX `graduacion_idx` (`id_Graduacion` ASC) VISIBLE,
  INDEX `montura_id_idx` (`id_Montura` ASC) VISIBLE,
  INDEX `id_provedor_idx` (`id_Provedor` ASC) VISIBLE,
  CONSTRAINT `id_Graduacion`
    FOREIGN KEY (`id_Graduacion`)
    REFERENCES `bd_optica`.`Graduacion_cristales` (`id_Graduacion_cristales`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_Montura`
    FOREIGN KEY (`id_Montura`)
    REFERENCES `bd_optica`.`Tipo_montura` (`id_`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_Provedor`
    FOREIGN KEY (`id_Provedor`)
    REFERENCES `bd_optica`.`Provedor` (`id_Provedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_optica`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_optica`.`Cliente` (
  `id_Cliente` INT NOT NULL,
  `id_ClienteRecomendado` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `data_registro` DATE NOT NULL,
  `registro_venta` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Cliente`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `telefono_UNIQUE` (`telefono` ASC) VISIBLE,
  INDEX `cliente_recomendado_id_idx` (`id_ClienteRecomendado` ASC) VISIBLE,
  CONSTRAINT `id_ClienteRecomendado`
    FOREIGN KEY (`id_ClienteRecomendado`)
    REFERENCES `bd_optica`.`Cliente` (`id_Cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_optica`.`Marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_optica`.`Marca` (
  `id_Marca` INT NOT NULL,
  `id_Provedor` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Marca`),
  INDEX `id_Provedor_idx` (`id_Provedor` ASC) VISIBLE,
  CONSTRAINT `id_Provedor`
    FOREIGN KEY (`id_Provedor`)
    REFERENCES `bd_optica`.`Provedor` (`id_Provedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_optica`.`Empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_optica`.`Empleados` (
  `id_Empleados` INT NOT NULL,
  `nomre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Empleados`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_optica`.`Ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_optica`.`Ventas` (
  `Id_Ventas` INT NOT NULL,
  `id_Gafas` INT NOT NULL,
  `id_Cliente` INT NOT NULL,
  `id_Empleados` INT NOT NULL,
  PRIMARY KEY (`Id_Ventas`),
  INDEX `id_gafas_idx` (`id_Gafas` ASC) VISIBLE,
  INDEX `id_cliente_idx` (`id_Cliente` ASC) VISIBLE,
  INDEX `id_empleados_idx` (`id_Empleados` ASC) VISIBLE,
  CONSTRAINT `id_gafas`
    FOREIGN KEY (`id_Gafas`)
    REFERENCES `bd_optica`.`Gafas` (`id_Gafas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_cliente`
    FOREIGN KEY (`id_Cliente`)
    REFERENCES `bd_optica`.`Cliente` (`id_Cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_empleados`
    FOREIGN KEY (`id_Empleados`)
    REFERENCES `bd_optica`.`Empleados` (`id_Empleados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
