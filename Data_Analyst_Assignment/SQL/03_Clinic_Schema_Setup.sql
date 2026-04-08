create table clinics (
    cid varchar(50) primary key,
    clinic_name varchar(100),
    city varchar(50),
    state varchar(50),
    country varchar(50)
);
---------------------

create table customer (
    uid varchar(50) primary key,
    name varchar(100),
    mobile varchar(15)
);
--------------------------------------
create table clinic_sales (
    oid varchar(50) primary key,
    uid varchar(50),
    cid varchar(50),
    amount decimal(10, 2),
    datetime datetime,
    sales_channel varchar(50),
    foreign key (uid) references customer(uid),
    foreign key (cid) references clinics(cid)
);

--------------------------------------------------
create table expenses (
    eid varchar(50) primary key,
    cid varchar(50),
    description varchar(255),
    amount decimal(10, 2),
    datetime datetime,
    foreign key (cid) references clinics(cid)
);

-----------------------------------------------------------------------------
insert into clinics (cid, clinic_name, city, state, country) values
('cnc-001', 'wellness clinic', 'mumbai', 'maharashtra', 'india'),
('cnc-002', 'city care', 'pune', 'maharashtra', 'india'),
('cnc-003', 'health point', 'bangalore', 'karnataka', 'india'),
('cnc-004', 'metro clinic', 'delhi', 'delhi', 'india'),
('cnc-005', 'healing touch', 'chennai', 'tamil nadu', 'india');

-------------------------------------------------------------
insert into customer (uid, name, mobile) values
('u-001', 'alice smith', '9876543210'),
('u-002', 'bob johnson', '9123456789'),
('u-003', 'charlie brown', '9988776655'),
('u-004', 'david miller', '9000011111'),
('u-005', 'eve davis', '9222233333');
-----------------------------------------------------------------------------------
insert into clinic_sales (oid, uid, cid, amount, datetime, sales_channel) values
('ord-101', 'u-001', 'cnc-001', 1500.00, '2021-10-05 10:30:00', 'direct'),
('ord-102', 'u-002', 'cnc-001', 2500.00, '2021-10-12 11:15:00', 'online'),
('ord-103', 'u-003', 'cnc-002', 3000.00, '2021-11-01 14:00:00', 'sodat'),
('ord-104', 'u-004', 'cnc-003', 5000.00, '2021-11-20 09:45:00', 'direct'),
('ord-105', 'u-005', 'cnc-004', 1200.00, '2021-12-05 16:20:00', 'online');
----------------------------------------------------------------------------------------
insert into expenses (eid, cid, description, amount, datetime) values
('exp-201', 'cnc-001', 'medical supplies', 450.00, '2021-10-06 09:00:00'),
('exp-202', 'cnc-002', 'electricity bill', 1200.00, '2021-11-05 10:00:00'),
('exp-203', 'cnc-003', 'staff salary', 15000.00, '2021-11-30 17:00:00'),
('exp-204', 'cnc-004', 'cleaning services', 800.00, '2021-12-01 08:30:00'),
('exp-205', 'cnc-005', 'rent', 5000.00, '2021-12-10 12:00:00');