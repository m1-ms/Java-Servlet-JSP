package com.item.service;

import com.item.model.User;

public interface UserService {

    boolean signup(User user);
    User login(String username, String password);
    
    boolean deleteAccount(long userID);

}