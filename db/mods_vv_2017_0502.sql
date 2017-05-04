USE impulso_db;

set @rcds = 0; 

-- Create Users if not exist
CREATE TABLE IF NOT EXISTS users (
  id INT(11) NOT NULL AUTO_INCREMENT,
  user_name VARCHAR(255) NOT NULL,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  passResetHash VARCHAR(255), 
  PRIMARY KEY (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- Create & Load Palettes if not exist
CREATE TABLE IF NOT EXISTS palettes (
  id INT(11) NOT NULL AUTO_INCREMENT,
  palette_name VARCHAR(255) NOT NULL,
  file_path VARCHAR(255) NOT NULL, 
  file_name VARCHAR(255) NOT NULL,   
  PRIMARY KEY (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

truncate table palettes;

select 'Palettes' as 'Loading Table'; 
INSERT INTO palettes (palette_name, file_path, file_name)
VALUES ('Behr HDC Colors','/app/Media/Colors/','behr-hdc-colors.ase'); 
INSERT INTO palettes (palette_name, file_path, file_name)
VALUES ('Behr Marquee Colors','/app/Media/Colors/','behr-marquee-colors.ase'); 
INSERT INTO palettes (palette_name, file_path, file_name)
VALUES ('Behr Plus 40003 Colors','/app/Media/Colors/','behr-pplus2003-colors.ase'); 
INSERT INTO palettes (palette_name, file_path, file_name)
VALUES ('Behr Plus 2012 Colors','/app/Media/Colors/','behr-pplus2012-colors.ase'); 
INSERT INTO palettes (palette_name, file_path, file_name)
VALUES ('Behr Plus Ultra Colors','/app/Media/Colors/','behr-pplusultra-colors.ase'); 
INSERT INTO palettes (palette_name, file_path, file_name)
VALUES ('Behr Timeless Colors','/app/Media/Colors/','behr-timeless-colors.ase'); 
INSERT INTO palettes (palette_name, file_path, file_name)
VALUES ('Benjamin Moore Americas Collection','/app/Media/Colors/','BenjaminMoore_Americas_Collection.ase');
INSERT INTO palettes (palette_name, file_path, file_name)
VALUES ('Benjamin Moore Classic Colors','/app/Media/Colors/','BenjaminMoore_ClassicColors.ase');
INSERT INTO palettes (palette_name, file_path, file_name)
VALUES ('Benjamin Moore Color Preview','/app/Media/Colors/','BenjaminMoore_ColorPreview_en-us.ase');
INSERT INTO palettes (palette_name, file_path, file_name)
VALUES ('Benjamin Moore Designer Classics','/app/Media/Colors/','BenjaminMoore_DesignerClassics.ase');
INSERT INTO palettes (palette_name, file_path, file_name)
VALUES ('Benjamin Moore Historical Colors','/app/Media/Colors/','BenjaminMoore_HistoricalColors_en-us.ase');
INSERT INTO palettes (palette_name, file_path, file_name)
VALUES ('Benjamin Moore REVIVE Colors','/app/Media/Colors/','BenjaminMoore_REVIVEColorsForVinylSiding_en-us.ase');
INSERT INTO palettes (palette_name, file_path, file_name)
VALUES ('Dunn Edwards Colors','/app/Media/Colors/','Dunn_Edwards_Colors.ase');
INSERT INTO palettes (palette_name, file_path, file_name)
VALUES ('Kelly Moore Colors','/app/Media/Colors/','Kelly_Moore_Colors.ase');
INSERT INTO palettes (palette_name, file_path, file_name)
VALUES ('PHM Valspar','/app/Media/Colors/','PHM_Valspar.ase');
INSERT INTO palettes (palette_name, file_path, file_name)
VALUES ('PPG Voice Of Color','/app/Media/Colors/','PPG_Voice_of_Color.ase');
INSERT INTO palettes (palette_name, file_path, file_name)
VALUES ('Sherwin Williams Colors','/app/Media/Colors/','Sherwin_Williams_Colors.ase');

select count(*) from palettes into @rcds; 
select @rcds as 'Rows Loaded';

drop table canvas;
drop table canvas_objects; 
drop table sizes;

-- Create & Load Sizes if not exist
CREATE TABLE IF NOT EXISTS sizes (
  id INT(11) NOT NULL AUTO_INCREMENT,
  size_name VARCHAR(255) NOT NULL,
  real_uom char(4) NOT NULL,
  pixel_uom INT(11) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

select 'Sizes' as 'Loading Table'; 
INSERT INTO sizes (size_name,real_uom,pixel_uom) 
VALUES ('Small','inch',3);
INSERT INTO sizes (size_name,real_uom,pixel_uom) 
VALUES ('Medium','inch',4);
INSERT INTO sizes (size_name,real_uom,pixel_uom) 
VALUES ('Large','inch',6);

select count(*) from sizes into @rcds; 
select @rcds as 'Rows Loaded';

-- Create & Load Canvas if not exist
CREATE TABLE IF NOT EXISTS canvas (
  id INT(11) NOT NULL AUTO_INCREMENT,
  canvas_name VARCHAR(255) NOT NULL,
  canvas_size_id INT(11) NOT NULL,
  real_height INT(11) NOT NULL,
  real_width INT(11) NOT NULL,
  pixel_height INT(11) NOT NULL,
  pixel_width INT(11) NOT NULL,
  useradd BOOLEAN NOT NULL,
  user_id INT(11), 
  PRIMARY KEY (id),
  CONSTRAINT canvas_size_id
    FOREIGN KEY (canvas_size_id)
    REFERENCES sizes (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

select 'Canvas' as 'Loading Table'; 
INSERT INTO canvas (canvas_name,canvas_size_id,real_height,real_width,pixel_height,pixel_width,useradd,user_id) 
VALUES ('FreeForm (Default)',2,192,288,768,1152,0,null);

select count(*) from canvas into @rcds; 
select @rcds as 'Rows Loaded';

-- Create Canvas_Objects if not exist
CREATE TABLE IF NOT EXISTS canvas_objects (
  id INT(11) NOT NULL AUTO_INCREMENT,
  canvas_id INT(11) NOT NULL,
  obj_cat_id INT(11),
  PRIMARY KEY (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- Furniture Brand, Style & Category
CREATE TABLE IF NOT EXISTS furniture_brand (
  id INT(11) NOT NULL AUTO_INCREMENT,
  brand VARCHAR(255) NOT NULL,
  file_path VARCHAR(255) NOT NULL, 
  file_name VARCHAR(255) NOT NULL,    
  PRIMARY KEY (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

truncate table furniture_brand; 

select 'Furniture_Brand' as 'Loading Table'; 
INSERT INTO Furniture_Brand (brand, file_path, file_name) 
VALUES ('Ashley','/app/Media/Furniture/Ashley/','Ashley.list');
INSERT INTO Furniture_Brand (brand, file_path, file_name) 
VALUES ('Crate & Barrel','/app/Media/Furniture/CnB/','CnB.list');
INSERT INTO Furniture_Brand (brand, file_path, file_name) 
VALUES ('Default','/app/Media/Furniture/','Default.list');
INSERT INTO Furniture_Brand (brand, file_path, file_name) 
VALUES ('Ethan Allen','/app/Media/Furniture/EthanAllen/','EthanAllen.list');
INSERT INTO Furniture_Brand (brand, file_path, file_name) 
VALUES ('IKEA','/app/Media/Furniture/IKEA/','IKEA.list');
INSERT INTO Furniture_Brand (brand, file_path, file_name) 
VALUES ('La-Z-Boy','/app/Media/Furniture/La-Z-Boy/','La-Z-Boy.list');
INSERT INTO Furniture_Brand (brand, file_path, file_name) 
VALUES ('Raymour & Flanigan','/app/Media/Furniture/RnF/','RnF.list');
INSERT INTO Furniture_Brand (brand, file_path, file_name) 
VALUES ('Restoration Hardware','/app/Media/Furniture/Restoration_HW/','RestorationHW.list');
INSERT INTO Furniture_Brand (brand, file_path, file_name) 
VALUES ('Thomasville','/app/Media/Furniture/Thomasville/','Thomasville.list');
INSERT INTO Furniture_Brand (brand, file_path, file_name) 
VALUES ('WayFair','/app/Media/Furniture/WayFair/','WayFair.list');
INSERT INTO Furniture_Brand (brand, file_path, file_name) 
VALUES ('West Elm','/app/Media/Furniture/WestElm/','WestElm.list');

select count(*) from furniture_brand into @rcds; 
select @rcds as 'Rows Loaded';

-- Style is a future add-on
-- CREATE TABLE IF NOT EXISTS furniture_style (
--   id INT(11) NOT NULL AUTO_INCREMENT,
--   style VARCHAR(255) NOT NULL,
--   PRIMARY KEY (id))
-- ENGINE = InnoDB
-- DEFAULT CHARACTER SET = utf8;

-- Create & Load Furniture_Category if not exist
CREATE TABLE IF NOT EXISTS furniture_category (
  id INT(11) NOT NULL AUTO_INCREMENT,
  category VARCHAR(255),
  furniture_type varchar(255), 
  PRIMARY KEY (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

truncate table furniture_category;

select 'Furniture_Category' as 'Loading Table'; 
INSERT INTO furniture_category (category, furniture_type) VALUES ('Accents', 'accent');
INSERT INTO furniture_category (category, furniture_type) VALUES ('Bars', 'bar');
INSERT INTO furniture_category (category, furniture_type) VALUES ('Beds', 'bed');
INSERT INTO furniture_category (category, furniture_type) VALUES ('Benches', 'bench');
INSERT INTO furniture_category (category, furniture_type) VALUES ('Bookshelves', 'bookshelf');
INSERT INTO furniture_category (category, furniture_type) VALUES ('Buffets', 'buffet');
INSERT INTO furniture_category (category, furniture_type) VALUES ('Cabinets', 'cabinet');
INSERT INTO furniture_category (category, furniture_type) VALUES ('Chairs', 'chair');
INSERT INTO furniture_category (category, furniture_type) VALUES ('Chests', 'chest');
INSERT INTO furniture_category (category, furniture_type) VALUES ('Closets', 'closet');
INSERT INTO furniture_category (category, furniture_type) VALUES ('Consoles', 'console');
INSERT INTO furniture_category (category, furniture_type) VALUES ('Desks', 'desk');
INSERT INTO furniture_category (category, furniture_type) VALUES ('Dining', 'dining');
INSERT INTO furniture_category (category, furniture_type) VALUES ('Dressers', 'dresser');
INSERT INTO furniture_category (category, furniture_type) VALUES ('Futons', 'futon');
INSERT INTO furniture_category (category, furniture_type) VALUES ('Lamps', 'lamp');
INSERT INTO furniture_category (category, furniture_type) VALUES ('Lounges', 'lounge');
INSERT INTO furniture_category (category, furniture_type) VALUES ('Loveseats', 'loveseat');
INSERT INTO furniture_category (category, furniture_type) VALUES ('Ottomans', 'ottoman');
INSERT INTO furniture_category (category, furniture_type) VALUES ('Plants', 'plant');
INSERT INTO furniture_category (category, furniture_type) VALUES ('Sectionals', 'sectional');
INSERT INTO furniture_category (category, furniture_type) VALUES ('Sofas', 'sofa');
INSERT INTO furniture_category (category, furniture_type) VALUES ('Stands', 'stand');
INSERT INTO furniture_category (category, furniture_type) VALUES ('Stools', 'stool');
INSERT INTO furniture_category (category, furniture_type) VALUES ('Tables', 'table');

select count(*) from furniture_category into @rcds; 
select @rcds as 'Rows Loaded';

-- Create & Load Furniture
CREATE TABLE IF NOT EXISTS furniture (
  id INT(11) NOT NULL AUTO_INCREMENT,
  brand_id INT(11) NOT NULL,
  category_id INT(11) NOT NULL, 
  furniture_name VARCHAR(255) NOT NULL,  
  real_height INT(11) NOT NULL,
  real_width INT(11) NOT NULL,
  pixel_height INT(11) NOT NULL,
  pixel_width INT(11) NOT NULL,
  resolution INT(11) NOT NULL,
  click_rate INT(11) NOT NULL,
  file_path VARCHAR(255) NOT NULL,
  file_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8; 

truncate table furniture; 

-- Load Objects - Furniture
select 'Furniture' as 'Loading Table'; 
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'accent_f_30x30_mirror',30,30,120,120,72,0,'/app/Media/Furniture/','accent_f_30x30_mirror.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'accent_f_36x56_studio455mirror',36,56,144,224,72,0,'/app/Media/Furniture/','accent_f_36x56_studio455mirror.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'accent_f_44x44_mirror',44,44,176,176,72,0,'/app/Media/Furniture/','accent_f_44x44_mirror.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'bed_f_35x64_mikkel',35,64,140,256,72,0,'/app/Media/Furniture/','bed_f_35x64_mikkel.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'bed_f_51x65_chloe',51,65,204,260,72,0,'/app/Media/Furniture/','bed_f_51x65_chloe.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'bed_r_35x91_mikkel',35,91,140,364,72,0,'/app/Media/Furniture/','bed_r_35x91_mikkel.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'bed_r_51x93_chloe',51,93,204,372,72,0,'/app/Media/Furniture/','bed_r_51x93_chloe.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'bed_s_35x91_mikkel',35,91,140,364,72,0,'/app/Media/Furniture/','bed_s_35x91_mikkel.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'bed_s_51x93_chloe',51,93,204,372,72,0,'/app/Media/Furniture/','bed_s_51x93_chloe.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'bench_f_17x63_ziggy',17,63,68,252,72,0,'/app/Media/Furniture/','bench_f_17x63_ziggy.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'bench_f_20x52_phoebe',20,52,80,208,72,0,'/app/Media/Furniture/','bench_f_20x52_phoebe.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'bench_f_22x58_landry',22,58,88,232,72,0,'/app/Media/Furniture/','bench_f_22x58_landry.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'bench_f_23x47_acorn',23,47,92,188,72,0,'/app/Media/Furniture/','bench_f_23x47_acorn.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'bench_r_17x63_ziggy',17,63,68,252,72,0,'/app/Media/Furniture/','bench_r_17x63_ziggy.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'bench_r_22x60_landry',22,60,88,240,72,0,'/app/Media/Furniture/','bench_r_22x60_landry.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_b_43x24_hayden',43,24,172,96,72,0,'/app/Media/Furniture/','chair_b_43x24_hayden.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_f_29x25_emil',29,25,116,100,72,0,'/app/Media/Furniture/','chair_f_29x25_emil.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_f_30x28',30,28,120,112,72,0,'/app/Media/Furniture/','chair_f_30x28.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_f_32x26_aluna',32,26,128,104,72,0,'/app/Media/Furniture/','chair_f_32x26_aluna.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_f_32x27_nook',32,27,128,108,72,0,'/app/Media/Furniture/','chair_f_32x27_nook.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_f_33x33',33,33,132,132,72,0,'/app/Media/Furniture/','chair_f_33x33.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_f_34x17_crestwood',34,17,136,68,72,0,'/app/Media/Furniture/','chair_f_34x17_crestwood.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_f_34x19_porter',34,19,136,76,72,0,'/app/Media/Furniture/','chair_f_34x19_porter.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_f_34x29_grace',34,29,136,116,72,0,'/app/Media/Furniture/','chair_f_34x29_grace.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_f_35x37_rowan',35,37,140,148,72,0,'/app/Media/Furniture/','chair_f_35x37_rowan.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_f_36x24_mykonos',36,24,144,96,72,0,'/app/Media/Furniture/','chair_f_36x24_mykonos.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_f_36x38',36,38,144,152,72,0,'/app/Media/Furniture/','chair_f_36x38.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_f_37x38_dean',37,38,148,152,72,0,'/app/Media/Furniture/','chair_f_37x38_dean.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_f_38x25_axel',38,25,152,100,72,0,'/app/Media/Furniture/','chair_f_38x25_axel.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_f_38x34_atlanta',38,34,152,136,72,0,'/app/Media/Furniture/','chair_f_38x34_atlanta.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_f_40x29',40,29,160,116,72,0,'/app/Media/Furniture/','chair_f_40x29.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_f_40x33',40,33,160,132,72,0,'/app/Media/Furniture/','chair_f_40x33.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_f_41x29',41,29,164,116,72,0,'/app/Media/Furniture/','chair_f_41x29.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_f_43x24_hayden',43,24,172,96,72,0,'/app/Media/Furniture/','chair_f_43x24_hayden.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_l_36x41',36,41,144,164,72,0,'/app/Media/Furniture/','chair_l_36x41.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_r_29x35_emil',29,35,116,140,72,0,'/app/Media/Furniture/','chair_r_29x35_emil.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_r_30x31',30,31,120,124,72,0,'/app/Media/Furniture/','chair_r_30x31.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_r_31x27',31,27,124,108,72,0,'/app/Media/Furniture/','chair_r_31x27.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_r_31x29',31,29,124,116,72,0,'/app/Media/Furniture/','chair_r_31x29.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_r_32x27_nook',32,27,128,108,72,0,'/app/Media/Furniture/','chair_r_32x27_nook.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_r_33x40_metro',33,40,132,160,72,0,'/app/Media/Furniture/','chair_r_33x40_metro.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_r_34x20_crestwood',34,20,136,80,72,0,'/app/Media/Furniture/','chair_r_34x20_crestwood.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_r_34x24_porter',34,24,136,96,72,0,'/app/Media/Furniture/','chair_r_34x24_porter.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_r_34x34_grace',34,34,136,136,72,0,'/app/Media/Furniture/','chair_r_34x34_grace.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_r_35x38',35,38,140,152,72,0,'/app/Media/Furniture/','chair_r_35x38.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_r_36x41',36,41,144,164,72,0,'/app/Media/Furniture/','chair_r_36x41.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_r_37x36',37,36,148,144,72,0,'/app/Media/Furniture/','chair_r_37x36.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_r_37x38_dean',37,38,148,152,72,0,'/app/Media/Furniture/','chair_r_37x38_dean.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_r_38x40_atlanta',38,40,152,160,72,0,'/app/Media/Furniture/','chair_r_38x40_atlanta.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_r_40x33',40,33,160,132,72,0,'/app/Media/Furniture/','chair_r_40x33.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_r_42x26_studio1904',42,26,168,104,72,0,'/app/Media/Furniture/','chair_r_42x26_studio1904.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_r_43x28_hayden',43,28,172,112,72,0,'/app/Media/Furniture/','chair_r_43x28_hayden.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_s_29x35_emil',29,35,116,140,72,0,'/app/Media/Furniture/','chair_s_29x35_emil.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_s_30x31',30,31,120,124,72,0,'/app/Media/Furniture/','chair_s_30x31.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_s_34x20_crestwood',34,20,136,80,72,0,'/app/Media/Furniture/','chair_s_34x20_crestwood.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_s_34x34_grace',34,34,136,136,72,0,'/app/Media/Furniture/','chair_s_34x34_grace.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_s_37x37_dean',37,37,148,148,72,0,'/app/Media/Furniture/','chair_s_37x37_dean.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_s_38x40_atlanta',38,40,152,160,72,0,'/app/Media/Furniture/','chair_s_38x40_atlanta.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'chair_s_43x28_hayden',43,28,172,112,72,0,'/app/Media/Furniture/','chair_s_43x28_hayden.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'console_f_23x48_maggie',23,48,92,192,72,0,'/app/Media/Furniture/','console_f_23x48_maggie.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'console_f_26x68',26,68,104,272,72,0,'/app/Media/Furniture/','console_f_26x68.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'console_f_27x48',27,48,108,192,72,0,'/app/Media/Furniture/','console_f_27x48.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'console_f_27x60',27,60,108,240,72,0,'/app/Media/Furniture/','console_f_27x60.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'console_f_27x80_arlo',27,80,108,320,72,0,'/app/Media/Furniture/','console_f_27x80_arlo.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'console_f_33x31_geo',33,31,132,124,72,0,'/app/Media/Furniture/','console_f_33x31_geo.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'console_f_33x41_geo',33,41,132,164,72,0,'/app/Media/Furniture/','console_f_33x41_geo.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'console_f_69x81_acorn',69,81,276,324,72,0,'/app/Media/Furniture/','console_f_69x81_acorn.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'console_f_75x89',75,89,300,356,72,0,'/app/Media/Furniture/','console_f_75x89.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'console_r_23x48_maggie',23,48,92,192,72,0,'/app/Media/Furniture/','console_r_23x48_maggie.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'console_r_33x31_geo',33,31,132,124,72,0,'/app/Media/Furniture/','console_r_33x31_geo.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'console_r_33x41_geo',33,41,132,164,72,0,'/app/Media/Furniture/','console_r_33x41_geo.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'dresser_f_26x56_massaro',26,56,104,224,72,0,'/app/Media/Furniture/','dresser_f_26x56_massaro.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'dresser_f_33x30_audrey',33,30,132,120,72,0,'/app/Media/Furniture/','dresser_f_33x30_audrey.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'dresser_f_33x52_audrey',33,52,132,208,72,0,'/app/Media/Furniture/','dresser_f_33x52_audrey.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'dresser_f_35x70_alexa',35,70,140,280,72,0,'/app/Media/Furniture/','dresser_f_35x70_alexa.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'dresser_f_37x67_heston',37,67,148,268,72,0,'/app/Media/Furniture/','dresser_f_37x67_heston.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'dresser_r_26x56_massaro',26,56,104,224,72,0,'/app/Media/Furniture/','dresser_r_26x56_massaro.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'dresser_r_33x30_audrey',33,30,132,120,72,0,'/app/Media/Furniture/','dresser_r_33x30_audrey.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'dresser_r_33x52_audrey',33,52,132,208,72,0,'/app/Media/Furniture/','dresser_r_33x52_audrey.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'dresser_r_37x67_heston',37,67,148,268,72,0,'/app/Media/Furniture/','dresser_r_37x67_heston.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'dresser_s_37x19_heston',37,19,148,76,72,0,'/app/Media/Furniture/','dresser_s_37x19_heston.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'lamp1_f_61x17',61,17,244,68,72,0,'/app/Media/Furniture/','lamp1_f_61x17.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'lamp1_f_61x19',61,19,244,76,72,0,'/app/Media/Furniture/','lamp1_f_61x19.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'lamp2_f_61x17',61,17,244,68,72,0,'/app/Media/Furniture/','lamp2_f_61x17.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'lamp2_f_61x19',61,19,244,76,72,0,'/app/Media/Furniture/','lamp2_f_61x19.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'lamp_f_33x7',33,7,132,28,72,0,'/app/Media/Furniture/','lamp_f_33x7.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'lamp_f_52x17',52,17,208,68,72,0,'/app/Media/Furniture/','lamp_f_52x17.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'lamp_f_54x30',54,30,216,120,72,0,'/app/Media/Furniture/','lamp_f_54x30.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'lamp_f_55x14_5',55,14,220,56,72,0,'/app/Media/Furniture/','lamp_f_55x14_5.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'lamp_f_60x20',60,20,240,80,72,0,'/app/Media/Furniture/','lamp_f_60x20.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'lamp_f_63x26',63,26,252,104,72,0,'/app/Media/Furniture/','lamp_f_63x26.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'lamp_f_64x12',64,12,256,48,72,0,'/app/Media/Furniture/','lamp_f_64x12.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'lamp_f_66x12',66,12,264,48,72,0,'/app/Media/Furniture/','lamp_f_66x12.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'lamp_f_66x22',66,22,264,88,72,0,'/app/Media/Furniture/','lamp_f_66x22.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'lamp_f_67x11',67,11,268,44,72,0,'/app/Media/Furniture/','lamp_f_67x11.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'lamp_f_68x10',68,10,272,40,72,0,'/app/Media/Furniture/','lamp_f_68x10.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'lamp_f_69x15_5',69,15,276,60,72,0,'/app/Media/Furniture/','lamp_f_69x15_5.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'lamp_f_77x15',77,15,308,60,72,0,'/app/Media/Furniture/','lamp_f_77x15.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'loveseat_f_36x57',36,57,144,228,72,0,'/app/Media/Furniture/','loveseat_f_36x57.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'nightstand_f_18x24_massaro',18,24,72,96,72,0,'/app/Media/Furniture/','nightstand_f_18x24_massaro.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'nightstand_f_24x18_acorn',24,18,96,72,72,0,'/app/Media/Furniture/','nightstand_f_24x18_acorn.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'nightstand_f_26x21_audrey',26,21,104,84,72,0,'/app/Media/Furniture/','nightstand_f_26x21_audrey.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'nightstand_f_28x22_alexa',28,22,112,88,72,0,'/app/Media/Furniture/','nightstand_f_28x22_alexa.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'nightstand_f_30x27_heston',30,27,120,108,72,0,'/app/Media/Furniture/','nightstand_f_30x27_heston.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'nightstand_f_35x40_ming',35,40,140,160,72,0,'/app/Media/Furniture/','nightstand_f_35x40_ming.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'nightstand_r_18x24_massaro',18,24,72,96,72,0,'/app/Media/Furniture/','nightstand_r_18x24_massaro.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'nightstand_r_24x18_acorn',24,18,96,72,72,0,'/app/Media/Furniture/','nightstand_r_24x18_acorn.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'nightstand_r_26x21_audrey',26,21,104,84,72,0,'/app/Media/Furniture/','nightstand_r_26x21_audrey.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'nightstand_r_30x27_heston',30,27,120,108,72,0,'/app/Media/Furniture/','nightstand_r_30x27_heston.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'nightstand_r_35x40_ming',35,40,140,160,72,0,'/app/Media/Furniture/','nightstand_r_35x40_ming.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'nightstand_s_30x19_heston',30,19,120,76,72,0,'/app/Media/Furniture/','nightstand_s_30x19_heston.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'nightstand_s_35x18_ming',35,18,140,72,72,0,'/app/Media/Furniture/','nightstand_s_35x18_ming.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sectional_f_31x103',31,103,124,412,72,0,'/app/Media/Furniture/','sectional_f_31x103.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sectional_f_35x107',35,107,140,428,72,0,'/app/Media/Furniture/','sectional_f_35x107.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sectional_f_35x107_henry',35,107,140,428,72,0,'/app/Media/Furniture/','sectional_f_35x107_henry.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sectional_f_64x97',64,97,256,388,72,0,'/app/Media/Furniture/','sectional_f_64x97.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sectional_r_35x107_henry',35,107,140,428,72,0,'/app/Media/Furniture/','sectional_r_35x107_henry.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_f_30x81',30,81,120,324,72,0,'/app/Media/Furniture/','sofa_f_30x81.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_f_30x85_surrey',30,85,120,340,72,0,'/app/Media/Furniture/','sofa_f_30x85_surrey.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_f_31x60',31,60,124,240,72,0,'/app/Media/Furniture/','sofa_f_31x60.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_f_31x85_urban',31,85,124,340,72,0,'/app/Media/Furniture/','sofa_f_31x85_urban.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_f_32x66',32,66,128,264,72,0,'/app/Media/Furniture/','sofa_f_32x66.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_f_32x66_mathias',32,66,128,264,72,0,'/app/Media/Furniture/','sofa_f_32x66_mathias.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_f_32x83',32,83,128,332,72,0,'/app/Media/Furniture/','sofa_f_32x83.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_f_32x89',32,89,128,356,72,0,'/app/Media/Furniture/','sofa_f_32x89.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_f_32x94',32,94,128,376,72,0,'/app/Media/Furniture/','sofa_f_32x94.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_f_33x75_metro',33,75,132,300,72,0,'/app/Media/Furniture/','sofa_f_33x75_metro.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_f_33x92',33,92,132,368,72,0,'/app/Media/Furniture/','sofa_f_33x92.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_f_35x64_baldwin',35,64,140,256,72,0,'/app/Media/Furniture/','sofa_f_35x64_baldwin.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_f_35x73_paidge copy',35,73,140,292,72,0,'/app/Media/Furniture/','sofa_f_35x73_paidge copy.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_f_35x73_paidge',35,73,140,292,72,0,'/app/Media/Furniture/','sofa_f_35x73_paidge.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_f_35x73_red',35,73,140,292,72,0,'/app/Media/Furniture/','sofa_f_35x73_red.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_f_36x87',36,87,144,348,72,0,'/app/Media/Furniture/','sofa_f_36x87.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_f_36x87_ancil',36,87,144,348,72,0,'/app/Media/Furniture/','sofa_f_36x87_ancil.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_f_39x98_portofino',39,98,156,392,72,0,'/app/Media/Furniture/','sofa_f_39x98_portofino.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_f_40x79',40,79,160,316,72,0,'/app/Media/Furniture/','sofa_f_40x79.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_f_41x127_portofino',41,127,164,508,72,0,'/app/Media/Furniture/','sofa_f_41x127_portofino.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_f_41x49',41,49,164,196,72,0,'/app/Media/Furniture/','sofa_f_41x49.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_r_31x85_urban',31,85,124,340,72,0,'/app/Media/Furniture/','sofa_r_31x85_urban.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_r_32x66_mathias',32,66,128,264,72,0,'/app/Media/Furniture/','sofa_r_32x66_mathias.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_r_35x64_baldwin',35,64,140,256,72,0,'/app/Media/Furniture/','sofa_r_35x64_baldwin.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_r_35x73_paidge',35,73,140,292,72,0,'/app/Media/Furniture/','sofa_r_35x73_paidge.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_s_32x39_mathias',32,39,128,156,72,0,'/app/Media/Furniture/','sofa_s_32x39_mathias.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_s_35x33_baldwin',35,33,140,132,72,0,'/app/Media/Furniture/','sofa_s_35x33_baldwin.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'sofa_s_35x38_paidge',35,38,140,152,72,0,'/app/Media/Furniture/','sofa_s_35x38_paidge.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'stand_f_44x12_donatello',44,12,176,48,72,0,'/app/Media/Furniture/','stand_f_44x12_donatello.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'stool_b_41x21_saddle',41,21,164,84,72,0,'/app/Media/Furniture/','stool_b_41x21_saddle.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'stool_f_41x21_saddle',41,21,164,84,72,0,'/app/Media/Furniture/','stool_f_41x21_saddle.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'stool_s_41x21_saddle',41,21,164,84,72,0,'/app/Media/Furniture/','stool_s_41x21_saddle.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_15x35',15,35,60,140,72,0,'/app/Media/Furniture/','table_f_15x35.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_16x19_gem',16,19,64,76,72,0,'/app/Media/Furniture/','table_f_16x19_gem.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_16x34',16,34,64,136,72,0,'/app/Media/Furniture/','table_f_16x34.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_16x34_plank',16,34,64,136,72,0,'/app/Media/Furniture/','table_f_16x34_plank.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_16x42',16,42,64,168,72,0,'/app/Media/Furniture/','table_f_16x42.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_17x15_martini',17,15,68,60,72,0,'/app/Media/Furniture/','table_f_17x15_martini.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_17x58',17,58,68,232,72,0,'/app/Media/Furniture/','table_f_17x58.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_18x16_escaya',18,16,72,64,72,0,'/app/Media/Furniture/','table_f_18x16_escaya.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_18x16_hex',18,16,72,64,72,0,'/app/Media/Furniture/','table_f_18x16_hex.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_18x21',18,21,72,84,72,0,'/app/Media/Furniture/','table_f_18x21.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_19x40_studio1904',19,40,76,160,72,0,'/app/Media/Furniture/','table_f_19x40_studio1904.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_19x41',19,41,76,164,72,0,'/app/Media/Furniture/','table_f_19x41.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_19x43_retrospect',19,43,76,172,72,0,'/app/Media/Furniture/','table_f_19x43_retrospect.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_20x34',20,34,80,136,72,0,'/app/Media/Furniture/','table_f_20x34.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_20x52',20,52,80,208,72,0,'/app/Media/Furniture/','table_f_20x52.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_22x24_reclaimed',22,24,88,96,72,0,'/app/Media/Furniture/','table_f_22x24_reclaimed.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_26x21_geo',26,21,104,84,72,0,'/app/Media/Furniture/','table_f_26x21_geo.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_26x30_manuscript',26,30,104,120,72,0,'/app/Media/Furniture/','table_f_26x30_manuscript.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_30x50_modern',30,50,120,200,72,0,'/app/Media/Furniture/','table_f_30x50_modern.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_30x60_ashcroft',30,60,120,240,72,0,'/app/Media/Furniture/','table_f_30x60_ashcroft.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_30x60_uptown',30,60,120,240,72,0,'/app/Media/Furniture/','table_f_30x60_uptown.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_30x68_adelaide',30,68,120,272,72,0,'/app/Media/Furniture/','table_f_30x68_adelaide.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_30x73',30,73,120,292,72,0,'/app/Media/Furniture/','table_f_30x73.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_30x77_tivoli',30,77,120,308,72,0,'/app/Media/Furniture/','table_f_30x77_tivoli.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_30x84_westwood',30,84,120,336,72,0,'/app/Media/Furniture/','table_f_30x84_westwood.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_f_36x48_counter',36,48,144,192,72,0,'/app/Media/Furniture/','table_f_36x48_counter.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_r_26x24_geo',26,24,104,96,72,0,'/app/Media/Furniture/','table_r_26x24_geo.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_r_30x50_modern',30,50,120,200,72,0,'/app/Media/Furniture/','table_r_30x50_modern.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_r_30x60_parsons',30,60,120,240,72,0,'/app/Media/Furniture/','table_r_30x60_parsons.png');
insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)
VALUES (3,0,'table_r_36x48_counter',36,48,144,192,72,0,'/app/Media/Furniture/','table_r_36x48_counter.png');


-- Create & Reload Object_Types
drop table objects;
drop table object_types;

CREATE TABLE IF NOT EXISTS object_types (
  id INT(11) NOT NULL AUTO_INCREMENT,
  obj_type VARCHAR(255) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

select 'Object_Types' as 'Loading Table'; 
INSERT INTO object_types (obj_type) VALUES ('Artwork');
INSERT INTO object_types (obj_type) VALUES ('Decors');
INSERT INTO object_types (obj_type) VALUES ('Floors');
INSERT INTO object_types (obj_type) VALUES ('Furniture');
INSERT INTO object_types (obj_type) VALUES ('Rooms');
INSERT INTO object_types (obj_type) VALUES ('Textures');

select count(*) from object_types into @rcds; 
select @rcds as 'Rows Loaded';

-- Create & Reload objects 
CREATE TABLE IF NOT EXISTS objects (
  id INT(11) NOT NULL AUTO_INCREMENT,
  obj_name VARCHAR(255) NOT NULL,
  obj_type_id INT(11) NOT NULL,
  furniture_id INT(11),
  real_height INT(11) NOT NULL,
  real_width INT(11) NOT NULL, 
  pixel_height INT(11) NOT NULL,
  pixel_width INT(11) NOT NULL,
  resolution INT(11) NOT NULL,
  static BOOLEAN NOT NULL,
  useradd BOOLEAN NOT NULL,
  user_id int(11), 
  file_path VARCHAR(255) NOT NULL,
  file_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8; 

-- Load Objects - Artwork
select 'Objects:Artwork' as 'Loading Table'; 
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Abandoned Michelin Tire',1,null,60,40,240,160,72,false,false,null,'/app/Media/Artwork/','Abandoned_Michelin_Tire.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Americana Diner',1,null,40,60,160,240,72,false,false,null,'/app/Media/Artwork/','Americana_Diner.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('art01',1,null,40,40,160,160,72,false,false,null,'/app/Media/Artwork/','art01.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('art02',1,null,40,40,160,160,72,false,false,null,'/app/Media/Artwork/','art02.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Arthur Kill Bridge',1,null,40,60,160,240,72,false,false,null,'/app/Media/Artwork/','Arthur_Kill_Bridge.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Bayway Diner',1,null,40,60,160,240,72,false,false,null,'/app/Media/Artwork/','Bayway_Diner.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Blue Hour Manhattan',1,null,40,60,160,240,72,false,false,null,'/app/Media/Artwork/','Blue_Hour_Manhattan.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Blue Hour Phillie',1,null,40,60,160,240,72,false,false,null,'/app/Media/Artwork/','Blue_Hour_Phillie.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Denver Union Station',1,null,40,60,160,240,72,false,false,null,'/app/Media/Artwork/','Denver_Union_Station.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Denver Capitol',1,null,40,60,160,240,72,false,false,null,'/app/Media/Artwork/','Denver_Capitol.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Midtown Magic',1,null,40,60,160,240,72,false,false,null,'/app/Media/Artwork/','Midtown_Magic.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Monster Bridge',1,null,40,60,160,240,72,false,false,null,'/app/Media/Artwork/','Monster_Bridge.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Center City Philadelphia',1,null,40,60,160,240,72,false,false,null,'/app/Media/Artwork/','Center_City_Philadelphia.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Sleepy Hollow LightHouse',1,null,40,40,160,160,72,false,false,null,'/app/Media/Artwork/','Sleepy_Hollow_LightHouse.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Two Cities',1,null,40,60,160,240,72,false,false,null,'/app/Media/Artwork/','Two_Cities.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Freedom Tower Lights',1,null,40,40,160,160,72,false,false,null,'/app/Media/Artwork/','Freedom_Tower_Lights.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Gehry Building',1,null,60,40,240,160,72,false,false,null,'/app/Media/Artwork/','Gehry_Building.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Jersey City IndieGrove',1,null,60,40,240,160,72,false,false,null,'/app/Media/Artwork/','Jersey_City_IndieGrove.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Philadelphia City Hall',1,null,60,40,240,160,72,false,false,null,'/app/Media/Artwork/','Philadelphia_City_Hall.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Raritan Reflections',1,null,40,60,160,240,72,false,false,null,'/app/Media/Artwork/','Raritan_Reflections.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Factory POV',1,null,40,60,160,240,72,false,false,null,'/app/Media/Artwork/','Factory_POV.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Midnight Express',1,null,40,60,160,240,72,false,false,null,'/app/Media/Artwork/','Midnight_Express.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Baltimore Magic',1,null,40,60,160,240,72,false,false,null,'/app/Media/Artwork/','Baltimore_Magic.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Jersey City Twilight',1,null,40,60,160,240,72,false,false,null,'/app/Media/Artwork/','Jersey_City_Twilight.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Ocean Ave Nights',1,null,40,60,160,240,72,false,false,null,'/app/Media/Artwork/','Ocean_Ave_Nights.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Center City Magic Hour',1,null,40,60,160,240,72,false,false,null,'/app/Media/Artwork/','Center_City_Magic_Hour.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Kearny NS9492',1,null,40,60,160,240,72,false,false,null,'/app/Media/Artwork/','Kearny_NS9492.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('West 17th',1,null,40,60,160,240,72,false,false,null,'/app/Media/Artwork/','West_17th.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('459 W18th',1,null,40,60,160,240,72,false,false,null,'/app/Media/Artwork/','459_W18th.jpg');

select count(*) from objects where obj_type_id=1 into @rcds; 
select @rcds as 'Rows Loaded';

-- Load Objects - Decors
select 'Objects:Decors' as 'Loading Table'; 
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('decor01',2,null,192,288,768,1152,72,true,false,null,'/app/Media/Decors/','dc01.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('decor02',2,null,192,288,768,1152,72,true,false,null,'/app/Media/Decors/','dc02.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('decor03',2,null,192,288,768,1152,72,true,false,null,'/app/Media/Decors/','dc03.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('decor05',2,null,192,288,768,1152,72,true,false,null,'/app/Media/Decors/','dc05.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('decor06',2,null,192,288,768,1152,72,true,false,null,'/app/Media/Decors/','dc06.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('decor08',2,null,192,288,768,1152,72,true,false,null,'/app/Media/Decors/','dc08.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('decor09',2,null,192,288,768,1152,72,true,false,null,'/app/Media/Decors/','dc09.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('decor10',2,null,192,288,768,1152,72,true,false,null,'/app/Media/Decors/','dc10.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('decor11',2,null,192,288,768,1152,72,true,false,null,'/app/Media/Decors/','dc11.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('decor12',2,null,192,288,768,1152,72,true,false,null,'/app/Media/Decors/','dc12.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('decor13',2,null,192,288,768,1152,72,true,false,null,'/app/Media/Decors/','dc13.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('decor14',2,null,192,288,768,1152,72,true,false,null,'/app/Media/Decors/','dc14.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('decor15',2,null,192,288,768,1152,72,true,false,null,'/app/Media/Decors/','dc15.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('decor18',2,null,192,288,768,1152,72,true,false,null,'/app/Media/Decors/','dc18.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('decor19',2,null,192,288,768,1152,72,true,false,null,'/app/Media/Decors/','dc19.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('bedRoom01',2,null,192,288,768,1152,72,true,false,null,'/app/Media/Decors/','br01.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('cafe01',2,null,192,288,768,1152,72,true,false,null,'/app/Media/Decors/','cafe01.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('cafe02',2,null,192,288,768,1152,72,true,false,null,'/app/Media/Decors/','cafe02.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('cafe03',2,null,192,288,768,1152,72,true,false,null,'/app/Media/Decors/','cafe03.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('waitingRoom01',2,null,192,288,768,1152,72,true,false,null,'/app/Media/Decors/','wr01.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('waitingRoom02',2,null,192,288,768,1152,72,true,false,null,'/app/Media/Decors/','wr02.png');

select count(*) from objects where obj_type_id=2 into @rcds; 
select @rcds as 'Rows Loaded';

-- Load Objects - Floors
select 'Objects:Floors' as 'Loading Table'; 
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('floor01',3,null,48,288,192,1152,72,true,false,null,'/app/Media/Floors/','floor01.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('floor02',3,null,48,288,192,1152,72,true,false,null,'/app/Media/Floors/','floor02.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('floor03',3,null,48,288,192,1152,72,true,false,null,'/app/Media/Floors/','floor03.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('floor04',3,null,48,288,192,1152,72,true,false,null,'/app/Media/Floors/','floor04.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('floor11',3,null,48,288,192,1152,72,true,false,null,'/app/Media/Floors/','floor11.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('floor12',3,null,48,288,192,1152,72,true,false,null,'/app/Media/Floors/','floor12.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('floor13',3,null,48,288,192,1152,72,true,false,null,'/app/Media/Floors/','floor13.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('floor14',3,null,48,288,192,1152,72,true,false,null,'/app/Media/Floors/','floor14.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('floor15',3,null,48,288,192,1152,72,true,false,null,'/app/Media/Floors/','floor15.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('floor16',3,null,48,288,192,1152,72,true,false,null,'/app/Media/Floors/','floor16.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('floor17',3,null,48,288,192,1152,72,true,false,null,'/app/Media/Floors/','floor17.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('floor18',3,null,48,288,192,1152,72,true,false,null,'/app/Media/Floors/','floor18.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('wood01',3,null,48,288,192,1152,72,true,false,null,'/app/Media/Floors/','wood01.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('wood02',3,null,48,288,192,1152,72,true,false,null,'/app/Media/Floors/','wood02.png');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('brick01',3,null,48,288,192,1152,72,true,false,null,'/app/Media/Floors/','brick01.png');

select count(*) from objects where obj_type_id=3 into @rcds; 
select @rcds as 'Rows Loaded';

-- Load Objects - Rooms
select 'Objects:Rooms' as 'Loading Table'; 
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('room01',5,null,192,288,768,1152,72,true,false,null,'/app/Media/Rooms/','cr01_ss_242225470.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('room02',5,null,192,288,768,1152,72,true,false,null,'/app/Media/Rooms/','er01_ss_510807781.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('room03',5,null,192,288,768,1152,72,true,false,null,'/app/Media/Rooms/','er02_ss_494779795.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('room04',5,null,192,288,768,1152,72,true,false,null,'/app/Media/Rooms/','er03_ss_400105312.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('room06',5,null,192,288,768,1152,72,true,false,null,'/app/Media/Rooms/','er04_ss_414284713.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('room07',5,null,192,288,768,1152,72,true,false,null,'/app/Media/Rooms/','er05_ss_289077719.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('room08',5,null,192,288,768,1152,72,true,false,null,'/app/Media/Rooms/','er06_IMGP6298_001.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('room09',5,null,192,288,768,1152,72,true,false,null,'/app/Media/Rooms/','er07_ss_524569297.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('room10',5,null,192,288,768,1152,72,true,false,null,'/app/Media/Rooms/','er08_ss_8570896.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('room11',5,null,192,288,768,1152,72,true,false,null,'/app/Media/Rooms/','er09_ss_37866571.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('room12',5,null,192,288,768,1152,72,true,false,null,'/app/Media/Rooms/','er10_ss_130470404.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('room13',5,null,192,288,768,1152,72,true,false,null,'/app/Media/Rooms/','er11_ss_413684080.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('room14',5,null,192,288,768,1152,72,true,false,null,'/app/Media/Rooms/','gl01.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('room15',5,null,192,288,768,1152,72,true,false,null,'/app/Media/Rooms/','lr01.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('room16',5,null,192,288,768,1152,72,true,false,null,'/app/Media/Rooms/','lr02.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('room17',5,null,192,288,768,1152,72,true,false,null,'/app/Media/Rooms/','lr03_ss_507907399.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('room18',5,null,192,288,768,1152,72,true,false,null,'/app/Media/Rooms/','sr01_ss_516539476.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('room19',5,null,192,288,768,1152,72,true,false,null,'/app/Media/Rooms/','sr02_ss_253334842.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('room20',5,null,192,288,768,1152,72,true,false,null,'/app/Media/Rooms/','lr04.jpg');

select count(*) from objects where obj_type_id=5 into @rcds; 
select @rcds as 'Rows Loaded';

-- Load Objects - Textures
select 'Objects:Textures' as 'Loading Table'; 
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Marble01',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','mb01.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Marble02',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','mb02.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Marble03',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','mb03.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Marble04',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','mb04.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Marble05',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','mb05.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Marble06',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','mb06.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture01',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','tx01.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture02',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','tx02.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture03',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','tx03.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture04',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','tx04.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture05',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','tx05.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture06',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','tx06.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture07',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','tx07.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture08',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','tx08.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture09',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','tx09.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture10',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','tx10.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture11',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','tx11.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture12',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','tx12.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture13',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','tx13.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture14',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','tx14.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture15',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','tx15.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture16',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','tx16.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture21',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','tx21.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture22',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','tx22.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture23',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','tx23.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture24',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','tx24.jpg');
INSERT INTO objects (obj_name, obj_type_id, furniture_id, real_height, real_width, pixel_height, pixel_width, resolution, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture25',6,null,192,288,768,1152,72,true,false,null,'/app/Media/Textures/','tx25.jpg');

select count(*) from objects where obj_type_id=6 into @rcds; 
select @rcds as 'Rows Loaded';

-- Load Objects - Furniture
-- THESE WERE THE OLD VALUES - IN CASE WE NEED TO RE-IMPLEMENT ANY OF THEM
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('armchair01',4,5,400,400,false,false,null,'/app/Media/Furniture/','armchair01.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('armoire01',4,4,400,400,false,false,null,'/app/Media/Furniture/','armoire01.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('bed01',4,2,400,400,false,false,null,'/app/Media/Furniture/','bed01.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('bed02',4,2,400,400,false,false,null,'/app/Media/Furniture/','bed02.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('chair03',4,5,400,400,false,false,null,'/app/Media/Furniture/','chair03.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('chair06',4,5,400,400,false,false,null,'/app/Media/Furniture/','chair06.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('chair07',4,5,400,400,false,false,null,'/app/Media/Furniture/','chair07.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('chair08',4,5,400,400,false,false,null,'/app/Media/Furniture/','chair08.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('chair21',4,5,400,400,false,false,null,'/app/Media/Furniture/','chair21.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('chair33',4,5,400,400,false,false,null,'/app/Media/Furniture/','chair33.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('chair_31x26_5',4,5,400,400,false,false,null,'/app/Media/Furniture/','chair_31x26_5.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('chair_32_3x26',4,5,400,400,false,false,null,'/app/Media/Furniture/','chair_32_3x26.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('chair_33x32_5',4,5,400,400,false,false,null,'/app/Media/Furniture/','chair_33x32_5.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('chair_33x40',4,5,400,400,false,false,null,'/app/Media/Furniture/','chair_33x40.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('chair_35x38',4,5,400,400,false,false,null,'/app/Media/Furniture/','chair_35x38.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('chair_37x36',4,5,400,400,false,false,null,'/app/Media/Furniture/','chair_37x36.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('chair_l_35_5x41',4,5,400,400,false,false,null,'/app/Media/Furniture/','chair_l_35_5x41.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('chair_r_35_5x41',4,5,400,400,false,false,null,'/app/Media/Furniture/','chair_r_35_5x41.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('chaise01',4,11,400,400,false,false,null,'/app/Media/Furniture/','chaise01.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('chestmirror01',4,9,400,400,false,false,null,'/app/Media/Furniture/','chestmirror01.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('closet01',4,6,400,400,false,false,null,'/app/Media/Furniture/','closet01.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('framedmirror01',4,1,400,400,false,false,null,'/app/Media/Furniture/','framedmirror01.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('futon01',4,14,400,400,false,false,null,'/app/Media/Furniture/','futon01.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('futon02',4,14,400,400,false,false,null,'/app/Media/Furniture/','futon02.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('futon03',4,14,400,400,false,false,null,'/app/Media/Furniture/','futon03.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('lamp_51x13',4,10,300,200,false,false,null,'/app/Media/Furniture/','lamp_51x13.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('lamp_61_3x17',4,10,300,200,false,false,null,'/app/Media/Furniture/','lamp_61_3x17.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('lamp_61x17',4,10,300,200,false,false,null,'/app/Media/Furniture/','lamp_61x17.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('lamp_61x18_5',4,10,300,200,false,false,null,'/app/Media/Furniture/','lamp_61x18_5.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('lamp_64x12',4,10,300,200,false,false,null,'/app/Media/Furniture/','lamp_64x12.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('lamp_66_3x12',4,10,300,200,false,false,null,'/app/Media/Furniture/','lamp_66_3x12.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('lamp_66_5x11',4,10,300,200,false,false,null,'/app/Media/Furniture/','lamp_66_5x11.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('lamp_73x49',4,10,300,200,false,false,null,'/app/Media/Furniture/','lamp_73x49.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('lamp_77_5x55',4,10,300,200,false,false,null,'/app/Media/Furniture/','lamp_77_5x55.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('lamp_81_5x20',4,10,300,200,false,false,null,'/app/Media/Furniture/','lamp_81_5x20.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('loveseat_36x57',4,10,400,400,false,false,null,'/app/Media/Furniture/','loveseat_36x57.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('loveseat01',4,10,400,400,false,false,null,'/app/Media/Furniture/','loveseat01.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('mirror01',4,1,400,400,false,false,null,'/app/Media/Furniture/','mirror01.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('plant01',4,13,400,400,false,false,null,'/app/Media/Furniture/','plant01.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('schrank01',4,4,400,400,false,false,null,'/app/Media/Furniture/','schrank01.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('sectional01',4,14,400,400,false,false,null,'/app/Media/Furniture/','sectional01.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('sofa_31_5x94',4,14,400,400,false,false,null,'/app/Media/Furniture/','sofa_31_5x94.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('sofa_33x75',4,14,400,400,false,false,null,'/app/Media/Furniture/','sofa_33x75.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('sofa_35_5x87',4,14,400,400,false,false,null,'/app/Media/Furniture/','sofa_35_5x87.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('sofa_40x79_4',4,14,400,400,false,false,null,'/app/Media/Furniture/','sofa_40x79_4.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('sofa_41x49_4',4,14,400,400,false,false,null,'/app/Media/Furniture/','sofa_41x49_4.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('sofa01',4,14,400,400,false,false,null,'/app/Media/Furniture/','sofa01.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('sofa03',4,14,400,400,false,false,null,'/app/Media/Furniture/','sofa03.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('sofa04',4,14,400,400,false,false,null,'/app/Media/Furniture/','sofa04.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('sofa05',4,14,400,400,false,false,null,'/app/Media/Furniture/','sofa04.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('sofa06',4,14,400,400,false,false,null,'/app/Media/Furniture/','sofa06.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('sofa07',4,14,400,400,false,false,null,'/app/Media/Furniture/','sofa07.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('sofa08',4,14,400,400,false,false,null,'/app/Media/Furniture/','sofa08.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('sofa10',4,14,400,400,false,false,null,'/app/Media/Furniture/','sofa10.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('coffeetable01',4,16,400,400,false,false,null,'/app/Media/Furniture/','coffeetable01.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('table_19x35',4,16,400,400,false,false,null,'/app/Media/Furniture/','table_19x35.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('table_19x51',4,16,400,400,false,false,null,'/app/Media/Furniture/','table_19x51.png');
-- INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, real_height, real_width, static, useradd, user_id, file_path, file_name) 
-- VALUES ('wickerchair01',4,5,400,400,false,false,null,'/app/Media/Furniture/','wickerchair01.png');

select 'Objects:Furniture' as 'Loading Table'; 
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('accent_f_30x30_mirror',4,null,30,30,120,120,72,0,0,null,'/app/Media/Furniture/','accent_f_30x30_mirror.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('accent_f_36x56_studio455mirror',4,null,36,56,144,224,72,0,0,null,'/app/Media/Furniture/','accent_f_36x56_studio455mirror.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('accent_f_44x44_mirror',4,null,44,44,176,176,72,0,0,null,'/app/Media/Furniture/','accent_f_44x44_mirror.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('bed_f_35x64_mikkel',4,null,35,64,140,256,72,0,0,null,'/app/Media/Furniture/','bed_f_35x64_mikkel.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('bed_f_51x65_chloe',4,null,51,65,204,260,72,0,0,null,'/app/Media/Furniture/','bed_f_51x65_chloe.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('bed_r_35x91_mikkel',4,null,35,91,140,364,72,0,0,null,'/app/Media/Furniture/','bed_r_35x91_mikkel.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('bed_r_51x93_chloe',4,null,51,93,204,372,72,0,0,null,'/app/Media/Furniture/','bed_r_51x93_chloe.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('bed_s_35x91_mikkel',4,null,35,91,140,364,72,0,0,null,'/app/Media/Furniture/','bed_s_35x91_mikkel.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('bed_s_51x93_chloe',4,null,51,93,204,372,72,0,0,null,'/app/Media/Furniture/','bed_s_51x93_chloe.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('bench_f_17x63_ziggy',4,null,17,63,68,252,72,0,0,null,'/app/Media/Furniture/','bench_f_17x63_ziggy.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('bench_f_20x52_phoebe',4,null,20,52,80,208,72,0,0,null,'/app/Media/Furniture/','bench_f_20x52_phoebe.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('bench_f_22x58_landry',4,null,22,58,88,232,72,0,0,null,'/app/Media/Furniture/','bench_f_22x58_landry.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('bench_f_23x47_acorn',4,null,23,47,92,188,72,0,0,null,'/app/Media/Furniture/','bench_f_23x47_acorn.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('bench_r_17x63_ziggy',4,null,17,63,68,252,72,0,0,null,'/app/Media/Furniture/','bench_r_17x63_ziggy.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('bench_r_22x60_landry',4,null,22,60,88,240,72,0,0,null,'/app/Media/Furniture/','bench_r_22x60_landry.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_b_43x24_hayden',4,null,43,24,172,96,72,0,0,null,'/app/Media/Furniture/','chair_b_43x24_hayden.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_f_29x25_emil',4,null,29,25,116,100,72,0,0,null,'/app/Media/Furniture/','chair_f_29x25_emil.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_f_30x28',4,null,30,28,120,112,72,0,0,null,'/app/Media/Furniture/','chair_f_30x28.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_f_32x26_aluna',4,null,32,26,128,104,72,0,0,null,'/app/Media/Furniture/','chair_f_32x26_aluna.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_f_32x27_nook',4,null,32,27,128,108,72,0,0,null,'/app/Media/Furniture/','chair_f_32x27_nook.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_f_33x33',4,null,33,33,132,132,72,0,0,null,'/app/Media/Furniture/','chair_f_33x33.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_f_34x17_crestwood',4,null,34,17,136,68,72,0,0,null,'/app/Media/Furniture/','chair_f_34x17_crestwood.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_f_34x19_porter',4,null,34,19,136,76,72,0,0,null,'/app/Media/Furniture/','chair_f_34x19_porter.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_f_34x29_grace',4,null,34,29,136,116,72,0,0,null,'/app/Media/Furniture/','chair_f_34x29_grace.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_f_35x37_rowan',4,null,35,37,140,148,72,0,0,null,'/app/Media/Furniture/','chair_f_35x37_rowan.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_f_36x24_mykonos',4,null,36,24,144,96,72,0,0,null,'/app/Media/Furniture/','chair_f_36x24_mykonos.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_f_36x38',4,null,36,38,144,152,72,0,0,null,'/app/Media/Furniture/','chair_f_36x38.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_f_37x38_dean',4,null,37,38,148,152,72,0,0,null,'/app/Media/Furniture/','chair_f_37x38_dean.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_f_38x25_axel',4,null,38,25,152,100,72,0,0,null,'/app/Media/Furniture/','chair_f_38x25_axel.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_f_38x34_atlanta',4,null,38,34,152,136,72,0,0,null,'/app/Media/Furniture/','chair_f_38x34_atlanta.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_f_40x29',4,null,40,29,160,116,72,0,0,null,'/app/Media/Furniture/','chair_f_40x29.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_f_40x33',4,null,40,33,160,132,72,0,0,null,'/app/Media/Furniture/','chair_f_40x33.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_f_41x29',4,null,41,29,164,116,72,0,0,null,'/app/Media/Furniture/','chair_f_41x29.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_f_43x24_hayden',4,null,43,24,172,96,72,0,0,null,'/app/Media/Furniture/','chair_f_43x24_hayden.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_l_36x41',4,null,36,41,144,164,72,0,0,null,'/app/Media/Furniture/','chair_l_36x41.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_r_29x35_emil',4,null,29,35,116,140,72,0,0,null,'/app/Media/Furniture/','chair_r_29x35_emil.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_r_30x31',4,null,30,31,120,124,72,0,0,null,'/app/Media/Furniture/','chair_r_30x31.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_r_31x27',4,null,31,27,124,108,72,0,0,null,'/app/Media/Furniture/','chair_r_31x27.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_r_31x29',4,null,31,29,124,116,72,0,0,null,'/app/Media/Furniture/','chair_r_31x29.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_r_32x27_nook',4,null,32,27,128,108,72,0,0,null,'/app/Media/Furniture/','chair_r_32x27_nook.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_r_33x40_metro',4,null,33,40,132,160,72,0,0,null,'/app/Media/Furniture/','chair_r_33x40_metro.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_r_34x20_crestwood',4,null,34,20,136,80,72,0,0,null,'/app/Media/Furniture/','chair_r_34x20_crestwood.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_r_34x24_porter',4,null,34,24,136,96,72,0,0,null,'/app/Media/Furniture/','chair_r_34x24_porter.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_r_34x34_grace',4,null,34,34,136,136,72,0,0,null,'/app/Media/Furniture/','chair_r_34x34_grace.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_r_35x38',4,null,35,38,140,152,72,0,0,null,'/app/Media/Furniture/','chair_r_35x38.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_r_36x41',4,null,36,41,144,164,72,0,0,null,'/app/Media/Furniture/','chair_r_36x41.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_r_37x36',4,null,37,36,148,144,72,0,0,null,'/app/Media/Furniture/','chair_r_37x36.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_r_37x38_dean',4,null,37,38,148,152,72,0,0,null,'/app/Media/Furniture/','chair_r_37x38_dean.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_r_38x40_atlanta',4,null,38,40,152,160,72,0,0,null,'/app/Media/Furniture/','chair_r_38x40_atlanta.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_r_40x33',4,null,40,33,160,132,72,0,0,null,'/app/Media/Furniture/','chair_r_40x33.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_r_42x26_studio1904',4,null,42,26,168,104,72,0,0,null,'/app/Media/Furniture/','chair_r_42x26_studio1904.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_r_43x28_hayden',4,null,43,28,172,112,72,0,0,null,'/app/Media/Furniture/','chair_r_43x28_hayden.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_s_29x35_emil',4,null,29,35,116,140,72,0,0,null,'/app/Media/Furniture/','chair_s_29x35_emil.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_s_30x31',4,null,30,31,120,124,72,0,0,null,'/app/Media/Furniture/','chair_s_30x31.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_s_34x20_crestwood',4,null,34,20,136,80,72,0,0,null,'/app/Media/Furniture/','chair_s_34x20_crestwood.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_s_34x34_grace',4,null,34,34,136,136,72,0,0,null,'/app/Media/Furniture/','chair_s_34x34_grace.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_s_37x37_dean',4,null,37,37,148,148,72,0,0,null,'/app/Media/Furniture/','chair_s_37x37_dean.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_s_38x40_atlanta',4,null,38,40,152,160,72,0,0,null,'/app/Media/Furniture/','chair_s_38x40_atlanta.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('chair_s_43x28_hayden',4,null,43,28,172,112,72,0,0,null,'/app/Media/Furniture/','chair_s_43x28_hayden.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('console_f_23x48_maggie',4,null,23,48,92,192,72,0,0,null,'/app/Media/Furniture/','console_f_23x48_maggie.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('console_f_26x68',4,null,26,68,104,272,72,0,0,null,'/app/Media/Furniture/','console_f_26x68.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('console_f_27x48',4,null,27,48,108,192,72,0,0,null,'/app/Media/Furniture/','console_f_27x48.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('console_f_27x60',4,null,27,60,108,240,72,0,0,null,'/app/Media/Furniture/','console_f_27x60.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('console_f_27x80_arlo',4,null,27,80,108,320,72,0,0,null,'/app/Media/Furniture/','console_f_27x80_arlo.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('console_f_33x31_geo',4,null,33,31,132,124,72,0,0,null,'/app/Media/Furniture/','console_f_33x31_geo.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('console_f_33x41_geo',4,null,33,41,132,164,72,0,0,null,'/app/Media/Furniture/','console_f_33x41_geo.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('console_f_69x81_acorn',4,null,69,81,276,324,72,0,0,null,'/app/Media/Furniture/','console_f_69x81_acorn.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('console_f_75x89',4,null,75,89,300,356,72,0,0,null,'/app/Media/Furniture/','console_f_75x89.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('console_r_23x48_maggie',4,null,23,48,92,192,72,0,0,null,'/app/Media/Furniture/','console_r_23x48_maggie.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('console_r_33x31_geo',4,null,33,31,132,124,72,0,0,null,'/app/Media/Furniture/','console_r_33x31_geo.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('console_r_33x41_geo',4,null,33,41,132,164,72,0,0,null,'/app/Media/Furniture/','console_r_33x41_geo.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('dresser_f_26x56_massaro',4,null,26,56,104,224,72,0,0,null,'/app/Media/Furniture/','dresser_f_26x56_massaro.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('dresser_f_33x30_audrey',4,null,33,30,132,120,72,0,0,null,'/app/Media/Furniture/','dresser_f_33x30_audrey.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('dresser_f_33x52_audrey',4,null,33,52,132,208,72,0,0,null,'/app/Media/Furniture/','dresser_f_33x52_audrey.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('dresser_f_35x70_alexa',4,null,35,70,140,280,72,0,0,null,'/app/Media/Furniture/','dresser_f_35x70_alexa.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('dresser_f_37x67_heston',4,null,37,67,148,268,72,0,0,null,'/app/Media/Furniture/','dresser_f_37x67_heston.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('dresser_r_26x56_massaro',4,null,26,56,104,224,72,0,0,null,'/app/Media/Furniture/','dresser_r_26x56_massaro.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('dresser_r_33x30_audrey',4,null,33,30,132,120,72,0,0,null,'/app/Media/Furniture/','dresser_r_33x30_audrey.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('dresser_r_33x52_audrey',4,null,33,52,132,208,72,0,0,null,'/app/Media/Furniture/','dresser_r_33x52_audrey.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('dresser_r_37x67_heston',4,null,37,67,148,268,72,0,0,null,'/app/Media/Furniture/','dresser_r_37x67_heston.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('dresser_s_37x19_heston',4,null,37,19,148,76,72,0,0,null,'/app/Media/Furniture/','dresser_s_37x19_heston.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('lamp1_f_61x17',4,null,61,17,244,68,72,0,0,null,'/app/Media/Furniture/','lamp1_f_61x17.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('lamp1_f_61x19',4,null,61,19,244,76,72,0,0,null,'/app/Media/Furniture/','lamp1_f_61x19.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('lamp2_f_61x17',4,null,61,17,244,68,72,0,0,null,'/app/Media/Furniture/','lamp2_f_61x17.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('lamp2_f_61x19',4,null,61,19,244,76,72,0,0,null,'/app/Media/Furniture/','lamp2_f_61x19.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('lamp_f_33x7',4,null,33,7,132,28,72,0,0,null,'/app/Media/Furniture/','lamp_f_33x7.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('lamp_f_52x17',4,null,52,17,208,68,72,0,0,null,'/app/Media/Furniture/','lamp_f_52x17.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('lamp_f_54x30',4,null,54,30,216,120,72,0,0,null,'/app/Media/Furniture/','lamp_f_54x30.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('lamp_f_55x14_5',4,null,55,14,220,56,72,0,0,null,'/app/Media/Furniture/','lamp_f_55x14_5.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('lamp_f_60x20',4,null,60,20,240,80,72,0,0,null,'/app/Media/Furniture/','lamp_f_60x20.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('lamp_f_63x26',4,null,63,26,252,104,72,0,0,null,'/app/Media/Furniture/','lamp_f_63x26.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('lamp_f_64x12',4,null,64,12,256,48,72,0,0,null,'/app/Media/Furniture/','lamp_f_64x12.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('lamp_f_66x12',4,null,66,12,264,48,72,0,0,null,'/app/Media/Furniture/','lamp_f_66x12.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('lamp_f_66x22',4,null,66,22,264,88,72,0,0,null,'/app/Media/Furniture/','lamp_f_66x22.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('lamp_f_67x11',4,null,67,11,268,44,72,0,0,null,'/app/Media/Furniture/','lamp_f_67x11.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('lamp_f_68x10',4,null,68,10,272,40,72,0,0,null,'/app/Media/Furniture/','lamp_f_68x10.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('lamp_f_69x15_5',4,null,69,15,276,60,72,0,0,null,'/app/Media/Furniture/','lamp_f_69x15_5.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('lamp_f_77x15',4,null,77,15,308,60,72,0,0,null,'/app/Media/Furniture/','lamp_f_77x15.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('loveseat_f_36x57',4,null,36,57,144,228,72,0,0,null,'/app/Media/Furniture/','loveseat_f_36x57.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('nightstand_f_18x24_massaro',4,null,18,24,72,96,72,0,0,null,'/app/Media/Furniture/','nightstand_f_18x24_massaro.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('nightstand_f_24x18_acorn',4,null,24,18,96,72,72,0,0,null,'/app/Media/Furniture/','nightstand_f_24x18_acorn.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('nightstand_f_26x21_audrey',4,null,26,21,104,84,72,0,0,null,'/app/Media/Furniture/','nightstand_f_26x21_audrey.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('nightstand_f_28x22_alexa',4,null,28,22,112,88,72,0,0,null,'/app/Media/Furniture/','nightstand_f_28x22_alexa.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('nightstand_f_30x27_heston',4,null,30,27,120,108,72,0,0,null,'/app/Media/Furniture/','nightstand_f_30x27_heston.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('nightstand_f_35x40_ming',4,null,35,40,140,160,72,0,0,null,'/app/Media/Furniture/','nightstand_f_35x40_ming.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('nightstand_r_18x24_massaro',4,null,18,24,72,96,72,0,0,null,'/app/Media/Furniture/','nightstand_r_18x24_massaro.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('nightstand_r_24x18_acorn',4,null,24,18,96,72,72,0,0,null,'/app/Media/Furniture/','nightstand_r_24x18_acorn.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('nightstand_r_26x21_audrey',4,null,26,21,104,84,72,0,0,null,'/app/Media/Furniture/','nightstand_r_26x21_audrey.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('nightstand_r_30x27_heston',4,null,30,27,120,108,72,0,0,null,'/app/Media/Furniture/','nightstand_r_30x27_heston.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('nightstand_r_35x40_ming',4,null,35,40,140,160,72,0,0,null,'/app/Media/Furniture/','nightstand_r_35x40_ming.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('nightstand_s_30x19_heston',4,null,30,19,120,76,72,0,0,null,'/app/Media/Furniture/','nightstand_s_30x19_heston.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('nightstand_s_35x18_ming',4,null,35,18,140,72,72,0,0,null,'/app/Media/Furniture/','nightstand_s_35x18_ming.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sectional_f_31x103',4,null,31,103,124,412,72,0,0,null,'/app/Media/Furniture/','sectional_f_31x103.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sectional_f_35x107',4,null,35,107,140,428,72,0,0,null,'/app/Media/Furniture/','sectional_f_35x107.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sectional_f_35x107_henry',4,null,35,107,140,428,72,0,0,null,'/app/Media/Furniture/','sectional_f_35x107_henry.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sectional_f_64x97',4,null,64,97,256,388,72,0,0,null,'/app/Media/Furniture/','sectional_f_64x97.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sectional_r_35x107_henry',4,null,35,107,140,428,72,0,0,null,'/app/Media/Furniture/','sectional_r_35x107_henry.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_f_30x81',4,null,30,81,120,324,72,0,0,null,'/app/Media/Furniture/','sofa_f_30x81.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_f_30x85_surrey',4,null,30,85,120,340,72,0,0,null,'/app/Media/Furniture/','sofa_f_30x85_surrey.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_f_31x60',4,null,31,60,124,240,72,0,0,null,'/app/Media/Furniture/','sofa_f_31x60.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_f_31x85_urban',4,null,31,85,124,340,72,0,0,null,'/app/Media/Furniture/','sofa_f_31x85_urban.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_f_32x66',4,null,32,66,128,264,72,0,0,null,'/app/Media/Furniture/','sofa_f_32x66.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_f_32x66_mathias',4,null,32,66,128,264,72,0,0,null,'/app/Media/Furniture/','sofa_f_32x66_mathias.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_f_32x83',4,null,32,83,128,332,72,0,0,null,'/app/Media/Furniture/','sofa_f_32x83.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_f_32x89',4,null,32,89,128,356,72,0,0,null,'/app/Media/Furniture/','sofa_f_32x89.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_f_32x94',4,null,32,94,128,376,72,0,0,null,'/app/Media/Furniture/','sofa_f_32x94.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_f_33x75_metro',4,null,33,75,132,300,72,0,0,null,'/app/Media/Furniture/','sofa_f_33x75_metro.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_f_33x92',4,null,33,92,132,368,72,0,0,null,'/app/Media/Furniture/','sofa_f_33x92.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_f_35x64_baldwin',4,null,35,64,140,256,72,0,0,null,'/app/Media/Furniture/','sofa_f_35x64_baldwin.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_f_35x73_paidge copy',4,null,35,73,140,292,72,0,0,null,'/app/Media/Furniture/','sofa_f_35x73_paidge copy.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_f_35x73_paidge',4,null,35,73,140,292,72,0,0,null,'/app/Media/Furniture/','sofa_f_35x73_paidge.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_f_35x73_red',4,null,35,73,140,292,72,0,0,null,'/app/Media/Furniture/','sofa_f_35x73_red.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_f_36x87',4,null,36,87,144,348,72,0,0,null,'/app/Media/Furniture/','sofa_f_36x87.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_f_36x87_ancil',4,null,36,87,144,348,72,0,0,null,'/app/Media/Furniture/','sofa_f_36x87_ancil.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_f_39x98_portofino',4,null,39,98,156,392,72,0,0,null,'/app/Media/Furniture/','sofa_f_39x98_portofino.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_f_40x79',4,null,40,79,160,316,72,0,0,null,'/app/Media/Furniture/','sofa_f_40x79.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_f_41x127_portofino',4,null,41,127,164,508,72,0,0,null,'/app/Media/Furniture/','sofa_f_41x127_portofino.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_f_41x49',4,null,41,49,164,196,72,0,0,null,'/app/Media/Furniture/','sofa_f_41x49.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_r_31x85_urban',4,null,31,85,124,340,72,0,0,null,'/app/Media/Furniture/','sofa_r_31x85_urban.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_r_32x66_mathias',4,null,32,66,128,264,72,0,0,null,'/app/Media/Furniture/','sofa_r_32x66_mathias.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_r_35x64_baldwin',4,null,35,64,140,256,72,0,0,null,'/app/Media/Furniture/','sofa_r_35x64_baldwin.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_r_35x73_paidge',4,null,35,73,140,292,72,0,0,null,'/app/Media/Furniture/','sofa_r_35x73_paidge.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_s_32x39_mathias',4,null,32,39,128,156,72,0,0,null,'/app/Media/Furniture/','sofa_s_32x39_mathias.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_s_35x33_baldwin',4,null,35,33,140,132,72,0,0,null,'/app/Media/Furniture/','sofa_s_35x33_baldwin.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('sofa_s_35x38_paidge',4,null,35,38,140,152,72,0,0,null,'/app/Media/Furniture/','sofa_s_35x38_paidge.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('stand_f_44x12_donatello',4,null,44,12,176,48,72,0,0,null,'/app/Media/Furniture/','stand_f_44x12_donatello.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('stool_b_41x21_saddle',4,null,41,21,164,84,72,0,0,null,'/app/Media/Furniture/','stool_b_41x21_saddle.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('stool_f_41x21_saddle',4,null,41,21,164,84,72,0,0,null,'/app/Media/Furniture/','stool_f_41x21_saddle.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('stool_s_41x21_saddle',4,null,41,21,164,84,72,0,0,null,'/app/Media/Furniture/','stool_s_41x21_saddle.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_15x35',4,null,15,35,60,140,72,0,0,null,'/app/Media/Furniture/','table_f_15x35.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_16x19_gem',4,null,16,19,64,76,72,0,0,null,'/app/Media/Furniture/','table_f_16x19_gem.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_16x34',4,null,16,34,64,136,72,0,0,null,'/app/Media/Furniture/','table_f_16x34.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_16x34_plank',4,null,16,34,64,136,72,0,0,null,'/app/Media/Furniture/','table_f_16x34_plank.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_16x42',4,null,16,42,64,168,72,0,0,null,'/app/Media/Furniture/','table_f_16x42.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_17x15_martini',4,null,17,15,68,60,72,0,0,null,'/app/Media/Furniture/','table_f_17x15_martini.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_17x58',4,null,17,58,68,232,72,0,0,null,'/app/Media/Furniture/','table_f_17x58.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_18x16_escaya',4,null,18,16,72,64,72,0,0,null,'/app/Media/Furniture/','table_f_18x16_escaya.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_18x16_hex',4,null,18,16,72,64,72,0,0,null,'/app/Media/Furniture/','table_f_18x16_hex.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_18x21',4,null,18,21,72,84,72,0,0,null,'/app/Media/Furniture/','table_f_18x21.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_19x40_studio1904',4,null,19,40,76,160,72,0,0,null,'/app/Media/Furniture/','table_f_19x40_studio1904.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_19x41',4,null,19,41,76,164,72,0,0,null,'/app/Media/Furniture/','table_f_19x41.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_19x43_retrospect',4,null,19,43,76,172,72,0,0,null,'/app/Media/Furniture/','table_f_19x43_retrospect.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_20x34',4,null,20,34,80,136,72,0,0,null,'/app/Media/Furniture/','table_f_20x34.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_20x52',4,null,20,52,80,208,72,0,0,null,'/app/Media/Furniture/','table_f_20x52.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_22x24_reclaimed',4,null,22,24,88,96,72,0,0,null,'/app/Media/Furniture/','table_f_22x24_reclaimed.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_26x21_geo',4,null,26,21,104,84,72,0,0,null,'/app/Media/Furniture/','table_f_26x21_geo.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_26x30_manuscript',4,null,26,30,104,120,72,0,0,null,'/app/Media/Furniture/','table_f_26x30_manuscript.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_30x50_modern',4,null,30,50,120,200,72,0,0,null,'/app/Media/Furniture/','table_f_30x50_modern.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_30x60_ashcroft',4,null,30,60,120,240,72,0,0,null,'/app/Media/Furniture/','table_f_30x60_ashcroft.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_30x60_uptown',4,null,30,60,120,240,72,0,0,null,'/app/Media/Furniture/','table_f_30x60_uptown.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_30x68_adelaide',4,null,30,68,120,272,72,0,0,null,'/app/Media/Furniture/','table_f_30x68_adelaide.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_30x73',4,null,30,73,120,292,72,0,0,null,'/app/Media/Furniture/','table_f_30x73.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_30x77_tivoli',4,null,30,77,120,308,72,0,0,null,'/app/Media/Furniture/','table_f_30x77_tivoli.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_30x84_westwood',4,null,30,84,120,336,72,0,0,null,'/app/Media/Furniture/','table_f_30x84_westwood.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_f_36x48_counter',4,null,36,48,144,192,72,0,0,null,'/app/Media/Furniture/','table_f_36x48_counter.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_r_26x24_geo',4,null,26,24,104,96,72,0,0,null,'/app/Media/Furniture/','table_r_26x24_geo.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_r_30x50_modern',4,null,30,50,120,200,72,0,0,null,'/app/Media/Furniture/','table_r_30x50_modern.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_r_30x60_parsons',4,null,30,60,120,240,72,0,0,null,'/app/Media/Furniture/','table_r_30x60_parsons.png');
insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)
VALUES ('table_r_36x48_counter',4,null,36,48,144,192,72,0,0,null,'/app/Media/Furniture/','table_r_36x48_counter.png');

select count(*) from objects where obj_type_id=4 into @rcds; 
select @rcds as 'Rows Loaded';


-- -- Alter Table & Update Showrooms
-- alter table showrooms
-- add column showroom_height INT(11) NOT NULL AFTER id,
-- add column showroom_width INT(11) NOT NULL AFTER showroom_height,
-- add column canvas_id INT(11) AFTER showroom_name,
-- add column file_path VARCHAR(255) AFTER canvas_id,
-- add column file_name VARCHAR(255) AFTER file_path;

-- update showrooms 
-- 	set canvas_id=1, file_path = null, file_name = null, showroom_height = 768, showroom_width = 1152;
	
-- -- Added on 05/02
-- ALTER TABLE `impulso_db`.`layers` 
-- ADD COLUMN `angle` DECIMAL(13,10) NULL DEFAULT 0 AFTER `position_left`;  


