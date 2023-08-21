package com.example.user_management_sp.service;



import com.example.user_management_sp.model.User;
import com.example.user_management_sp.repository.user.IUserRepo;
import com.example.user_management_sp.repository.user.UserRepo;

import java.util.List;

public class UserService implements IUserService {
    IUserRepo userRepo = new UserRepo();

    @Override
    public List<User> findAll() {
        return userRepo.findAll();
    }

    @Override
    public void createUser(User user) {
        userRepo.createUser(user);
    }

    @Override
    public User findId(int id) {
        return userRepo.findId(id);
    }

    @Override
    public void updateUser(int id, User user) {
        userRepo.updateUser(id, user);
    }


    @Override
    public void deleteUser(int id) {
        userRepo.deleteUser(id);
    }

    @Override
    public User search(String country) {
        return userRepo.search(country);
    }

    @Override
    public List<User> sort() {
        return userRepo.sort();
    }

    @Override
    public User getUserById(int id) {
        return userRepo.getUserById(id);
    }

    @Override
    public void insertUserStore(User user) {
        userRepo.insertUserStore(user);
    }

    @Override
    public List<User> displaySP() {
        return userRepo.displaySP();
    }

    @Override
    public void updateUserSP(int id, User user) {
        userRepo.updateUserSP(id,user);
    }

    @Override
    public void deleteUserSP(int id) {
        userRepo.deleteUserSP(id);
    }
}
