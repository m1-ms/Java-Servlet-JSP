package com.item.service.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Objects;

import javax.sql.DataSource;

import com.item.exception.DatabaseException;
import com.item.model.User;
import com.item.service.UserService;

public class UserServiceImpl implements UserService {

    private DataSource dataSource;

    public UserServiceImpl(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public boolean signup(User user) {
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = dataSource.getConnection();
            String query = "INSERT INTO users (first_name, last_name, username, email, phone, password) VALUES (?, ?, ?, ?, ?, ?)";
            ps = connection.prepareStatement(query);
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getUserName());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getPassword());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
        	throw new DatabaseException("Failed to signup", e);
        } finally {
            closeResources(connection, ps, null);
        }
    }
    
    

    @Override
    public User login(String username, String password) {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        try {
            connection = dataSource.getConnection();
            String query = "SELECT * FROM users WHERE username = ? AND password = ?";
            ps = connection.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            resultSet = ps.executeQuery();
            if (resultSet.next()) {
                return new User(
                    resultSet.getLong("ID"),
                    resultSet.getString("FIRST_NAME"),
                    resultSet.getString("LAST_NAME"),
                    resultSet.getString("USERNAME"),
                    resultSet.getString("EMAIL"),
                    resultSet.getString("PHONE"),
                    resultSet.getString("PASSWORD")
                );
            }
        } catch (SQLException e) {
        	throw new DatabaseException("Failed to login", e);
        } finally {
            closeResources(connection, ps, resultSet);
        }
        return null;
    }

    private void closeResources(Connection connection, PreparedStatement ps, ResultSet resultSet) {
        try {
            if (Objects.nonNull(resultSet)) resultSet.close();
            if (Objects.nonNull(ps)) ps.close();
            if (Objects.nonNull(connection)) connection.close();
        } catch (SQLException e) {
            System.out.println("Exception closing resources: " + e.getMessage());
        }
    }
    
    
    @Override
    public boolean deleteAccount(long userId) {
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = dataSource.getConnection();
            ps = connection.prepareStatement("DELETE FROM USERS WHERE ID = ?");
            ps.setLong(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
        	throw new DatabaseException("Failed to delete account", e);
        } finally {
            closeResources(connection, ps, null);
        }
    }
    
    
    @Override
    public User verifyUser(String username, String email, String phone) {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        try {
            connection = dataSource.getConnection();
            String query = "SELECT * FROM users WHERE username = ? AND email = ? AND phone = ?";
            ps = connection.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, phone);
            resultSet = ps.executeQuery();
            if (resultSet.next()) {
                return new User(
                    resultSet.getLong("ID"),
                    resultSet.getString("FIRST_NAME"),
                    resultSet.getString("LAST_NAME"),
                    resultSet.getString("USERNAME"),
                    resultSet.getString("EMAIL"),
                    resultSet.getString("PHONE"),
                    resultSet.getString("PASSWORD")
                );
            }
        } catch (SQLException e) {
        	throw new DatabaseException("Failed to verify user", e);
        } finally {
            closeResources(connection, ps, resultSet);
        }
        return null;
    }

    @Override
    public boolean updatePassword(long userId, String newPassword) {
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = dataSource.getConnection();
            String query = "UPDATE users SET password = ? WHERE id = ?";
            ps = connection.prepareStatement(query);
            ps.setString(1, newPassword);
            ps.setLong(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
        	throw new DatabaseException("Failed to update password", e);
        } finally {
            closeResources(connection, ps, null);
        }
    }
}