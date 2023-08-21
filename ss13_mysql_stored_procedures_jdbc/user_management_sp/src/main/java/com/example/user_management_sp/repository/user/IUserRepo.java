package com.example.user_management_sp.repository.user;

import com.example.user_management_sp.model.User;

import java.util.List;

public interface IUserRepo {
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

    void deleteUserSP(int id);

    void updateUserSP(int id, User user);
}
