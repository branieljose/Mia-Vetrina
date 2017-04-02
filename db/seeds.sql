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
INSERT INTO object_category (obj_type_id,category) VALUES (4,'Accents');
INSERT INTO object_category (obj_type_id,category) VALUES (4,'Beds');
INSERT INTO object_category (obj_type_id,category) VALUES (4,'Benches');
INSERT INTO object_category (obj_type_id,category) VALUES (4,'Cabinets');
INSERT INTO object_category (obj_type_id,category) VALUES (4,'Chairs');
INSERT INTO object_category (obj_type_id,category) VALUES (4,'Closets');
INSERT INTO object_category (obj_type_id,category) VALUES (4,'Desks');
INSERT INTO object_category (obj_type_id,category) VALUES (4,'Dining');
INSERT INTO object_category (obj_type_id,category) VALUES (4,'Dressers');
INSERT INTO object_category (obj_type_id,category) VALUES (4,'Lamps');
INSERT INTO object_category (obj_type_id,category) VALUES (4,'Loungers');
INSERT INTO object_category (obj_type_id,category) VALUES (4,'Ottomans');
INSERT INTO object_category (obj_type_id,category) VALUES (4,'Plants');
INSERT INTO object_category (obj_type_id,category) VALUES (4,'Sofas');
INSERT INTO object_category (obj_type_id,category) VALUES (4,'Stands');
INSERT INTO object_category (obj_type_id,category) VALUES (4,'Tables');

select count(*) from object_category into @rcds; 
select @rcds as 'Rows Loaded';

-- Load Canvas Types 
select 'Canvas_Types' as 'Loading Table'; 
INSERT INTO canvas (canvas_name,canvas_size,real_uom,real_height,real_width,pixel_uom,pixel_height,pixel_width,useradd,user_id) 
VALUES ('FreeForm','Default','I',192,288,4,768,1152,0,null);

select count(*) from canvas into @rcds; 
select @rcds as 'Rows Loaded';


-- Load Objects - Artwork
select 'Objects:Artwork' as 'Loading Table'; 
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Abandoned Michelin Tire',1,null,600,400,false,false,null,'/app/Media/Artwork/','Abandoned_Michelin_Tire.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Americana Diner',1,null,400,600,false,false,null,'/app/Media/Artwork/','Americana_Diner.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('art01',1,null,400,400,false,false,null,'/app/Media/Artwork/','art01.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('art02',1,null,400,400,false,false,null,'/app/Media/Artwork/','art02.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Arthur Kill Bridge',1,null,400,600,false,false,null,'/app/Media/Artwork/','Arthur_Kill_Bridge.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Bayway Diner',1,null,400,600,false,false,null,'/app/Media/Artwork/','Bayway_Diner.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Blue Hour Manhattan',1,null,400,600,false,false,null,'/app/Media/Artwork/','Blue_Hour_Manhattan.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Blue Hour Phillie',1,null,400,600,false,false,null,'/app/Media/Artwork/','Blue_Hour_Phillie.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Denver Union Station',1,null,400,600,false,false,null,'/app/Media/Artwork/','Denver_Union_Station.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Denver Capitol',1,null,400,600,false,false,null,'/app/Media/Artwork/','Denver_Capitol.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Midtown Magic',1,null,400,600,false,false,null,'/app/Media/Artwork/','Midtown_Magic.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Monster Bridge',1,null,400,600,false,false,null,'/app/Media/Artwork/','Monster_Bridge.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Center City Philadelphia',1,null,400,600,false,false,null,'/app/Media/Artwork/','Center_City_Philadelphia.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Sleepy Hollow LightHouse',1,null,400,400,false,false,null,'/app/Media/Artwork/','Sleepy_Hollow_LightHouse.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Two Cities',1,null,400,600,false,false,null,'/app/Media/Artwork/','Two_Cities.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Freedom Tower Lights',1,null,400,400,false,false,null,'/app/Media/Artwork/','Freedom_Tower_Lights.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Gehry Building',1,null,600,400,false,false,null,'/app/Media/Artwork/','Gehry_Building.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Jersey City IndieGrove',1,null,600,400,false,false,null,'/app/Media/Artwork/','Jersey_City_IndieGrove.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Philadelphia City Hall',1,null,600,400,false,false,null,'/app/Media/Artwork/','Philadelphia_City_Hall.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Raritan Reflections',1,null,400,600,false,false,null,'/app/Media/Artwork/','Raritan_Reflections.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Factory POV',1,null,400,600,false,false,null,'/app/Media/Artwork/','Factory_POV.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Midnight Express',1,null,400,600,false,false,null,'/app/Media/Artwork/','Midnight_Express.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Baltimore Magic',1,null,400,600,false,false,null,'/app/Media/Artwork/','Baltimore_Magic.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Jersey City Twilight',1,null,400,600,false,false,null,'/app/Media/Artwork/','Jersey_City_Twilight.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Ocean Ave Nights',1,null,400,600,false,false,null,'/app/Media/Artwork/','Ocean_Ave_Nights.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Center City Magic Hour',1,null,400,600,false,false,null,'/app/Media/Artwork/','Center_City_Magic_Hour.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Kearny NS9492',1,null,400,600,false,false,null,'/app/Media/Artwork/','Kearny_NS9492.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('West 17th',1,null,400,600,false,false,null,'/app/Media/Artwork/','West_17th.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('459 W18th',1,null,400,600,false,false,null,'/app/Media/Artwork/','459_W18th.jpg');

select count(*) from objects where obj_type_id=1 into @rcds; 
select @rcds as 'Rows Loaded';

-- Load Objects - Decors
select 'Objects:Decors' as 'Loading Table'; 
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('decor01',2,null,800,1200,true,false,null,'/app/Media/Decors/','dc01.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('decor02',2,null,800,1200,true,false,null,'/app/Media/Decors/','dc02.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('decor03',2,null,800,1200,true,false,null,'/app/Media/Decors/','dc03.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('decor05',2,null,800,1200,true,false,null,'/app/Media/Decors/','dc05.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('decor06',2,null,800,1200,true,false,null,'/app/Media/Decors/','dc06.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('decor08',2,null,800,1200,true,false,null,'/app/Media/Decors/','dc08.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('decor09',2,null,800,1200,true,false,null,'/app/Media/Decors/','dc09.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('decor10',2,null,800,1200,true,false,null,'/app/Media/Decors/','dc10.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('decor11',2,null,800,1200,true,false,null,'/app/Media/Decors/','dc11.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('decor12',2,null,800,1200,true,false,null,'/app/Media/Decors/','dc12.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('decor13',2,null,800,1200,true,false,null,'/app/Media/Decors/','dc13.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('decor14',2,null,800,1200,true,false,null,'/app/Media/Decors/','dc14.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('decor15',2,null,800,1200,true,false,null,'/app/Media/Decors/','dc15.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('decor18',2,null,800,1200,true,false,null,'/app/Media/Decors/','dc18.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('bedRoom01',2,null,800,1200,true,false,null,'/app/Media/Decors/','br01.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('cafe01',2,null,800,1200,true,false,null,'/app/Media/Decors/','cafe01.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('cafe02',2,null,800,1200,true,false,null,'/app/Media/Decors/','cafe02.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('cafe03',2,null,800,1200,true,false,null,'/app/Media/Decors/','cafe03.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('waitingRoom01',2,null,800,1200,true,false,null,'/app/Media/Decors/','wr01.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('waitingRoom02',2,null,800,1200,true,false,null,'/app/Media/Decors/','wr02.png');

select count(*) from objects where obj_type_id=2 into @rcds; 
select @rcds as 'Rows Loaded';

-- Load Objects - Floors
select 'Objects:Floors' as 'Loading Table'; 
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('floor01',3,null,200,1200,true,false,null,'/app/Media/Floors/','floor01.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('floor02',3,null,200,1200,true,false,null,'/app/Media/Floors/','floor02.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('floor03',3,null,200,1200,true,false,null,'/app/Media/Floors/','floor03.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('floor04',3,null,200,1200,true,false,null,'/app/Media/Floors/','floor04.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('floor11',3,null,200,1200,true,false,null,'/app/Media/Floors/','floor11.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('floor12',3,null,200,1200,true,false,null,'/app/Media/Floors/','floor12.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('floor13',3,null,200,1200,true,false,null,'/app/Media/Floors/','floor13.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('floor14',3,null,200,1200,true,false,null,'/app/Media/Floors/','floor14.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('floor15',3,null,200,1200,true,false,null,'/app/Media/Floors/','floor15.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('floor16',3,null,200,1200,true,false,null,'/app/Media/Floors/','floor16.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('floor17',3,null,200,1200,true,false,null,'/app/Media/Floors/','floor17.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('floor18',3,null,200,1200,true,false,null,'/app/Media/Floors/','floor18.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('wood01',3,null,200,1200,true,false,null,'/app/Media/Floors/','wood01.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('wood02',3,null,200,1200,true,false,null,'/app/Media/Floors/','wood02.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('brick01',3,null,200,1200,true,false,null,'/app/Media/Floors/','brick01.png');

select count(*) from objects where obj_type_id=3 into @rcds; 
select @rcds as 'Rows Loaded';

-- Load Objects - Rooms
select 'Objects:Rooms' as 'Loading Table'; 
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('room01',5,null,800,1200,true,false,null,'/app/Media/Rooms/','br01.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('room02',5,null,800,1200,true,false,null,'/app/Media/Rooms/','gl01.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('room03',5,null,800,1200,true,false,null,'/app/Media/Rooms/','lb01.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('room04',5,null,800,1200,true,false,null,'/app/Media/Rooms/','lr01.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('room05',5,null,800,1200,true,false,null,'/app/Media/Rooms/','lr02.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('room06',5,null,800,1200,true,false,null,'/app/Media/Rooms/','br01_ss_37866571.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('room07',5,null,800,1200,true,false,null,'/app/Media/Rooms/','br02_ss_130470404.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('room08',5,null,800,1200,true,false,null,'/app/Media/Rooms/','br03_ss_413684080.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('room09',5,null,800,1200,true,false,null,'/app/Media/Rooms/','dr01_ss_8570896.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('room10',5,null,800,1200,true,false,null,'/app/Media/Rooms/','dr02_ss_524569297.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('room11',5,null,800,1200,true,false,null,'/app/Media/Rooms/','lr01_ss_289077719.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('room12',5,null,800,1200,true,false,null,'/app/Media/Rooms/','lr02_ss_345232532.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('room13',5,null,800,1200,true,false,null,'/app/Media/Rooms/','lr03_ss_400105312.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('room14',5,null,800,1200,true,false,null,'/app/Media/Rooms/','lr04_ss_414284713.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('room15',5,null,800,1200,true,false,null,'/app/Media/Rooms/','lr05_ss_494779795.jpg');

select count(*) from objects where obj_type_id=5 into @rcds; 
select @rcds as 'Rows Loaded';

-- Load Objects - Textures
select 'Objects:Textures' as 'Loading Table'; 
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Marble01',6,null,800,1200,true,false,null,'/app/Media/Textures/','mb01.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Marble02',6,null,800,1200,true,false,null,'/app/Media/Textures/','mb02.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Marble03',6,null,800,1200,true,false,null,'/app/Media/Textures/','mb03.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Marble04',6,null,800,1200,true,false,null,'/app/Media/Textures/','mb04.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Marble05',6,null,800,1200,true,false,null,'/app/Media/Textures/','mb05.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Marble06',6,null,800,1200,true,false,null,'/app/Media/Textures/','mb06.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture01',6,null,800,1200,true,false,null,'/app/Media/Textures/','tx01.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture02',6,null,800,1200,true,false,null,'/app/Media/Textures/','tx02.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture03',6,null,800,1200,true,false,null,'/app/Media/Textures/','tx03.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture04',6,null,800,1200,true,false,null,'/app/Media/Textures/','tx04.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture05',6,null,800,1200,true,false,null,'/app/Media/Textures/','tx05.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture06',6,null,800,1200,true,false,null,'/app/Media/Textures/','tx06.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture07',6,null,800,1200,true,false,null,'/app/Media/Textures/','tx07.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture08',6,null,800,1200,true,false,null,'/app/Media/Textures/','tx08.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture09',6,null,800,1200,true,false,null,'/app/Media/Textures/','tx09.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture10',6,null,800,1200,true,false,null,'/app/Media/Textures/','tx10.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture11',6,null,800,1200,true,false,null,'/app/Media/Textures/','tx11.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture12',6,null,800,1200,true,false,null,'/app/Media/Textures/','tx12.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture13',6,null,800,1200,true,false,null,'/app/Media/Textures/','tx13.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture14',6,null,800,1200,true,false,null,'/app/Media/Textures/','tx14.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture15',6,null,800,1200,true,false,null,'/app/Media/Textures/','tx15.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture21',6,null,800,1200,true,false,null,'/app/Media/Textures/','tx21.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture22',6,null,800,1200,true,false,null,'/app/Media/Textures/','tx22.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture23',6,null,800,1200,true,false,null,'/app/Media/Textures/','tx23.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture24',6,null,800,1200,true,false,null,'/app/Media/Textures/','tx24.jpg');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('Texture25',6,null,800,1200,true,false,null,'/app/Media/Textures/','tx25.jpg');

select count(*) from objects where obj_type_id=6 into @rcds; 
select @rcds as 'Rows Loaded';

-- Load Objects - Furniture
select 'Objects:Furniture' as 'Loading Table'; 
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('armchair01',4,5,400,400,false,false,null,'/app/Media/Furniture/','armchair01.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('armoire01',4,4,400,400,false,false,null,'/app/Media/Furniture/','armoire01.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('bed01',4,2,400,400,false,false,null,'/app/Media/Furniture/','bed01.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('bed02',4,2,400,400,false,false,null,'/app/Media/Furniture/','bed02.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('chair03',4,5,400,400,false,false,null,'/app/Media/Furniture/','chair03.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('chair07',4,5,400,400,false,false,null,'/app/Media/Furniture/','chair07.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('chair08',4,5,400,400,false,false,null,'/app/Media/Furniture/','chair08.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('chaise01',4,12,400,400,false,false,null,'/app/Media/Furniture/','chaise01.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('chestmirror01',4,9,400,400,false,false,null,'/app/Media/Furniture/','chestmirror01.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('closet01',4,7,400,400,false,false,null,'/app/Media/Furniture/','closet01.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('framedmirror01',4,13,400,400,false,false,null,'/app/Media/Furniture/','framedmirror01.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('futon01',4,10,400,400,false,false,null,'/app/Media/Furniture/','futon01.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('futon02',4,10,400,400,false,false,null,'/app/Media/Furniture/','futon02.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('futon03',4,10,400,400,false,false,null,'/app/Media/Furniture/','futon03.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('loveseat01',4,15,400,400,false,false,null,'/app/Media/Furniture/','loveseat01.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('mirror01',4,13,400,400,false,false,null,'/app/Media/Furniture/','mirror01.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('plant01',4,14,400,400,false,false,null,'/app/Media/Furniture/','plant01.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('schrank01',4,5,400,400,false,false,null,'/app/Media/Furniture/','schrank01.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('sectional01',4,15,400,400,false,false,null,'/app/Media/Furniture/','sectional01.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('sofa01',4,15,400,400,false,false,null,'/app/Media/Furniture/','sofa01.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('sofa03',4,15,400,400,false,false,null,'/app/Media/Furniture/','sofa03.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('sofa04',4,15,400,400,false,false,null,'/app/Media/Furniture/','sofa04.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('sofa05',4,15,400,400,false,false,null,'/app/Media/Furniture/','sofa04.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('sofa06',4,15,400,400,false,false,null,'/app/Media/Furniture/','sofa06.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('sofa07',4,15,400,400,false,false,null,'/app/Media/Furniture/','sofa07.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('sofa08',4,15,400,400,false,false,null,'/app/Media/Furniture/','sofa08.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('sofa10',4,15,400,400,false,false,null,'/app/Media/Furniture/','sofa10.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('wickerchair01',4,6,400,400,false,false,null,'/app/Media/Furniture/','wickerchair01.png');
INSERT INTO objects (obj_name, obj_type_id, obj_cat_id, height, width, static, useradd, user_id, file_path, file_name) 
VALUES ('coffeetable01',4,16,400,400,false,false,null,'/app/Media/Furniture/','coffeetable01.png');

select count(*) from objects where obj_type_id=4 into @rcds; 
select @rcds as 'Rows Loaded';


