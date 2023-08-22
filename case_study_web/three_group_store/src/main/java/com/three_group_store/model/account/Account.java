package com.three_group_store.model.account;

import java.util.Objects;

public class Account {
    private String userName;
    private String password;
    private String roleName;

    public Account() {
    }

    public Account(String userName, String password, String roleName) {
        this.userName = userName;
        this.password = password;
        this.roleName = roleName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Account account = (Account) o;
        return Objects.equals(userName, account.userName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userName);
    }
}
