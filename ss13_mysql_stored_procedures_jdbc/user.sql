create database user_management;
use user_management;
create table users (
      id int(3) not null auto_increment,
      name varchar(120) not null,
      email varchar(220) not null,
      country varchar(120),
      primary key (id)
);
insert into users(name, email, country) values('minh','minh@codegym.vn','viet nam');
insert into users(name, email, country) values('kante','kante@che.uk','kenia');

delimiter $$
create procedure get_user_by_id(in user_id int)
begin
   select users.name, users.email, users.country
   from users
   where users.id = user_id;
   end$$
delimiter ;
delimiter $$
create procedure insert_user(
in user_name varchar(50),
in user_email varchar(50),
in user_country varchar(50)
)
begin
   insert into users(name, email, country) values(user_name, user_email, user_country);
   end$$
delimiter ;
create table permision(
      id int(11) primary key,
      name varchar(50)
);
create table user_permision(
     permision_id int(11),
     user_id int(11)
);

insert into permision(id, name) values(1, 'add');
insert into permision(id, name) values(2, 'edit');
insert into permision(id, name) values(3, 'delete');
insert into permision(id, name) values(4, 'view');


delimiter //
create procedure get_all_users()
begin
   select * from users;
end //
delimiter ;


delimiter //

create procedure sp_update_user(in user_id int, in new_name varchar(50), in new_email varchar(100), in new_country varchar(50))
begin
    update users
    set name = new_name, email = new_email, country=new_country
    where id = user_id;
end //

delimiter ;

delimiter //

create procedure sp_delete_user(in user_id int)
begin
    delete from users where id = user_id;
end //

delimiter ;
