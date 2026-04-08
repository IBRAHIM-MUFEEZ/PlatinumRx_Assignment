create table users (
user_id varchar(50) PRIMARY KEY,
name Varchar(50),
phone_number varchar(15),
mail_id varchar(100) Unique,
billing_address TEXT
);

-----------------------------------------------------------------
create table bookings (
booking_id varchar(100) PRIMARY KEY,
booking_date datetime,
room_no varchar(50),
user_id varchar(50),
FOREIGN KEY (user_id) REFERENCES users(user_id) 
);

-----------------------------------------------------------------
create table items (
item_id varchar(50) PRIMARY KEY,
item_name varchar(100),
item_rate decimal(10,2)
);

-----------------------------------------------------------------

create table booking_commercials (
id varchar(50) PRIMARY KEY,
booking_id varchar(100),
bill_id varchar(50),
bill_date datetime,
item_id varchar(50),
item_quantity decimal(10,2),
foreign key (booking_id) references bookings(booking_id),
foreign key (item_id) references items(item_id)
);
-----------------------------------------------------------------

INSERT INTO users (user_id, name, phone_number, mail_id, billing_address) VALUES
('21wrcxuy-67erfn', 'John Doe', '97XXXXXXXX', 'john.doe@example.com', '399c, high Street , roosevile'), -- From PDF [cite: 9]
('usr-8822-kp10', 'Jane Smith', '9812345678', 'jane.smith@email.com', '123 Maple Dr, Springfield'),
('usr-4591-mn04', 'Robert Brown', '9123456780', 'rbrown@provider.net', 'Flat 402, Highrise Apts');
-----------------------------------------------------------------

INSERT INTO bookings (booking_id, booking_date, room_no, user_id) VALUES
('bk-09f3e-95hj', '2021-09-23 07:36:48', 'rm-bhf9-aerjn', '21wrcxuy-67erfn'),
('bk-q034-q4o', '2021-09-23 11:45:00', 'rm-c123-xyz', 'usr-8822-kp10'),
('bk-nov-1101', '2021-11-05 14:20:00', 'rm-d456-abc', 'usr-4591-mn04'),
('bk-oct-1050', '2021-10-15 09:00:00', 'rm-bhf9-aerjn', '21wrcxuy-67erfn');

-----------------------------------------------------------------
INSERT INTO items (item_id, item_name, item_rate) VALUES
('itm-a9e8-q8fu', 'Tawa Paratha', 18.00),
('itm-a07vh-aer8', 'Mix Veg', 89.00), 
('itm-w978-23u4', 'Laundry Service', 150.00), 
('itm-lux-99', 'Luxury Dinner', 1200.00);
-----------------------------------------------------------------

INSERT INTO booking_commercials (id, booking_id, bill_id, bill_date, item_id, item_quantity) VALUES
-- John Doe's first bill 
('q34r-3q408-q34u', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a9e8-q8fu', 3.0),
('q304-ahf32-02u4', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a07vh-aer8', 1.0),
('134lr-oyfo8-3qk4', 'bk-q034-q4o', 'bl-34qhd-r7h8', '2021-09-23 12:05:37', 'itm-w978-23u4', 0.5),
('oct-comm-01', 'bk-oct-1050', 'bl-oct-777', '2021-10-15 20:30:00', 'itm-lux-99', 1.0),
('nov-comm-01', 'bk-nov-1101', 'bl-nov-888', '2021-11-06 08:15:00', 'itm-a07vh-aer8', 5.0);



