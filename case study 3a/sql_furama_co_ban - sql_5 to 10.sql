use furama_database;
/* Câu 6. Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu của tất cả các
loại dịch vụ chưa từng được khách hàng thực hiện đặt từ quý 1 của năm 2021 (Quý 1 là tháng 1, 2, 3).
*/

select dv.ma_dich_vu, dv.ten_dich_vu, ldv.ten_loai_dich_vu, dv.dien_tich, dv.chi_phi_thue
from dich_vu dv
join hop_dong hd on dv.ma_dich_vu = hd.ma_dich_vu
join loai_dich_vu ldv on dv.ma_loai_dich_vu=ldv.ma_loai_dich_vu
where hd.ngay_lam_hop_dong >= '2021-04-01'
group by dv.ma_dich_vu;

/* Câu 7.Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue, 
ten_loai_dich_vu của tất cả các loại dịch vụ đã từng được khách hàng đặt phòng trong năm 2020 
nhưng chưa từng được khách hàng đặt phòng trong năm 2021.
*/
-- cách 1: Sử dụng IN và NOT IN
SELECT dv.ma_dich_vu, dv.ten_dich_vu, dv.dien_tich, dv.so_nguoi_toi_da, dv.chi_phi_thue, ldv.ten_loai_dich_vu
FROM dich_vu dv
JOIN loai_dich_vu ldv ON dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
WHERE dv.ma_dich_vu IN (
    SELECT dv1.ma_dich_vu
    FROM dich_vu dv1
    JOIN hop_dong hd1 ON dv1.ma_dich_vu = hd1.ma_dich_vu
    WHERE YEAR(hd1.ngay_lam_hop_dong) = 2020
)
AND dv.ma_dich_vu NOT IN (
    SELECT dv2.ma_dich_vu
    FROM dich_vu dv2
    JOIN hop_dong hd2 ON dv2.ma_dich_vu = hd2.ma_dich_vu
    WHERE YEAR(hd2.ngay_lam_hop_dong) = 2021
);

-- cách 2: Sử dụng EXISTS và NOT EXISTS
SELECT dv.ma_dich_vu, dv.ten_dich_vu, dv.dien_tich, dv.so_nguoi_toi_da, dv.chi_phi_thue, ldv.ten_loai_dich_vu
FROM dich_vu dv
JOIN loai_dich_vu ldv ON dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
WHERE EXISTS (
    SELECT true
    FROM hop_dong hd1
    WHERE dv.ma_dich_vu = hd1.ma_dich_vu and YEAR(hd1.ngay_lam_hop_dong) = 2020
)
AND  NOT EXISTS(
    SELECT true
    FROM hop_dong hd2
  WHERE dv.ma_dich_vu = hd2.ma_dich_vu and YEAR(hd2.ngay_lam_hop_dong) = 2021
);

 /* Câu 8.Hiển thị thông tin ho_ten khách hàng có trong hệ thống, với yêu cầu ho_ten không trùng nhau.
Học viên sử dụng theo 3 cách khác nhau để thực hiện yêu cầu trên.
*/
 
 -- cách 1: Sử dụng GROUP BY và HAVING
SELECT khach_hang.ho_ten, count(khach_hang.ma_khach_hang)
FROM khach_hang
GROUP BY khach_hang.ho_ten
HAVING COUNT(khach_hang.ma_khach_hang) = 1;

-- cách 2: Sử dụng NOT EXISTS
SELECT DISTINCT khach_hang.ho_ten
FROM khach_hang
WHERE NOT EXISTS (
    SELECT 1
    FROM khach_hang AS kh
    WHERE kh.ho_ten = khach_hang.ho_ten AND kh.ma_khach_hang != khach_hang.ma_khach_hang
);

 /* Câu 9. Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng 
 trong năm 2021 thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.
*/

select month(hd.ngay_lam_hop_dong) as `thang`, count(hd.ma_khach_hang) as `so_khach_hang`
from khach_hang kh
join hop_dong hd on kh.ma_khach_hang = hd.ma_khach_hang
where year(hd.ngay_lam_hop_dong) = 2021
group by thang
order by thang;

 /* Câu 10. Hiển thị thông tin tương ứng với từng hợp đồng thì đã sử dụng bao nhiêu dịch vụ đi kèm. 
 Kết quả hiển thị bao gồm ma_hop_dong, ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc, so_luong_dich_vu_di_kem 
 (được tính dựa trên việc sum so_luong ở dich_vu_di_kem).
*/

select hd.ma_hop_dong, hd.ngay_lam_hop_dong, hd.ngay_ket_thuc, hd.tien_dat_coc, sum(hdc.so_luong) as 'so_luong_dich_vu_di_kem'
from hop_dong hd
join hop_dong_chi_tiet hdc on hd.ma_hop_dong = hdc.ma_hop_dong
join dich_vu_di_kem dvd on hdc.ma_hop_dong_chi_tiet = dvd.ma_dich_vu_di_kem
group by hd.ma_hop_dong;
