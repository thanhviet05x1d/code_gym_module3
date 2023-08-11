create database furama_database;
use furama_database;
CREATE TABLE IF NOT EXISTS vi_tri (
    ma_vi_tri INT PRIMARY KEY,
    ten_vi_tri VARCHAR(45) NOT NULL
);

    
CREATE TABLE IF NOT EXISTS trinh_do (
    ma_trinh_do INT PRIMARY KEY,
    ten_trinh_do VARCHAR(45) NOT NULL
);

    
    CREATE TABLE IF NOT EXISTS bo_phan (
    ma_bo_phan INT PRIMARY KEY,
    ten_bo_phan VARCHAR(45) NOT NULL
);


CREATE TABLE IF NOT EXISTS nhan_vien (
    ma_nhan_vien INT PRIMARY KEY,
    ho_ten VARCHAR(45) NOT NULL,
    ngay_sinh DATE NOT NULL,
    so_cmnd VARCHAR(45) NOT NULL,
    luong DOUBLE NOT NULL,
    so_dien_thoai VARCHAR(15) NOT NULL,
    email VARCHAR(45) NOT NULL,
    dia_chi VARCHAR(45) NOT NULL,
    ma_vi_tri INT NOT NULL,
    ma_trinh_do INT NOT NULL,
    ma_bo_phan INT NOT NULL
);

CREATE TABLE IF NOT EXISTS loai_khach (
    ma_loai_khach INT PRIMARY KEY,
    ten_loai_khach VARCHAR(50) NOT NULL
);

    
    CREATE TABLE IF NOT EXISTS khach_hang (
    ma_khach_hang INT PRIMARY KEY,
    ho_ten VARCHAR(45) NOT NULL,
    ngay_sinh DATE NOT NULL,
    gioi_tinh TINYINT NOT NULL,
    so_cmnd VARCHAR(15) NOT NULL,
    so_dien_thoai VARCHAR(15) NOT NULL,
    email VARCHAR(50) NOT NULL,
    dia_chi VARCHAR(50) NOT NULL,
    ma_loai_khach INT NOT NULL
);

    
CREATE TABLE IF NOT EXISTS kieu_thue (
    ma_kieu_thue INT PRIMARY KEY,
    ten_kieu_thue VARCHAR(50) NOT NULL
);

    
    CREATE TABLE IF NOT EXISTS loai_dich_vu (
    ma_loai_dich_vu INT PRIMARY KEY,
    ten_loai_dich_vu VARCHAR(50) NOT NULL
);

    
    CREATE TABLE IF NOT EXISTS dich_vu (
    ma_dich_vu INT PRIMARY KEY,
    ten_dich_vu VARCHAR(50) NOT NULL,
    dien_tich INT NOT NULL,
    chi_phi_thue DOUBLE NOT NULL,
    so_nguoi_toi_da INT NOT NULL,
    tieu_chuan_phong VARCHAR(50) NOT NULL,
    mo_ta_tien_nghi_khac VARCHAR(45),
    dien_tich_ho_boi DOUBLE,
    so_tang INT,
    ma_kieu_thue INT NOT NULL,
    ma_loai_dich_vu INT NOT NULL
);


CREATE TABLE IF NOT EXISTS dich_vu_di_kem (
    ma_dich_vu_di_kem INT PRIMARY KEY,
    ten_dich_vu_di_kem VARCHAR(50) NOT NULL,
    gia double NOT NULL,
    don_vi VARCHAR(20) NOT NULL,
    trang_thai VARCHAR(50) NOT NULL
);


CREATE TABLE IF NOT EXISTS hop_dong (
    ma_hop_dong INT PRIMARY KEY,
    ngay_lam_hop_dong DATE NOT NULL,
    ngay_ket_thuc DATE NOT NULL,
    tien_dat_coc INT NOT NULL,
    ma_nhan_vien INT NOT NULL,
    ma_khach_hang INT NOT NULL,
    ma_dich_vu INT NOT NULL
);

    
    CREATE TABLE IF NOT EXISTS hop_dong_chi_tiet (
    ma_hop_dong_chi_tiet INT PRIMARY KEY,
    so_luong INT NOT NULL,
    ma_hop_dong INT NOT NULL,
    ma_dich_vu_di_kem INT NOT NULL
);

-- task2 2023-08-11 ---
-- khi can xoa: ALTER TABLE nhan_vien DROP FOREIGN KEY lk1;

alter table nhan_vien
add constraint nhan_vien_lk1 foreign key (`ma_vi_tri`) references vi_tri(`ma_vi_tri`),
add constraint nhan_vien_lk2 foreign key (`ma_trinh_do`) references trinh_do(`ma_trinh_do`),
add constraint nhan_vien_lk3 foreign key (`ma_bo_phan`) references bo_phan(`ma_bo_phan`);

alter table khach_hang
add constraint khach_hang_lk1 foreign key (`ma_loai_khach`) references loai_khach(`ma_loai_khach`);

alter table hop_dong
add constraint hop_dong_lk1 foreign key (`ma_khach_hang`) references khach_hang(`ma_khach_hang`),
add constraint hop_dong_lk2 foreign key (`ma_nhan_vien`) references nhan_vien(`ma_nhan_vien`),
add constraint hop_dong_lk3 foreign key (`ma_dich_vu`) references dich_vu(`ma_dich_vu`);

alter table hop_dong_chi_tiet
add constraint hop_dong_chi_tiet_lk1 foreign key (`ma_hop_dong`) references hop_dong(`ma_hop_dong`),
add constraint hop_dong_chi_tiet_lk2 foreign key (`ma_dich_vu_di_kem`) references dich_vu_di_kem(`ma_dich_vu_di_kem`);

alter table dich_vu
add constraint dich_vu_lk1 foreign key (`ma_kieu_thue`) references kieu_thue(`ma_kieu_thue`),
add constraint dich_vu_lk2 foreign key (`ma_loai_dich_vu`) references loai_dich_vu(`ma_loai_dich_vu`);
