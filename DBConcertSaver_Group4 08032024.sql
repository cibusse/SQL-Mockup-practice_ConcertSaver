/*CREATING  DATABASE*/

create database ConcertSaver;

use ConcertSaver;

/*CREATING TABLES*/

CREATE TABLE City (
	city_ID int not null,
	city_name varchar(50) not null,
	PRIMARY KEY(city_ID)
);

CREATE INDEX index_city_ID ON City(city_ID);
CREATE INDEX index_city_name ON City(city_name);

CREATE TABLE Venue (
    venue_ID int not null,
    venue_name varchar(50) not null,
    address varchar(100) null,
    city_ID int,
    city_name varchar(50) not null,
    PRIMARY KEY (venue_ID),
    FOREIGN KEY (city_ID) REFERENCES City (city_ID),
    FOREIGN KEY (city_name) REFERENCES City(city_name)
);

CREATE INDEX index_venue_ID ON Venue (venue_ID);
CREATE INDEX index_venue_name ON Venue (venue_name);

CREATE TABLE Concert (
	concert_ID int not null,
	concert_name varchar(100) not null,
    concert_date timestamp not null,
    city_ID int,
    city_name varchar(50) not null,
    venue_ID int not null,
    venue_name varchar(50) not null,
    PRIMARY KEY(concert_ID),
    FOREIGN KEY (city_ID) REFERENCES City (city_ID),
    FOREIGN KEY (city_name) REFERENCES City(city_name),
    FOREIGN KEY (venue_ID) REFERENCES Venue (venue_ID),
    FOREIGN KEY (venue_name) REFERENCES Venue(venue_name)
);

CREATE INDEX index_concert_ID ON Concert (concert_ID);
CREATE INDEX index_concert_name ON Concert (concert_name);

CREATE TABLE Artist (
	artist_ID int not null,
	artist_name varchar(100) not null,
    concert_ID int not null,
    concert_name varchar(100) not null,
	PRIMARY KEY(artist_ID),
	FOREIGN KEY (concert_ID) REFERENCES Concert (concert_ID),
    FOREIGN KEY (concert_name) REFERENCES Concert (concert_name)
);

CREATE TABLE Coupon (
	coupon_ID int not null,
	coupon_code integer not null,
    title varchar(80) not null,
    c_description varchar (300) not null,
    promo_image varbinary (8000) null,
	full_price float not null,
    discount_price float not null,
    concert_ID int not null,
    PRIMARY KEY(coupon_ID),
    FOREIGN KEY (concert_ID) REFERENCES Concert (concert_ID)
);


CREATE TABLE Users (
	user_ID int not null,
    username varchar(10) not null,
	first_name varchar(50) null,
    last_name varchar(50) not null,
    pass_word binary (64) not null,
    coupon_ID int not null,
    PRIMARY KEY(user_ID),
    FOREIGN KEY (coupon_ID) REFERENCES Coupon (coupon_ID)
);

CREATE INDEX index_user_ID ON Users (user_ID);
CREATE INDEX index_first_name ON Users (first_name);
CREATE INDEX index_last_name ON Users (last_name);
CREATE INDEX index_coupon_code ON Coupon (coupon_code);
CREATE INDEX index_full_price ON Coupon (full_price);
CREATE INDEX index_discount_price ON Coupon (discount_price);

CREATE TABLE Purchase_Order (
	order_ID int not null,
	order_date timestamp not null,
    payment_method varchar(20) not null,
    quantity integer not null,
    total_price float not null,
    user_ID int not null,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    coupon_code int not null,
	full_price float not null,
    discount_price float not null,
    PRIMARY KEY(order_ID),
    FOREIGN KEY (user_ID) REFERENCES Users (user_ID),
    FOREIGN KEY (first_name) REFERENCES Users (first_name),
    FOREIGN KEY (last_name) REFERENCES Users (last_name),
    FOREIGN KEY (coupon_code) REFERENCES Coupon (coupon_code),
	FOREIGN KEY (full_price) REFERENCES Coupon (full_price),
    FOREIGN KEY (discount_price) REFERENCES Coupon (discount_price)
);


--------------------------------------------------------------

/*POPULATING DATABASE*/
 
INSERT INTO City (city_ID, city_name) VALUES 
(1, 'Helsinki'),
(2, 'Turku'),
(3, 'Tampere'),
(4, 'Järvenpää'),
(5, 'Naantali')
;

INSERT INTO Venue (venue_ID, venue_name, address, city_ID, city_name) VALUES 
(001, 'Böle Arena & Club', 'Veturimiehenkatu 7, 00520', 1, 'Helsinki'),
(002, 'Sibelius-sali', 'Hallintokatu 4, 04400', 4, 'Järvenpää'),
(003, 'Logomo-sali', 'Junakatu 9, 20100', 2 , 'Turku'),
(004, 'Naantali Koivohuone', 'Nunnakatu 4, 21100', 5, 'Naantali'),
(005, 'Nokia Arena', 'Kansikatu 3, 33100', 3, 'Tampere')
;

INSERT INTO Concert (concert_ID, concert_name, concert_date, venue_ID, venue_name, city_ID, city_name) VALUES
(001, 'KÄÄRIJÄ - It’s Crazy, It’s Part2', '2024-04-05', 001, 'Böle Arena & Club', 1, 'Helsinki'),
(002, 'Teatraaliset Vivahteet', '2024-10-03', 002, 'Sibelius-sali', 4, 'Järvenpää'),
(003, 'Kaija Koo', '2024-03-13', 003 , 'Logomo-sali', 2, 'Turku'),
(004, 'Portion Boys', '2024-05-24', 004 ,'Naantali Koivohuone', 5, 'Naantali'),
(005, 'Blind Channel', '2024-04-27', 005, 'Nokia Arena', 3, 'Tampere')
;

INSERT INTO Artist (artist_ID, artist_name, concert_ID, concert_name) VALUES 
(001, 'Käärijä', 001,'KÄÄRIJÄ - It’s Crazy, It’s Part2'),
(002, 'Behm', 002, 'Teatraaliset Vivahteet'),
(003, 'Kaija Koo', 003, 'Kaija Koo'),
(004, 'Portion Boys', 004, 'Portion Boys'),
(005, 'Blind Channel', 005, 'Blind Channel')
;

INSERT INTO Coupon (coupon_ID, coupon_code, title, c_description, discount_price, full_price, concert_ID) VALUES
(001, 11111, "20% Less Standing Ticket Käärijä It’s Crazy, It’s Part2", "Save & enjoy of the best concert in town. Best discount coupon only here- GRAB IT NOW!", 25.00, 30.00, 001),
(002, 22222, "30% OFF Standard Ticket Exclusive BEHM ", "Save & enjoy of the best concert in town. Best discount coupon only here- GRAB IT NOW!
", 35.00, 45.50, 002),
(003, 33333, "25% Super Save Kaija Koo Auditorium Ticket", "Save & enjoy of the best concert in town. Best discount coupon only here- GRAB IT NOW!", 30.00, 37.50, 003),
(004, 44444, "30% Extra Discount Portion Boys Unnumbered Ticket", "Save & enjoy of the best concert in town. Best discount coupon only here- GRAB IT NOW!", 20.00, 26.00, 004),
(005, 55555, "22% OFF Blind Channel Golden Circle All Ages","Save & enjoy of the best concert in town. Best discount coupon only here- GRAB IT NOW!", 40.00, 48.80, 05)
;

INSERT INTO Users (user_ID, username, first_name, last_name, pass_word, coupon_ID) VALUES
(0001, 'cchuang', 'Chien-Chuan', 'Huang', 'admin111', 005),
(0002, 'cbusse', 'Charlotte', 'Busse', 'admin222', 001),
(0003, 'hkoskinen', 'Koskinen', 'Henri', 'admin333', 004),
(0004, 'dmartinez', 'Martinez', 'Diana', 'admin444', 003),
(0005, 'snygård', 'Nygård', 'Saara', 'admin555', 002);


INSERT INTO Purchase_Order (order_ID, order_date, payment_method, quantity, total_price, coupon_code, user_ID, first_name, last_name, full_price, discount_price) VALUES
(1100, '2024-01-09', 'Visa', 1, 25.00, 11111, 0002,'Charlotte', 'Busse', 30.00, 25.00),
(1101, '2024-03-06', 'Mastercard', 2, 80.00, 55555, 0001, 'Chien-Chuan', 'Huang', 48.80, 40.00),
(1102, '2024-02-28', 'AMEX', 1, 20.00, 44444, 0003, 'Koskinen', 'Henri', 26.00, 20.00),
(1103, '2024-02-14', 'Discover', 3, 90.00, 33333, 0004, 'Martinez', 'Diana', 37.50, 30.00),
(1104, '2024-03-01', 'Visa', 2, 70.00, 22222, 0005, 'Nygård', 'Saara',45.50, 35.00);

INSERT INTO City (city_ID, city_name) VALUES 
(6, 'Espoo')
;















