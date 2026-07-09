package controller;

import exception.AccountException;
import model.Account;
import service.impl.AccountServiceImpl;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.io.IOException;

public class AuthController extends HttpServlet {

    @Resource(name = "jdbc/EWalletDB")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        switch (action) {
            case "login":    handleLogin(request, response);    break;
            case "register": handleRegister(request, response); break;
            
            case "verifyAccount": handleVerifyAccount(request, response); break;
            case "resetPassword": handleResetPassword(request, response); break;
            
            default:         response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("logout".equals(action)) {
            handleLogout(request, response);
        } else if ("ForgetPassword".equals(action)) {
            request.getRequestDispatcher("forgetPassword.jsp").forward(request, response);
        } else if ("ResetPassword".equals(action)) {
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
        
    }

    // Login
    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userName = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            AccountServiceImpl accountService = new AccountServiceImpl(dataSource);
            Account account = accountService.login(userName, password);

            HttpSession session = request.getSession();
            session.setAttribute("account", account);

            if (account.isAdmin()) {
                response.sendRedirect("AdminController");
            } else {
                response.sendRedirect("DashboardController");
            }

        } catch (AccountException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    // Register
    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name        = request.getParameter("fullName");
        String userName    = request.getParameter("username");
        String password    = request.getParameter("password");
        String phoneNumber = request.getParameter("phone");
        String email       = request.getParameter("email");
        String ageStr      = request.getParameter("age");

        try {
            int age = Integer.parseInt(ageStr);
            AccountServiceImpl accountService = new AccountServiceImpl(dataSource);
            accountService.register(name, userName, password, phoneNumber, email, age);

            request.setAttribute("success", "Account created! Please login.");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } catch (AccountException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid age!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    // Logout
    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) session.invalidate();
        response.sendRedirect("login.jsp");
    }
    
    
    // Verify Account
    private void handleVerifyAccount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userName    = request.getParameter("username");
        String phoneNumber = request.getParameter("phone");
        String email       = request.getParameter("email");

        try {
            AccountServiceImpl accountService = new AccountServiceImpl(dataSource);
            Account account = accountService.verifyAccount(userName, phoneNumber, email);

            request.getSession().setAttribute("resetUsername", account.getUserName());
            response.sendRedirect("resetPassword.jsp");

        } catch (AccountException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("forgetPassword.jsp").forward(request, response);
        }
    }

    
    // Reset Password
    private void handleResetPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userName   = (String) request.getSession().getAttribute("resetUsername");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (userName == null) {
            response.sendRedirect("forgetPassword.jsp");
            return;
        }

        try {
            if (!newPassword.equals(confirmPassword))
                throw new AccountException("Passwords don't match!");

            AccountServiceImpl accountService = new AccountServiceImpl(dataSource);
            accountService.resetPassword(userName, newPassword);

            request.getSession().removeAttribute("resetUsername");

            response.sendRedirect("login.jsp?success=Password+reset+successfully!");

        } catch (AccountException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
        }
    }
}