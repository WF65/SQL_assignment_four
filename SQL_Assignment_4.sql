-- part 1

--1
/*
View is a kind of virtual tables, A view also has rows and columns as they are in a real 
table in the database. And a view can be created by selecting fields from one or more tabes
present in the database. A view can either have all the rows of a table or specific rows based
on certain condition.

The benefits are that:
(1) retricting data access
views provide an additional level of table secutrity by restricting access to a 
predetermined set of rows and columns of a table
(2) Hiding data complexity
a view can hide the complexity taht exists in a multiple table join
(3)simplify commands for the user
views allow the user to select information from multiple tables without requiring the user
to actually know how to perform a join
(4)store complex queries
views can be used to store complex queries
(5)rename columns
views can also be used to rename the columns without affecting the base tables provided the
number of columns in view must match the number of columns specified in select statement.
Thus, renaming helps to hide the names of the columns of the base tables
(6)muliple view facility
different views can be created on the same table for different users
*/

--2
/*
Yes, usng transact sql 
*/

--3
/*
Stored procedure is a batch of statements grouped as a logical unit and stored dataset.
It accepts the parameters and executes the T-sql statment in the procedure.

(1)It can be easily modified.We can easily modify the code inside the stored procedure 
without the need to restart or deploying the application. 
(2)Reduced network traffic:  When we use stored procedures instead of writing T-SQL queries at 
the application level, only the procedure name is passed over the network instead of the 
whole T-SQL code.
(3)Reusable: Stored procedures can be executed by multiple users or multiple client applications
without the need of writing the code again.
(4)Security: Stored procedures reduce the threat by eliminating direct access to the tables. 
we can also encrypt the stored procedures while creating them so that source code inside 
the stored procedure is not visible.
(5)Performance: The SQL Server stored procedure when executed for the first time creates a plan 
and stores it in the buffer pool so that the plan can be reused when it executes next time.
*/

--4
/*
Stored procedure:
accepts parameter
can not be used as building block in a larger query
can contain serveral statements, loop, if else, etc
can not be used as the target of insert, update, delete statement

view:
does not accept parameter
can be used as building block in a larger query
can contain only one select statment
can be used as the target of insert, update, delete
*/

--5
/*
- The function must return a value but in Stored Procedure it is optional. Even a procedure can 
return zero or n values.
- Functions can have only input parameters for it whereas Procedures can have input or output parameters.
- Functions can be called from Procedure whereas Procedures cannot be called from a Function.
- The procedure allows SELECT as well as DML(INSERT/UPDATE/DELETE) statement in it whereas Function allows 
only SELECT statement in it.
- Procedures cannot be utilized in a SELECT statement whereas Function can be embedded in a SELECT statement.
- Stored Procedures cannot be used in the SQL statements anywhere in the WHERE/HAVING/SELECT section whereas
Function can be.
- Functions that return tables can be treated as another rowset. This can be used in JOINs with other tables.
- Inline Function can be though of as views that take parameters and can be used in JOINs and other Rowset operations.
- An exception can be handled by try-catch block in a Procedure whereas try-catch block cannot be used in a Function.
- We can use Transactions in Procedure whereas we can't use Transactions in Function.
*/

--6
/*
Yes
You can call an existing stored procedure using the CallableStatement. The prepareCall() method of the Connection 
interface accepts the procedure call in string format and returns a callable statement 
object.
CallableStatement cstmt = con.prepareCall("{call sampleProcedure()}");
Execute the above created callable statement using the executeQuery() method this returns a
result set object.
ResultSet rs1 = cstmt.executeQuery();
If this procedure returns more result-set objects move to the next result-set using the 
cstmt.getMoreResults() method.
And then, retrieve the next result-set using the getResultSet() method of the 
CallableStatement interface.
ResultSet rs2 = cstmt.getResultSet();
*/

--7
/*
No.
stored procedure cannot return a value
*/

--8
/*
A trigger is a special type of stored procedure that automatically runs when an event 
occurs in the database server.
it includes DML, DDL, and Logon trigger.
*/

--9
/*
DML triggers run when a user tries to modify data through a data manipulation language (DML)
event. DML events are INSERT, UPDATE, or DELETE statements on a table or view. These 
triggers fire when any valid event fires, whether table rows are affected or not.
DDL triggers run in response to a variety of data definition language (DDL) events. 
These events primarily correspond to Transact-SQL CREATE, ALTER, and DROP statements,
and certain system stored procedures that perform DDL-like operations.
Logon triggers fire in response to the LOGON event that's raised when a user's session
is being established. You can create triggers directly from Transact-SQL statements or 
from methods of assemblies that are created in the Microsoft .NET Framework common 
language runtime (CLR) and uploaded to an instance of SQL Server. SQL Server lets you
create multiple triggers for any specific statement.
*/

--10
/*
Triggers cannot be manually executed by the user.
There is no chance for triggers to receive parameters.
You cannot commit or rollback a transaction inside a trigger.
*/

--part 2
--1
-- do not know how to lock and unlock table
insert into Region values (5, 'Middle Earth')
insert into Territories values (87654, 'Gondor', 5)
insert into Employees values (10, 'King', 'Aragorn', 'Sales Representative',
'Mr.', '1960-05-29 00:00:00.000', '1994-01-02 00:00:00.000', 'Edgeham Hollow
Winchester Way', 'Melad', 'Middle Earth', '12345', 'Middle Earth', '(206) 555-1189',
'2344', null, 'description', 2, null)
insert into EmployeeTerritories values (10, 5)


--2
update Territories set TerritoryDescription = 'Arnor' where TerritoryID = 87654

--3
delete from Employees where Region = 'Middle Earth'
delete from EmployeeTerritories where TerritoryID = 5
delete from Territories where RegionID = 5
delete from Region where RegionID = 5

--4
create view view_product_order_fang as
select p.ProductID, p.ProductName, p.UnitsOnOrder
from Products p

--5
create procedure sp_product_order_quantity_fang @productid int
as
select d.ProductID, count(d.OrderID)
from [Order Details] d
where d.ProductID = @productid
group by d.ProductID

execute sp_product_order_quantity_fang @productid = 10250

--6
create procedure sp_product_order_city_fang @ProductName nvarchar(20)
as
select top 5 o.ShipCity, sum(d.Quantity)
from Orders o inner join [Order Details] d
on o.OrderID = d.OrderID
inner join Products p
on d.ProductID = p.ProductID
where p.ProductName = @ProductName
group by o.ShipCity

execute sp_product_order_city_fang @ProductName = 'NuNuCa Nuß-Nougat-Creme'

--7
--need to take the lesson about stored procedure and function
create procedure sp_move_employees_fang
as
select e.EmployeeID
from Employees e inner join EmployeeTerritories t
on e.EmployeeID = t.EmployeeID
inner join Territories te
on t.TerritoryID = te.TerritoryID
where te.TerritoryDescription = 'Tory'

--8
--need to take the lesson about trigger

--9
create table city_fang (Id int, City varchar(20))
create table people_fang (Id int, pname varchar(20), CityId int)
insert into city_fang values (1, 'Seattle')
insert into city_fang values (2, 'Green Bay')
insert into people_fang values (1, 'Aaron Rodgers', 2)
insert into people_fang values (2, 'Russell Wilson', 1)
insert into people_fang values (3, 'Jody Nelson', 2)

insert into city_fang values (3, 'Madison')
update people_fang set CityId = 3
where CityId = 1
delete from city_fang where City = 'Seattle'


create view Packers_fang
as
select p.Id, p.pname, p.CityId
from people_fang p
where CityId = 3

drop view Packers_fang
drop table people_fang
drop table city_fang

--10
create procedure sp_birthday_employees_fang
as
create table birthday_employees_fang (id int, ename varchar(20), birthdaydate datetime)
insert into birthday_employees_fang values (1, 'Kate', '1990-04-28')
insert into birthday_employees_fang values (2, 'Karen', '1992-02-28')
insert into birthday_employees_fang values (3, 'Smith', '1991-05-28')
insert into birthday_employees_fang values (4, 'Jake', '1990-04-02')
drop table birthday_employees_fang

--11
create procedure sp_fang_1
as
select City
from (
select customerID, City from Customers where 
customerid not in
(select CustomerID from Orders group by CustomerID having count(OrderID) > 1)
)dt
group by City
having Count(CustomerID) >=2

--not sure how to do it without subquery
create procedure sp_fang_2
as
select distinct c.City, c.CustomerID
from Customers c

except

select c.City, c.CustomerID
from customers c inner join Orders o
on c.CustomerID = o.CustomerID
group by c.CustomerID
having count(o.OrderID) > 1



--12
/*
using except clause
SELECT * FROM table1
EXCEPT
SELECT * FROM table2

SELECT * FROM table2
EXCEPT
SELECT * FROM table1
*/

--14
select t.FirstName + t.LastName as "Full Name"
from testtable 
where t.MiddleName is null

union

select t.FirstName + t.LastName + t.MiddleName + '.' 
from testtable 
where t.MiddleName is not null

--15
select top 1 marks
from testtable
where sex = 'F'
order by marks

--16
select student, marks, sex
from testtable
order by sex, marks
