package com.three_group_store.repository.product;

import com.three_group_store.model.product.Product;
import com.three_group_store.model.product.ProductType;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductRepository implements IProductRepository {
    private static final String SELECT_ALL = " SELECT product_id, product_name, product_price, product_description, product_type_name, product_inventory,product_img_path FROM product p JOIN  product_type pt ON p.product_type_id = pt.product_type_id ";
    private static final String SELECT_BY_ID = " SELECT product_name, product_price, product_description, product_type_name, product_inventory,product_img_path FROM product p JOIN  product_type pt ON p.product_type_id = pt.product_type_id WHERE product_id = ? ";
    private static final String SELECT_BY_NAME = " SELECT * FROM product p JOIN  product_type pt ON p.product_type_id = pt.product_type_id WHERE product_name like ? ";
    private static final String CALL_INSERT_PRODUCT = " call insert_product(?,?,?,?,?,?) ";
    private static final String CALL_UPDATE_PRODUCT = " call update_product(?,?,?,?,?,?,?) ";
    private static final String DELETE_PRODUCT = " DELETE FROM product WHERE product_id = ? ";
    private static final String SORT_ASC_BY_PRICE = " SELECT p.product_id, p.product_name, p.product_price, p.product_description, pt.product_type_name, p.product_inventory,p.product_img_path FROM product p JOIN  product_type pt ON p.product_type_id = pt.product_type_id ORDER BY p.product_price asc ";
    private static final String SORT_DESC_BY_PRICE = "  SELECT p.product_id, p.product_name, p.product_price, p.product_description, pt.product_type_name, p.product_inventory,p.product_img_path FROM product p JOIN  product_type pt ON p.product_type_id = pt.product_type_id ORDER BY p.product_price desc ";
    private static final String SELECT_ALL_TYPE = " SELECT * FROM product_type ";
    private static final String CALL_SELECT_BY_PRICE = " call select_by_price(?,?) ";
    private static final String CALL_PAGING = " call paging(?,?); ";

    @Override
    public List<Product> getAll() {
        List<Product> productList = new ArrayList<>();
        Connection connection = BaseProductRepository.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL);
            ResultSet resultSet = preparedStatement.executeQuery();
            int id;
            String name;
            double price;
            String description;
            String type;
            int inventory;
            String imgPath;
            while (resultSet.next()) {
                id = resultSet.getInt("product_id");
                name = resultSet.getString("product_name");
                price = resultSet.getDouble("product_price");
                description = resultSet.getString("product_description");
                type = resultSet.getString("product_type_name");
                inventory = resultSet.getInt("product_inventory");
                imgPath = resultSet.getString("product_img_path");
                productList.add(new Product(id, name, price, description, type, inventory, imgPath));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return productList;
    }

    @Override
    public Product searchById(int id) {
        Product product = null;
        Connection connection = BaseProductRepository.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BY_ID);
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            String name;
            double price;
            String description;
            String type;
            int inventory;
            String imgPath;
            while (resultSet.next()) {
                name = resultSet.getString("product_name");
                price = resultSet.getDouble("product_price");
                description = resultSet.getString("product_description");
                type = resultSet.getString("product_type_name");
                inventory = resultSet.getInt("product_inventory");
                imgPath = resultSet.getString("product_img_path");
                product = new Product(id, name, price, description, type, inventory, imgPath);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return product;
    }

    @Override
    public List<Product> searchByName(String searchName) {
        List<Product> productList = new ArrayList<>();
        Connection connection = BaseProductRepository.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BY_NAME);
            preparedStatement.setString(1, "%" + searchName + "%");
            ResultSet resultSet = preparedStatement.executeQuery();
            int id;
            String name;
            double price;
            String description;
            String type;
            int inventory;
            String imgPath;
            while (resultSet.next()) {
                id = resultSet.getInt("product_id");
                price = resultSet.getDouble("product_price");
                name = resultSet.getString("product_name");
                description = resultSet.getString("product_description");
                type = resultSet.getString("product_type_name");
                inventory = resultSet.getInt("product_inventory");
                imgPath = resultSet.getString("product_img_path");
                productList.add(new Product(id, name, price, description, type, inventory, imgPath));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return productList;
    }

    @Override
    public List<Product> searchByPrice(int range) {
        Connection connection = BaseProductRepository.getConnection();
        List<Product> productList = new ArrayList<>();
        if (range == 0) {
            return getAll();
        } else {
            try {
                CallableStatement callableStatement = connection.prepareCall(CALL_SELECT_BY_PRICE);
                switch (range) {
                    case 1:
                        callableStatement.setDouble(1, 0);
                        callableStatement.setDouble(2, 100000);
                        break;
                    case 2:
                        callableStatement.setDouble(1, 100000);
                        callableStatement.setDouble(2, 500000);
                        break;
                    case 3:
                        callableStatement.setDouble(1, 500000);
                        callableStatement.setDouble(2, 1000000);
                        break;
                    default:
                        callableStatement.setDouble(1, 1000000);
                        callableStatement.setDouble(2, 5000000);
                        break;
                }
                ResultSet resultSet = callableStatement.executeQuery();
                int id;
                String name;
                double price;
                String description;
                String type;
                int inventory;
                String imgPath;
                while (resultSet.next()) {
                    id = resultSet.getInt("product_id");
                    price = resultSet.getDouble("product_price");
                    name = resultSet.getString("product_name");
                    description = resultSet.getString("product_description");
                    type = resultSet.getString("product_type_name");
                    inventory = resultSet.getInt("product_inventory");
                    imgPath = resultSet.getString("product_img_path");
                    productList.add(new Product(id, name, price, description, type, inventory, imgPath));
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return productList;
        }
    }

    @Override
    public void add(Product product) {
        Connection connection = BaseProductRepository.getConnection();
        try {
            CallableStatement callableStatement = connection.prepareCall(CALL_INSERT_PRODUCT);
            callableStatement.setString(1, product.getName());
            callableStatement.setDouble(2, product.getPrice());
            callableStatement.setString(3, product.getDescription());
            callableStatement.setString(4, product.getType());
            callableStatement.setInt(5, product.getInventory());
            callableStatement.setString(6, product.getImgPath());
            callableStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public boolean update(Product product) {
        boolean rowUpdate = false;
        Connection connection = BaseProductRepository.getConnection();
        try {
            CallableStatement callableStatement = connection.prepareCall(CALL_UPDATE_PRODUCT);
            callableStatement.setString(1, product.getName());
            callableStatement.setDouble(2, product.getPrice());
            callableStatement.setString(3, product.getDescription());
            callableStatement.setString(4, product.getType());
            callableStatement.setInt(5, product.getInventory());
            callableStatement.setString(6, product.getImgPath());
            callableStatement.setInt(7, product.getId());
            rowUpdate = callableStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return rowUpdate;
    }

    @Override
    public boolean remove(int id) {
        boolean rowDelete = false;
        Connection connection = BaseProductRepository.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(DELETE_PRODUCT);
            preparedStatement.setInt(1, id);
            rowDelete = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return rowDelete;
    }

    @Override
    public List<Product> sortAscByPrice() {
        List<Product> productList = new ArrayList<>();
        Connection connection = BaseProductRepository.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SORT_ASC_BY_PRICE);
            ResultSet resultSet = preparedStatement.executeQuery();
            int id;
            String name;
            double price;
            String description;
            String type;
            int inventory;
            String imgPath;
            while (resultSet.next()) {
                id = resultSet.getInt("product_id");
                name = resultSet.getString("product_name");
                price = resultSet.getDouble("product_price");
                description = resultSet.getString("product_description");
                type = resultSet.getString("product_type_name");
                inventory = resultSet.getInt("product_inventory");
                imgPath = resultSet.getString("product_img_path");
                productList.add(new Product(id, name, price, description, type, inventory, imgPath));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return productList;
    }

    @Override
    public List<Product> sortDescByPrice() {
        List<Product> productList = new ArrayList<>();
        Connection connection = BaseProductRepository.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SORT_DESC_BY_PRICE);
            ResultSet resultSet = preparedStatement.executeQuery();
            int id;
            String name;
            double price;
            String description;
            String type;
            int inventory;
            String imgPath;
            while (resultSet.next()) {
                id = resultSet.getInt("product_id");
                name = resultSet.getString("product_name");
                price = resultSet.getDouble("product_price");
                description = resultSet.getString("product_description");
                type = resultSet.getString("product_type_name");
                inventory = resultSet.getInt("product_inventory");
                imgPath = resultSet.getString("product_img_path");
                productList.add(new Product(id, name, price, description, type, inventory, imgPath));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return productList;
    }

    @Override
    public List<ProductType> getAllType() {
        Connection connection = BaseProductRepository.getConnection();
        List<ProductType> productTypeList = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_TYPE);
            int id;
            String name;
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                id = resultSet.getInt("product_type_id");
                name = resultSet.getString("product_type_name");
                productTypeList.add(new ProductType(id, name));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return productTypeList;
    }

    @Override
    public List<Product> getAllPaging(int i, int recordsPerPage) {
        List<Product> productList = new ArrayList<>();
        Connection connection = BaseProductRepository.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(CALL_PAGING);
            preparedStatement.setInt(1, i);
            preparedStatement.setInt(2, recordsPerPage);
            ResultSet resultSet = preparedStatement.executeQuery();
            int id;
            String name;
            double price;
            String description;
            String type;
            int inventory;
            String imgPath;
            while (resultSet.next()) {
                id = resultSet.getInt("product_id");
                name = resultSet.getString("product_name");
                price = resultSet.getDouble("product_price");
                description = resultSet.getString("product_description");
                type = resultSet.getString("product_type_name");
                inventory = resultSet.getInt("product_inventory");
                imgPath = resultSet.getString("product_img_path");
                productList.add(new Product(id, name, price, description, type, inventory, imgPath));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return productList;
    }
}
