package com.three_group_store.service.account;

import com.three_group_store.model.account.Account;
import com.three_group_store.model.customer.Customer;

import java.util.List;
import java.util.Map;

public interface IAccountService {
    Account findByUserName(String userName);

    Account login(String userName, String password);

    boolean checkUserName(String userName);

    boolean addUser(Account user);

    List<Account> getAllUser();

    Customer findCustomerByUserName(String userName);

    String findTypeOfCustomer(Customer user);

    boolean deleteUser(String userName);

    Map<String, String> checkValidateAccount(String userName, String password, String confirmPassword);

    Map<String, String> checkValidateLogin(String userName, String password);

    Map<String, String> checkValidatePassword(String oldPassword, String password, String confirmPassword);

    Map<String,String> editUser(String userName,String oldPassword, String password, String confirmPassword);

    void forgotPassword(String userName, String password);

    Map<String, String> checkValidateUserName(String userName);

    Map<String, String> checkValidateForgotPassword(String password, String confirmPassword);
}
