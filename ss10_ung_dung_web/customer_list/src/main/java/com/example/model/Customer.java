package com.example.model;

public class Customer {
    private String name;
    private String birthdate;
    private String address;

    public Customer(String name, String birthdate, String address) {
        this.name = name;
        this.birthdate = birthdate;
        this.address = address;
    }

    public String getName() {
        return name;
    }

    public String getBirthdate() {
        return birthdate;
    }

    public String getAddress() {
        return address;
    }
}
