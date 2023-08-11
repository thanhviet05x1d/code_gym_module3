select * from nhan_vien where (ho_ten like 'H%' or ho_ten like 'T%' or ho_ten like 'K%') and char_length(ho_ten)<=15;

SELECT * FROM khach_hang WHERE YEAR(NOW()) - YEAR(ngay_sinh) BETWEEN 18 AND 50 AND (dia_chi like '%Đà Nẵng' OR dia_chi like '%Quảng Trị');

select * from khach_hang where ma_loai_khach like 'Diamond';
