package com.example.user_management_sp.repository.database;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Base {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/user_management";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "123456";

    public static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
        return connection;
    }
}
