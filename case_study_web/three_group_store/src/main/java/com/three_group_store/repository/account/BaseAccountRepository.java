package com.three_group_store.repository.account;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class BaseAccountRepository {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/three_group_store_database";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "123456";
    public static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }
}
