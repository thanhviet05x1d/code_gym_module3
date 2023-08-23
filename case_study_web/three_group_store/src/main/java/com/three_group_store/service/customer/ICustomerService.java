package com.three_group_store.service.customer;

import com.three_group_store.model.customer.Customer;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface ICustomerService {
    List<Customer> selectAllCustomer() throws SQLException;
    Customer selectCustomer(int id) throws SQLException;
    boolean removeUser(int id) throws SQLException;
    Map<String, String> save(Customer customer);
    Map<String, String> updateUser(Customer customer);
    Customer selectCustomerByAccUser(String accUserName) throws SQLException;
}
