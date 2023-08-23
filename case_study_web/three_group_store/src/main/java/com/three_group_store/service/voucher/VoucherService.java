package com.three_group_store.service.voucher;

import com.three_group_store.model.voucher.Voucher;
import com.three_group_store.repository.voucher.IVoucherRepository;
import com.three_group_store.repository.voucher.VoucherRepository;

import java.util.List;

public class VoucherService implements IVoucherService {
    private static IVoucherRepository voucherRepository = new VoucherRepository();

    @Override
    public List<Voucher> selectAllVoucher() {
        return voucherRepository.selectAllVoucher();
    }

    @Override
    public void insertVoucher(Voucher voucher) {
        voucherRepository.insertVoucher(voucher);
    }

    @Override
    public Voucher selectVoucher(int id) {
        return voucherRepository.selectVoucher(id);
    }

    @Override
    public void deleteVoucher(int id) {
        voucherRepository.deleteVoucher(id);
    }

    @Override
    public void updateVoucher(Voucher voucher) {
        voucherRepository.updateVoucher(voucher);
    }

    @Override
    public List<Voucher> searchByName(String searchName) {
        return voucherRepository.searchByName(searchName);
    }

    @Override
    public List<Voucher> orderByIncreaseRate() {
        return voucherRepository.orderByIncreaseRate();
    }

    @Override
    public List<Voucher> orderByDecreaseRate() {
        return orderByDecreaseRate();
    }

    @Override
    public boolean checkVoucherByName(String name) {
        Voucher voucher = voucherRepository.findVoucherByName(name);
        if (voucher == null) {
            return true;
        } else {
            return false;
        }
    }

    @Override
    public boolean checkVoucherByRate(float rate) {
        Voucher voucher = voucherRepository.findVoucherByRate(rate);
        if (voucher == null) {
            return true;
        } else {
            return false;
        }
    }

    @Override
    public Voucher getByName(String voucherName) {
        return voucherRepository.findVoucherByName(voucherName);
    }
}
