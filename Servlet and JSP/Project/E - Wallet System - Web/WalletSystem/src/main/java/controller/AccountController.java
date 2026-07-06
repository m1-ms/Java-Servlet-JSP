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

public class AccountController extends HttpServlet {

    @Resource(name = "jdbc/EWalletDB")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        switch (action != null ? action : "") {
            case "showChangePasswordPage":
                request.getRequestDispatcher("changePassword.jsp").forward(request, response);
                break;
            case "showDeletePage":
                request.getRequestDispatcher("deleteAccount.jsp").forward(request, response);
                break;
            default:
                response.sendRedirect("DashboardController");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        switch (action != null ? action : "") {
            case "changePassword": handleChangePassword(request, response); break;
            case "deleteAccount":  handleDeleteAccount(request, response);  break;
            case "inActive":       handleInActive(request, response);       break;
            default:               response.sendRedirect("DashboardController");
        }
    }

    // Change Password
    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Account account     = (Account) request.getSession().getAttribute("account");
        String oldPassword  = request.getParameter("oldPassword");
        String newPassword  = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        try {
            if (!newPassword.equals(confirmPassword)) {
                throw new AccountException("Passwords do not match!");
            }

            AccountServiceImpl accountService = new AccountServiceImpl(dataSource);
            accountService.changePassword(account, oldPassword, newPassword);

            Account fresh = accountService.findByUserName(account.getUserName());
            request.getSession().setAttribute("account", fresh);

            request.setAttribute("success", "Password changed successfully!");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);

        } catch (AccountException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
        }
    }

    // Delete Account
    private void handleDeleteAccount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Account account = (Account) request.getSession().getAttribute("account");
        String password = request.getParameter("password");

        try {
            AccountServiceImpl accountService = new AccountServiceImpl(dataSource);
            accountService.deleteAccount(account.getUserName(), password);

            request.getSession().invalidate();
            response.sendRedirect("login.jsp");

        } catch (AccountException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("deleteAccount.jsp").forward(request, response);
        }
    }

    // InActive Account
    private void handleInActive(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Account account = (Account) request.getSession().getAttribute("account");
        String password = request.getParameter("password");

        try {
            AccountServiceImpl accountService = new AccountServiceImpl(dataSource);
            accountService.inActive(account.getUserName(), password);

            request.getSession().invalidate();
            response.sendRedirect("login.jsp");

        } catch (AccountException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("deleteAccount.jsp").forward(request, response);
        }
    }
}