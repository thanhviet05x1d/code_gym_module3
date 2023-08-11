DROP TABLE IF EXISTS `vat_tu`;
CREATE TABLE `vat_tu` (
  `MaVTU` varchar(20) NOT NULL PRIMARY KEY,
  `TenVTU` varchar(20) NOT NULL
);

DROP TABLE IF EXISTS `phieu_xuat`;
CREATE TABLE `phieu_xuat` (
  `SoPX` varchar(20) NOT NULL PRIMARY KEY ,
  `NgayXuat` date NOT NULL
);

DROP TABLE IF EXISTS `chi_tiet_phieu_xuat`;
CREATE TABLE `chi_tiet_phieu_xuat` (
  `DGXuat` double NOT NULL,
  `SLXuat` int NOT NULL
);

DROP TABLE IF EXISTS `phieu_nhap`;
CREATE TABLE `phieu_nhap` (
  `SoPN` varchar(20) NOT NULL PRIMARY KEY,
  `NgayNhap` date NOT NULL
);

DROP TABLE IF EXISTS `chi_tiet_phieu_nhap`;
CREATE TABLE `chi_tiet_phieu_nhap` (
  `DGNhatp` double NOT NULL,
  `SLNhap` int NOT NULL
);

DROP TABLE IF EXISTS `don_dat_hang`;
CREATE TABLE `don_dat_hang` (
  `SoDH` varchar(20) NOT NULL PRIMARY KEY,
  `NgayDH` date NOT NULL
);

DROP TABLE IF EXISTS `chi_tiet_dat_hang`;
CREATE TABLE `chi_tiet_dat_hang` (
  `SoDH` int NOT NULL AUTO_INCREMENT,
  `MaVTU` varchar(20) NOT NULL,
  PRIMARY KEY (`SoDH`)
);

DROP TABLE IF EXISTS `nha_cung_cap`;
CREATE TABLE `nha_cung_cap` (
  `MaNCC` varchar(20) NOT NULL PRIMARY KEY,
  `TenNCC` varchar(20) NOT NULL,
  `DiaChi` varchar(45) NOT NULL,
  `SDT` int NOT NULL
);







