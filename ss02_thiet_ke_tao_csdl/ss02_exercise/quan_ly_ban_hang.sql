create database quan_ly_ban_hang;
use quan_ly_ban_hang;
-- tạo bảng customer --
create table `customer` (
`cutomser_id` int auto_increment primary key,
`customer_name` varchar(45) not null,
`customer_age` int
);

-- tạo bảng product --
create table `product` (
`product_id` int auto_increment primary key,
`product_name` varchar(45) not null,
`product_price` double
);

-- tạo bảng order --
create table `order` (
`order_id` int auto_increment primary key,
`order_date` int,
`order_total_price` double,
`cutomser_id` int,
foreign key (`cutomser_id`) references `customer`(`cutomser_id`)
);

-- tạo bảng order detail --
create table `order_detail` (
`order_id` int,
`product_id` int,
`order_detail_quantity` int,
primary key(`order_id`,`product_id`),
foreign key (`order_id`) references `order`(`order_id`),
foreign key (`product_id`) references `product`(`product_id`)
);