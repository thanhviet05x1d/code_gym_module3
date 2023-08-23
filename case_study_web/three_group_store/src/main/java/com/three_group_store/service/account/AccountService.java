package com.three_group_store.service.account;

import com.three_group_store.common.account.ValidateAccount;
import com.three_group_store.model.account.Account;
import com.three_group_store.model.customer.Customer;
import com.three_group_store.repository.account.AccountRepository;
import com.three_group_store.repository.account.IAccountRepository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AccountService implements IAccountService {
    private static IAccountRepository accountRepository = new AccountRepository();

    @Override
    public Account findByUserName(String userName) {
        return accountRepository.findByUserName(userName);
    }

    @Override
    public Account login(String userName, String password) {
        return accountRepository.checkAccount(userName, password);
    }

    @Override
    public boolean checkUserName(String userName) {
        Account user = accountRepository.findByUserName(userName);
        if (user != null) {
            return true;
        }
        return false;
    }

    @Override
    public boolean addUser(Account user) {
        return accountRepository.addUser(user);
    }

    @Override
    public List<Account> getAllUser() {
        List<Account> accountList = accountRepository.getAllUser();
        if (accountList.isEmpty()) {
            return null;
        }
        return accountList;
    }

    @Override
    public Customer findCustomerByUserName(String userName) {
        return accountRepository.findCustomerByUserName(userName);
    }

    @Override
    public String findTypeOfCustomer(Customer user) {
        return findTypeOfCustomer(user);
    }

    @Override
    public boolean deleteUser(String userName) {
        return accountRepository.deleteUser(userName);
    }

    @Override
    public Map<String, String> checkValidateAccount(String userName, String password, String confirmPassword) {
        return ValidateAccount.checkRegister(userName, password, confirmPassword);
    }

    @Override
    public Map<String, String> checkValidateLogin(String userName, String password) {
        return ValidateAccount.checkLogin(userName, password);
    }

    @Override
    public Map<String, String> checkValidatePassword(String oldPassword, String password, String confirmPassword) {
        return ValidateAccount.checkEditPassword(oldPassword, password, confirmPassword);
    }

    @Override
    public Map<String, String> editUser(String userName, String oldPassword, String password, String confirmPassword) {
        Account user = accountRepository.findByUserName(userName);
        Map<String, String> errEditMap = new HashMap<>();
        if (!user.getPassword().equals(oldPassword)) {
            errEditMap.put("errOldPassword", "Mật khẩu không đúng!");
        }
        if (!password.equals(confirmPassword)) {
            errEditMap.put("confirmPassword", "Mật khẩu không khớp!");
        }
        if (errEditMap.isEmpty()) {
            if (!accountRepository.editUser(userName, password)) {
                errEditMap.put("msg", "Lỗi");
            } else {
                errEditMap.put("msg", "Đã đổi mật khẩu!");
            }
        }
        return errEditMap;
    }

    @Override
    public void forgotPassword(String userName, String password) {
        accountRepository.editUser(userName, password);
    }

    @Override
    public Map<String, String> checkValidateUserName(String userName) {
        return ValidateAccount.checkValidateUserName(userName);
    }

    @Override
    public Map<String, String> checkValidateForgotPassword(String password, String confirmPassword) {
        return ValidateAccount.checkValidateForgotPassword(password,confirmPassword);
    }
}
