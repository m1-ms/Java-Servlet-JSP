package controller;

import exception.AccountException;
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

public class WalletController extends HttpServlet {

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
        case "showDepositPage":
            request.setAttribute("operation", "deposit");
            request.setAttribute("success", request.getParameter("success"));
            request.getRequestDispatcher("operation.jsp").forward(request, response);
            break;
            case "showWithdrawPage":
                request.setAttribute("operation", "withdraw");
                request.setAttribute("success", request.getParameter("success"));
                request.getRequestDispatcher("operation.jsp").forward(request, response);
                break;
            case "showTransferPage":
                request.setAttribute("operation", "transfer");
                request.setAttribute("success", request.getParameter("success"));
                request.getRequestDispatcher("operation.jsp").forward(request, response);
                break;
            case "showTransactionsPage":
                handleShowTransactions(request, response);
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
            case "deposit":  handleDeposit(request, response);  break;
            case "withdraw": handleWithdraw(request, response); break;
            case "transfer": handleTransfer(request, response); break;
            default:         response.sendRedirect("DashboardController");
        }
    }

    // Show Transactions
    private void handleShowTransactions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Account account = (Account) request.getSession().getAttribute("account");
        AccountServiceImpl accountService = new AccountServiceImpl(dataSource);
        WalletServiceImpl walletService   = new WalletServiceImpl(dataSource, accountService);

        List<Transaction> transactions = walletService.getTransactions(account.getId());
        request.setAttribute("transactions", transactions);
        request.getRequestDispatcher("transactions.jsp").forward(request, response);
    }

    // Deposit
    private void handleDeposit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Account account = (Account) request.getSession().getAttribute("account");

        try {
            double amount = Double.parseDouble(request.getParameter("amount"));
            AccountServiceImpl accountService = new AccountServiceImpl(dataSource);
            WalletServiceImpl walletService   = new WalletServiceImpl(dataSource, accountService);

            walletService.deposit(account.getUserName(), amount);

            // Refresh account in session
            Account fresh = accountService.findByUserName(account.getUserName());
            request.getSession().setAttribute("account", fresh);

            response.sendRedirect("WalletController?action=showDepositPage&success=Deposit+successful!");

        } catch (AccountException e) {
            request.setAttribute("operation", "deposit");
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("operation.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("operation", "deposit");
            request.setAttribute("error", "Invalid amount!");
            request.getRequestDispatcher("operation.jsp").forward(request, response);
        }
    }

    // Withdraw
    private void handleWithdraw(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Account account = (Account) request.getSession().getAttribute("account");

        try {
            double amount = Double.parseDouble(request.getParameter("amount"));
            AccountServiceImpl accountService = new AccountServiceImpl(dataSource);
            WalletServiceImpl walletService   = new WalletServiceImpl(dataSource, accountService);

            walletService.withdraw(account.getUserName(), amount);

            // Refresh account in session
            Account fresh = accountService.findByUserName(account.getUserName());
            request.getSession().setAttribute("account", fresh);

            response.sendRedirect("WalletController?action=showWithdrawPage&success=Withdraw+successful!");

        } catch (AccountException e) {
            request.setAttribute("operation", "withdraw");
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("operation.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("operation", "withdraw");
            request.setAttribute("error", "Invalid amount!");
            request.getRequestDispatcher("operation.jsp").forward(request, response);
        }
    }

    // Transfer
    private void handleTransfer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Account account = (Account) request.getSession().getAttribute("account");

        try {
            double amount         = Double.parseDouble(request.getParameter("amount"));
            String targetUsername = request.getParameter("targetUsername");

            AccountServiceImpl accountService = new AccountServiceImpl(dataSource);
            WalletServiceImpl walletService   = new WalletServiceImpl(dataSource, accountService);

            walletService.transfer(account.getUserName(), targetUsername, amount);

            Account fresh = accountService.findByUserName(account.getUserName());
            request.getSession().setAttribute("account", fresh);

            response.sendRedirect("WalletController?action=showTransferPage&success=Transfer+successful!");

        } catch (AccountException e) {
            request.setAttribute("operation", "transfer");
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("operation.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("operation", "transfer");
            request.setAttribute("error", "Invalid amount!");
            request.getRequestDispatcher("operation.jsp").forward(request, response);
        }
    }
}