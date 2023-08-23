package com.three_group_store.repository.order;

import com.three_group_store.model.product.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class OrderRepository implements IOrderRepository {
    private static final String SELECT_ALL_CUSTOMER_ORDER = " call getCustomerOrder(); ";
    private static final String ADD_ORDER = " call add_order_and_return_id(?, ?, ?, @new_id); ";
    private static final String SELECT_NEW_ORDER = " select @new_id; ";
    private static final String ADD_ORDER_DETAIL = " insert into order_detail (order_id,product_id,order_detail_price,product_quantity)\n" +
            "    value (?,?,?,?); ";
    private static final String DELETE_ORDER = " call delete_order(?); ";

    @Override
    public List<CustomerOrders> getAll() {
        List<CustomerOrders> customerOrdersList = new ArrayList<>();
        Connection connection = BaseOrderRepository.getConnection();
        try {
            CallableStatement callableStatement = connection.prepareCall(SELECT_ALL_CUSTOMER_ORDER);
            ResultSet resultSet = callableStatement.executeQuery();
            int id;
            String productName;
            double price;
            int quantity;
            Date date;
            float voucherPercent;
            String userName;
            String phoneNumber;
            String address;
            while (resultSet.next()) {
                id = resultSet.getInt("order_id");
                productName = resultSet.getString("product_name");
                price = resultSet.getDouble("order_detail_price");
                quantity = resultSet.getInt("product_quantity");
                date = resultSet.getDate("order_date");
                voucherPercent = resultSet.getFloat("voucher_rate");
                userName = resultSet.getString("user_name");
                phoneNumber = resultSet.getString("user_phone_number");
                address = resultSet.getString("user_address");
                customerOrdersList.add(new CustomerOrders(id, productName, price, quantity, date, voucherPercent, userName, phoneNumber, address));
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
        return customerOrdersList;
    }

    @Override
    public void add(String date, int userId, Integer voucherId, int productId, double price, int totalQuantity) {

    }

    @Override
    public int addOrder(String date, int userId, Integer voucherId) {
        Connection connection = BaseOrderRepository.getConnection();
        try {
            CallableStatement callableStatement = connection.prepareCall("call add_order_and_return_id(?, ?, ?, ?)");
            callableStatement.setDate(1, Date.valueOf(date));
            callableStatement.setInt(2, userId);
            if (voucherId == null) {
                callableStatement.setNull(3, Types.INTEGER);
            } else {
                callableStatement.setInt(3, voucherId);
            }
            callableStatement.registerOutParameter(4, Types.INTEGER);
            callableStatement.executeUpdate();

            int newId = callableStatement.getInt(4);
            return newId;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    @Override
    public void addOrderDetail(Map<Product, Integer> items, int idOrder) {
        Connection connection = BaseOrderRepository.getConnection();
        try {
            for (Product key : items.keySet()) {
                PreparedStatement preparedStatement = connection.prepareStatement(ADD_ORDER_DETAIL);
                preparedStatement.setInt(1, idOrder);
                preparedStatement.setInt(2, key.getId());
                preparedStatement.setDouble(3, key.getPrice());
                preparedStatement.setInt(4, items.get(key));
                preparedStatement.executeUpdate();
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
    }

    @Override
    public void delete(int id) {
        Connection connection = BaseOrderRepository.getConnection();
        try {
            CallableStatement callableStatement = connection.prepareCall(DELETE_ORDER);
            callableStatement.setInt(1, id);
            callableStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }
}

