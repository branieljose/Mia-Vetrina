CREATE DATABASE IF NOT EXISTS impulso_db;

USE impulso_db;

CREATE TABLE IF NOT EXISTS users (
  id INT(11) NOT NULL AUTO_INCREMENT,
  user_name VARCHAR(255) NOT NULL,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS palettes (
  id INT(11) NOT NULL AUTO_INCREMENT,
  palette_name VARCHAR(255) NOT NULL,
  file_path VARCHAR(255) NOT NULL, 
  file_name VARCHAR(255) NOT NULL,   
  PRIMARY KEY (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS object_types (
  id INT(11) NOT NULL AUTO_INCREMENT,
  obj_type VARCHAR(255) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS object_category (
  id INT(11) NOT NULL AUTO_INCREMENT,
  obj_type_id INT(11), 
  category VARCHAR(255), 
  PRIMARY KEY (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS objects (
  id INT(11) NOT NULL AUTO_INCREMENT,
  obj_name VARCHAR(255) NOT NULL,
  obj_type_id INT(11) NOT NULL,
  obj_cat_id INT(11),
  height INT(11) NOT NULL,
  width INT(11) NOT NULL,
  static BOOLEAN NOT NULL,
  useradd BOOLEAN NOT NULL,
  user_id int(11), 
  file_path VARCHAR(255) NOT NULL,
  file_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT obj_type_id
    FOREIGN KEY (obj_type_id)
    REFERENCES object_types (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8; 

CREATE TABLE IF NOT EXISTS canvas (
  id INT(11) NOT NULL AUTO_INCREMENT,
  canvas_name VARCHAR(255) NOT NULL,
  canvas_size VARCHAR(255) NOT NULL,
  real_uom char(1) NOT NULL,
  real_height INT(11) NOT NULL,
  real_width INT(11) NOT NULL,
  pixel_uom INT(11) NOT NULL,
  pixel_height INT(11) NOT NULL,
  pixel_width INT(11) NOT NULL,
  useradd BOOLEAN NOT NULL,
  user_id INT(11), 
  PRIMARY KEY (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS canvas_objects (
  id INT(11) NOT NULL AUTO_INCREMENT,
  canvas_id INT(11) NOT NULL,
  obj_cat_id INT(11),
  PRIMARY KEY (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS showrooms (
  id INT(11) NOT NULL AUTO_INCREMENT,
  showroom_name VARCHAR(255) NOT NULL,
  user_id INT(11) NOT NULL,   
  PRIMARY KEY (id),
  CONSTRAINT user_id
    FOREIGN KEY (user_id)
    REFERENCES users (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS layers (
  id INT(11) NOT NULL AUTO_INCREMENT,
  layer_index INT(11) NOT NULL,
  canvas_id INT(11), 
  height INT(11) NOT NULL,
  width INT(11) NOT NULL,
  position_top INT(11) NOT NULL,
  position_left INT(11) NOT NULL,
  color VARCHAR(255), 
  opacity DECIMAL,  
  layer_type VARCHAR(255),
  object_id INT(11),
  showroom_id INT(11) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT showroom_id
    FOREIGN KEY (showroom_id)
    REFERENCES showrooms (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
