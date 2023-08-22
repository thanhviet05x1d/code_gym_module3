package com.three_group_store.model.product;

import java.util.Objects;

public class Product {
    private int id;
    private String name;
    private double price;
    private String description;
    private String type;
    private int inventory;
    private String imgPath;

    public Product(int id, String name, double price, String description, String type, int inventory, String imgPath) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.description = description;
        this.type = type;
        this.inventory = inventory;
        this.imgPath = imgPath;
    }

    public Product(String name, double price, String description, String type, int inventory, String imgPath) {
        this.name = name;
        this.price = price;
        this.description = description;
        this.type = type;
        this.inventory = inventory;
        this.imgPath = imgPath;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getInventory() {
        return inventory;
    }

    public void setInventory(int inventory) {
        this.inventory = inventory;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", description='" + description + '\'' +
                ", type='" + type + '\'' +
                ", inventory=" + inventory +
                ", imgPath='" + imgPath + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Product product = (Product) o;
        return id == product.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

}
