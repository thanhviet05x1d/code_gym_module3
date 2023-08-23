package com.three_group_store.service.voucher;

import com.three_group_store.model.voucher.Voucher;

import java.util.List;

public interface IVoucherService {
    List<Voucher> selectAllVoucher();
    void insertVoucher(Voucher voucher);
    Voucher selectVoucher(int id);
    void deleteVoucher(int id);
    void updateVoucher(Voucher voucher);
    List<Voucher> searchByName(String searchName);
    List<Voucher> orderByIncreaseRate();
    List<Voucher> orderByDecreaseRate();
    boolean checkVoucherByName(String name);
    boolean checkVoucherByRate(float rate);
    Voucher getByName(String voucherName);
}
