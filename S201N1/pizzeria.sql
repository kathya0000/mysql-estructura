-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bd_pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bd_pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bd_pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `bd_pizzeria` ;

-- -----------------------------------------------------
-- Table `bd_pizzeria`.`Provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_pizzeria`.`Provincia` (
  `idProvincia` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idProvincia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_pizzeria`.`Localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_pizzeria`.`Localidad` (
  `idLocalidad` INT NOT NULL,
  `id_Provincia` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idLocalidad`),
  INDEX `id_Provincia_idx` (`id_Provincia` ASC) VISIBLE,
  CONSTRAINT `id_Provincia`
    FOREIGN KEY (`id_Provincia`)
    REFERENCES `bd_pizzeria`.`Provincia` (`idProvincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_pizzeria`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_pizzeria`.`Cliente` (
  `idCliente` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `id_Localidad` INT NOT NULL,
  `telefono` INT NOT NULL,
  `codigoPostal` INT NOT NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `Codigo Postal_idx` (`id_Localidad` ASC) VISIBLE,
  CONSTRAINT `id_Localidad`
    FOREIGN KEY (`id_Localidad`)
    REFERENCES `bd_pizzeria`.`Localidad` (`idLocalidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_pizzeria`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_pizzeria`.`Categoria` (
  `idCategoria` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_pizzeria`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_pizzeria`.`producto` (
  `idproducto` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(80) NOT NULL,
  `imagen` VARCHAR(45) NOT NULL,
  `precio` INT NOT NULL,
  `id_Categoria` INT NOT NULL,
  PRIMARY KEY (`idproducto`),
  INDEX `id_Categoria_idx` (`id_Categoria` ASC) VISIBLE,
  CONSTRAINT `id_Categoria`
    FOREIGN KEY (`id_Categoria`)
    REFERENCES `bd_pizzeria`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_pizzeria`.`Rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_pizzeria`.`Rol` (
  `idRol` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idRol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_pizzeria`.`Tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_pizzeria`.`Tienda` (
  `idTienda` INT NOT NULL,
  `Id_Provincia` INT NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `codigo postal` INT NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTienda`),
  INDEX `id_Provincia_idx` (`Id_Provincia` ASC) VISIBLE,
  CONSTRAINT `id_Provincia`
    FOREIGN KEY (`Id_Provincia`)
    REFERENCES `bd_pizzeria`.`Provincia` (`idProvincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_pizzeria`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_pizzeria`.`Empleado` (
  `idEmpleado` INT NOT NULL,
  `id_Rol` INT NOT NULL,
  `id_Tienda` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `nif` INT NOT NULL,
  `telefono` INT NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  INDEX `id_rol_idx` (`id_Rol` ASC) VISIBLE,
  INDEX `id_Tienda_idx` (`id_Tienda` ASC) VISIBLE,
  CONSTRAINT `id_rol`
    FOREIGN KEY (`id_Rol`)
    REFERENCES `bd_pizzeria`.`Rol` (`idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_Tienda`
    FOREIGN KEY (`id_Tienda`)
    REFERENCES `bd_pizzeria`.`Tienda` (`idTienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_pizzeria`.`TipoEntrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_pizzeria`.`TipoEntrega` (
  `idTipoEntrega` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idTipoEntrega`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_pizzeria`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_pizzeria`.`Pedido` (
  `idPedido` INT NOT NULL,
  `id_TipoEntrega` INT NOT NULL,
  `id_Tienda` INT NOT NULL,
  `id_Cliente` INT NOT NULL,
  `id_Empleado` INT NOT NULL,
  `id_PedidoProducto` INT NOT NULL,
  `precio total` INT NOT NULL,
  PRIMARY KEY (`idPedido`),
  INDEX `id_TipoEntrega_idx` (`id_TipoEntrega` ASC) VISIBLE,
  INDEX `id_Tienda_idx` (`id_Tienda` ASC) VISIBLE,
  INDEX `id_Cliente_idx` (`id_Cliente` ASC) VISIBLE,
  INDEX `id_Empleado_idx` (`id_Empleado` ASC) VISIBLE,
  INDEX `id_PedidoProducto_idx` (`id_PedidoProducto` ASC) VISIBLE,
  CONSTRAINT `id_TipoEntrega`
    FOREIGN KEY (`id_TipoEntrega`)
    REFERENCES `bd_pizzeria`.`TipoEntrega` (`idTipoEntrega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_Tienda`
    FOREIGN KEY (`id_Tienda`)
    REFERENCES `bd_pizzeria`.`Tienda` (`idTienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_Cliente`
    FOREIGN KEY (`id_Cliente`)
    REFERENCES `bd_pizzeria`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_Empleado`
    FOREIGN KEY (`id_Empleado`)
    REFERENCES `bd_pizzeria`.`Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_PedidoProducto`
    FOREIGN KEY (`id_PedidoProducto`)
    REFERENCES `bd_pizzeria`.`PedidoProducto` (`idPedidoProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_pizzeria`.`PedidoProducto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_pizzeria`.`PedidoProducto` (
  `idPedidoProducto` INT NOT NULL,
  `id_Producto` INT NOT NULL,
  `id_Pedido` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`idPedidoProducto`),
  INDEX `id_Producto_idx` (`id_Producto` ASC) VISIBLE,
  INDEX `id_Pedido_idx` (`id_Pedido` ASC) VISIBLE,
  CONSTRAINT `id_Producto`
    FOREIGN KEY (`id_Producto`)
    REFERENCES `bd_pizzeria`.`producto` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_Pedido`
    FOREIGN KEY (`id_Pedido`)
    REFERENCES `bd_pizzeria`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_pizzeria`.`EntregaDomicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_pizzeria`.`EntregaDomicilio` (
  `idEmpleadoPedido` INT NOT NULL,
  `id_Empleado` INT NOT NULL,
  `id_Pedido` INT NOT NULL,
  `fecha/hora` INT NOT NULL,
  PRIMARY KEY (`idEmpleadoPedido`),
  INDEX `id_Pedido_idx` (`id_Pedido` ASC) VISIBLE,
  INDEX `id_Empleado_idx` (`id_Empleado` ASC) VISIBLE,
  CONSTRAINT `id_Pedido`
    FOREIGN KEY (`id_Pedido`)
    REFERENCES `bd_pizzeria`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_Empleado`
    FOREIGN KEY (`id_Empleado`)
    REFERENCES `bd_pizzeria`.`Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
