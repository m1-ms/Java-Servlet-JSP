package service.impl;

import exception.AccountException;
import exception.InvalidBalanceException;
import model.Account;
import model.Transaction;
import service.WalletService;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WalletServiceImpl implements WalletService {

    private final DataSource dataSource;
    private final AccountServiceImpl accountService;

    public WalletServiceImpl(DataSource dataSource, AccountServiceImpl accountService) {
        this.dataSource     = dataSource;
        this.accountService = accountService;
    }

    // Deposit
    @Override
    public void deposit(String userName, double amount) {

        Account account = accountService.findByUserName(userName);
        if (account == null)
            throw new AccountException("User not found: " + userName);

        if (amount <= 0)
            throw new AccountException("Amount must be greater than 0");

        double newBalance = account.getBalance() + amount;

        updateBalance(userName, newBalance);
        saveTransaction(account.getId(), "Deposit", amount, newBalance,
                        "Deposit to " + userName);
    }

    // Withdraw
    @Override
    public void withdraw(String userName, double amount) {

        Account account = accountService.findByUserName(userName);
        if (account == null)
            throw new AccountException("User not found: " + userName);

        if (amount <= 0)
            throw new AccountException("Amount must be greater than 0");

        if (account.getBalance() < amount)
            throw new InvalidBalanceException(account.getBalance());

        double newBalance = account.getBalance() - amount;

        updateBalance(userName, newBalance);
        saveTransaction(account.getId(), "Withdraw", amount, newBalance,
                        "Withdraw from " + userName);
    }

    // Transfer
    @Override
    public void transfer(String fromUserName, String toUserName, double amount) {

        if (fromUserName.equals(toUserName))
            throw new AccountException("Can't transfer to yourself!");

        Account from = accountService.findByUserName(fromUserName);
        Account to   = accountService.findByUserName(toUserName);

        if (from == null)
            throw new AccountException("Sender not found: " + fromUserName);

        if (to == null)
            throw new AccountException("Receiver not found: " + toUserName);

        if (amount <= 0)
            throw new AccountException("Amount must be greater than 0");

        if (from.getBalance() < amount)
            throw new InvalidBalanceException(from.getBalance());

        double fromNewBalance = from.getBalance() - amount;
        double toNewBalance   = to.getBalance()   + amount;

        updateBalance(fromUserName, fromNewBalance);
        updateBalance(toUserName,   toNewBalance);

        saveTransaction(from.getId(), "Transfer Out", amount, fromNewBalance,
                        "Transfer to " + toUserName);

        saveTransaction(to.getId(), "Transfer In", amount, toNewBalance,
                        "Transfer from " + fromUserName);
    }

    
    public List<Transaction> getTransactions(int accountId) {
        String sql = "SELECT * FROM TRANSACTIONS WHERE ACCOUNT_ID = ? ORDER BY ID";
        List<Transaction> list = new ArrayList<>();

        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Transaction(
                    rs.getInt("ID"),
                    rs.getInt("ACCOUNT_ID"),
                    rs.getString("TYPE"),
                    rs.getDouble("AMOUNT"),
                    rs.getDouble("BALANCE_AFTER"),
                    rs.getString("DETAILS")
                ));
            }

        } catch (SQLException e) {
            throw new AccountException("Database error: " + e.getMessage());
        }
        return list;
    }

    // Helper Methods 

    private void updateBalance(String userName, double newBalance) {
        String sql = "UPDATE ACCOUNTS SET BALANCE = ? WHERE USERNAME = ?";
        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setDouble(1, newBalance);
            ps.setString(2, userName);
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new AccountException("Database error: " + e.getMessage());
        }
    }

    private void saveTransaction(int accountId, String type, double amount,
                                  double balanceAfter, String details) {
        String sql = "INSERT INTO TRANSACTIONS (ACCOUNT_ID, TYPE, AMOUNT, BALANCE_AFTER, DETAILS) " +
                     "VALUES (?, ?, ?, ?, ?)";
        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt   (1, accountId);
            ps.setString(2, type);
            ps.setDouble(3, amount);
            ps.setDouble(4, balanceAfter);
            ps.setString(5, details);
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new AccountException("Database error: " + e.getMessage());
        }
    }
}