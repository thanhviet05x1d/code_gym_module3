create database mo_hinh_quan_he;
use mo_hinh_quan_he;

create table nha_cung_cap(
ma int primary key auto_increment,
ten varchar(45),
dia_chi varchar(45),
so_dien_thoai int
);

create table vat_tu(
ma int primary key auto_increment,
ten varchar(45)
);

create table don_hang(
so int primary key auto_increment,
ngay_dat_hang date,
ma_vat_tu int,
ma_nha_cung_cap int
);

create table phieu_xuat(
so int primary key auto_increment,
ngay_xuat date
);

create table chi_tiet_phieu_xuat(
so_phieu_xuat int,
ma_vat_tu int,
don_gia_xuat double,
so_luong_xuat int,
primary key (so_phieu_xuat,ma_vat_tu)
);

create table phieu_nhap(
so int primary key auto_increment,
ngay_nhap date
);

create table chi_tiet_phieu_nhap(
so_phieu_nhap int,
ma_vat_tu int,
don_gia_nhap double,
so_luong_nhap int,
primary key (so_phieu_nhap,ma_vat_tu)
);

create table chi_tiet_don_hang(
so_don_hang int,
ma_vat_tu int,
primary key (so_don_hang,ma_vat_tu)
);

/* tạo các khóa */

alter table don_hang
add constraint don_dat_hang_lk1 foreign key (ma_nha_cung_cap) references nha_cung_cap(ma);

alter table chi_tiet_don_hang
add constraint chi_tiet_don_hang_lk1 foreign key (so_don_hang) references don_hang(so),
add constraint chi_tiet_don_hang_lk2 foreign key (ma_vat_tu) references vat_tu(ma);

alter table chi_tiet_phieu_xuat
add constraint chi_tiet_phieu_xuat_lk1 foreign key (so_phieu_xuat) references phieu_xuat(so),
add constraint chi_tiet_phieu_xuat_lk2 foreign key (ma_vat_tu) references vat_tu(ma);

alter table chi_tiet_phieu_nhap
add constraint chi_tiet_phieu_nhap_lk1 foreign key (so_phieu_nhap) references phieu_nhap(so),
add constraint chi_tiet_phieu_nhap_lk2 foreign key (ma_vat_tu) references vat_tu(ma);
