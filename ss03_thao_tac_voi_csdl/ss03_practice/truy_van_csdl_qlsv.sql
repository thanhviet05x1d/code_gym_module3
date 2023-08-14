create database quan_ly_sinh_vien;
use quan_ly_sinh_vien;
create table `class`(
`id` int not null auto_increment primary key,
`name` varchar(60) not null,
`start_date` datetime not null,
`status` bit
);
create table `student`(
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

insert into class (`name`,`start_date`,`status`)
values('A1','2008-12-20',1),('A2','2008-12-20',1),('B3',current_date,0);

insert into student (`name`,`adrees`,`phone`,`status`,`class_id`)
values('Hung', 'Ha Noi', '0912113113', 1, 1),('Hoa', 'Hai Phong',null, 1, 1),('Manh', 'HCM', '0123123123', 0, 2);

insert into `subject` (`id`,`name`,`credit`,`status`)
values (1, 'CF', 5, 1), (2, 'C', 6, 1), (3, 'HDJ', 5, 1), (4, 'RDBMS', 10, 1);

insert into `mark` (`sub_id`, `student_id`, `mark`, `exam_time`)
values (1, 1, 8, 1), (1, 2, 10, 2), (2, 1, 12, 1);

use quan_ly_sinh_vien;
select *
from student;

select *
from student
where status = true;

select *
from subject
where credit <10;

/* Câu 5 - cách 1 */
select student.id, student.name , class.name
from student , class
where student.class_id = class.id and class.name ="A1"; 

/* Câu 5 - cách 2 */
select s.id, s.name, c.name
from student s join class c 
on s.class_id = c.id
where c.name = 'A1' ;

/* Câu 6 - Hiển thị điểm môn CF của các học viên */
select S.id , S.name, Sub.name, M.mark
from student S join mark M on S.id = M.id join subject Sub on M.sub_id = Sub.id 
where Sub.name = 'CF';  
