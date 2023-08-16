delimiter //
create procedure getCusById (IN cusNum int(11))
begin
select *
from customers
where customerNumber = cusNum;
end //

call getCusById(175);

delimiter //
create procedure getCustomersCountByCity(
IN in_city varchar(50),
OUT total INT
)
begin 
select count(customerNumber)
INTO total
from customers
where city = in_city;
end //
delimiter ;

call getCustomersCountByCity('Lyon', @total);
select @total;

delimiter //
create procedure setCounter(
INOUT counter int,
IN inc int
)
begin
set counter = counter+inc;
end //
delimiter ;

set @counter = 1;
call setCounter(@counter,1);
call setCounter(@counter,1);
call setCounter(@counter,5);
select @counter;

