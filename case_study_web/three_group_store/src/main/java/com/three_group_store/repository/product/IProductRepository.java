package com.three_group_store.repository.product;

import com.three_group_store.model.product.Product;
import com.three_group_store.model.product.ProductType;

import java.util.List;

public interface IProductRepository {
    List<Product> getAll();
    Product searchById(int id);
    List<Product> searchByName(String searchName);
    List<Product> searchByPrice(int range);
    void add(Product product);
    boolean update(Product product);
    boolean remove(int id);
    List<Product> sortAscByPrice();
    List<Product> sortDescByPrice();
    List<ProductType> getAllType();
    List<Product> getAllPaging(int i, int recordsPerPage);
}
