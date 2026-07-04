package com.item.service.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.sql.DataSource;

import com.item.exception.DatabaseException;
import com.item.model.Item;
import com.item.model.ItemDetail;
import com.item.service.ItemService;

public class ItemServiceImpl implements ItemService {

    private DataSource dataSource;

    public ItemServiceImpl(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public Item selectItemById(Long id) {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        try {
            connection = dataSource.getConnection();
            ps = connection.prepareStatement("SELECT * FROM item WHERE id = ?");
            ps.setLong(1, id);
            resultSet = ps.executeQuery();
            if (resultSet.next()) {
                String name = resultSet.getString("NAME");
                Double price = resultSet.getDouble("PRICE");
                int totalNumber = resultSet.getInt("TOTAL_NUMBER");
                return new Item(id, name, price, totalNumber);
            }
        } catch (SQLException e) {
        	throw new DatabaseException("Failed to get item", e);
        } finally {
            closeResources(connection, ps, resultSet);
        }
        return null;
    }

    @Override
    public boolean removeItemById(Long id) {
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = dataSource.getConnection();
            ps = connection.prepareStatement("DELETE FROM item WHERE id = ?");
            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
        	throw new DatabaseException("Failed to delete item", e);
        } finally {
            closeResources(connection, ps, null);
        }
    }

    @Override
    public boolean addItem(Item item) {
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = dataSource.getConnection();
            ps = connection.prepareStatement("INSERT INTO item (name, price, total_number) VALUES (?, ?, ?)");
            ps.setString(1, item.getName());
            ps.setDouble(2, item.getPrice());
            ps.setInt(3, item.getTotalNumber());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
        	throw new DatabaseException("Failed to add item", e);
        } finally {
            closeResources(connection, ps, null);
        }
    }

    @Override
    public boolean updateItem(Item item) {
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = dataSource.getConnection();
            ps = connection.prepareStatement("UPDATE item SET name=?, price=?, total_number=? WHERE id=?");
            ps.setString(1, item.getName());
            ps.setDouble(2, item.getPrice());
            ps.setInt(3, item.getTotalNumber());
            ps.setLong(4, item.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
        	throw new DatabaseException("Failed to update item", e);
        } finally {
            closeResources(connection, ps, null);
        }
    }

    @Override
    public List<Item> getItems() {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        try {
            connection = dataSource.getConnection();
            ps = connection.prepareStatement("SELECT * FROM item ORDER BY id ASC");
            resultSet = ps.executeQuery();
            List<Item> items = new ArrayList<>();
            while (resultSet.next()) {
                Long id = resultSet.getLong("ID");
                String name = resultSet.getString("NAME");
                Double price = resultSet.getDouble("PRICE");
                int totalNumber = resultSet.getInt("TOTAL_NUMBER");
                items.add(new Item(id, name, price, totalNumber));
            }
            return items;
        } catch (SQLException e) {
        	throw new DatabaseException("Failed to get items", e);
        } finally {
            closeResources(connection, ps, resultSet);
        }
    }

    // Helper method
    private void closeResources(Connection connection, PreparedStatement ps, ResultSet resultSet) {
        try {
            if (Objects.nonNull(resultSet)) resultSet.close();
            if (Objects.nonNull(ps)) ps.close();
            if (Objects.nonNull(connection)) connection.close();
        } catch (SQLException e) {
            System.out.println("Exception closing resources: " + e.getMessage());
        }
    }
    
    
    
    // Item Detail
    @Override
    public ItemDetail getItemDetail(long itemId) {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        try {
            connection = dataSource.getConnection();
            ps = connection.prepareStatement("SELECT * FROM item_details WHERE item_id = ?");
            ps.setLong(1, itemId);
            resultSet = ps.executeQuery();
            if (resultSet.next()) {
                return new ItemDetail(
                    resultSet.getLong("ITEM_ID"),
                    resultSet.getString("DESCRIPTION"),
                    resultSet.getString("MANUFACTURER")
                );
            }
        } catch (SQLException e) {
        	throw new DatabaseException("Failed to get item details", e);
        } finally {
            closeResources(connection, ps, resultSet);
        }
        return null;
    }

    @Override
    public boolean addItemDetail(ItemDetail itemDetail) {
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = dataSource.getConnection();
            ps = connection.prepareStatement("INSERT INTO item_details (item_id, description, manufacturer) VALUES (?, ?, ?)");
            ps.setLong(1, itemDetail.getItemId());
            ps.setString(2, itemDetail.getDescription());
            ps.setString(3, itemDetail.getManufacturer());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
        	throw new DatabaseException("Failed to add item details", e);
        } finally {
            closeResources(connection, ps, null);
        }
    }

    @Override
    public boolean updateItemDetail(ItemDetail itemDetail) {
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = dataSource.getConnection();
            ps = connection.prepareStatement("UPDATE item_details SET description=?, manufacturer=? WHERE item_id=?");
            ps.setString(1, itemDetail.getDescription());
            ps.setString(2, itemDetail.getManufacturer());
            ps.setLong(3, itemDetail.getItemId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
        	throw new DatabaseException("Failed to update item details", e);
        } finally {
            closeResources(connection, ps, null);
        }
    }
    
    
    @Override
    public boolean deleteItemDetail(long itemId) {
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = dataSource.getConnection();
            ps = connection.prepareStatement("DELETE FROM item_details WHERE item_id = ?");
            ps.setLong(1, itemId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new DatabaseException("Failed to delete item details", e);
        } finally {
            closeResources(connection, ps, null);
        }
    }
}