-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema futeboldospais
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema futeboldospais
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `futeboldospais` DEFAULT CHARACTER SET utf8 ;
USE `futeboldospais` ;

-- -----------------------------------------------------
-- Table `futeboldospais`.`administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futeboldospais`.`administrador` (
  `idadministrador` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idadministrador`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futeboldospais`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futeboldospais`.`categoria` (
  `idcategoria` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcategoria`),
  UNIQUE INDEX `tipo_UNIQUE` (`tipo` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futeboldospais`.`campeonato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futeboldospais`.`campeonato` (
  `idcampeonato` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `valor_vitoria` INT NOT NULL,
  `valor_empate` INT NOT NULL,
  `valor_derrota` INT NOT NULL,
  `qtdtimes` INT NOT NULL,
  `qtd_turno` INT NOT NULL,
  `qtd_promo_autom` INT NULL,
  `qtd_promo_playoff` INT NULL,
  `qtd_rebaix_autom` INT NULL,
  `qtd_rebaix_playoff` INT NULL,
  PRIMARY KEY (`idcampeonato`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futeboldospais`.`time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futeboldospais`.`time` (
  `idtime` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `foto_equipe` VARCHAR(45) NULL,
  `coordenador` VARCHAR(45) NOT NULL,
  `foto_logo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtime`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futeboldospais`.`tabela_campeonato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futeboldospais`.`tabela_campeonato` (
  `time_idtime` INT NOT NULL,
  `campeonato_idcampeonato` INT NOT NULL,
  `pontos` INT NOT NULL,
  `jogos` INT NOT NULL,
  `vitoria` INT NOT NULL,
  `empate` INT NOT NULL,
  `derrota` INT NOT NULL,
  `gol_pro` INT NOT NULL,
  `gol_contra` INT NOT NULL,
  `saldo_gol` INT NOT NULL,
  PRIMARY KEY (`time_idtime`, `campeonato_idcampeonato`),
  INDEX `fk_tabela_campeonato_campeonato1_idx` (`campeonato_idcampeonato` ASC) ,
  CONSTRAINT `fk_tabela_campeonato_time`
    FOREIGN KEY (`time_idtime`)
    REFERENCES `futeboldospais`.`time` (`idtime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tabela_campeonato_campeonato1`
    FOREIGN KEY (`campeonato_idcampeonato`)
    REFERENCES `futeboldospais`.`campeonato` (`idcampeonato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futeboldospais`.`posicao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futeboldospais`.`posicao` (
  `idposicao` INT NOT NULL AUTO_INCREMENT,
  `tipo_posicao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idposicao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futeboldospais`.`jogador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futeboldospais`.`jogador` (
  `idjogador` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `time_idtime` INT NOT NULL,
  `categoria_idcategoria` INT NOT NULL,
  `posicao_idposicao` INT NOT NULL,
  `altura` INT NULL,
  `peso` VARCHAR(45) NULL,
  PRIMARY KEY (`idjogador`),
  INDEX `fk_jogador_time1_idx` (`time_idtime` ASC) ,
  INDEX `fk_jogador_categoria1_idx` (`categoria_idcategoria` ASC) ,
  INDEX `fk_jogador_posicao1_idx` (`posicao_idposicao` ASC) ,
  CONSTRAINT `fk_jogador_time1`
    FOREIGN KEY (`time_idtime`)
    REFERENCES `futeboldospais`.`time` (`idtime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jogador_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `futeboldospais`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jogador_posicao1`
    FOREIGN KEY (`posicao_idposicao`)
    REFERENCES `futeboldospais`.`posicao` (`idposicao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futeboldospais`.`tipo_arbitro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futeboldospais`.`tipo_arbitro` (
  `idtipo_arbitro` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtipo_arbitro`),
  UNIQUE INDEX `tipo_UNIQUE` (`tipo` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futeboldospais`.`arbitros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futeboldospais`.`arbitros` (
  `idarbitro` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `tipo_arbitro` INT NOT NULL,
  PRIMARY KEY (`idarbitro`),
  INDEX `fk_arbitros_tipo_arbitro1_idx` (`tipo_arbitro` ASC) ,
  CONSTRAINT `fk_arbitros_tipo_arbitro1`
    FOREIGN KEY (`tipo_arbitro`)
    REFERENCES `futeboldospais`.`tipo_arbitro` (`idtipo_arbitro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futeboldospais`.`partida_campeonato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futeboldospais`.`partida_campeonato` (
  `campeonato_idcampeonato` INT NOT NULL,
  `id_time_casa` INT NOT NULL,
  `id_time_visitante` INT NOT NULL,
  `gol_casa` INT NULL,
  `gol_visitante` INT NULL,
  `acrescimo_primeiro_tempo` INT NULL,
  `acrescimo_segundo_tempo` INT NULL,
  `data_partida` DATETIME NOT NULL,
  PRIMARY KEY (`campeonato_idcampeonato`, `id_time_casa`, `id_time_visitante`),
  INDEX `fk_partida_campeonato_campeonato1_idx` (`campeonato_idcampeonato` ASC) ,
  INDEX `fk_partida_campeonato_time2_idx` (`id_time_visitante` ASC) ,
  CONSTRAINT `fk_partida_campeonato_time1`
    FOREIGN KEY (`id_time_casa`)
    REFERENCES `futeboldospais`.`time` (`idtime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_partida_campeonato_campeonato1`
    FOREIGN KEY (`campeonato_idcampeonato`)
    REFERENCES `futeboldospais`.`campeonato` (`idcampeonato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_partida_campeonato_time2`
    FOREIGN KEY (`id_time_visitante`)
    REFERENCES `futeboldospais`.`time` (`idtime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futeboldospais`.`jogador_partida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futeboldospais`.`jogador_partida` (
  `jogador_idjogador` INT NOT NULL,
  `partida_campeonato_id_time_visitante` INT NOT NULL,
  `jogador_partidacol` VARCHAR(45) NULL,
  `partida_campeonato_id_time_casa` INT NOT NULL,
  `partida_campeonato_campeonato_idcampeonato` INT NOT NULL,
  `qtd_gol` INT NULL,
  `cartao_amarelo` INT NULL,
  `cartao_vermelho` INT NULL,
  `faltas_recebidas` INT NULL,
  `faltas_cometidas` INT NULL,
  `impedimentos` INT NULL,
  `assistencia` INT NULL,
  `chute_gol` INT NULL,
  `chute_fora` INT NULL,
  `tempo_entrada` TIME NULL,
  `tempo_substiuicao` TIME NULL,
  PRIMARY KEY (`jogador_idjogador`, `partida_campeonato_id_time_visitante`, `partida_campeonato_id_time_casa`, `partida_campeonato_campeonato_idcampeonato`),
  INDEX `fk_jogador_partida_jogador1_idx` (`jogador_idjogador` ASC) ,
  INDEX `fk_jogador_partida_partida_campeonato1_idx` (`partida_campeonato_campeonato_idcampeonato` ASC, `partida_campeonato_id_time_casa` ASC, `partida_campeonato_id_time_visitante` ASC) ,
  CONSTRAINT `fk_jogador_partida_jogador1`
    FOREIGN KEY (`jogador_idjogador`)
    REFERENCES `futeboldospais`.`jogador` (`idjogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jogador_partida_partida_campeonato1`
    FOREIGN KEY (`partida_campeonato_campeonato_idcampeonato` , `partida_campeonato_id_time_casa` , `partida_campeonato_id_time_visitante`)
    REFERENCES `futeboldospais`.`partida_campeonato` (`campeonato_idcampeonato` , `id_time_casa` , `id_time_visitante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futeboldospais`.`noticias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futeboldospais`.`noticias` (
  `idnoticias` INT NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `texto` VARCHAR(1000) NOT NULL,
  `foto` VARCHAR(45) NULL,
  PRIMARY KEY (`idnoticias`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futeboldospais`.`comissao_de_arbitragem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futeboldospais`.`comissao_de_arbitragem` (
  `arbitros_idarbitro` INT NOT NULL,
  `arbitros_idarbitro1` INT NOT NULL,
  `arbitros_idarbitro2` INT NOT NULL,
  `arbitros_idarbitro3` INT NOT NULL,
  `partida_campeonato_campeonato_idcampeonato` INT NOT NULL,
  `partida_campeonato_id_time_casa` INT NOT NULL,
  `partida_campeonato_id_time_visitante` INT NOT NULL,
  INDEX `fk_comissao_de_arbitragem_arbitros1_idx` (`arbitros_idarbitro` ASC) ,
  INDEX `fk_comissao_de_arbitragem_arbitros2_idx` (`arbitros_idarbitro1` ASC) ,
  INDEX `fk_comissao_de_arbitragem_arbitros3_idx` (`arbitros_idarbitro2` ASC) ,
  INDEX `fk_comissao_de_arbitragem_arbitros4_idx` (`arbitros_idarbitro3` ASC) ,
  PRIMARY KEY (`partida_campeonato_campeonato_idcampeonato`, `partida_campeonato_id_time_casa`, `partida_campeonato_id_time_visitante`),
  CONSTRAINT `fk_comissao_de_arbitragem_arbitros1`
    FOREIGN KEY (`arbitros_idarbitro`)
    REFERENCES `futeboldospais`.`arbitros` (`idarbitro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comissao_de_arbitragem_arbitros2`
    FOREIGN KEY (`arbitros_idarbitro1`)
    REFERENCES `futeboldospais`.`arbitros` (`idarbitro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comissao_de_arbitragem_arbitros3`
    FOREIGN KEY (`arbitros_idarbitro2`)
    REFERENCES `futeboldospais`.`arbitros` (`idarbitro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comissao_de_arbitragem_arbitros4`
    FOREIGN KEY (`arbitros_idarbitro3`)
    REFERENCES `futeboldospais`.`arbitros` (`idarbitro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comissao_de_arbitragem_partida_campeonato1`
    FOREIGN KEY (`partida_campeonato_campeonato_idcampeonato` , `partida_campeonato_id_time_casa` , `partida_campeonato_id_time_visitante`)
    REFERENCES `futeboldospais`.`partida_campeonato` (`campeonato_idcampeonato` , `id_time_casa` , `id_time_visitante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futeboldospais`.`comissao_executiva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futeboldospais`.`comissao_executiva` (
  `idcomissao_executiva` INT NOT NULL AUTO_INCREMENT,
  `cargo` VARCHAR(45) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcomissao_executiva`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
