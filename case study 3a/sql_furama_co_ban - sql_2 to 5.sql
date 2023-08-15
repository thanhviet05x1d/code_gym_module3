use furama_database;
/* câu 2 (Cách 1 - lấy theo họ) */

select * from nhan_vien where (ho_ten like 'H%' or ho_ten like 'T%' or ho_ten like 'K%') and char_length(ho_ten)<=15;

/* Câu 2 (Cách 2 - lấy theo tên) */
select * from nhan_vien 
where (substring_index(ho_ten," ", -1) like 'H%' or
substring_index(ho_ten," ", -1) like 'T%' or
substring_index(ho_ten," ", -1) like 'K%') and
char_length(ho_ten) <=15;


/* Câu 3. Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”  */
SELECT * FROM khach_hang WHERE timestampdiff(year, khachhang.ngay_sinh,now()) BETWEEN 18 AND 50 AND (dia_chi like '%Đà Nẵng' OR dia_chi like '%Quảng Trị');

/* Câu 4. Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. 
Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng. 
Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.
*/
SELECT khach_hang.ma_khach_hang, khach_hang.ho_ten,
    COUNT(*)
FROM khach_hang
JOIN hop_dong ON khach_hang.ma_khach_hang = hop_dong.ma_khach_hang
JOIN loai_khach ON khach_hang.ma_loai_khach = loai_khach.ma_loai_khach
WHERE loai_khach.ten_loai_khach = 'Diamond'
GROUP BY khach_hang.ma_khach_hang
ORDER BY COUNT(*) ASC;

/* Câu 5. Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc, tong_tien
(Với tổng tiền được tính theo công thức như sau: Chi Phí Thuê + Số Lượng * Giá, với Số Lượng và 
Giá là từ bảng dich_vu_di_kem, hop_dong_chi_tiet) cho tất cả các khách hàng đã từng đặt phòng. 
(những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra)..

Chú ý chế độ `sql_mode=only_full_group_by` trong MySQL đang hoạt động, trong MySQL, khi sử dụng `GROUP BY`, 
tất cả các cột trong mệnh đề `SELECT` ngoại trừ các hàm tổng hợp (như SUM, COUNT, AVG, MAX, MIN) 
phải xuất hiện trong mệnh đề `GROUP BY`.
*/

SELECT khach_hang.ma_khach_hang, khach_hang.ho_ten, loai_khach.ten_loai_khach,
    hop_dong.ma_hop_dong, dich_vu.ten_dich_vu, hop_dong.ngay_lam_hop_dong, hop_dong.ngay_ket_thuc, 
    ifnull(dich_vu.chi_phi_thue + SUM(IFNULL(hop_dong_chi_tiet.so_luong * dich_vu_di_kem.gia,0)),0) AS tong_tien
FROM khach_hang
LEFT JOIN loai_khach ON khach_hang.ma_loai_khach = loai_khach.ma_loai_khach
LEFT JOIN hop_dong ON khach_hang.ma_khach_hang = hop_dong.ma_khach_hang
LEFT JOIN hop_dong_chi_tiet ON hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
LEFT JOIN dich_vu_di_kem ON hop_dong_chi_tiet.ma_dich_vu_di_kem = dich_vu_di_kem.ma_dich_vu_di_kem
LEFT JOIN dich_vu ON hop_dong.ma_dich_vu = dich_vu.ma_dich_vu
GROUP BY khach_hang.ma_khach_hang, khach_hang.ho_ten, loai_khach.ten_loai_khach,
    hop_dong.ma_hop_dong, dich_vu.ten_dich_vu, hop_dong.ngay_lam_hop_dong, hop_dong.ngay_ket_thuc
ORDER BY khach_hang.ma_khach_hang;
