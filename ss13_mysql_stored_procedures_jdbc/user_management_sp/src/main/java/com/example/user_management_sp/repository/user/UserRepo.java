package com.example.user_management_sp.repository.user;


import com.example.user_management_sp.model.User;
import com.example.user_management_sp.repository.database.Base;
import com.mysql.cj.jdbc.CallableStatement;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserRepo implements IUserRepo {
    private static final String INSERT = "insert into users(name, email, country) values(?,?,?);";
    private static final String SELECT_ALL = "select * from users";
    private static final String SELECT_BY_ID = "select * from users where id = ?";
    private static final String SELECT_BY_COUNTRY = "select * from users where country = ?";
    private static final String DELETE = "delete from users where id = ?";
    private static final String UPDATE = "update users set name = ?" +
            ",email=?" +
            ",country=?" +
            " where id = ?;";
    private static final String SORT = "select * from users order by name";
    private static final String GET_BY_ID_SP = "{call get_user_by_id(?)}";


    private static final String INSERT_SP = "{call insert_user(?,?,?)}";
    private static final String SELECT_ALL_SP = "call get_all_users()";
    private static final String UPDATE_SP = "call sp_update_user(?,?,?,?)";
    private static final String DELETE_SP = "call sp_delete_user(?)";



    @Override
    public List<User> findAll() {
        Connection connection = Base.getConnection();
        List<User> userList = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String email = resultSet.getString("email");
                String country = resultSet.getString("country");

                userList.add(new User(id, name, email, country));
            }
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return userList;
    }

    @Override
    public void createUser(User user) {
        Connection connection = Base.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(INSERT);
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getCountry());

            preparedStatement.executeUpdate();
            connection.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public User findId(int id) {
        Connection connection = Base.getConnection();
        User user = null;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BY_ID);
            preparedStatement.setInt(1, id);

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                String name = resultSet.getString("name");
                String email = resultSet.getString("email");
                String country = resultSet.getString("country");
                user = new User(name, email, country);
            }
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return user;
    }

    @Override
    public void updateUser(int id, User user) {
        Connection connection = Base.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(UPDATE);
            preparedStatement.setInt(1, id);
            preparedStatement.setString(2, user.getName());
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setString(4, user.getCountry());

            preparedStatement.executeUpdate();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void deleteUser(int id) {
        Connection connection = Base.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(DELETE);
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public User search(String country) {
        Connection connection = Base.getConnection();
        User user = null;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BY_COUNTRY);
            preparedStatement.setString(1, country);

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                String name = resultSet.getString("name");
                String email = resultSet.getString("email");
                String country1 = resultSet.getString("country");
                user = new User(name, email, country1);

            }
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return user;
    }

    @Override
    public List<User> sort() {
        Connection connection = Base.getConnection();
        List<User> userList = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SORT);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                String name = resultSet.getString("name");
                String email = resultSet.getString("email");
                String country = resultSet.getString("country");

                userList.add(new User(name, email, country));
            }
            connection.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return userList;
    }

    @Override
    public User getUserById(int id) {
        Connection connection = Base.getConnection();
        User user = null;
        try {
            CallableStatement callableStatement = (CallableStatement) connection.prepareCall(GET_BY_ID_SP);
            callableStatement.setInt(1, id);

            ResultSet resultSet = callableStatement.executeQuery();
            while (resultSet.next()) {
                String name = resultSet.getString("name");
                String email = resultSet.getString("email");
                String country = resultSet.getString("country");
                user = new User(id, name, email, country);
            }
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return user;
    }

    @Override
    public void insertUserStore(User user) {
        Connection connection = Base.getConnection();
        try {
            CallableStatement callableStatement = (CallableStatement) connection.prepareCall(INSERT_SP);
            callableStatement.setString(1, user.getName());
            callableStatement.setString(2, user.getEmail());
            callableStatement.setString(3, user.getCountry());

            callableStatement.executeUpdate();

            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<User> displaySP() {
        Connection connection = Base.getConnection();
        List<User> userList = new ArrayList<>();
        try {
            CallableStatement callableStatement = (CallableStatement) connection.prepareCall(SELECT_ALL_SP);
            ResultSet resultSet = callableStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String email = resultSet.getString("email");
                String country = resultSet.getString("country");

                userList.add(new User(id, name, email, country));
            }
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return userList;
    }

    @Override
    public void deleteUserSP(int id) {
        Connection connection = Base.getConnection();
        try {
            CallableStatement callableStatement = (CallableStatement) connection.prepareCall(DELETE_SP);
            callableStatement.setInt(1, id);
            callableStatement.executeUpdate();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void updateUserSP(int id, User user) {
        Connection connection = Base.getConnection();
        try {
            CallableStatement callableStatement = (CallableStatement) connection.prepareCall(UPDATE_SP);
            callableStatement.setInt(1, id);
            callableStatement.setString(2, user.getName());
            callableStatement.setString(3, user.getEmail());
            callableStatement.setString(4, user.getCountry());


            callableStatement.executeUpdate();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
