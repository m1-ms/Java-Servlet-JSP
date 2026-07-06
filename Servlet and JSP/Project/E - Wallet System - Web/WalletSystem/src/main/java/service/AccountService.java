package service;

import model.Account;

public interface AccountService {

    // Register
    public void register(String name, String userName, String password,
                  String phoneNumber, String email, int age);

    // Login
    Account login(String userName, String password);

    // Change Account Password
    public void changePassword(Account account, String oldPassword, String newPassword);

    // Delete Account
    public void deleteAccount(String userName , String password);

    // inActive Account
    public void inActive(String userName , String password);
}