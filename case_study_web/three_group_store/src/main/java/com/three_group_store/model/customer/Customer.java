package com.three_group_store.model.customer;

import java.sql.Date;
import java.util.Objects;

public class Customer {
    private int id;
    private String name;
    private Date dOB;
    private boolean gender;
    private String idCard;
    private String phoneNumber;
    private String email;
    private String address;
    private int typeOfCustomerID;
    private String accUserName;

    public Customer() {
    }

    public Customer(String name, Date dOB, boolean gender, String idCard, String phoneNumber, String email, String address, int typeOfCustomerID, String accUserName) {
        this.name = name;
        this.dOB = dOB;
        this.gender = gender;
        this.idCard = idCard;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.address = address;
        this.typeOfCustomerID = typeOfCustomerID;
        this.accUserName = accUserName;
    }

    public Customer(String name, Date dOB, boolean gender, String idCard, String phoneNumber, String email, String address, String accUserName) {
        this.name = name;
        this.dOB = dOB;
        this.gender = gender;
        this.idCard = idCard;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.address = address;
        this.accUserName = accUserName;
    }

    public Customer(int id, String name, Date dOB, boolean gender, String idCard, String phoneNumber, String email, String address, int typeOfCustomerID, String accUserName) {
        this.id = id;
        this.name = name;
        this.dOB = dOB;
        this.gender = gender;
        this.idCard = idCard;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.address = address;
        this.typeOfCustomerID = typeOfCustomerID;
        this.accUserName = accUserName;
    }

    public Customer(int id, String name, Date dOB, boolean gender, String idCard, String phoneNumber, String email, String address) {
        this.id = id;
        this.name = name;
        this.dOB = dOB;
        this.gender = gender;
        this.idCard = idCard;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.address = address;
    }

    public Customer(int id, String name, Date dOB, boolean gender, String idCard, String phoneNumber, String email, String address, String accUserName) {
        this.id = id;
        this.name = name;
        this.dOB = dOB;
        this.gender = gender;
        this.idCard = idCard;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.address = address;
        this.accUserName = accUserName;
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

    public Date getdOB() {
        return dOB;
    }

    public void setdOB(Date dOB) {
        this.dOB = dOB;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public String getIdCard() {
        return idCard;
    }

    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getTypeOfCustomerID() {
        return typeOfCustomerID;
    }

    public void setTypeOfCustomerID(int typeOfCustomerID) {
        this.typeOfCustomerID = typeOfCustomerID;
    }

    public String getAccUserName() {
        return accUserName;
    }

    public void setAccUserName(String accUserName) {
        this.accUserName = accUserName;
    }

    @Override
    public String toString() {
        return "Customer{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", dob=" + dOB +
                ", gender=" + gender +
                ", idCard='" + idCard + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", email='" + email + '\'' +
                ", address='" + address + '\'' +
                ", typeOfCustomerID=" + typeOfCustomerID +
                ", accUserName='" + accUserName + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Customer customer = (Customer) o;
        return id == customer.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
