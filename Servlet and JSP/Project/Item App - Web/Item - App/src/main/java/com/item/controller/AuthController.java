package com.item.controller;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import com.item.model.User;
import com.item.service.UserService;
import com.item.service.impl.UserServiceImpl;

@WebServlet("/AuthController")
public class AuthController extends HttpServlet {

    @Resource(name = "jdbc/item")
    private DataSource dataSource;

    private static final long serialVersionUID = 1L;

    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl(dataSource);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "login":  login(request, response);  break;
            case "signup": signup(request, response); break;
            case "logout": logout(request, response); break;
            default:
                response.sendRedirect("login.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    // Login
    private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userService.login(username, password);

        if (user == null) {
            request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Session
        HttpSession session = request.getSession();
        session.setAttribute("loggedUser", user);

        // Cookie
        Cookie usernameCookie = new Cookie("rememberedUsername", username);
        usernameCookie.setMaxAge(2 * 24 * 60 * 60);
        usernameCookie.setPath("/");
        response.addCookie(usernameCookie);

        // Redirect
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }

    // Sign up
    private void signup(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstName   = request.getParameter("firstName");
        String lastName    = request.getParameter("lastName");
        String username    = request.getParameter("username");
        String email       = request.getParameter("email");
        String phone       = request.getParameter("phone");
        String password    = request.getParameter("password");
        String confirmPass = request.getParameter("confirmPassword");

        if (!password.equals(confirmPass)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        User newUser = new User();
        newUser.setFirstName(firstName);
        newUser.setLastName(lastName);
        newUser.setUserName(username);
        newUser.setEmail(email);
        newUser.setPhone(phone);
        newUser.setPassword(password);

        boolean success = userService.signup(newUser);

        if (!success) {
            request.setAttribute("errorMessage", "Signup failed. Username or email may already exist.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        Cookie usernameCookie = new Cookie("rememberedUsername", username);
        usernameCookie.setMaxAge(2 * 24 * 60 * 60); // 2 days
        usernameCookie.setPath("/");
        response.addCookie(usernameCookie);

        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
    
    // Logout
    private void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        Cookie usernameCookie = new Cookie("rememberedUsername", "");
        usernameCookie.setMaxAge(0);
        usernameCookie.setPath("/");
        response.addCookie(usernameCookie);

        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}