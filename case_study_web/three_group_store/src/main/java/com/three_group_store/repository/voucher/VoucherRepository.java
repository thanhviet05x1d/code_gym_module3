package com.three_group_store.repository.voucher;

import com.three_group_store.model.voucher.Voucher;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VoucherRepository implements IVoucherRepository {
    private static final String SELECT_ALL_USERS = "select * from voucher;";
    private static final String INSERT_VOUCHER_SQL = "INSERT into voucher(voucher_name,voucher_rate) VALUES(?,?);";
    private static final String SELECT_VOUCHER_BY_ID ="select voucher_id, voucher_name,voucher_rate from voucher where voucher_id= ?;";
    private static final String SEARCH_BY_NAME ="SELECT * FROM voucher WHERE voucher_name LIKE ?;";
    private static final String DELETE_VOUCHER_SQL ="delete from voucher where voucher_id = ?;";
    private static final String UPDATE_VOUCHER_SQL ="update voucher set voucher_name=?,voucher_rate=? where voucher_id =?;";
    private static final String SORT_BY_INCREASING_PRICE ="SELECT * FROM voucher ORDER BY voucher_rate ASC;";
    private static final String SORT_BY_DECREASING_PRICE ="SELECT * FROM voucher ORDER BY voucher_rate DESC;";
    private static final String FIND_VOUCHER_BY_NAME ="SELECT * from voucher WHERE voucher_name = ?;";
    private static final String FIND_VOUCHER_BY_RATE = "SELECT * FROM voucher WHERE voucher_rate BETWEEN ? AND ?";
    @Override
    public List<Voucher> selectAllVoucher() {
        List<Voucher> vouchers = new ArrayList<>();
        Connection connection = BaseVoucherRepository.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_USERS);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int voucher_id = resultSet.getInt("voucher_id");
                String voucher_name = resultSet.getString("voucher_name");
                Float voucher_rate = resultSet.getFloat("voucher_rate");
                vouchers.add(new Voucher(voucher_id,voucher_name,voucher_rate));
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }return vouchers;
    }

    @Override
    public void insertVoucher(Voucher voucher) {
        Connection connection = BaseVoucherRepository.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(INSERT_VOUCHER_SQL);
            preparedStatement.setString(1,voucher.getName());
            preparedStatement.setFloat(2,voucher.getRate());
            preparedStatement.executeUpdate();
        } catch (SQLException ex) {
            printSQLException(ex);
        }
    }

    @Override
    public Voucher selectVoucher(int id) {
        Voucher voucher = null;
        Connection connection = BaseVoucherRepository.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_VOUCHER_BY_ID);
            preparedStatement.setInt(1,id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                String name =resultSet.getString("voucher_name");
                Float rate = resultSet.getFloat("voucher_rate");
                voucher = new Voucher(id,name,rate);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return voucher;
    }

    @Override
    public void deleteVoucher(int id) {
        Connection connection = BaseVoucherRepository.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(DELETE_VOUCHER_SQL);
            preparedStatement.setInt(1,id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void updateVoucher(Voucher voucher) {
        Connection connection = BaseVoucherRepository.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_VOUCHER_SQL);
            preparedStatement.setString(1,voucher.getName());
            preparedStatement.setFloat(2,voucher.getRate());
            preparedStatement.setInt(3,voucher.getId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Voucher> searchByName(String searchName) {
        Connection connection = BaseVoucherRepository.getConnection();
        List<Voucher> voucherList = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SEARCH_BY_NAME);
            preparedStatement.setString(1,"%"+searchName+"%");
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()){
                int id = resultSet.getInt("voucher_id");
                String name = resultSet.getString("voucher_name");
                Float rate =resultSet.getFloat("voucher_rate");
                voucherList.add(new Voucher(id,name,rate));
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return voucherList;
    }

    @Override
    public List<Voucher> orderByIncreaseRate() {
        Connection connection = BaseVoucherRepository.getConnection();
        List<Voucher> voucherList = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SORT_BY_INCREASING_PRICE);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()){
                int voucher_id = resultSet.getInt("voucher_id");
                String voucher_name = resultSet.getString("voucher_name");
                float voucher_rate = resultSet.getFloat("voucher_rate");
                voucherList.add(new Voucher(voucher_id,voucher_name,voucher_rate));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }return voucherList;
    }

    @Override
    public List<Voucher> orderByDecreaseRate() {
        Connection connection = BaseVoucherRepository.getConnection();
        List<Voucher> voucherList = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SORT_BY_DECREASING_PRICE);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()){
                int voucher_id = resultSet.getInt("voucher_id");
                String voucher_name = resultSet.getString("voucher_name");
                float voucher_rate = resultSet.getFloat("voucher_rate");
                voucherList.add(new Voucher(voucher_id,voucher_name,voucher_rate));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }return voucherList;
    }

    @Override
    public Voucher findVoucherByName(String name) {
        Connection connection = BaseVoucherRepository.getConnection();
        Voucher voucher = null;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(FIND_VOUCHER_BY_NAME);
            preparedStatement.setString(1,name);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()){
                voucher = new Voucher(resultSet.getInt("voucher_id"),resultSet.getString("voucher_name"),resultSet.getFloat("voucher_rate"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return voucher;
    }

    @Override
    public Voucher findVoucherByRate(float rate) {
        Connection connection = BaseVoucherRepository.getConnection();
        Voucher voucher = null;
        float rate1 = (float) (rate*0.95);
        float rate2 = (float) (rate*1.05);
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(FIND_VOUCHER_BY_RATE);
            preparedStatement.setFloat(1,rate1);
            preparedStatement.setFloat(2,rate2);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()){
                voucher = new Voucher(resultSet.getInt("voucher_id"),resultSet.getString("voucher_name"),resultSet.getFloat("voucher_rate"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return voucher;
    }

    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
