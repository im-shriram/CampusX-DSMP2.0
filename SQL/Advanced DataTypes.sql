use db;
-- Numeric Datatypes
create table numeric_datatypes(
	-- integer datatypes
	id int primary key,
    age tinyint,
    weight smallint,
    likes mediumint signed,
    views bigint unsigned,
    
    -- Decimal Datatypes
    height decimal(5, 2), -- If you store the number which have more than 2 numbers after decimal point it will get round of.
    d_type_float float, -- range of 7 numbers
    d_type_double double -- range of 15 numbers
);

insert into numeric_datatypes values
(1, 23, 155,32444, 77234896, 23.855, 56.0986545, 34555.09781245090);
select * from numeric_datatypes; -- You can see the decimal values are rounded of.

-- Remaining String DataTypes
create table string_datatypes(
	gender enum('male', 'female'),
    hobbies set('playing', 'reading', 'singing', 'dancing')
);
insert into string_datatypes values
('others', 'drawing'), -- Empty string inserted
('male', 'playing,reading'); -- Cannot insert like this - 'playing, reading'
select * from string_datatypes;

-- Other Datatypes
-- blob
create table other_datatypes_1(
	dp mediumblob not null -- adding display profile
);
insert into other_datatypes_1(dp) values
(load_file("C:/Users/shrir/OneDrive/Pictures/Screenshots/Screenshot 2025-03-06 105613.png"));
select * from other_datatypes_1;

-- geometry - points, lines and polygon
create table other_datatypes_2(
	latlong geometry -- adding display profile
);
insert into other_datatypes_2(latlong) values
(point(123.4, 675.9));
select st_astext(latlong), st_x(latlong), st_y(latlong) from other_datatypes_2; -- convert blog to text representation

-- json
create table other_datatypes_3(
	description json -- adding display profile
);
insert into other_datatypes_3 (description) values 
('{
	"name": "dexter",
	"desc": "ML Engineer"
}');
select description, json_extract(description, '$.desc') from other_datatypes_3;





-- STRING DATATYPES
CREATE TABLE IF NOT EXISTS string_datatypes(
	col1 CHAR(255), -- Static - 0 to 255. Default is 1
    col2 VARCHAR(255), -- Dynamic - can be from 0 to 65535
    col3 TEXT, -- maximum length of 65,535 bytes
    col4 MEDIUMTEXT, -- maximum length of 16,777,215 characters
    col4 LONGTEXT -- maximum length of 4,294,967,295 characters
    -- The "BINARY" and "BLOB - binary large object" comes under string datatypes
);

-- NUMERIC DATATYPES
CREATE TABLE IF NOT EXISTS numeric_datatypes(
	-- Numeric Datatypes
    id INT, -- -2^31 to 2^31 - 1
    age SMALLINT, -- -2^15 to 2^15 - 1
    phone BIGINT, -- -2^63 to 2^63 - 1
    new_column TINYINT, -- 0 to 255 
    
    -- Flotting point Numbers
    height FLOAT(10), -- FLOAT(p) -> MySQL uses the p value to determine whether to use FLOAT or DOUBLE for the resulting data type. If p is from 0 to 24, the data type becomes FLOAT(). If p is from 25 to 53, the data type becomes DOUBLE()
    weight REAL,
    
    -- Formatted Numbers -> The numbers which are relatively bigger than INT
    num_1 DECIMAL(5, 3), -- The total number of digits is specified in first number and the number of digits after the decimal point is specified in the second parameter. The maximum number for size is 65. The maximum number for d is 30. The default value for size is 10.
    num_2 NUMERIC(6, 3)
);

-- Note: All the numeric data types may have an extra option: UNSIGNED or ZEROFILL. If you add the UNSIGNED option, MySQL disallows negative values for the column. If you add the ZEROFILL(depricated) option, MySQL automatically also adds the UNSIGNED attribute to the column.

-- BOOLEAN DATATYPES
CREATE TABLE IF NOT EXISTS boolean_datatypes(
	col BOOLEAN
);

-- DATETIME DATATYPES
CREATE TABLE IF NOT EXISTS datetime_datatypes(
	birth_date DATE, -- Format: YYYY-MM-DD. The supported range is from '1000-01-01' to '9999-12-31'
    birth_time TIME, -- Format: hh:mm:ss. The supported range is from '-838:59:59' to '838:59:59'
    today_time DATETIME, -- Format: YYYY-MM-DD hh:mm:ss.
    curr_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Adding DEFAULT and ON UPDATE in the column definition to get automatic initialization and updating to the current date and time
    time_col_second TIMESTAMP, -- Format: hh:mm:ss. TIMESTAMP values are stored as the number of seconds
    yr YEAR -- Format: YYYY.
);

INSERT INTO datatypes VALUES (1, 43, 123456, 1, 5.11, 50, 12.123, 123.123, 'Dexter', 'India', False, '2000-10-23', '05:34:50', '2000-10-23 05:34:50');
SELECT * FROM datatypes;