package com.item.service;

import com.item.model.User;

public interface UserService {

    boolean signup(User user);
    User login(String username, String password);
    
    boolean deleteAccount(long userID);

    boolean updatePassword(long userId , String newPassword);
    
    User getUserByEmailOrUsername(String identifier);
    
    // Email Service OTP
    boolean saveOTP(String email, int otp);
    boolean verifyOTP(String email, int otp);
    User getUserByEmail(String email);
    
}