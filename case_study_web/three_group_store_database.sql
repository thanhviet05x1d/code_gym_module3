/* 1. Xây dựng Database */
create database three_group_store_database;
use three_group_store_database;

create table `product_type` (
    `product_type_id` int primary key auto_increment,
    `product_type_name` varchar(255) not null
);

create table `product` (	
    `product_id` int primary key auto_increment,
    `product_name` varchar(255) not null,
    `product_price` double not null,
    `product_description` varchar(255),
    `product_type_id` int not null,
    `product_inventory` bigint not null,
    `product_img_path` text,
    foreign key (`product_type_id`) references `product_type` (`product_type_id`)
);

create table `type_of_customer` (
	`type_of_customer_id` int auto_increment primary key,
    `type_of_customer_name` varchar(255) not null unique
    );
create table `role`(
	`role_id` int auto_increment primary key,
	`role_name` varchar(255) not null unique
	);
    
create table `account` (
	`account_user_name` varchar(255) primary key,
    `account_password` varchar(55) not null,
    `role_id` int not null,
	foreign key (`role_id`) references role (`role_id`)
    );
    
create table user (
	`user_id` int auto_increment primary key,
    `user_name` varchar(255) not null,
    `user_dob` date not null,
    `user_gender` bit(1) not null,
    `user_id_card` varchar(20) not null,
    `user_phone_number` varchar(20) not null,
    `user_mail` varchar(55) not null,
    `user_address` varchar(255) not null,
    `type_of_customer_id` int,
    `account_user_name` varchar(255) not null unique,
    foreign key (`type_of_customer_id`) references `type_of_customer`(`type_of_customer_id`),
    foreign key (`account_user_name`) references account(`account_user_name`)
    );
    
create table `voucher`(
`voucher_id` int primary key auto_increment,
`voucher_name` varchar(55) not null unique,
`voucher_rate` float not null unique
);

create table `order`(
`order_id` int primary key auto_increment,
`order_date` datetime not null,
`user_id` int not null,
`voucher_id` int unique,
foreign key (`user_id`) references user(`user_id`),
foreign key (`voucher_id`) references `voucher`(`voucher_id`)
);

create table `order_detail`(
`order_detail_id` int primary key auto_increment,
`order_id` int not null,
`product_id` int not null,
`order_detail_price` double not null,
`product_quantity` int not null,
foreign key (`order_id`) references `order`(`order_id`),
foreign key (`product_id`) references `product`(`product_id`)
);

/* 2. Viết các hàm SQL */
/* 2.1. Hàm hiển thị thông tin của User */

delimiter //
create procedure display_info_of_user(account_user_name varchar(255))
	begin
		select 	a.account_user_name,
				a.role_id,
				u.user_name,
				u.user_dob,
				u.user_gender,
				u.user_id_card,
				u.user_phone_number,
				u.user_mail,
				u.user_address,
				t_o_c.type_of_customer_name
		from `account` a
		left join `user` u on u.account_user_name = a.account_user_name
		left join `type_of_customer` toc on toc.type_of_customer_id = u.type_of_customer_id
		where a.account_user_name = account_user_name;
	end //
delimiter ;
 -- call display_info_of_user('thanhvietbkdn@gmail.com');

/* 2.2. Hàm tìm kiếm thông tin của User theo tên */
delimiter //
create procedure find_by_user_name(user_name varchar(255))
	begin
    select a.account_user_name, a.account_password, r.role_name
	from `account` a
	join `role` r on r.role_id = a.role_id
    where a.account_user_name = user_name;
	end //
delimiter ;
 -- call find_by_user_name('thanhvietbkdn@gmail.com')
 
/* 2.3. Hàm gọi tất cả tài khoản */
delimiter //
create procedure select_all_account()
	begin
    select a.account_user_name,a.account_password,r.role_name
	from account a
	join role r on r.role_id = a.role_id;
	end //
delimiter ;

/* 2.4. Hàm thêm sản phẩm mới */
delimiter //
create procedure insert_product (
	 in product_name varchar(255),
	 in product_price double,
	 in product_description varchar(255),
	 in type_name varchar(255),
	 in product_inventory bigint,
	 in product_img_path text(65535) )
begin
declare id int;
select product_type_id into id
from product_type
where product_type_name = type_name;
	if id is not null then
	insert into product (product_name, product_price, product_description, product_type_id, product_inventory, product_img_path )
	values (product_name, product_price, product_description, id, product_inventory, product_img_path );
	else
	signal sqlstate '45000' set message_text = 'product type is not found';
	end if;
end //
delimiter ;

/* 2.6. Hàm cập nhật sản phẩm */

delimiter //
create procedure update_product(
	in new_name varchar(255),
	in new_price double,
	in new_description varchar(300),
	in new_type varchar(255),
	in new_inventory bigint,
	in new_img_path varchar(255),
	in new_id int)
begin
	declare id int;
	select product_type_id into id
	from product_type
	where product_type_name = new_type;
	update product p
	join product_type pt on p.product_type_id = pt.product_type_id
	set
	p.product_name = new_name,
	p.product_price = new_price,
	p.product_description = new_description,
	p.product_type_id = id,
	p.product_inventory = new_inventory,
	product_img_path = new_img_path
	where product_id = new_id;
end //
 delimiter ;

/* 2.7. Hàm chọn sản phẩm theo mức giá */

delimiter //
create procedure select_by_price (in min double, in max double)
begin
	select product_id, product_name, product_price, product_description, product_type_name, product_inventory, product_img_path
	from product p join  product_type pt on p.product_type_id = pt.product_type_id
	where p.product_price < max and p.product_price >= min;
end //
delimiter ;

/* 2.8. Hàm phân trang số lượng sản phẩm */
delimiter //
create procedure paging(limited int , offseted int)
begin
select * from product p
left join product_type pt on pt.product_type_id = p.product_type_id
limit limited offset offseted;
end //
delimiter ;

/* 3. Thêm dữ liệu  */
/* 3.1. Thêm thể loại sản phẩm  */
insert into product_type(product_type_name)
	values ("Ghế công thái học 1"),
		   ("Ghế công thái học 2"),
		   ("Ghế công thái học 3"),
		   ("Ghế công thái học 4"),
		   ("Ghế công thái học 5"),
		   ("Ghế công thái học 6")
on duplicate key update product_type_name = values(product_type_name);

/* 3.2. Thêm sản phẩm mẫu */
call insert_product( "Ghế công thái học công nghệ 1_1",170000, "thương hiệu: Xiaomi  xuất xứ: Lào ","Ghế công thái học 1", 100, "https://i.postimg.cc/3wVgwDTZ/1-Gh-c-ng-th-i-h-c-Xiaomi-Manson-Regal-en.jpg") ;
call insert_product( "Ghế công thái học công nghệ 1_2",270000, "thương hiệu: Xiaomi  xuất xứ: Lào ","Ghế công thái học 2", 200, "https://i.postimg.cc/jSq63bcy/1-Gh-c-ng-th-i-h-c-Xiaomi-Manson-Regal-en-2.jpg") ;
call insert_product( "Ghế công thái học công nghệ 1_3",370000, "thương hiệu: Xiaomi  xuất xứ: Lào ","Ghế công thái học 3", 300, "https://i.postimg.cc/K89PdHpw/2-Sihoo-Ergonomic-M57-N103-en.jpg") ;
call insert_product( "Ghế công thái học công nghệ 1_4",470000, "thương hiệu: Xiaomi  xuất xứ: Lào ","Ghế công thái học 4", 400, "https://i.postimg.cc/TPpVGJZw/Gh-c-ng-th-i-h-c-E-DRA-EEC215-M-u-X-m-4.jpg") ;
call insert_product( "Ghế công thái học công nghệ 1_5",570000, "thương hiệu: Xiaomi  xuất xứ: Lào ","Ghế công thái học 5", 500, "https://i.postimg.cc/bJn1SNYf/Gh-C-ng-Th-i-H-c-Ergonomic-WARRIOR-WEC509-3.jpg") ;
call insert_product( "Ghế công thái học công nghệ 1_6",670000, "thương hiệu: Xiaomi  xuất xứ: Lào ","Ghế công thái học 6", 600, "https://i.postimg.cc/D0KLrkmJ/Gh-C-ng-Th-i-H-c-Sihoo-M90-B-M-u-x-m-C-K-Ch-n-4.jpg") ;

/* 3.3. Thêm thể loại khách hàng */
insert into type_of_customer(type_of_customer_id,type_of_customer_name)
values
(1,"silver"),
(2,"platinum"),
(3,"gold"),
(4,"diamond");

/* 3.4. Thêm nhóm người dùng Web */
insert into role(role_name)
values ('admin'),('user');
 
 /* 3.5. Thêm tài khoản mẫu để dùng Web */

insert into account
values 	('viet@gmail.com','12345678',1),
		('long@gmail.com','12345678',1),
        ('hau@gmail.com','12345678',1),
        ('sang@gmail.com','12345678',1),
        ('viet1@gmail.com','12345678',2),
        ('viet2@gmail.com','12345678',2),
        ('viet3@gmail.com','12345678',2),
        ('viet4@gmail.com','12345678',2);
        
/* 3.6. Thêm người dùng mẫu để dùng Web */
        
insert into `user`(`user_name`,`user_dob`,`user_gender`,`user_id_card`,`user_phone_number`,`user_mail`,`user_address`,`type_of_customer_id`,`account_user_name`) 
values('viet',"1990-12-20",1,"212723756","0987654321","viet@gmail.com","danang",2,"viet@gmail.com"),
("long","1990-12-20",1,"2044444","0987654321","long@gmail.com","hue",2,"long@gmail.com"),
("hau","1990-12-20",1,"2044444","090344444","hau@gmail.com","hue",2,"hau@gmail.com"),
("sang","1990-12-20",1,"2044444","090344444","sang@gmail.com","hue",2,"sang@gmail.com"),
("viet 1","1990-12-20",1,"2044444","090344444","viet1@gmail.com","hue",2,"viet1@gmail.com"),
("viet 2","1990-12-20",0,"2044444","090344444","viet2@gmail.com","hue",2,"viet2@gmail.com"),
("viet 3","1990-12-20",0,"2044444","090344444","viet3@gmail.com","hue",2,"viet3@gmail.com"),
("viet 4","1990-12-20",0,"2044444","090344444","viet4@gmail.com","hue",2,"viet4@gmail.com");

/* 4. Một số hàm phát sinh */
/* 4.1. Hàm xóa User */

delimiter //
create procedure sp_delete_user(in user_id int)
begin
    delete from users where id = user_id;
end //
delimiter ;

