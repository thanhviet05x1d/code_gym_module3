create database mo_hinh_quan_he;
use mo_hinh_quan_he;
-- drop table if exists `vat_tu`;
create table `vat_tu` (
  `ma_vat_tu` varchar(20) primary key,
  `ten_vat_tu` varchar(20) not null
);

-- drop table if exists `phieu_xuat`;
create table `phieu_xuat` (
  `so_phieu_xuat` varchar(20) primary key ,
  `ngay_xuat` date not null
);

-- drop table if exists `chi_tiet_phieu_xuat`;
create table `chi_tiet_phieu_xuat` (
  `so_phieu_xuat` varchar(20),
  `ma_vat_tu` varchar(20) ,
  `don_gia_xuat` double not null,
  `so_luong_xuat` int not null,
primary key(so_phieu_xuat, ma_vat_tu),
foreign key(so_phieu_xuat) references phieu_xuat(so_phieu_xuat),
foreign key(ma_vat_tu) references vat_tu(ma_vat_tu)
);

-- drop table if exists `phieu_nhap`;
create table `phieu_nhap` (
  `so_phieu_nhap` varchar(20) primary key,
  `ngay_nhap` date not null
);

-- drop table if exists `chi_tiet_phieu_nhap`;
create table `chi_tiet_phieu_nhap` (
  `don_gia_nhap` double not null,
  `so_luong_nhap` int not null,
  `so_phieu_nhap` varchar(20),
  `ma_vat_tu` varchar(20),
primary key (so_phieu_nhap, ma_vat_tu),
foreign key(so_phieu_nhap) references phieu_nhap(so_phieu_nhap),
foreign key(ma_vat_tu) references vat_tu(ma_vat_tu)
);

-- drop table if exists `nha_cung_cap`;
create table `nha_cung_cap` (
  `ma_nha_cung_cap` varchar(20) primary key,
  `ten_nha_cung_cap` varchar(20) not null,
  `dia_chi` varchar(45) not null,
  `so_dien_thoai` varchar(20) not null
);

-- drop table if exists `don_dat_hang`;
create table `don_dat_hang` (
    `so_don_hang` varchar(20) primary key,
    `ngay_dat_hang` date not null,
	`ma_nha_cung_cap` varchar(20),
	foreign key(ma_nha_cung_cap) references nha_cung_cap(ma_nha_cung_cap)
);

-- drop table if exists `chi_tiet_don_dat_hang`;
create table `chi_tiet_don_dat_hang` (
  `so_don_hang` varchar(20),
  `ma_vat_tu` varchar(20),
  primary key(so_don_hang, ma_vat_tu),
  foreign key(so_don_hang) references don_dat_hang(so_don_hang),
  foreign key(ma_vat_tu) references vat_tu(ma_vat_tu)
);

