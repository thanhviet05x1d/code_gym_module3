package com.example.user_management_sp.service;

import com.example.user_management_sp.model.User;

import java.util.List;

public interface IUserService {
    List<User> findAll();

    void createUser(User user);

    User findId(int id);

    void updateUser(int id, User user);

    void deleteUser(int id);

    User search(String country);

    List<User> sort();

    User getUserById(int id);
    void insertUserStore(User user);

    List<User> displaySP();

    void updateUserSP(int id, User user);

    void deleteUserSP(int id);
}
