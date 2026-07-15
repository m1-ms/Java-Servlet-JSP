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

import com.item.exception.DatabaseException;
import com.item.model.User;
import com.item.service.EmailService;
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

        try {
            switch (action) {
                case "login":         login(request, response);         break;
                case "signup":        signup(request, response);        break;
                
                case "verifySignupOTP": verifySignupOTP(request, response); break;
                
                case "logout":        logout(request, response);        break;
                case "deleteAccount": deleteAccount(request, response); break;
                
                case "verifyDeleteOTP": verifyDeleteOTP(request, response); break;
                
                case "resetPassword": resetPassword(request, response); break;
                
                case "sendOTP":   sendOTP(request, response);   break;
                case "verifyOTP": verifyOTP(request, response); break;
                
                case "verifyLoginOTP": verifyLoginOTP(request, response); break;
                
                default:
                    response.sendRedirect("login.jsp");
            }
        } catch (DatabaseException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An unexpected error occurred. Please try again.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    // Login
    private void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Username is required.");
            request.getRequestDispatcher("login.jsp").forward(request, response); return;
        }
        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Password is required.");
            request.getRequestDispatcher("login.jsp").forward(request, response); return;
        }

        User user = userService.login(username.trim(), password);
        if (user == null) {
            request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response); return;
        }

        int otp = (int)(Math.random() * 900000) + 100000;
        userService.saveOTP(user.getEmail(), otp);
        
        try {
            EmailService.sendOTP(user.getEmail(), String.valueOf(otp));
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Failed to send OTP. Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response); return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("pendingUser", user);
        session.setAttribute("showOTPModal", true);

        Cookie usernameCookie = new Cookie("rememberedUsername", username);
        usernameCookie.setMaxAge(2 * 24 * 60 * 60);
        usernameCookie.setPath("/");
        response.addCookie(usernameCookie);

        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    
    
    private void verifyLoginOTP(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User pendingUser = (User) session.getAttribute("pendingUser");
        String otpStr = request.getParameter("otp");

        if (pendingUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        boolean valid = userService.verifyOTP(pendingUser.getEmail(), Integer.parseInt(otpStr));
        if (!valid) {
            session.setAttribute("otpError", "Invalid or expired OTP. Please try again.");
            session.setAttribute("showOTPModal", true);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        session.removeAttribute("pendingUser");
        session.removeAttribute("showOTPModal");
        session.setAttribute("loggedUser", pendingUser);
        session.setAttribute("successMessage", "Welcome back! 👋");

        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
    

    // Sign up
    private void signup(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstName   = request.getParameter("firstName");
        String lastName    = request.getParameter("lastName");
        String username    = request.getParameter("username");
        String email       = request.getParameter("email");
        String phone       = request.getParameter("phone");
        String password    = request.getParameter("password");
        String confirmPass = request.getParameter("confirmPassword");

        if (firstName == null || firstName.trim().isEmpty()) {
            request.setAttribute("errorMessage", "First name is required.");
            request.getRequestDispatcher("signup.jsp").forward(request, response); return;
        }
        if (lastName == null || lastName.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Last name is required.");
            request.getRequestDispatcher("signup.jsp").forward(request, response); return;
        }
        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Username is required.");
            request.getRequestDispatcher("signup.jsp").forward(request, response); return;
        }
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Email is required.");
            request.getRequestDispatcher("signup.jsp").forward(request, response); return;
        }
        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Password is required.");
            request.getRequestDispatcher("signup.jsp").forward(request, response); return;
        }
        if (password.length() < 6) {
            request.setAttribute("errorMessage", "Password must be at least 6 characters.");
            request.getRequestDispatcher("signup.jsp").forward(request, response); return;
        }
        if (!password.equals(confirmPass)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("signup.jsp").forward(request, response); return;
        }

        User newUser = new User();
        newUser.setFirstName(firstName.trim());
        newUser.setLastName(lastName.trim());
        newUser.setUserName(username.trim());
        newUser.setEmail(email.trim());
        newUser.setPhone(phone);
        newUser.setPassword(password);

        int otp = (int)(Math.random() * 900000) + 100000;

        HttpSession session = request.getSession();
        session.setAttribute("pendingSignupUser", newUser);
        session.setAttribute("pendingSignupOTP", otp);
        session.setAttribute("showSignupOTPModal", true);

        try {
            EmailService.sendOTP(email.trim(), String.valueOf(otp));
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Failed to send OTP. Please try again.");
            request.getRequestDispatcher("signup.jsp").forward(request, response); return;
        }

        request.getRequestDispatcher("signup.jsp").forward(request, response);
    }
    
    
    // Verify SignUp OTP
    private void verifySignupOTP(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User pendingUser = (User) session.getAttribute("pendingSignupUser");
        Integer pendingOTP = (Integer) session.getAttribute("pendingSignupOTP");
        String otpStr = request.getParameter("otp");

        if (pendingUser == null) {
            response.sendRedirect(request.getContextPath() + "/signup.jsp");
            return;
        }

        if (!String.valueOf(pendingOTP).equals(otpStr.trim())) {
            session.setAttribute("signupOtpError", "Invalid OTP. Please try again.");
            session.setAttribute("showSignupOTPModal", true);
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        boolean success = userService.signup(pendingUser);
        if (!success) {
            session.removeAttribute("pendingSignupUser");
            session.removeAttribute("pendingSignupOTP");
            request.setAttribute("errorMessage", "Signup failed. Username or email may already exist.");
            request.getRequestDispatcher("signup.jsp").forward(request, response); return;
        }

        session.removeAttribute("pendingSignupUser");
        session.removeAttribute("pendingSignupOTP");
        session.removeAttribute("showSignupOTPModal");

        Cookie usernameCookie = new Cookie("rememberedUsername", pendingUser.getUserName());
        usernameCookie.setMaxAge(2 * 24 * 60 * 60);
        usernameCookie.setPath("/");
        response.addCookie(usernameCookie);

        session.setAttribute("successMessage", "Account created successfully! ✅");
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
    
    
    // Delete Account
    private void deleteAccount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User loggedUser = (User) session.getAttribute("loggedUser");

        int otp = (int)(Math.random() * 900000) + 100000;
        userService.saveOTP(loggedUser.getEmail(), otp);

        try {
            EmailService.sendOTP(loggedUser.getEmail(), String.valueOf(otp));
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Failed to send OTP. Please try again.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        session.setAttribute("showDeleteOTPModal", true);
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
    
    
    
    // Verify Delete OTP
    private void verifyDeleteOTP(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User loggedUser = (User) session.getAttribute("loggedUser");
        String otpStr = request.getParameter("otp");

        if (loggedUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        boolean valid = userService.verifyOTP(loggedUser.getEmail(), Integer.parseInt(otpStr));
        if (!valid) {
            session.setAttribute("deleteOtpError", "Invalid or expired OTP. Please try again.");
            session.setAttribute("showDeleteOTPModal", true);
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        userService.deleteAccount(loggedUser.getId());
        session.invalidate();

        Cookie usernameCookie = new Cookie("rememberedUsername", "");
        usernameCookie.setMaxAge(0);
        usernameCookie.setPath("/");
        response.addCookie(usernameCookie);

        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
    
    
    
    // Reset Password
    private void resetPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("resetUserId") == null) {
            response.sendRedirect(request.getContextPath() + "/forgotPassword.jsp");
            return;
        }

        String newPassword     = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        long userId = (long) session.getAttribute("resetUserId");
        boolean success = userService.updatePassword(userId, newPassword);

        if (!success) {
            request.setAttribute("errorMessage", "Failed to reset password. Please try again.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        session.removeAttribute("resetUserId");

        HttpSession resetSession = request.getSession();
        resetSession.setAttribute("successMessage", "Password reset successfully! ✅");
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
    
    
    // Send OTP
    private void sendOTP(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String identifier = request.getParameter("identifier");

        if (identifier == null || identifier.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Email or UserName is required.");
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
            return;
        }

        int otp = (int)(Math.random() * 900000) + 100000;

        boolean saved = userService.saveOTP(identifier.trim(), otp);
        if (!saved) {
            request.setAttribute("errorMessage", "Email not found. Please try again.");
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
            return;
        }

        try {
            EmailService.sendOTP(identifier.trim(), String.valueOf(otp));
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Failed to send OTP. Please try again.");
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
            return;
        }

        request.getSession().setAttribute("resetEmail", identifier.trim());
        request.getSession().setAttribute("successMessage", "OTP sent to your email! Check your inbox ✅");
        request.getRequestDispatcher("verifyOTP.jsp").forward(request, response);
    }

    // Verify OTP
    private void verifyOTP(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String email  = (String) session.getAttribute("resetEmail");
        String otpStr = request.getParameter("otp");

        if (otpStr == null || otpStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "OTP is required.");
            request.getRequestDispatcher("verifyOTP.jsp").forward(request, response);
            return;
        }

        boolean valid = userService.verifyOTP(email, Integer.parseInt(otpStr));
        if (!valid) {
            request.setAttribute("errorMessage", "Invalid or expired OTP. Please try again.");
            request.getRequestDispatcher("verifyOTP.jsp").forward(request, response);
            return;
        }

        User user = userService.getUserByEmail(email);
        session.setAttribute("resetUserId", user.getId());
        session.setAttribute("successMessage", "OTP verified successfully! ✅ Please set your new password.");

        request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
    }
}