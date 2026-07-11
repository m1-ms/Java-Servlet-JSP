package controller;

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
import java.util.List;

public class AdminController extends HttpServlet {

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

		Account admin = (Account) session.getAttribute("account");
		if (!admin.isAdmin()) {
			response.sendRedirect("DashboardController");
			return;
		}

		String action = request.getParameter("action");

		switch (action != null ? action : "showDashboard") {
		case "showDashboard":
			handleShowDashboard(request, response);
			break;

		case "showAllAccounts":
			handleShowAllAccounts(request, response);
			break;

		default:
			handleShowDashboard(request, response);
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

	    Account admin = (Account) session.getAttribute("account");
	    if (!admin.isAdmin()) {
	        response.sendRedirect("DashboardController");
	        return;
	    }

	    String action = request.getParameter("action");

	    if ("deactivateAccount".equals(action)) {
	        String userName = request.getParameter("userName");
	        AccountServiceImpl accountService = new AccountServiceImpl(dataSource);
	        accountService.deactivateAccount(userName);
	        response.sendRedirect("AdminController?action=showAllAccounts");
	    } else if ("activateAccount".equals(action)) {
	        String userName = request.getParameter("userName");
	        AccountServiceImpl accountService = new AccountServiceImpl(dataSource);
	        accountService.activateAccount(userName);
	        response.sendRedirect("AdminController?action=showAllAccounts");
	    } else {
	        response.sendRedirect("AdminController?action=showDashboard");
	    }
	}
	
	private void handleShowDashboard(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		AccountServiceImpl accountService = new AccountServiceImpl(dataSource);
		List<Account> allAccounts = accountService.findAll();

		request.setAttribute("allAccounts", allAccounts);
		request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
	}

	private void handleShowAllAccounts(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		AccountServiceImpl accountService = new AccountServiceImpl(dataSource);
		List<Account> allAccounts = accountService.findAll();

		request.setAttribute("allAccounts", allAccounts);
		request.getRequestDispatcher("allAccounts.jsp").forward(request, response);
	}

}