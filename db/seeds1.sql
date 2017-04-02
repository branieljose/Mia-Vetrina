USE impulso_db;

set @rcds = 0; 

-- Load Palettes 
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
VALUES ('Sherwin Williams Colors','/app/Media/Colors/','Sherwin_Williams_Colors.ase');
select count(*) from palettes into @rcds; 
select @rcds as 'Rows Loaded';

-- Load Object Types 
select 'Object_Types' as 'Loading Table'; 
INSERT INTO object_types (obj_type) VALUES ('Artwork');
INSERT INTO object_types (obj_type) VALUES ('Decors');
INSERT INTO object_types (obj_type) VALUES ('Floors');
INSERT INTO object_types (obj_type) VALUES ('Furniture');
INSERT INTO object_types (obj_type) VALUES ('Rooms');
INSERT INTO object_types (obj_type) VALUES ('Textures');
select count(*) from object_types into @rcds; 
select @rcds as 'Rows Loaded';

-- Load Object Categories 
select 'Object_Category' as 'Loading Table'; 
INSERT INTO object_category (category) VALUES ('Artwork');
INSERT INTO object_category (category) VALUES ('Decors');
INSERT INTO object_category (category) VALUES ('Floors');
INSERT INTO object_category (category) VALUES ('Furniture-Beds');
INSERT INTO object_category (category) VALUES ('Furniture-Cabinets');
INSERT INTO object_category (category) VALUES ('Furniture-Chairs');
INSERT INTO object_category (category) VALUES ('Furniture-Closets');
INSERT INTO object_category (category) VALUES ('Furniture-Desks');
INSERT INTO object_category (category) VALUES ('Furniture-Dressers');
INSERT INTO object_category (category) VALUES ('Furniture-Futons');
INSERT INTO object_category (category) VALUES ('Furniture-Lamps');
INSERT INTO object_category (category) VALUES ('Furniture-Loungers');
INSERT INTO object_category (category) VALUES ('Furniture-Plants');
INSERT INTO object_category (category) VALUES ('Furniture-Sofas');
INSERT INTO object_category (category) VALUES ('Furniture-Tables');
INSERT INTO object_category (category) VALUES ('Rooms');
INSERT INTO object_category (category) VALUES ('Textures');
select count(*) from object_types into @rcds; 
select @rcds as 'Rows Loaded';