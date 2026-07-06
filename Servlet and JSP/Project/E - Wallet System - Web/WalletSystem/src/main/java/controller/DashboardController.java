package controller;

import model.Account;
import model.Transaction;
import service.impl.AccountServiceImpl;
import service.impl.WalletServiceImpl;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.io.IOException;
import java.util.List;

public class DashboardController extends HttpServlet {

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

        Account account = (Account) session.getAttribute("account");

        AccountServiceImpl accountService = new AccountServiceImpl(dataSource);
        Account freshAccount = accountService.findByUserName(account.getUserName());
        session.setAttribute("account", freshAccount);

        WalletServiceImpl walletService = new WalletServiceImpl(dataSource, accountService);
        List<Transaction> allTx = walletService.getTransactions(freshAccount.getId());

        int size = allTx.size();
        List<Transaction> recentTx = allTx.subList(Math.max(0, size - 4), size);

        request.setAttribute("recentTransactions", recentTx);
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}