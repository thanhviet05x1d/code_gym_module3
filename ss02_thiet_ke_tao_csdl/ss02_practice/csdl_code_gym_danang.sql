create database ss2;
use ss2;
create table `class`(
class_id int primary key auto_increment,
class_name varchar(20)
);
create table `room`(
room_id int primary key auto_increment,
room_name varchar(20),
class_id int
);
create table jame(
jame_account varchar(50) primary key,
jame_password varchar(50)
);
create table student(
student_id int primary key auto_increment,
student_name varchar(50),
student_birdthday date,
student_gender boolean,
student_email varchar(50),
student_point float,
class_id int,
jame_account varchar(50),
jame_password varchar(50) unique
);
create table instructor(
instructor_id int primary key auto_increment,
instructor_name varchar(50),
instructor_birdthday date,
instructor_salary double
);
create table instructor_class(
class_id int,
instructor_id int,
start_time date,
end_time date
);

-- Thêm khóa ngoại
alter table room
add constraint room_lk1 foreign key (`class_id`) references class(`class_id`);

alter table student
add constraint student_lk1 foreign key (`class_id`) references class(`class_id`),
add constraint student_lk2 foreign key (`jame_account`) references jame(`jame_account`);

alter table instructor_class
add constraint instructor_class_lk1 foreign key (`class_id`) references class(`class_id`),
add constraint instructor_class_lk2 foreign key (`instructor_id`) references instructor(`instructor_id`);

-- Thêm dữ liệu
insert into class (class_name) values ('c1121g1'), ('c1221g1'),('a0821i1'),('a0921i1');
insert into room(room_name,class_id) values ('Ken',1), ('Jame',1),('Ada',2),('Andy',2);

insert into jame(`jame_account`,`jame_password`)
 values('cunn','12345'),('chunglh','12345'),('hoanhh','12345'),('dungd','12345'),('huynhtd','12345'),
 ('hainm','12345'),('namtv','12345'),('hieuvm','12345'),('kynx','12345'),('vulm','12345'),('anv','12345'),('bnv','12345');

insert into instructor(`instructor_name`,`instructor_birdthday`,`instructor_salary`)
 values('tran van chanh','1985-02-03',100),('tran minh chien','1985-02-03',200),('vu thanh tien','1985-02-03',300),('tran van nam','1989-12-12',100);

 insert into student(`student_name`,student_birdthday, student_gender,`student_point`, class_id,`jame_account`) 
 values ('nguyen ngoc cu','1981-12-12',1,8,1,'cunn'),('le hai chung','1981-12-12',1,5,1,'chunglh'),
 ('hoang huu hoan','1990-12-12',1,6,2,'hoanhh'),('dau dung','1987-12-12',1,8,1,'dungd'),
 ('ta dinh huynh','1981-12-12',1,7,2,'huynhtd'),('nguyen minh hai','1987-12-12',1,9,1,'hainm'),
 ('tran van nam','1989-12-12',1,4,2,'namtv'),('vo minh hieu','1981-12-12',1,3,1,'hieuvm'),
 ('le xuan ky','1981-12-12',1,7,2,'kynx'),('le minh vu','1981-12-12',1,7,1,'vulm'), ('nguyen van a','1981-12-12',1,8,null,'anv'),('tran van b','1981-12-12',1,5,null,'bnv');

 insert into instructor_class(class_id,instructor_id) values (1,1),(1,2),(2,1),(2,2),(3,1),(3,2);
