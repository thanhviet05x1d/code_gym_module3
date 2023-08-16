DELIMITER //
create procedure findAllCustomers()
begin
select * from customers;
end //
delimiter //
call findAllCustomers();

DELIMITER //

DROP PROCEDURE IF EXISTS `findAllCustomers`//

CREATE PROCEDURE findAllCustomers()

BEGIN

SELECT * FROM customers where customerNumber = 175;

END //
