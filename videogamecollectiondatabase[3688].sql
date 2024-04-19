drop database VideoGameCollection
go
Create database VideoGameCollection
go
use VideoGameCollection

create table VideoGame (
Unique_ID int identity (100,1) primary key,
Name nvarchar(50) not null UNIQUE,
Release_Date date,
ESRB_Rating nvarchar(3)
);

create table Console (
Serial_Numb nvarchar(50) primary key,
Name nvarchar(50) not null,
Model nvarchar(50) not null,
Release_Date date,
);

create table Borrower (
Borrower_ID int identity (100,1) primary key,
FName nvarchar(50) not null,
MI nvarchar(1),
LName nvarchar(50) not null,
Address nvarchar(50) not null,
city nvarchar(20) not null,
state nvarchar(2),
country nvarchar(20) not null,
zip_code nvarchar(5) not null,
phone_Numb nvarchar(15) not null,
date_borrowed date not null,
date_returned date
);

create table Genre (
Genre_ID int identity (100,1) primary key,
Name nvarchar(50) not null UNIQUE,
); 

create table Developer (
Name nvarchar(200) primary key,
est_date date,
business_status nvarchar(50) not null,
Address nvarchar(50) not null,
city nvarchar(20) not null,
state nvarchar(2),
country nvarchar(20) not null,
zip_code nvarchar(20) not null
);

create table GameDeveloper (
Name nvarchar(200) FOREIGN KEY REFERENCES Developer(Name),
Unique_ID int FOREIGN KEY REFERENCES VideoGame(Unique_ID)
);

create table GameGenre (
Genre_ID int FOREIGN KEY REFERENCES Genre(Genre_ID),
Unique_ID int FOREIGN KEY REFERENCES VideoGame(Unique_ID)
);

create table ConsoleGame (
Unique_ID int FOREIGN KEY REFERENCES VideoGame(Unique_ID),
Serial_Numb nvarchar(50)  FOREIGN KEY REFERENCES Console(Serial_Numb)
);

create table GameBorrow(
Unique_ID int FOREIGN KEY REFERENCES VideoGame(Unique_ID),
Borrower_ID int FOREIGN KEY REFERENCES Borrower(Borrower_ID)
);

Create table ConsoleBorrow(
Serial_Numb nvarchar(50) FOREIGN KEY REFERENCES Console(Serial_Numb),
Borrower_ID int FOREIGN KEY REFERENCES Borrower(Borrower_ID)
);

create index Contact on borrower(Fname,Mi,Lname,address,city,state,country,zip_code,phone_numb);
create index daddress on developer(address,city,state,country,zip_code);
create index BInfo on developer(business_status, est_date);
create index Gname on genre(Name);
CREATE UNIQUE INDEX name on developer(name);
CREATE UNIQUE INDEX snum on console(serial_numb);
CREATE UNIQUE INDEX BID on borrower(borrower_ID);
CREATE UNIQUE INDEX VID on videoGame(Unique_ID);
CREATE UNIQUE INDEX GID on Genre(Genre_ID);

go
create view ConsoleNameMod 
as
select Name, Model
from Console
go

go
CREATE PROCEDURE AllDevelopers 
@country nvarchar(20) 
AS BEGIN SELECT * FROM Developer WHERE country = @country 
END; 
go

Insert into Borrower (FName, MI, LName, Address, city, state, country, zip_code, phone_Numb,date_borrowed) VALUES ('Steph','E','Morra','11 Boss Ave','Bradford','PA','USA','16701','2035201276','4/7/2019');
Insert into Borrower (FName, MI, LName, Address, city, state, country, zip_code, phone_Numb,date_borrowed) VALUES ('Kellen','J','Rouff','11 Boss Ave','Bradford','PA','USA','16701','4754953305','4/14/2019');
insert into Console (Name, Model, Release_Date, Serial_Numb) VALUES ('PS4','Standard','11/15/2013','CUH-1012A');
insert into Developer (Name, est_date, business_status, Address, city,state, country,zip_code) VALUES ('Rockstar North','2002','Active','4 622, Broadway','New York','NY','USA','10012');
insert into VideoGame (Name, ESRB_Rating, Release_Date) VALUES ('GTA 5','M','09/17/2013');
insert into VideoGame (Name, ESRB_Rating, Release_Date) VALUES ('Witcher 3','M','3/19/2015');
insert into Developer (Name, est_date, business_status, Address, city,country,zip_code) VALUES ('CD Project Red','2002','Active','Jagiellonska 74','Warsaw','Poland','05-077')
insert into Console (Name, Model, Release_Date, Serial_Numb) VALUES ('Nintendo Switch','First Gen','5/13/2017','XAW70000000000');
insert into Console (Name, Model, Release_Date, Serial_Numb) VALUES ('Nintendo Switch','First Gen','5/13/2017','XAW78159320121');
insert into VideoGame (Name, ESRB_Rating, Release_Date) VALUES ('Nier Automata','M','02/23/2017');
insert into Developer (Name, est_date, business_status, Address, city,country,zip_code) VALUES ('PlatniumGames','2007','Acticve','8F Tower West, Umeda Sky Building','Osaka','Japan','531-6108');
insert into VideoGame (Name, ESRB_Rating, Release_Date) VALUES ('Legend of Zelda Breath of the Wild','T','3/3/2017')
insert into Developer (Name, est_date, business_status, Address, city,country,zip_code) VALUES ('Nintendo Entertainment Planning & Development','2015','Active','２−１ Higashikujō Minamimatsudachō','Kyoto','Japan','601-8502');
Insert into Genre (name) Values ('Action');
Insert into Genre (name) Values ('Adventure');
Insert into Genre (name) Values ('MMO');
Insert into Genre (name) Values ('MOBA');
Insert into Genre (name) Values ('RPG');
Insert into Genre (name) Values ('FPS');
Insert into Genre (name) Values ('Simulation');
Insert into Genre (name) Values ('Horror');
Insert into Genre (name) Values ('Puzzle');
Insert into Genre (name) Values ('Sandbox');
Insert into Genre (name) Values ('Metriodvania');
Insert into Genre (name) Values ('Tactical');
Insert into Genre (name) Values ('Open World');
insert into VideoGame (Name, ESRB_Rating, Release_Date) VALUES ('Devil May Cry 5','M','3/8/2019');
insert into VideoGame (Name, ESRB_Rating, Release_Date) VALUES ('Sekiro Shadows Die Twice','M','3/22/2019');
insert into VideoGame (Name, ESRB_Rating, Release_Date) VALUES ('Legend of Zelda Majoras Mask','T','4/27/2000');
insert into Developer (Name, est_date, business_status, Address, city,country,zip_code) values ('Capcom','2001','Active','3-chōme-1-番３号 Uchihiranomachi','Osaka','Japan','540-0037');
insert into GameGenre (Genre_ID, Unique_ID) VALUES ('112','100');
insert into GameGenre (Genre_ID, Unique_ID) VALUES ('109','100');
insert into GameDeveloper (Unique_ID, Name) VALUES ('100','Rockstar North');
insert into ConsoleGame (Unique_ID, Serial_Numb) VALUES ('100','CUH-1012A');
insert into ConsoleBorrow(Serial_Numb,Borrower_ID) VALUES ('CUH-1012A','100');
insert into GameBorrow(Unique_ID,Borrower_ID) VALUES ('100','100');
insert into VideoGame (Name, ESRB_Rating, Release_Date) VALUES ('Dark Souls','M','9/22/2011');
insert into VideoGame (Name, ESRB_Rating, Release_Date) VALUES ('Dark Souls 2','M','5/11/2014');
insert into VideoGame (Name, ESRB_Rating, Release_Date) VALUES ('Dark Souls 3','M','5/24/2016');
insert into VideoGame (Name, ESRB_Rating, Release_Date) VALUES ('Bloodborne','M','5/24/2015');
insert into VideoGame (Name, ESRB_Rating, Release_Date) VALUES ('World of Warcraft','T','8/14/2018');
insert into VideoGame (Name, ESRB_Rating, Release_Date) VALUES ('Warcraft 3 Reign of Chaos','T','7/3/2002');
insert into VideoGame (Name, ESRB_Rating, Release_Date) VALUES ('Legend Of Zelda Ocarina of Time','T','11/21/1998');
insert into VideoGame (Name, ESRB_Rating, Release_Date) VALUES ('Crash Bandicoot N.sane Trilogy','T','6/30/2017');
insert into VideoGame (Name, ESRB_Rating, Release_Date) VALUES ('Final Fantasy X/X-2 Remastered','T','12/05/2013');
insert into VideoGame (Name, ESRB_Rating, Release_Date) VALUES ('Warcraft 3 Frozen Throne','T','7/1/2001');
insert into VideoGame (Name, ESRB_Rating, Release_Date) VALUES ('Sonic the Hedgehog','T','6/23/1991');
insert into VideoGame (Name, ESRB_Rating, Release_Date) VALUES ('Toejam and Earl','T','3/12/1991');


select * from Console;
select * from Developer;
select * from VideoGame;
Select * from Genre;
select * from Borrower;
select * from GameGenre;
select * from GameDeveloper;
select * from ConsoleGame;
select * from ConsoleBorrow;
select * from GameBorrow;

go
CREATE PROCEDURE UpdateBorrower
@borrowerID int,
@FName nvarchar(50) = null,
@MI nvarchar(1) = null,
@LName nvarchar(50) = null,
@Address nvarchar(50) = null,
@city nvarchar(20) = null,
@state nvarchar(2) = null,
@country nvarchar(20) = null,
@zip_code nvarchar(5) = null,
@phone_Numb nvarchar(15) = null,
@date_borrowed date = null,
@date_returned date = null
AS BEGIN 
Update Borrower 
set FName= isnull (@FName, FName), MI=isnull (@MI, MI), LName=isnull (@LName, LName), Address=isnull (@Address, Address), city=isnull (@city, city), state=isnull (@state, state), country=isnull (@country, country), zip_code=isnull (@zip_code, zip_code), phone_Numb=isnull (@phone_Numb, phone_Numb), date_borrowed=isnull (@date_borrowed, date_borrowed), date_returned=isnull (@date_returned, date_returned)
where Borrower_ID=@borrowerID
END
go

