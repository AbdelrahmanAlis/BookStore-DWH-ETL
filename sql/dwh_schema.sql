create database BookStore_DWH
go
use BookStore_DWH



create table Dim_Customer(

	customer_sk int identity(1,1) Primary key,
	customer_ID int ,
	full_name nvarchar(300),
	city nvarchar(50),
	state nvarchar(50),
	zip_code varchar(20)
)

go

create table Dim_Book(
	
	book_sk int identity(1,1) primary key,
	book_id int,
	title nvarchar(300),
	category_name nvarchar(200),
	price decimal(8,2)
)

go

create table Dim_Date
(
  Date_SK int primary key,
  Full_Date date not null,
  Year int,
  Quarter int ,
  Month_Number int,
  Month_Name nvarchar(50),
  Day_of_Week int,
  Day_Name nvarchar(50),
  Day_of_Month int,
  Week_of_Year int,
  Is_Weekend bit
)

create table Dim_Author(
	author_sk int identity(1,1) primary key,
    author_id int,
    author_name nvarchar(300)
)



create table Bridge_Book_Author(
	book_sk int foreign key references Dim_Book(book_sk),
    author_sk int foreign key references Dim_Author(author_sk),
    primary key (book_sk, author_sk)
)






-- Simple stored procedure to populate date dimension
CREATE PROCEDURE sp_PopulateDateDimension
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    DECLARE @CurrentDate DATE = @StartDate;
    
    WHILE @CurrentDate <= @EndDate
    BEGIN
        INSERT INTO Dim_Date (
            Date_SK,
            Full_Date,
            Year,
            Quarter,
            Month_Number,
            Month_Name,
            Day_of_Week,
            Day_Name,
            Day_of_Month,
            Week_of_Year,
            Is_Weekend
        )
        VALUES (
            CONVERT(INT, FORMAT(@CurrentDate, 'yyyyMMdd')),
            @CurrentDate,
            YEAR(@CurrentDate),
            DATEPART(QUARTER, @CurrentDate),
            MONTH(@CurrentDate),
            DATENAME(MONTH, @CurrentDate),
            DATEPART(WEEKDAY, @CurrentDate),
            DATENAME(WEEKDAY, @CurrentDate),
            DAY(@CurrentDate),
            DATEPART(WEEK, @CurrentDate),
            CASE WHEN DATEPART(WEEKDAY, @CurrentDate) IN (1, 7) THEN 1 ELSE 0 END
        );
        
        SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
    END
END;
GO


-- Populate dimensions
EXEC sp_PopulateDateDimension '2019-01-01', '2050-12-31';

-- Verify data
SELECT 'Dim_Date' AS TableName, COUNT(*) AS 'RowCount' FROM Dim_Date



go


create table Fact_Book(
	sales_sk int identity(100,1) primary key,
	date_sk int foreign key references Dim_Date(Date_sk),
	customer_sk int foreign key references Dim_Customer(customer_sk),
	book_sk int foreign key references Dim_Book(book_sk),
	order_id int,
	quantity int,
	unit_price decimal(8,2),
	total_price as (quantity * unit_price) persisted
)

---Adding Null SK
set identity_insert Dim_Customer ON;
insert into Dim_Customer
(customer_sk, customer_ID, full_name, city, state, zip_code)
VALUES
(0, 0, 'Unknown', 'Unknown', 'Unknown', 'Unknown');
set identity_insert Dim_Customer oFF;


set identity_insert Dim_Book ON;
insert into Dim_Book
(book_sk,book_id,title ,category_name,price)
VALUES
(0, 0, 'Unknown', 'Unknown', 0);
set identity_insert Dim_Book oFF;


select * from dim_customer
select * from Dim_Book
select * from Dim_Author
select * from Fact_Book