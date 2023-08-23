package com.three_group_store.repository.account;

import com.three_group_store.model.account.Account;
import com.three_group_store.model.customer.Customer;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AccountRepository implements IAccountRepository {
    private Map<Integer, Account> accountMap = new HashMap<>();
    private static final String FIND_BY_USER_NAME = " call find_by_user_name(?) ";
    private static final String SELECT_ALL_ACCOUNT = " call select_all_account() ";
    private static final String INSERT_ACCOUNT = " insert into account values (?,?,?) ";
    private static final String DELETE_ACCOUNT = " call delete_account(?); ";
    private static final String DISPLAY_INFO_OF_CUSTOMER = " select * from `user` u where u.account_user_name = ? ";
    private static final String FIND_TYPE_OF_CUSTOMER = " select t_o_c.type_of_customer_name from type_of_customer t_o_c where t_o_c.type_of_customer_id = ? ";
    private static final String UPDATE_PASSWORD = " update `account` set account_password = ? where account_user_name = ? ";

    @Override
    public Account findByUserName(String userName) {
        Connection connection = BaseAccountRepository.getConnection();
        try {
            CallableStatement callableStatement = connection.prepareCall(FIND_BY_USER_NAME);
            callableStatement.setString(1, userName);
            ResultSet resultSet = callableStatement.executeQuery();
            if (resultSet.next()) {
                String name = resultSet.getString("account_user_name");
                String password = resultSet.getString("account_password");
                String role = resultSet.getString("role_name");
                return new Account(name, password, role);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public Account checkAccount(String userName, String password) {
        Account account = findByUserName(userName);
        if (account == null) {
            return null;
        }
        if (account.getPassword().equals(password)) {
            return account;
        }
        return null;
    }

    @Override
    public boolean addUser(Account user) {
        Connection connection = BaseAccountRepository.getConnection();
        boolean rowUpdate;
        try {
            PreparedStatement preparedStatement = connection.prepareCall(INSERT_ACCOUNT);
            preparedStatement.setString(1, user.getUserName());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setInt(3, 2);
            rowUpdate = preparedStatement.executeUpdate() > 0;
            preparedStatement.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return rowUpdate;
    }

    @Override
    public List<Account> getAllUser() {
        List<Account> accountList = new ArrayList<>();
        Connection connection = BaseAccountRepository.getConnection();
        try {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(SELECT_ALL_ACCOUNT);
            while (resultSet.next()) {
                String userName = resultSet.getString("account_user_name");
                String password = resultSet.getString("account_password");
                String roleName = resultSet.getString("role_name");
                accountList.add(new Account(userName, password, roleName));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return accountList;
    }

    @Override
    public Customer findCustomerByUserName(String userName) {
        Connection connection = BaseAccountRepository.getConnection();

        try {
            PreparedStatement preparedStatement = connection.prepareCall(DISPLAY_INFO_OF_CUSTOMER);
            preparedStatement.setString(1, userName);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                int id = resultSet.getInt("user_id");
                String name = resultSet.getString("user_name");
                Date dOB = Date.valueOf(resultSet.getString("user_dob"));
                boolean gender = resultSet.getBoolean("user_gender");
                String idCard = resultSet.getString("user_id_card");
                String phoneNumber = resultSet.getString("user_phone_number");
                String userMail = resultSet.getString("user_mail");
                String userAddress = resultSet.getString("user_address");
                int typeOfCustomerId = resultSet.getInt("type_of_customer_id");
                String accountUserName = resultSet.getString("account_user_name");
                return new Customer(id, name, dOB, gender, idCard, phoneNumber, userMail, userAddress, typeOfCustomerId, accountUserName);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return null;
    }

    @Override
    public String findTypeOfCustomer(Customer user) {
        Connection connection = BaseAccountRepository.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(FIND_TYPE_OF_CUSTOMER);
            preparedStatement.setInt(1, user.getTypeOfCustomerID());
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("type_of_customer_name");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public boolean deleteUser(String userName) {
        Connection connection = BaseAccountRepository.getConnection();
        boolean rowDelete;
        try {
            CallableStatement callableStatement = connection.prepareCall(DELETE_ACCOUNT);
            callableStatement.setString(1, userName);
            rowDelete = callableStatement.executeUpdate() > 0;
            System.out.println(rowDelete);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return rowDelete;
    }

    @Override
    public boolean editUser(String userName, String password) {
        Connection connection = BaseAccountRepository.getConnection();
        boolean rowEdit;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_PASSWORD);
            preparedStatement.setString(1, password);
            preparedStatement.setString(2, userName);
            rowEdit = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return rowEdit;
    }
}
