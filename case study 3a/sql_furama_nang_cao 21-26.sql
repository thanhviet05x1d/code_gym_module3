use furama_database;
/* Câu 21. Tạo khung nhìn có tên là v_nhan_vien để lấy được thông tin của tất cả các nhân viên có địa chỉ là “Hải Châu”
 và đã từng lập hợp đồng cho một hoặc nhiều khách hàng bất kì với ngày lập hợp đồng là “12/12/2019”. */
 -- a. Tạo một bảng copy
drop table if exists nhan_vien_copy;
create table nhan_vien_copy as select * from nhan_vien;
select * from nhan_vien_copy;

 -- b. Tạo một view từ bảng copy thỏa điều kiện
create or replace view v_nhan_vien as
select nv.*
from nhan_vien_copy nv
join hop_dong on hop_dong.ma_nhan_vien = nv.ma_nhan_vien
where nv.dia_chi like '%Gia Lai' and hop_dong.ngay_lam_hop_dong = '2020-12-08';
    

/* Câu 22. Thông qua khung nhìn v_nhan_vien thực hiện cập nhật địa chỉ thành “Liên Chiểu” đối với tất cả các nhân viên 
được nhìn thấy bởi khung nhìn này. */

update v_nhan_vien
set dia_chi = replace(dia_chi,'Gia Lai','Liên Chiểu');

/* Câu 23. Tạo Stored Procedure sp_xoa_khach_hang dùng để xóa thông tin của một khách hàng nào đó với
 ma_khach_hang được truyền vào như là 1 tham số của sp_xoa_khach_hang. */

 -- a. Tạo một bảng khach_hang copy
drop table if exists khach_hang_copy;
create table khach_hang_copy as select * from khach_hang;
select * from khach_hang_copy;

 -- b. Viết SP
delimiter //
create procedure sp_xoa_khach_hang(in ma_khach_hang_del int)
begin
delete from khach_hang_copy kh where kh.ma_khach_hang = ma_khach_hang_del;
end //
delimiter ;
call sp_xoa_khach_hang(5);

/* Câu 24. Tạo Stored Procedure sp_them_moi_hop_dong dùng để thêm mới vào bảng 
hop_dong với yêu cầu sp_them_moi_hop_dong phải thực hiện kiểm tra tính hợp lệ của dữ liệu bổ sung, 
với nguyên tắc không được trùng khóa chính và đảm bảo toàn vẹn tham chiếu đến các bảng liên quan. */
 
delimiter //
create procedure sp_them_moi_hop_dong(
new_ma_hop_dong int,
new_ngay_lam_hop_dong date,
new_ngay_ket_thuc date,
new_tien_dat_coc double,
new_ma_nhan_vien int,	
new_ma_khach_hang int,
new_ma_dich_vu int,
new_ma_hop_dong_chi_tiet int,
new_so_luong int,
new_ma_dich_vu_di_kem int
)
begin
    declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
start transaction;

	-- Kiểm tra tính hợp lệ của mã hợp đồng
    if exists (select 1 from hop_dong where hop_dong.ma_hop_dong = new_ma_hop_dong) then
        signal sqlstate '45000' set message_text = 'Mã hợp đồng đã tồn tại';
    end if;
    
	-- Kiểm tra tính hợp lệ của ngày tháng hợp đồng
    if new_ngay_lam_hop_dong > new_ngay_ket_thuc then
        signal sqlstate '45000' set message_text = 'Ngày kết thúc phải sau ngày làm hợp đồng';
    end if;
    
	-- Viết hàm nhập liệu
	insert into hop_dong (ma_hop_dong, ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc, ma_nhan_vien, ma_khach_hang, ma_dich_vu)
    values (new_ma_hop_dong, new_ngay_lam_hop_dong, new_ngay_ket_thuc, new_tien_dat_coc, new_ma_nhan_vien, new_ma_khach_hang, new_ma_dich_vu);
    
    -- Lấy mã hợp đồng vừa thêm
    set @ma_hop_dong = new_ma_hop_dong;
    
    -- Kiểm tra tính hợp lệ của dữ liệu bổ sung trong hop_dong_chi_tiet
    if new_so_luong < 1 then
        signal sqlstate '45000' set message_text = 'số lượng phải lớn hơn 0';
    end if;
	
    -- Thêm chi tiết hợp đồng vào bảng hop_dong_chi_tiet
    insert into hop_dong_chi_tiet (ma_hop_dong_chi_tiet, so_luong, ma_hop_dong, ma_dich_vu_di_kem)
    values (new_ma_hop_dong_chi_tiet, new_so_luong, @ma_hop_dong, new_ma_dich_vu_di_kem);
    commit;
end //

delimiter ;
call sp_them_moi_hop_dong(14,  '2023-08-10', '2023-08-15', 5000000, 2, 3, 4,12,20,1);

/* Câu 25. Tạo Trigger có tên tr_xoa_hop_dong khi xóa bản ghi trong bảng hop_dong thì hiển thị tổng số lượng
 bản ghi còn lại có trong bảng hop_dong ra giao diện console của database.
Lưu ý: Đối với MySQL thì sử dụng SIGNAL hoặc ghi log thay cho việc ghi ở console.
 */

delimiter //
create trigger tr_xoa_hop_dong
after delete on hop_dong
for each row
begin
    declare remaining_records int;
    select count(*) into remaining_records from hop_dong;
        -- ghi log thông tin số lượng bản ghi còn lại vào bảng log_hop_dong
    insert into log_hop_dong (thoi_gian, so_luong_ban_ghi) values (now(), remaining_records);
        -- có thể sử dụng signal thay vì ghi log, bạn có thể thêm dòng sau
    -- signal sqlstate '45000' set message_text = concat('số lượng bản ghi còn lại: ', remaining_records);
end //
delimiter ;
drop trigger tr_xoa_hop_dong;


/* Câu 26. Tạo Trigger có tên tr_cap_nhat_hop_dong khi cập nhật ngày kết thúc hợp đồng, cần kiểm tra xem thời gian 
cập nhật có phù hợp hay không, với quy tắc sau: Ngày kết thúc hợp đồng phải lớn hơn ngày làm hợp đồng ít nhất là 2 ngày. 
Nếu dữ liệu hợp lệ thì cho phép cập nhật, nếu dữ liệu không hợp lệ thì in ra thông báo “Ngày kết thúc hợp đồng phải lớn hơn ngày làm hợp đồng ít nhất là 2 ngày” trên console của database.
Lưu ý: Đối với MySQL thì sử dụng SIGNAL hoặc ghi log thay cho việc ghi ở console.
 */
 
delimiter //
create trigger tr_cap_nhat_hop_dong
before update on hop_dong
for each row
begin
    if new.ngay_ket_thuc <= new.ngay_lam_hop_dong + 2 then
        signal sqlstate '45000'
        set message_text = 'Ngày kết thúc hợp đồng phải lớn hơn ngày làm hợp đồng ít nhất là 2 ngày';
    end if;
end //
delimiter ;
