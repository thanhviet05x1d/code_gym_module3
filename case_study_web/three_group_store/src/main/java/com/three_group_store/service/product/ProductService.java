package com.three_group_store.service.product;

import com.three_group_store.model.product.Product;
import com.three_group_store.model.product.ProductType;
import com.three_group_store.repository.product.IProductRepository;
import com.three_group_store.repository.product.ProductRepository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductService implements IProductService {
    private IProductRepository productRepository = new ProductRepository();

    @Override
    public List<Product> showList() {
        return productRepository.getAll();
    }

    @Override
    public Map<String, String> add(Product product) {
        Map<String, String> errMap = new HashMap<>();
        errMap = validateInput(product.getName(), product.getPrice(), product.getDescription(), product.getInventory(), product.getImgPath());
        if (errMap.isEmpty()) {
            productRepository.add(product);
        }
        return errMap;
    }

    @Override
    public Map<String, String> save(Product product) {
        Map<String, String> errMap = new HashMap<>();
        errMap = validateInput(product.getName(), product.getPrice(), product.getDescription(), product.getInventory(), product.getImgPath());
        if (errMap.isEmpty()) {
            productRepository.update(product);
        }
        return errMap;
    }

    @Override
    public void remove(int id) {
        productRepository.remove(id);
    }

    @Override
    public List<Product> sortAscByPrice() {
        return productRepository.sortAscByPrice();
    }

    @Override
    public List<Product> sortDescByPrice() {
        return productRepository.sortDescByPrice();
    }

    @Override
    public Product searchById(int id) {
        return productRepository.searchById(id);
    }

    @Override
    public List<Product> searchByName(String searchName) {
        return productRepository.searchByName(searchName);
    }

    @Override
    public List<Product> searchByPrice(int range) {
        return productRepository.searchByPrice(range);
    }

    @Override
    public List<ProductType> showTypeList() {
        return productRepository.getAllType();
    }

    @Override
    public List<Product> getAllPaging(int i, int recordsPerPage) {
        List<Product> productList = productRepository.getAllPaging(i, recordsPerPage);
        if (productList.size() == 0) {
            return null;
        } else return productList;
    }

    public Map<String, String> validateInput(String name, double price, String description, int inventory, String imgPath) {
        Map<String, String> errMap = new HashMap<>();
        if (name.trim().equals("") || name == null) {
            errMap.put("errName", "Tên không được để trống");
        } else if (name.length() > 255) {
            errMap.put("errName", "Tên không dài quá 255 ký tự");
        }
        if (imgPath.length() > 65535) {
            errMap.put("errImg", "Đường dẫn dài quá 65535 ký tự");
        }
        if (price == 0) {
            errMap.put("errPrice", "Giá không được để trống");
        }
        if (description.trim().equals("") || description == null) {
            errMap.put("errDes", "Mô tả không được để trống");
        } else if (description.length()>255) {
            errMap.put("errDes", "Mô tả không được dài quá 255 ký tự");
        }
        if (inventory == 0) {
            errMap.put("errInven", "Số lượng không được để trống");
        }
        return errMap;
    }
}
