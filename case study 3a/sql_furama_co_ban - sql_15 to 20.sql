use furama_database;
 /* Câu 16.	Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2019 đến năm 2021.*/

 select nhan_vien.ma_nhan_vien, nhan_vien.ho_ten
 -- delete Cần bỏ tính năng safe mode --  
 from nhan_vien
 where ma_nhan_vien not in (
 select ma_nhan_vien
 from hop_dong
 where year(hop_dong.ngay_lam_hop_dong) between 2019 and 2021
 );

 /* Câu 17. Cập nhật thông tin những khách hàng có ten_loai_khach từ Platinum lên Diamond, chỉ cập nhật những khách hàng 
 đã từng đặt phòng với Tổng Tiền thanh toán trong năm 2021 là lớn hơn 10.000.000 VNĐ.*/
 
-- a. Xem thử khách hàng nào được nâng cấp
select hd.ma_khach_hang
from hop_dong hd
join dich_vu dv on hd.ma_dich_vu = dv.ma_dich_vu
join hop_dong_chi_tiet hdct on hd.ma_hop_dong = hdct.ma_hop_dong
join dich_vu_di_kem dvdk on hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
where year(hd.ngay_lam_hop_dong) = 2021
group by hd.ma_khach_hang
having sum(dv.chi_phi_thue + ifnull(hdct.so_luong * dvdk.gia, 0)) > 10000000;
    
 -- b. Tạo bảng tạm thời
create temporary table tmp_khach_hang as select * from khach_hang;
select * from tmp_khach_hang;
set sql_safe_updates = 0;
update tmp_khach_hang
set ma_loai_khach = 1
where ma_khach_hang in (
    select hd.ma_khach_hang
    from hop_dong hd
    join dich_vu dv on hd.ma_dich_vu = dv.ma_dich_vu
    join hop_dong_chi_tiet hdct on hd.ma_hop_dong = hdct.ma_hop_dong
    join dich_vu_di_kem dvdk on hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
    where year(hd.ngay_lam_hop_dong) = 2021
    group by hd.ma_khach_hang
    having sum(dv.chi_phi_thue + ifnull(hdct.so_luong * dvdk.gia, 0)) > 10000000
);
 -- c. Hiển thị bảng tạm thời sau khi đã update xem thử thế nào?
select * from tmp_khach_hang;
set sql_safe_updates = 1;

/* Câu 18.Xóa những khách hàng có hợp đồng trước năm 2021 (chú ý ràng buộc giữa các bảng). */

-- a. Hiển thị tất cả khách hàng thỏa điều kiện xem thử
select  kh.*
from khach_hang kh
join hop_dong hd on kh.ma_khach_hang = hd.ma_khach_hang
where year(hd.ngay_lam_hop_dong) < 2021;

 -- b. Tạo bảng tạm thời
 create temporary table tmp_khach_hang_xoa as select * from khach_hang;
select * from tmp_khach_hang_xoa;

set sql_safe_updates = 0;
delete kh
from tmp_khach_hang_xoa kh
where kh.ma_khach_hang in (
	select ma_khach_hang
	from hop_dong hd
	where year(hd.ngay_lam_hop_dong) < 2021 ); 

 -- c. Hiển thị bảng tạm thời sau khi đã update xem thử thế nào?
select * from tmp_khach_hang_xoa;
set sql_safe_updates = 1;

/* Câu 19. Cập nhật giá cho các dịch vụ đi kèm được sử dụng trên 10 lần trong năm 2020 lên gấp đôi */

-- a. Hiển thị tất cả dịch vụ đi kèm thỏa điều kiện xem thử
select  dvdk.* 
from dich_vu_di_kem dvdk
join hop_dong_chi_tiet hdct on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
join hop_dong hd on hdct.ma_hop_dong = hd.ma_hop_dong
where year(hd.ngay_lam_hop_dong) = 2020 
group by hdct.ma_dich_vu_di_kem
having sum(hdct.so_luong)>=10;

-- b. Tạo bảng tạm thời
create temporary table tmp_dich_vu_di_kem as select * from dich_vu_di_kem;
select * from tmp_dich_vu_di_kem;

-- c. Tăng giá lên gấp đôi
set sql_safe_updates = 0;
update tmp_dich_vu_di_kem
set gia = gia * 2
where ma_dich_vu_di_kem in (
select  dvdk.ma_dich_vu_di_kem
from dich_vu_di_kem dvdk
join hop_dong_chi_tiet hdct on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
join hop_dong hd on hdct.ma_hop_dong = hd.ma_hop_dong
where year(hd.ngay_lam_hop_dong) = 2020 
group by hdct.ma_dich_vu_di_kem
having sum(hdct.so_luong)>=10
);
select * from tmp_dich_vu_di_kem;
set sql_safe_updates = 1;

/* Câu 20. Hiển thị thông tin của tất cả các nhân viên và khách hàng có trong hệ thống, 
thông tin hiển thị bao gồm id (ma_nhan_vien, ma_khach_hang), ho_ten, email, so_dien_thoai, ngay_sinh, dia_chi */

SELECT nv.ma_nhan_vien, nv.ho_ten, nv.email, nv.so_dien_thoai, nv.ngay_sinh, nv.dia_chi
FROM nhan_vien nv
UNION ALL
SELECT '--------------', '---------------','---------------','---------------','---------------','---------------'
UNION ALL
SELECT 'ma_khach_hang', 'ho_ten', 'email', 'o_dien_thoai', 'ngay_sinh', 'dia_chi'
UNION ALL
SELECT kh.ma_khach_hang, kh.ho_ten, kh.email, kh.so_dien_thoai, kh.ngay_sinh, kh.dia_chi
FROM khach_hang kh;

