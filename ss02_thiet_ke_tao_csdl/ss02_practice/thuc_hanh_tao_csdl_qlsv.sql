create database quan_ly_sinh_vien;
use quan_ly_sinh_vien;
create table class(
`id` int not null auto_increment primary key,
`name` varchar(60) not null,
`start_date` datetime not null,
`status` bit
);
create table student(
`id` int not null auto_increment primary key,
`name` varchar(30) not null,
`adrees` varchar(50),
`phone` varchar(20),
`status` bit,
`class_id` int not null,
foreign key (`class_id`) references class(`id`)
);
create table `subject`(
`id` int not null auto_increment primary key,
`name` varchar(30) not null,
`credit` tinyint not null default 1 check(credit>=1),
`status` bit default 1
);
create table `mark`(
`id` int not null auto_increment primary key,
`sub_id` int not null,
`student_id` int not null,
`mark` float default 0 check (`mark` between 0 and 100 ),
`exam_time` tinyint default 1,
unique (`sub_id`, `student_id`),
foreign key (`sub_id`) references subject (`id`),
foreign key (`student_id`) references student (`id`)
);