package service.impl;

import exception.AccountException;
import model.Account;
import service.AccountService;

import javax.sql.DataSource;
import java.sql.*;

public class AccountServiceImpl implements AccountService {

    private final DataSource dataSource;

    public AccountServiceImpl(DataSource dataSource) {
        this.dataSource = dataSource;
    }
    
    private Account mapAccount(ResultSet rs) throws SQLException {
        return new Account(
            rs.getInt("ID"),
            rs.getString("NAME"),
            rs.getString("USERNAME"),
            rs.getString("PASSWORD"),
            rs.getString("PHONE"),
            rs.getString("EMAIL"),
            rs.getInt("AGE"),
            rs.getDouble("BALANCE"),
            rs.getInt("IS_ADMIN")  == 1,
            rs.getInt("IS_ACTIVE") == 1
        );
    }

    // Register
    @Override
    public void register(String name, String userName, String password,
                         String phoneNumber, String email, int age) {
        String sql = "INSERT INTO ACCOUNTS (NAME, USERNAME, PASSWORD, PHONE, EMAIL, AGE, BALANCE, IS_ADMIN, IS_ACTIVE) " +
                     "VALUES (?, ?, ?, ?, ?, ?, 0, 0, 1)";
        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // Check UserName exists
            if (findByUserName(userName) != null)
                throw new AccountException("Username already exists: " + userName);

            // Check phone exists
            if (findByPhone(phoneNumber) != null)
                throw new AccountException("Phone already exists: " + phoneNumber);

            // Check email exists
            if (findByEmail(email) != null)
                throw new AccountException("Email already exists: " + email);

            // Validate via Account constructor
            Account account = new Account(name, userName, password, phoneNumber, email, age);

            ps.setString(1, account.getName());
            ps.setString(2, account.getUserName());
            ps.setString(3, account.getPassword());
            ps.setString(4, account.getPhoneNumber());
            ps.setString(5, account.getEmail());
            ps.setInt   (6, account.getAge());
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new AccountException("Database error: " + e.getMessage());
        }
    }

    // Login
    @Override
    public Account login(String userName, String password) {
        Account account = findByUserName(userName);

        if (account == null)
            throw new AccountException("User not found: " + userName);

        if (!account.inActive())
            throw new AccountException("Account is inactive!");

        if (!account.getPassword().equals(password))
            throw new AccountException("Wrong password!");

        return account;
    }

    // Change Password
    @Override
    public void changePassword(Account account, String oldPassword, String newPassword) {
        if (!account.getPassword().equals(oldPassword))
            throw new AccountException("Old password is incorrect!");

        if (oldPassword.equals(newPassword))
            throw new AccountException("New password must be different!");

        String sql = "UPDATE ACCOUNTS SET PASSWORD = ? WHERE USERNAME = ?";
        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // Validate new password via setter
            account.setPassword(newPassword);

            ps.setString(1, newPassword);
            ps.setString(2, account.getUserName());
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new AccountException("Database error: " + e.getMessage());
        }
    }

    // Delete Account
    @Override
    public void deleteAccount(String userName, String password) {
        Account account = findByUserName(userName);

        if (account == null)
            throw new AccountException("User not found: " + userName);

        if (!account.getPassword().equals(password))
            throw new AccountException("Wrong password!");

        String sql = "DELETE FROM ACCOUNTS WHERE USERNAME = ?";
        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, userName);
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new AccountException("Database error: " + e.getMessage());
        }
    }

    // inActive Account
    @Override
    public void inActive(String userName, String password) {
        Account account = findByUserName(userName);

        if (account == null)
            throw new AccountException("User not found: " + userName);

        if (!account.getPassword().equals(password))
            throw new AccountException("Wrong password!");

        String sql = "UPDATE ACCOUNTS SET IS_ACTIVE = 0 WHERE USERNAME = ?";
        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, userName);
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new AccountException("Database error: " + e.getMessage());
        }
    }

    // Helper Methods 

    public Account findByUserName(String userName) {
        String sql = "SELECT * FROM ACCOUNTS WHERE USERNAME = ?";
        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, userName);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) return mapAccount(rs);

        } catch (SQLException e) {
            throw new AccountException("Database error: " + e.getMessage());
        }
        return null;
    }

    public Account findByPhone(String phone) {
        String sql = "SELECT * FROM ACCOUNTS WHERE PHONE = ?";
        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) return mapAccount(rs);

        } catch (SQLException e) {
            throw new AccountException("Database error: " + e.getMessage());
        }
        return null;
    }

    public Account findByEmail(String email) {
        String sql = "SELECT * FROM ACCOUNTS WHERE EMAIL = ?";
        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) return mapAccount(rs);

        } catch (SQLException e) {
            throw new AccountException("Database error: " + e.getMessage());
        }
        return null;
    }

    public java.util.List<Account> findAll() {
        String sql = "SELECT * FROM ACCOUNTS ORDER BY ID";
        java.util.List<Account> list = new java.util.ArrayList<>();
        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) list.add(mapAccount(rs));

        } catch (SQLException e) {
            throw new AccountException("Database error: " + e.getMessage());
        }
        return list;
    }

    
    // Update Name
    @Override
    public void updateName(Account account, String newName) {
        // Validate via setter
        account.setName(newName);

        String sql = "UPDATE ACCOUNTS SET NAME = ? WHERE USERNAME = ?";
        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, newName);
            ps.setString(2, account.getUserName());
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new AccountException("Database error: " + e.getMessage());
        }
    }
    
    
    // Verify Account 
    @Override
    public Account verifyAccount(String userName, String phoneNumber, String email) {
        Account account = findByUserName(userName);

        if (account == null)
            throw new AccountException("Username not found!");

        if (!account.getPhoneNumber().equals(phoneNumber))
            throw new AccountException("Phone number doesn't match!");

        if (!account.getEmail().equals(email))
            throw new AccountException("Email doesn't match!");

        return account;
    }

    
    // Reset Password
    @Override
    public void resetPassword(String userName, String newPassword) {
        if (newPassword == null || newPassword.length() < 6)
            throw new AccountException("Password must be at least 6 characters!");

        String sql = "UPDATE ACCOUNTS SET PASSWORD = ? WHERE USERNAME = ?";
        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, newPassword);
            ps.setString(2, userName);
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new AccountException("Database error: " + e.getMessage());
        }
    }
    
    
    // Activate Account
    @Override
    public void activateAccount(String userName) {
        String sql = "UPDATE ACCOUNTS SET IS_ACTIVE = 1 WHERE USERNAME = ?";
        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userName);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new AccountException("Database error: " + e.getMessage());
        }
    }
    
    // Deactivate Account
    @Override
    public void deactivateAccount(String userName) {
        String sql = "UPDATE ACCOUNTS SET IS_ACTIVE = 0 WHERE USERNAME = ?";
        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userName);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new AccountException("Database error: " + e.getMessage());
        }
    }
    
    
}