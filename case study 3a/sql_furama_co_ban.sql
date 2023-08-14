-- câu 2
select * from nhan_vien where (ho_ten like 'H%' or ho_ten like 'T%' or ho_ten like 'K%') and char_length(ho_ten)<=15;

-- câu 3
SELECT * FROM khach_hang WHERE YEAR(NOW()) - YEAR(ngay_sinh) BETWEEN 18 AND 50 AND (dia_chi like '%Đà Nẵng' OR dia_chi like '%Quảng Trị');

-- câu 4
SELECT khach_hang.ma_khach_hang, khach_hang.ho_ten,
    COUNT(hop_dong.ma_hop_dong)
FROM khach_hang
JOIN hop_dong ON khach_hang.ma_khach_hang = hop_dong.ma_khach_hang
JOIN loai_khach ON khach_hang.ma_loai_khach = loai_khach.ma_loai_khach
WHERE loai_khach.ten_loai_khach = 'Diamond'
GROUP BY khach_hang.ma_khach_hang, khach_hang.ho_ten
ORDER BY COUNT(hop_dong.ma_hop_dong) ASC;

-- câu 5
SELECT khach_hang.ma_khach_hang, khach_hang.ho_ten, loai_khach.ten_loai_khach,
    hop_dong.ma_hop_dong, dich_vu.ten_dich_vu, hop_dong.ngay_lam_hop_dong, hop_dong.ngay_ket_thuc,
    dich_vu.chi_phi_thue + SUM(dich_vu_di_kem.gia * hop_dong_chi_tiet.so_luong) AS tong_tien
FROM khach_hang
LEFT JOIN loai_khach ON khach_hang.ma_loai_khach = loai_khach.ma_loai_khach
LEFT JOIN hop_dong ON khach_hang.ma_khach_hang = hop_dong.ma_khach_hang
LEFT JOIN hop_dong_chi_tiet ON hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
LEFT JOIN dich_vu_di_kem ON hop_dong_chi_tiet.ma_dich_vu_di_kem = dich_vu_di_kem.ma_dich_vu_di_kem
LEFT JOIN dich_vu ON hop_dong.ma_dich_vu = dich_vu.ma_dich_vu
GROUP BY khach_hang.ma_khach_hang, khach_hang.ho_ten, loai_khach.ten_loai_khach,
    hop_dong.ma_hop_dong, dich_vu.ten_dich_vu, hop_dong.ngay_lam_hop_dong, hop_dong.ngay_ket_thuc
ORDER BY khach_hang.ma_khach_hang, hop_dong.ma_hop_dong;

-- câu 6
SELECT dich_vu.ma_dich_vu, dich_vu.ten_dich_vu, dich_vu.dien_tich, dich_vu.chi_phi_thue, loai_dich_vu.ten_loai_dich_vu
FROM dich_vu
JOIN loai_dich_vu ON dich_vu.ma_loai_dich_vu = loai_dich_vu.ma_loai_dich_vu
WHERE dich_vu.ma_dich_vu NOT IN (
    SELECT DISTINCT dich_vu.ma_dich_vu
    FROM dich_vu
    JOIN hop_dong ON dich_vu.ma_dich_vu = hop_dong.ma_dich_vu
    WHERE YEAR(hop_dong.ngay_lam_hop_dong) = 2021 AND QUARTER(hop_dong.ngay_lam_hop_dong) = 1
)
ORDER BY dich_vu.ma_dich_vu;

-- câu 7
SELECT dich_vu.ma_dich_vu, dich_vu.ten_dich_vu, dich_vu.dien_tich, dich_vu.so_nguoi_toi_da, dich_vu.chi_phi_thue, loai_dich_vu.ten_loai_dich_vu
FROM dich_vu
JOIN loai_dich_vu ON dich_vu.ma_loai_dich_vu = loai_dich_vu.ma_loai_dich_vu
WHERE dich_vu.ma_dich_vu IN (
    SELECT DISTINCT dich_vu.ma_dich_vu
    FROM dich_vu
    JOIN hop_dong_chi_tiet ON dich_vu.ma_dich_vu = hop_dong_chi_tiet.ma_dich_vu_di_kem
    JOIN hop_dong ON hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
    WHERE YEAR(hop_dong.ngay_lam_hop_dong) = 2020
)
AND dich_vu.ma_dich_vu NOT IN (
    SELECT DISTINCT dich_vu.ma_dich_vu
    FROM dich_vu
    JOIN hop_dong_chi_tiet ON dich_vu.ma_dich_vu = hop_dong_chi_tiet.ma_dich_vu_di_kem
    JOIN hop_dong ON hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
    WHERE YEAR(hop_dong.ngay_lam_hop_dong) = 2021
)
ORDER BY dich_vu.ma_dich_vu;

-- câu 8
-- cách 1: Sử dụng GROUP BY và HAVING
SELECT khach_hang.ho_ten
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
-- cách 3: Sử dụng INNER JOIN với bảng tạm thời
CREATE TEMPORARY TABLE temp_khach_hang AS (
    SELECT ho_ten, COUNT(ma_khach_hang) AS so_lan
    FROM khach_hang
    GROUP BY ho_ten
);

SELECT th.ho_ten
FROM temp_khach_hang AS th
INNER JOIN khach_hang AS kh ON th.ho_ten = kh.ho_ten
WHERE th.so_lan = 1;

DROP TEMPORARY TABLE temp_khach_hang;

-- câu 9
SELECT
    MONTH(hop_dong.ngay_lam_hop_dong) AS thang,
    COUNT(DISTINCT hop_dong.ma_khach_hang) AS so_khach_hang
FROM hop_dong
WHERE YEAR(hop_dong.ngay_lam_hop_dong) = 2021
GROUP BY MONTH(hop_dong.ngay_lam_hop_dong)
ORDER BY thang;

-- câu 10
SELECT
    hop_dong.ma_hop_dong,
    hop_dong.ngay_lam_hop_dong,
    hop_dong.ngay_ket_thuc,
    hop_dong.tien_dat_coc,
    SUM(hop_dong_chi_tiet.so_luong) AS so_luong_dich_vu_di_kem
FROM hop_dong
JOIN hop_dong_chi_tiet ON hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
GROUP BY hop_dong.ma_hop_dong, hop_dong.ngay_lam_hop_dong, hop_dong.ngay_ket_thuc, hop_dong.tien_dat_coc
ORDER BY hop_dong.ma_hop_dong;

-- câu 11
SELECT
    hop_dong.ma_hop_dong,
    hop_dong.ngay_lam_hop_dong,
    hop_dong.ngay_ket_thuc,
    hop_dong.tien_dat_coc,
    SUM(hop_dong_chi_tiet.so_luong) AS so_luong_dich_vu_di_kem
FROM hop_dong
JOIN hop_dong_chi_tiet ON hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
GROUP BY hop_dong.ma_hop_dong, hop_dong.ngay_lam_hop_dong, hop_dong.ngay_ket_thuc, hop_dong.tien_dat_coc
ORDER BY hop_dong.ma_hop_dong;

-- câu 12
SELECT
    hop_dong.ma_hop_dong,
    nhan_vien.ho_ten AS ho_ten_nhan_vien,
    khach_hang.ho_ten AS ho_ten_khach_hang,
    khach_hang.so_dien_thoai,
    dich_vu.ten_dich_vu,
    SUM(hop_dong_chi_tiet.so_luong) AS so_luong_dich_vu_di_kem,
    hop_dong.tien_dat_coc
FROM hop_dong
JOIN nhan_vien ON hop_dong.ma_nhan_vien = nhan_vien.ma_nhan_vien
JOIN khach_hang ON hop_dong.ma_khach_hang = khach_hang.ma_khach_hang
JOIN hop_dong_chi_tiet ON hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
JOIN dich_vu_di_kem ON hop_dong_chi_tiet.ma_dich_vu_di_kem = dich_vu_di_kem.ma_dich_vu_di_kem
JOIN dich_vu ON hop_dong.ma_dich_vu = dich_vu.ma_dich_vu
WHERE (YEAR(hop_dong.ngay_lam_hop_dong) = 2020 AND MONTH(hop_dong.ngay_lam_hop_dong) >= 10)
   OR (YEAR(hop_dong.ngay_lam_hop_dong) = 2021 AND MONTH(hop_dong.ngay_lam_hop_dong) <= 6)
GROUP BY hop_dong.ma_hop_dong, nhan_vien.ho_ten, khach_hang.ho_ten, khach_hang.so_dien_thoai, dich_vu.ten_dich_vu, hop_dong.tien_dat_coc
HAVING SUM(hop_dong_chi_tiet.so_luong) IS NULL
ORDER BY hop_dong.ma_hop_dong;

-- câu 13
SELECT
    dich_vu_di_kem.ma_dich_vu_di_kem,
    dich_vu_di_kem.ten_dich_vu_di_kem,
    COUNT(hop_dong_chi_tiet.ma_hop_dong_chi_tiet) AS so_lan_su_dung
FROM dich_vu_di_kem
JOIN hop_dong_chi_tiet ON dich_vu_di_kem.ma_dich_vu_di_kem = hop_dong_chi_tiet.ma_dich_vu_di_kem
JOIN hop_dong ON hop_dong_chi_tiet.ma_hop_dong = hop_dong.ma_hop_dong
GROUP BY dich_vu_di_kem.ma_dich_vu_di_kem, dich_vu_di_kem.ten_dich_vu_di_kem
ORDER BY so_lan_su_dung DESC, dich_vu_di_kem.ma_dich_vu_di_kem;

-- câu 14

-- câu 15
SELECT
    nhan_vien.ma_nhan_vien,
    nhan_vien.ho_ten,
    trinh_do.ten_trinh_do,
    bo_phan.ten_bo_phan,
    nhan_vien.so_dien_thoai,
    nhan_vien.dia_chi
FROM nhan_vien
JOIN trinh_do ON nhan_vien.ma_trinh_do = trinh_do.ma_trinh_do
JOIN bo_phan ON nhan_vien.ma_bo_phan = bo_phan.ma_bo_phan
WHERE nhan_vien.ma_nhan_vien IN (
    SELECT ma_nhan_vien
    FROM hop_dong
    WHERE YEAR(ngay_lam_hop_dong) BETWEEN 2020 AND 2021
    GROUP BY ma_nhan_vien
    HAVING COUNT(ma_hop_dong) <= 3
);

-- câu 16 - chưa tắt tính năng safemode
DELETE FROM nhan_vien
WHERE nhan_vien.ma_nhan_vien NOT IN (
    SELECT DISTINCT ma_nhan_vien
    FROM hop_dong
    WHERE YEAR(ngay_lam_hop_dong) BETWEEN 2019 AND 2021
);

-- câu 17
-- câu 18
-- câu 19
UPDATE dich_vu_di_kem
SET gia = gia * 2
WHERE ma_dich_vu_di_kem IN (
    SELECT hdt.ma_dich_vu_di_kem
    FROM hop_dong_chi_tiet AS hdt
    JOIN hop_dong AS hd ON hdt.ma_hop_dong = hd.ma_hop_dong
    WHERE YEAR(hd.ngay_lam_hop_dong) = 2020
    GROUP BY hdt.ma_dich_vu_di_kem
    HAVING COUNT(*) > 10
);

-- câu 20
SELECT
    ma_nhan_vien AS id,
    ho_ten,
    email,
    so_dien_thoai,
    ngay_sinh,
    dia_chi
FROM nhan_vien

UNION ALL

SELECT
    ma_khach_hang AS id,
    ho_ten,
    email,
    so_dien_thoai,
    ngay_sinh,
    dia_chi
FROM khach_hang;





























