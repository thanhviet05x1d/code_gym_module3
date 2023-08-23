package com.three_group_store.service.order;

import com.three_group_store.model.product.Product;
import com.three_group_store.repository.order.CustomerOrders;

import java.util.List;
import java.util.Map;

public class OrderService implements IOrderService {
    @Override
    public List<CustomerOrders> getAll() {
        return null;
    }

    @Override
    public void add(String date, int userId, Integer voucherId, int productId, double price, int totalQuantity) {

    }

    @Override
    public int addOrder(String date, int userId, Integer voucherId) {
        return 0;
    }

    @Override
    public void addOrderDetail(Map<Product, Integer> items, int idOrder) {

    }

    @Override
    public void deleteOrder(int id) {

    }
}
