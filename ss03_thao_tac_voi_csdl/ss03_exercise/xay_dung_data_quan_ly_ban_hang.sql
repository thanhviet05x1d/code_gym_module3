create database quan_ly_ban_hang;
use quan_ly_ban_hang;
-- tạo bảng customer --
create table `customer` (
`customer_id` int auto_increment primary key,
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
`order_date` datetime,
`order_total_price` double,
`customer_id` int,
foreign key (`customer_id`) references `customer`(`customer_id`)
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

use quan_ly_ban_hang;
insert into `customer`(`customer_id`,`customer_name`,`customer_age`)
values (1,'Minh Quan',10),(2,'Ngoc Oanh',20),(3,'Hong Ha',50);

insert into `order`(`order_id`,`customer_id`,`order_date`,`order_total_price`)
values (1,1,'2006-03-21',Null),(2,2,'2006-03-23',Null),(3,1,'2006-03-16',Null);

insert into `product`(`product_id`,`product_name`,`product_price`)
values (1,'May Giat',3),(2,'Tu Lanh',5),(3,'Dieu Hoa',7),(4,'Quat',1),(5,'Bep Dien',2);

insert into `order_detail`(`order_id`,`product_id`,`order_detail_quantity`)
values (1,1,3),(1,3,7),(1,4,2),(2,1,1),(3,1,8),(2,5,4),(2,3,3);

/* Câu 1: Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order */
select `order_id`,`order_date`,`order_total_price`
from `order`;

/* Câu 2: Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách */
select C.customer_name, P.product_name, O.order_id
from `customer` C join `order` O on C.customer_id=O.customer_id 
join `order_detail` Od on O.order_id = Od.order_id 
join `product` P on Od.product_id = P.product_id;

/* Câu 3: Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào */

select *
from `customer`
where customer_id not in (select `customer_id` from `order`);

/* Câu 4: Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn 
(giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. 
Giá bán của từng loại được tính = odQTY*pPrice). */

/* Bước 1: Không cần Group */
select O.order_id, O.order_date, Od.order_detail_quantity * P.product_price as "Gia ban"
from `order` O  join `order_detail` Od on O.order_id = Od.order_id 
join `product` P on Od.product_id = P.product_id;
-- group by O.order_id;

/* Bước 2: Group lại cho gọn gàng */
select O.order_id, O.order_date, sum(Od.order_detail_quantity * P.product_price) as "Gia ban"
from `order` O  join `order_detail` Od on O.order_id = Od.order_id 
join `product` P on Od.product_id = P.product_id
group by O.order_id;



