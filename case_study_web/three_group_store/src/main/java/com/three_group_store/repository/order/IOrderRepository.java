package com.three_group_store.repository.order;

import com.three_group_store.model.product.Product;

import java.util.List;
import java.util.Map;

public interface IOrderRepository {
    List<CustomerOrders> getAll();

    void add(String date, int userId, Integer voucherId, int productId, double price, int totalQuantity);

    int addOrder(String date, int userId, Integer voucherId);

    void addOrderDetail(Map<Product, Integer> items, int idOrder);

    void delete(int id);
}
