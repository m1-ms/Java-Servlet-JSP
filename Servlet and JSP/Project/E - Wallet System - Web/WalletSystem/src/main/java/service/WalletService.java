package service;

public interface WalletService {

    // Deposit
    void deposit(String userName, double amount);

    // Withdraw
    void withdraw(String userName, double amount);

    // Transfer
    void transfer(String fromUserName, String toUserName, double amount);
}