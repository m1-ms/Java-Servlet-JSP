package com.item.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import com.item.exception.DatabaseException;
import com.item.model.Item;
import com.item.model.ItemDetail;
import com.item.service.ItemService;
import com.item.service.impl.ItemServiceImpl;

@WebServlet("/ItemController")
public class ItemController extends HttpServlet {

    @Resource(name = "jdbc/item")
    private DataSource dataSource;

    private static final long serialVersionUID = 1L;

    private ItemService itemService;

    @Override
    public void init() throws ServletException {
        itemService = new ItemServiceImpl(dataSource);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
    	
    	String action = request.getParameter("action");
        if (Objects.isNull(action)) action = "showItems";

        try {
            switch (action) {
                case "showItems":            showItems(request, response);            break;
                case "showItem":             showItem(request, response);             break;
                case "addItem":              addItem(request, response);              break;
                case "updateItem":           updateItem(request, response);           break;
                case "showUpdatePage":       showUpdatePage(request, response);       break;
                case "deleteItem":           deleteItem(request, response);           break;
                case "showDeletePage":       showDeletePage(request, response);       break;
                case "addItemDetail":        addItemDetail(request, response);        break;
                case "updateItemDetail":     updateItemDetail(request, response);     break;
                case "showAddDetailPage":    showAddDetailPage(request, response);    break;
                case "showUpdateDetailPage": showUpdateDetailPage(request, response); break;
                default:                     showItems(request, response);
            }
        } catch (DatabaseException e) {
            handleError(request, response, e.getMessage());
        } catch (Exception e) {
            handleError(request, response, "An unexpected error occurred. Please try again.");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    private void showItems(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Item> items = itemService.getItems();
        if (items == null) {
            handleError(request, response, "Failed to load items. Please try again.");
            return;
        }
        
        List<Long> itemsWithDetails = new ArrayList<>();
        for (Item item : items) {
            if (itemService.getItemDetail(item.getId()) != null) {
                itemsWithDetails.add(item.getId());
            }
        }
        
        request.setAttribute("itemsData", items);
        request.setAttribute("itemsWithDetails", itemsWithDetails);
        request.getRequestDispatcher("showItems.jsp").forward(request, response);
    }

    private void showItem(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long id = Long.parseLong(request.getParameter("id"));
        Item item = itemService.selectItemById(id);
        if (item == null) {
            handleError(request, response, "Item not found.");
            return;
        }
        request.setAttribute("item", item);
        request.getRequestDispatcher("/WEB-INF/views/showItems.jsp").forward(request, response);
    }

    
    // Add Item
    private void addItem(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Item newItem = new Item();
        newItem.setName(request.getParameter("name"));
        newItem.setPrice(Double.parseDouble(request.getParameter("price")));
        newItem.setTotalNumber(Integer.parseInt(request.getParameter("totalNumber")));
        if (!itemService.addItem(newItem)) {
            handleError(request, response, "Failed to add item. Please try again.");
            return;
        }
        
        request.getSession().setAttribute("successMessage", "Item Added successfully! ✅");
        response.sendRedirect(request.getContextPath() + "/ItemController?action=showItems");
    }

    
    // Update Item
    private void updateItem(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Item updatedItem = new Item();
        updatedItem.setId(Long.parseLong(request.getParameter("id")));
        updatedItem.setName(request.getParameter("name"));
        updatedItem.setPrice(Double.parseDouble(request.getParameter("price")));
        updatedItem.setTotalNumber(Integer.parseInt(request.getParameter("totalNumber")));
        if (!itemService.updateItem(updatedItem)) {
            handleError(request, response, "Failed to update item. Please try again.");
            return;
        }
        
        request.getSession().setAttribute("successMessage", "Item Update successfully! ✅");
        response.sendRedirect(request.getContextPath() + "/ItemController?action=showItems");
    }

    
    // Show Update Page
    private void showUpdatePage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Item> items = itemService.getItems();
        if (items == null) {
            handleError(request, response, "Failed to load items. Please try again.");
            return;
        }
        request.setAttribute("itemsData", items);
        String id = request.getParameter("id");
        if (id != null) request.setAttribute("selectedId", id);
        request.getRequestDispatcher("updateItem.jsp").forward(request, response);
    }

    
    // Delete Item
    private void deleteItem(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!itemService.removeItemById(Long.parseLong(request.getParameter("id")))) {
            handleError(request, response, "Failed to delete item. Please try again.");
            return;
        }
        
        request.getSession().setAttribute("successMessage", "Item Deleted successfully! ✅");
        response.sendRedirect(request.getContextPath() + "/ItemController?action=showItems");
    }

    
    // Show Delete Page
    private void showDeletePage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Item> items = itemService.getItems();
        if (items == null) {
            handleError(request, response, "Failed to load items. Please try again.");
            return;
        }
        request.setAttribute("itemsData", items);
        String id = request.getParameter("id");
        if (id != null) request.setAttribute("selectedId", id);
        request.getRequestDispatcher("deleteItem.jsp").forward(request, response);
    }

    
    // Error 
    private void handleError(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        request.setAttribute("errorMessage", message);
        request.getRequestDispatcher("error.jsp").forward(request, response);
    }
    
    
    // Show Add Details Page
    private void showAddDetailPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        Item item = itemService.selectItemById(Long.parseLong(id));
        request.setAttribute("itemId", id);
        request.setAttribute("item", item);
        request.getRequestDispatcher("addItemDetail.jsp").forward(request, response);
    }
    
    
    // Show Update Detail Page
    private void showUpdateDetailPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long id = Long.parseLong(request.getParameter("id"));
        ItemDetail detail = itemService.getItemDetail(id);
        Item item = itemService.selectItemById(id);
        request.setAttribute("itemDetail", detail);
        request.setAttribute("item", item);
        request.getRequestDispatcher("updateItemDetail.jsp").forward(request, response);
    }

    
    // Add Item Detail
    private void addItemDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ItemDetail itemDetail = new ItemDetail();
        itemDetail.setItemId(Long.parseLong(request.getParameter("itemId")));
        itemDetail.setDescription(request.getParameter("description"));
        itemDetail.setManufacturer(request.getParameter("manufacturer"));
        if (!itemService.addItemDetail(itemDetail)) {
            handleError(request, response, "Failed to add item details. Please try again.");
            return;
        }
        
        request.getSession().setAttribute("successMessage", "Item Detials Added successfully! ✅");
        response.sendRedirect(request.getContextPath() + "/ItemController?action=showItems");
    }

    
    // Update Item Detail
    private void updateItemDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ItemDetail itemDetail = new ItemDetail();
        itemDetail.setItemId(Long.parseLong(request.getParameter("itemId")));
        itemDetail.setDescription(request.getParameter("description"));
        itemDetail.setManufacturer(request.getParameter("manufacturer"));
        if (!itemService.updateItemDetail(itemDetail)) {
            handleError(request, response, "Failed to update item details. Please try again.");
            return;
        }
        
        request.getSession().setAttribute("successMessage", "Item Detials Update successfully! ✅");
        response.sendRedirect(request.getContextPath() + "/ItemController?action=showItems");
    }
}