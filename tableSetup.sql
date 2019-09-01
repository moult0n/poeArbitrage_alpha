set foreign_key_checks=0;

drop table IF EXISTS flip;
drop table IF EXISTS component;

CREATE TABLE IF NOT EXISTS component (
	id 				INT(10) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name			VARCHAR(50) NOT NULL,
	query 			VARCHAR(400) NOT NULL,
	fullSet			INT NOT NULL
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS flip (
	id              INT unsigned NOT NULL AUTO_INCREMENT,
	name            VARCHAR(150) NOT NULL,
	componentId1	INT(10) unsigned NOT NULL,
	componentId2	INT(10) unsigned NOT NULL,
	componentId3	INT(10) unsigned DEFAULT NULL,
	sets			INT NOT NULL,
	PRIMARY KEY     (id)
)ENGINE = InnoDB;


alter table flip add foreign key (componentId1) references component(id);
alter table flip add foreign key (componentId2) references component(id);
alter table flip add foreign key (componentId3) references component(id);

#First Test add info
#insert into component (name,query,fullSet) values ('The Doctor','{"query":{"status":{"option":"online"},"type":"The Doctor","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',8);
#insert into component (name,query,fullSet) values ('Headhunter','{"query":{"status":{"option":"online"},"name":"Headhunter","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',2);
#insert into flip (name,componentId1,componentId2,sets) values ('Doctor to Headhunter Flip',1,2,2);

#Basic api call
#https://www.pathofexile.com/api/trade/search/Legion?source=

#Actual Data base entry
insert into component (name,query,fullSet) values ('The Doctor','{"query":{"status":{"option":"online"},"type":"The Doctor","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',8);
insert into component (name,query,fullSet) values ('Headhunter','{"query":{"status":{"option":"online"},"name":"Headhunter","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1);
insert into flip (name,componentId1,componentId2,sets) values ('Doctor to Headhunter Flip',1,2,2);
insert into component (name,query,fullSet) values ('The Fiend','{"query":{"status":{"option":"online"},"type":"The Fiend","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',11);
insert into flip (name,componentId1,componentId2,sets) values ('Fiend to Headhunter Flip',3,2,2);
insert into component (name,query,fullSet) values ('Pride of the First Ones','{"query":{"status":{"option":"online"},"type":"Pride of the First Ones","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',7);
insert into component (name,query,fullSet) values ('Farrul''s Fur','{"query":{"status":{"option":"online"},"name":"Farrul''s Fur","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1);
insert into flip (name,componentId1,componentId2,sets) values ('Pride of the First Ones to Farrul''s Fur Flip',4,5,2);
insert into component (name,query,fullSet) values ('The Immortal','{"query":{"status":{"option":"online"},"type":"The Immortal","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',10);
insert into component (name,query,fullSet) values ('House of Mirrors','{"query":{"status":{"option":"online"},"type":"House of Mirrors","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1);
insert into flip (name,componentId1,componentId2,sets) values ('The Immortal to House of Mirrors Flip',6,7,2);
insert into component (name,query,fullSet) values ('The Iron Bard','{"query":{"status":{"option":"online"},"type":"The Iron Bard","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',9);
insert into component (name,query,fullSet) values ('Trash to Treasure','{"query":{"status":{"option":"online"},"name":"Trash to Treasure","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1);
insert into flip (name,componentId1,componentId2,sets) values ('The Iron Bard to Trash to Treasure Flip',8,9,2);
insert into component (name,query,fullSet) values ('The Nurse','{"query":{"status":{"option":"online"},"type":"The Nurse","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',8);
insert into flip (name,componentId1,componentId2,sets) values ('The Nurse to The Doctor Flip',10,1,2);
insert into component (name,query,fullSet) values ('The Wolven King''s Bite','{"query":{"status":{"option":"online"},"type":"The Wolven King''s Bite","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',8);
insert into component (name,query,fullSet) values ('Rigwald''s Quills','{"query":{"status":{"option":"online"},"name":"Rigwald''s Quills","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1);
insert into flip (name,componentId1,componentId2,sets) values ('The Wolven King''s Bite to Rigwald''s Quills Flip',11,12,2);
insert into component (name,query,fullSet) values ('Immortal Resolve','{"query":{"status":{"option":"online"},"type":"Immortal Resolve","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',6);
insert into component (name,query,fullSet) values ('Fated Connections','{"query":{"status":{"option":"online"},"name":"Fated Connections","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1);
insert into flip (name,componentId1,componentId2,sets) values ('Immortal Resolve to Fated Connections Flip',13,14,2);
insert into component (name,query,fullSet) values ('The Life Thief','{"query":{"status":{"option":"online"},"type":"The Life Thief","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',6);
insert into component (name,query,fullSet) values ('Zerphi''s Heart','{"query":{"status":{"option":"online"},"name":"Zerphi''s Heart","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1);
insert into flip (name,componentId1,componentId2,sets) values ('The Life Thief to Zerphi''s Heart Flip',15,16,2);
insert into component (name,query,fullSet) values ('Hunter''s Reward','{"query":{"status":{"option":"online"},"type":"Hunter''s Reward","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',3);
insert into component (name,query,fullSet) values ('The Taming','{"query":{"status":{"option":"online"},"name":"The Taming","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1);
insert into flip (name,componentId1,componentId2,sets) values ('Hunter''s Reward to The Taming Flip',17,18,2);
insert into component (name,query,fullSet) values ('The Queen','{"query":{"status":{"option":"online"},"type":"The Queen","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',16);
insert into component (name,query,fullSet) values ('Atziri''s Acuity','{"query":{"status":{"option":"online"},"name":"Atziri''s Acuity","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1);
insert into flip (name,componentId1,componentId2,sets) values ('The Queen to Atziri''s Acuity Flip',19,20,1);
insert into component (name,query,fullSet) values ('The World Eater','{"query":{"status":{"option":"online"},"type":"The World Eater","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',8);
insert into component (name,query,fullSet) values ('Starforge','{"query":{"status":{"option":"online"},"name":"Starforge","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1);
insert into flip (name,componentId1,componentId2,sets) values ('The World Eater to Starforge Flip',21,22,2);
insert into component (name,query,fullSet) values ('The Mayor','{"query":{"status":{"option":"online"},"type":"The Mayor","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',5);
insert into component (name,query,fullSet) values ('The Perandus Manor','{"query":{"status":{"option":"online"},"name":"The Perandus Manor","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1);
insert into flip (name,componentId1,componentId2,sets) values ('The Mayor to The Perandus Manor Flip',23,24,2);
insert into component (name,query,fullSet) values ('The Professor','{"query":{"status":{"option":"online"},"type":"The Professor","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',4);
insert into component (name,query,fullSet) values ('The Putrid Cloister','{"query":{"status":{"option":"online"},"name":"The Putrid Cloister","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1);
insert into flip (name,componentId1,componentId2,sets) values ('The Professor to The Putrid Cloister Flip',25,26,2);
insert into component (name,query,fullSet) values ('Burning Blood','{"query":{"status":{"option":"online"},"type":"Burning Blood","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',6);
insert into component (name,query,fullSet) values ('Xoph''s Blood','{"query":{"status":{"option":"online"},"name":"Xoph''s Blood","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1);
insert into flip (name,componentId1,componentId2,sets) values ('Burning Blood to Xoph''s Blood Flip',27,28,2);
insert into component (name,query,fullSet) values ('Pride Before the Fall','{"query":{"status":{"option":"online"},"type":"Pride Before the Fall","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',8);
insert into component (name,query,fullSet) values ('Kaom''s Heart','{"query":{"status":{"option":"online"},"name":"Kaom''s Heart","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1);
insert into flip (name,componentId1,componentId2,sets) values ('Pride Before the Fall to Kaom''s Heart Flip',29,30,2);
insert into component (name,query,fullSet) values ('The King''s Heart','{"query":{"status":{"option":"online"},"type":"The King''s Heart","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',8);
insert into flip (name,componentId1,componentId2,sets) values ('The King''s Heart to Kaom''s Heart Flip',31,30,2);
insert into component (name,query,fullSet) values ('The Last One Standing','{"query":{"status":{"option":"online"},"type":"The Last One Standing","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',10);
insert into component (name,query,fullSet) values ('Atziri''s Disfavour','{"query":{"status":{"option":"online"},"name":"Atziri''s Disfavour","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1);
insert into flip (name,componentId1,componentId2,sets) values ('The Last One Standing to Atziri''s Disfavour Flip',32,33,2);
insert into component (name,query,fullSet) values ('Rebirth','{"query":{"status":{"option":"online"},"type":"Rebirth","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',27);
insert into component (name,query,fullSet) values ('Oni-Goroshi','{"query":{"status":{"option":"online"},"name":"Oni-Goroshi","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1);
insert into flip (name,componentId1,componentId2,sets) values ('Rebirth to Oni-Goroshi Flip',34,35,2);
insert into component (name,query,fullSet) values ('The Wind','{"query":{"status":{"option":"online"},"type":"The Wind","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',7);
insert into component (name,query,fullSet) values ('Windripper','{"query":{"status":{"option":"online"},"name":"Windripper","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1);
insert into flip (name,componentId1,componentId2,sets) values ('The Wind to Windripper Flip',36,37,2);
insert into component (name,query,fullSet) values ('The Endless Darkness','{"query":{"status":{"option":"online"},"type":"The Endless Darkness","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',9);
insert into component (name,query,fullSet) values ('Voidforge','{"query":{"status":{"option":"online"},"name":"Voidforge","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1);
insert into flip (name,componentId1,componentId2,sets) values ('The Endless Darkness to Voidforge Flip',38,39,2);
insert into component (name,query,fullSet) values ('The Hunger','{"query":{"status":{"option":"online"},"type":"The Hunger","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',9);
insert into component (name,query,fullSet) values ('Taste of Hate','{"query":{"status":{"option":"online"},"name":"Taste of Hate","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1);
insert into flip (name,componentId1,componentId2,sets) values ('The Hunger to Taste of Hate Flip',40,41,2);
insert into component (name,query,fullSet) values ('The Green Dream','{"query":{"status":{"option":"online"},"name":"The Green Dream","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1); 
insert into component (name,query,fullSet) values ('Blessing of Chayula','{"query":{"status":{"option":"online"},"type":"Blessing of Chayula","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1); 
insert into component (name,query,fullSet) values ('The Green Nightmare','{"query":{"status":{"option":"online"},"name":"The Green Nightmare","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1);
insert into flip (name,componentId1,componentId2,componentId3,sets) values ('The Green Dream to The Green Nightmare Flip',42,43,44,3);
insert into component (name,query,fullSet) values ('The Blue Dream','{"query":{"status":{"option":"online"},"name":"The Blue Dream","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1); 
insert into component (name,query,fullSet) values ('The Blue Nightmare','{"query":{"status":{"option":"online"},"name":"The Blue Nightmare","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1);
insert into flip (name,componentId1,componentId2,componentId3,sets) values ('The Blue Dream to The Blue Nightmare Flip',45,43,46,3);
insert into component (name,query,fullSet) values ('The Red Dream','{"query":{"status":{"option":"online"},"name":"The Red Dream","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1); 
insert into component (name,query,fullSet) values ('The Red Nightmare','{"query":{"status":{"option":"online"},"name":"The Red Nightmare","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1);
insert into flip (name,componentId1,componentId2,componentId3,sets) values ('The Red Dream to The Red Nightmare Flip',47,43,48,3);
insert into component (name,query,fullSet) values ('The Great Leader of the North','{"query":{"status":{"option":"online"},"name":"The Great Leader of the North","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1); 
insert into component (name,query,fullSet) values ('The Magnate','{"query":{"status":{"option":"online"},"name":"The Magnate","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1); 
insert into component (name,query,fullSet) values ('The Nomad','{"query":{"status":{"option":"online"},"name":"The Nomad","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1);
insert into flip (name,componentId1,componentId2,componentId3,sets) values ('The Magnate to The Nomad Flip',49,50,51,3);
insert into component (name,query,fullSet) values ('Wind and Thunder','{"query":{"status":{"option":"online"},"name":"Wind and Thunder","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1); 
insert into flip (name,componentId1,componentId2,sets) values ('Wind and Thunder to Windripper Flip',52,37,3);
insert into component (name,query,fullSet) values ('Beauty Through Death','{"query":{"status":{"option":"online"},"type":"Beauty Through Death","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',5); 
insert into component (name,query,fullSet) values ('The Queen''s Sacrifice','{"query":{"status":{"option":"online"},"name":"The Queen''s Sacrifice","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1); 
insert into flip (name,componentId1,componentId2,sets) values ('Beauty Through Death to The Queen''s Sacrifice Flip',53,54,3);
insert into component (name,query,fullSet) values ('The King''s Path','{"query":{"status":{"option":"online"},"name":"The King''s Path","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1); 
insert into component (name,query,fullSet) values ('Kaom''s Sign','{"query":{"status":{"option":"online"},"name":"Kaom''s Sign","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1); 
insert into component (name,query,fullSet) values ('Kaom''s Way','{"query":{"status":{"option":"online"},"name":"Kaom''s Way","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1);
insert into flip (name,componentId1,componentId2,componentId3,sets) values ('Kaom''s Sign to Kaom''s Way Flip',55,56,57,4);
insert into component (name,query,fullSet) values ('The Master','{"query":{"status":{"option":"online"},"type":"The Master","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',4); 
insert into component (name,query,fullSet) values ('Bisco''s Collar','{"query":{"status":{"option":"online"},"name":"Bisco''s Collar","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1); 
insert into flip (name,componentId1,componentId2,sets) values ('The Master to Bisco''s Collar Flip',58,59,2);
insert into component (name,query,fullSet) values ('The Celestial Stone','{"query":{"status":{"option":"online"},"type":"The Celestial Stone","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',10); 
insert into component (name,query,fullSet) values ('Shaper i86 Opal Ring','{"query":{"status":{"option":"online"},"filters":{"misc_filters":{"filters":{"ilvl":{"min":86},"corrupted":{"option":false},"shaper_item":{"option":true}}},"type_filters":{"filters":{"rarity":{"option":"nonunique"}}},"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}},"type":"Opal Ring"},"sort":{"price":"asc"}}',1); 
insert into flip (name,componentId1,componentId2,sets) values ('The Celestial Stone to Shaper i86 Opal Ring Flip',60,61,2);
insert into component (name,query,fullSet) values ('Wealth and Power','{"query":{"status":{"option":"online"},"type":"Wealth and Power","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',11); 
insert into component (name,query,fullSet) values ('Level 4 Enlighten','{"query":{"status":{"option":"online"},"type":"Enlighten Support","filters":{"misc_filters":{"filters":{"gem_level":{"min":4,"max":4}}},"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1); 
insert into flip (name,componentId1,componentId2,sets) values ('Wealth and Power to Level 4 Enlighten Flip',62,63,2);
insert into component (name,query,fullSet) values ('The Dragon''s Heart','{"query":{"status":{"option":"online"},"type":"The Dragon''s Heart","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',11); 
insert into component (name,query,fullSet) values ('Level 4 Empower','{"query":{"status":{"option":"online"},"type":"Empower Support","filters":{"misc_filters":{"filters":{"gem_level":{"min":4,"max":4}}},"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1); 
insert into flip (name,componentId1,componentId2,sets) values ('The Dragon''s Heart to Level 4 Empower Flip',64,65,2);
insert into component (name,query,fullSet) values ('The Polymath','{"query":{"status":{"option":"online"},"type":"The Polymath","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',4); 
insert into component (name,query,fullSet) values ('Astramentis','{"query":{"status":{"option":"online"},"name":"Astramentis","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1); 
insert into flip (name,componentId1,componentId2,sets) values ('The Polymath to Astramentis Flip',66,67,2);
insert into component (name,query,fullSet) values ('The Soul','{"query":{"status":{"option":"online"},"type":"The Soul","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',9); 
insert into component (name,query,fullSet) values ('Soul Taker','{"query":{"status":{"option":"online"},"name":"Soul Taker","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1); 
insert into flip (name,componentId1,componentId2,sets) values ('The Soul to Soul Taker Flip',68,69,2);
insert into component (name,query,fullSet) values ('Might is Right','{"query":{"status":{"option":"online"},"type":"Might is Right","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',9); 
insert into component (name,query,fullSet) values ('Trypanon','{"query":{"status":{"option":"online"},"name":"Trypanon","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1); 
insert into flip (name,componentId1,componentId2,sets) values ('Might is Right to Trypanon Flip',70,71,2);
insert into component (name,query,fullSet) values ('The Beast','{"query":{"status":{"option":"online"},"type":"The Beast","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',6); 
insert into component (name,query,fullSet) values ('Belly of the Beast','{"query":{"status":{"option":"online"},"name":"Belly of the Beast","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1); 
insert into flip (name,componentId1,componentId2,sets) values ('The Beast to Belly of the Beast Flip',72,73,2);
insert into component (name,query,fullSet) values ('The Brittle Emperor','{"query":{"status":{"option":"online"},"type":"The Brittle Emperor","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',8); 
insert into component (name,query,fullSet) values ('Voll''s Devotion','{"query":{"status":{"option":"online"},"name":"Voll''s Devotion","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1); 
insert into flip (name,componentId1,componentId2,sets) values ('The Brittle Emperor to Voll''s Devotion Flip',74,75,2);
insert into component (name,query,fullSet) values ('The Deep Ones','{"query":{"status":{"option":"online"},"type":"The Deep Ones","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',5); 
insert into component (name,query,fullSet) values ('Tidebreaker','{"query":{"status":{"option":"online"},"name":"Tidebreaker","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1); 
insert into flip (name,componentId1,componentId2,sets) values ('The Deep Ones to Tidebreaker Flip',76,77,2);
insert into component (name,query,fullSet) values ('The Formless Sea','{"query":{"status":{"option":"online"},"type":"The Formless Sea","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',7); 
insert into component (name,query,fullSet) values ('Varunastra','{"query":{"status":{"option":"online"},"name":"Varunastra","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1); 
insert into flip (name,componentId1,componentId2,sets) values ('The Formless Sea to Varunastra Flip',78,79,2);
insert into component (name,query,fullSet) values ('The Offering','{"query":{"status":{"option":"online"},"type":"The Offering","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',6); 
insert into component (name,query,fullSet) values ('Shavronne''s Wrappings','{"query":{"status":{"option":"online"},"name":"Shavronne''s Wrappings","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1); 
insert into flip (name,componentId1,componentId2,sets) values ('The Offering to Shavronne''s Wrappings Flip',80,81,2);
insert into component (name,query,fullSet) values ('The Scavenger','{"query":{"status":{"option":"online"},"type":"The Scavenger","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',8); 
insert into component (name,query,fullSet) values ('Carcass Jack','{"query":{"status":{"option":"online"},"name":"Carcass Jack","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1); 
insert into flip (name,componentId1,componentId2,sets) values ('The Scavenger to Carcass Jack Flip',82,83,2);
insert into component (name,query,fullSet) values ('The Valley of Steel Boxes','{"query":{"status":{"option":"online"},"type":"The Valley of Steel Boxes","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',9); 
insert into component (name,query,fullSet) values ('Monstrous Treasure','{"query":{"status":{"option":"online"},"name":"Monstrous Treasure","filters":{"trade_filters":{"filters":{"sale_type":{"option":"priced"}}}}},"sort":{"price":"asc"}}',1); 
insert into flip (name,componentId1,componentId2,sets) values ('The Valley of Steel Boxes to Monstrous Treasure Flip',84,85,2);
