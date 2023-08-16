create database company;
use company;
create table employees (
      id int auto_increment primary key,
      name varchar(50) not null,
      department varchar(50) not null,
      salary decimal(10,2) not null
);


delimiter //
create trigger update_department
before insert on employees
for each row
begin
if new.salary >=5000 then
set new.department = 'Management';
elseif new.salary >=3000 then
set new.department = 'Sales';
else 
set new.department = 'Support';
end if ;
end //
delimiter ;

insert into employees (`name`, department, salary)
values      ('John Doe', 'A', 3500),
                    ('Jane Smith', 'A', 2000),
                    ('David Johnson', 'A', 6000);