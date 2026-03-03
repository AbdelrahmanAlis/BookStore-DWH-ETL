use BookStore_EG

create view Vbook
as
	select distinct b.BookID,b.Title,c.CategoryDescription,b.Price
	from Book b left join Category c 
	on b.CategoryID = c.CategoryID

create view vcustomer
as
	select CustomerID, CONCAT(ISNULL(FirstName, ''), ' ' ,ISNULL(LastName, '')) as full_name, City, ZipCode, State
	from Customer

create view Vorder
as
	select o.OrderID, o.BookID, bo.CustomerID, bo.OrderDate, o.Price, o.Quantity
	from Ordering o left join Book_Order bo
	on o.OrderID = bo.OrderID

create view Vauthor
as
	select AuthorID, AuthorName
	from Author
