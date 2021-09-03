-- DDL Statements
CREATE DATABASE market_star_schema;

USE market_star_schema;

CREATE TABLE shopping_mode_dimen (
    ship_mode VARCHAR(25),
    vechicle_company VARCHAR(25),
    toll_required BOOLEAN
);

ALTER TABLE shopping_mode_dimen
ADD constraint primary key (ship_mode);

-- DML Statements
insert into shopping_mode_dimen
values 
	('Delivery Truck', 'Ashok Leyland', false),
    ('Regular Air', 'Air India', false);

insert into shopping_mode_dimen (ship_mode, vechicle_company, toll_required)
values 
	('Delivery Truck', 'Ashok Leyland', false),
    ('Regular Air', 'Air India', false);

UPDATE shopping_mode_dimen 
SET 
    toll_required = TRUE
WHERE
    ship_mode = 'Delivery Truck';

DELETE FROM shopping_mode_dimen 
WHERE
    vechicle_company = 'Air India';

alter table shopping_mode_dimen
add vechicle_number varchar(20);

update shopping_mode_dimen
set vechicle_number = 'TN-AH-0548';

alter table shopping_mode_dimen
drop column vechicle_number;

alter table shopping_mode_dimen
change toll_required toll_amount int;
