use quan_ly_sinh_vien;
/* Câu 1 - Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’ */
select *
from student
where substring_index(name," ",-1) like 'h%';

/* Câu 2 - Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12. */
select * 
from class
where month(start_date)=12;

/* Câu 3 - Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5 */

select *
from subject
where  credit between 3 and 5;

/* Câu 4 - Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2. */
set sql_safe_updates = 0;
update student
set student.class_id = 2
where student.name ='Hung';
set sql_safe_updates = 1;

/* Câu 5 - Hiển thị các thông tin: StudentName, SubName, Mark. 
Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.. */

select S.id , S.name, Sub.name, M.mark
from student S join mark M on S.id = M.id join subject Sub on M.sub_id = Sub.id 
order by M.mark DESC, S.name ASC;
