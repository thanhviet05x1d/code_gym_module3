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

/* Bước 1: Sử dụng câu lệnh Use QuanLySinhVien để sử dụng cơ sở dữ liệu: */
use quan_ly_sinh_vien;

/* Bước 2: Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.: */
select *
from `subject`
group by id
having max(credit) >= all  (select max(credit) from `subject` group by id);

/* Bước 3: Hiển thị các thông tin môn học có điểm thi lớn nhất. */
select sub.id, sub.name , max(mark)
from `subject` sub left join `mark` m on sub.id = m.sub_id
group by sub.id, sub.name, m.sub_id
having max(mark) >= all  (select max(mark) from `mark` group by id);

/* Bước 4: Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần. */

select s.*, avg(mark) as "diem_trung_binh"
from student s left join mark m on s.id = m.student_id
group by s.id
order by `diem_trung_binh` desc;
;


