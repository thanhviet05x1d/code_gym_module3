package com.three_group_store.repository.customer;

import com.three_group_store.model.customer.Customer;

import java.sql.SQLException;
import java.util.List;

public interface ICustomerRepository {
    List<Customer> selectAllUser() throws SQLException;
    void insertUser(Customer customer);
    boolean updateUser(Customer customer) throws SQLException;
    Customer selectCustomer(int id) throws SQLException;
    boolean removeUser(int id) throws SQLException;
    Customer selectCustomerByAccUser(String accUserName) throws SQLException;
}
