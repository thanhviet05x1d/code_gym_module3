-- câu 21
CREATE VIEW v_nhan_vien AS
SELECT
    nv.ma_nhan_vien,
    nv.ho_ten,
    nv.email,
    nv.so_dien_thoai,
    nv.ngay_sinh,
    nv.dia_chi
FROM nhan_vien AS nv
JOIN hop_dong AS hd ON nv.ma_nhan_vien = hd.ma_nhan_vien
JOIN khach_hang AS kh ON hd.ma_khach_hang = kh.ma_khach_hang
WHERE nv.dia_chi = 'Hải Châu'
    AND DATE(hd.ngay_lam_hop_dong) = '2019-12-12';

-- câu 22
UPDATE v_nhan_vien
SET dia_chi = 'Liên Chiểu';

-- câu 23
DELIMITER //

CREATE PROCEDURE sp_xoa_khach_hang(IN p_ma_khach_hang INT)
BEGIN
    DELETE FROM khach_hang WHERE ma_khach_hang = p_ma_khach_hang;
END //

DELIMITER ;
CALL sp_xoa_khach_hang(123); -- Thay 123 bằng mã khách hàng cần xóa

-- câu 24
DELIMITER //

CREATE PROCEDURE sp_them_moi_hop_dong(
    IN p_ma_khach_hang INT,
    IN p_ngay_lam_hop_dong DATE,
    IN p_ngay_ket_thuc DATE,
    IN p_tong_tien DECIMAL(10, 2),
    IN p_ma_dich_vu_di_kem INT,
    IN p_so_luong INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Kiểm tra tính hợp lệ của dữ liệu bổ sung
    IF p_ngay_lam_hop_dong > p_ngay_ket_thuc THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ngày kết thúc phải sau ngày làm hợp đồng';
    END IF;

    -- Thêm hợp đồng vào bảng hop_dong
    INSERT INTO hop_dong (ma_khach_hang, ngay_lam_hop_dong, ngay_ket_thuc, tong_tien)
    VALUES (p_ma_khach_hang, p_ngay_lam_hop_dong, p_ngay_ket_thuc, p_tong_tien);

    -- Lấy mã hợp đồng vừa thêm
    SET @ma_hop_dong = LAST_INSERT_ID();

    -- Kiểm tra tính hợp lệ của dữ liệu bổ sung trong hop_dong_chi_tiet
    IF p_so_luong < 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Số lượng phải lớn hơn 0';
    END IF;

    -- Thêm chi tiết hợp đồng vào bảng hop_dong_chi_tiet
    INSERT INTO hop_dong_chi_tiet (ma_hop_dong, ma_dich_vu_di_kem, so_luong)
    VALUES (@ma_hop_dong, p_ma_dich_vu_di_kem, p_so_luong);

    COMMIT;
END //

DELIMITER ;
CALL sp_them_moi_hop_dong(1, '2023-08-10', '2023-08-15', 5000000, 2, 3);

-- câu 25
DELIMITER //

CREATE TRIGGER tr_xoa_hop_dong
AFTER DELETE ON hop_dong
FOR EACH ROW
BEGIN
    DECLARE remaining_records INT;
    SELECT COUNT(*) INTO remaining_records FROM hop_dong;
    
    -- Ghi log thông tin số lượng bản ghi còn lại vào bảng log_hop_dong
    INSERT INTO log_hop_dong (thoi_gian, so_luong_ban_ghi) VALUES (NOW(), remaining_records);
    
    -- Nếu muốn sử dụng SIGNAL thay vì ghi log, bạn có thể thêm dòng sau
    -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = CONCAT('Số lượng bản ghi còn lại: ', remaining_records);
END //

DELIMITER ;

-- câu 26
DELIMITER //

CREATE TRIGGER tr_cap_nhat_hop_dong
BEFORE UPDATE ON hop_dong
FOR EACH ROW
BEGIN
    IF NEW.ngay_ket_thuc <= NEW.ngay_lam_hop_dong + INTERVAL 2 DAY THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ngày kết thúc hợp đồng phải lớn hơn ngày làm hợp đồng ít nhất là 2 ngày';
    END IF;
END //

DELIMITER ;

-- câu 27
DELIMITER //

CREATE FUNCTION func_dem_dich_vu() RETURNS INT
BEGIN
    DECLARE count INT;
    SELECT COUNT(*) INTO count
    FROM hop_dong AS hd
    JOIN hop_dong_chi_tiet AS hdt ON hd.ma_hop_dong = hdt.ma_hop_dong
    JOIN dich_vu_di_kem AS dvdk ON hdt.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
    WHERE hd.tong_tien > 2000000;
    RETURN count;
END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION func_tinh_thoi_gian_hop_dong(ma_khach_hang INT) RETURNS INT
BEGIN
    DECLARE max_duration INT;
    SELECT MAX(DATEDIFF(hd.ngay_ket_thuc, hd.ngay_lam_hop_dong)) INTO max_duration
    FROM hop_dong AS hd
    JOIN hop_dong_chi_tiet AS hdt ON hd.ma_hop_dong = hdt.ma_hop_dong
    WHERE hd.ma_khach_hang = ma_khach_hang;
    RETURN max_duration;
END //

DELIMITER ;

SELECT func_tinh_thoi_gian_hop_dong(ma_khach_hang);

-- câu 28
DELIMITER //

CREATE PROCEDURE sp_xoa_dich_vu_va_hd_room()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE ma_dich_vu INT;
    
    DECLARE cur CURSOR FOR
    SELECT ma_dich_vu
    FROM dich_vu
    WHERE loai_dich_vu = 'Room' AND YEAR(ngay_tao) BETWEEN 2015 AND 2019;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO ma_dich_vu;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Xóa các bản ghi liên quan trong bảng hop_dong_chi_tiet
        DELETE FROM hop_dong_chi_tiet WHERE ma_dich_vu_di_kem = ma_dich_vu;
        
        -- Xóa các bản ghi liên quan trong bảng hop_dong
        DELETE FROM hop_dong WHERE ma_hop_dong IN (
            SELECT hdct.ma_hop_dong
            FROM hop_dong_chi_tiet AS hdct
            JOIN dich_vu_di_kem AS dvdk ON hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
            WHERE dvdk.ma_dich_vu = ma_dich_vu
        );
        
        -- Xóa các bản ghi liên quan trong bảng dich_vu_di_kem
        DELETE FROM dich_vu_di_kem WHERE ma_dich_vu_di_kem = ma_dich_vu;
        
        -- Xóa bản ghi trong bảng dich_vu
        DELETE FROM dich_vu WHERE ma_dich_vu = ma_dich_vu;
    END LOOP;
    
    CLOSE cur;
    
END //

DELIMITER ;

CALL sp_xoa_dich_vu_va_hd_room();
