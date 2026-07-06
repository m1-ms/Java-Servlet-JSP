package model;

import exception.*;

public class Account {

    private int id;
    private String name;
    private String userName;
    private String password;
    private String phoneNumber;
    private String email;
    private int age;
    private double balance;
    private boolean isAdmin;
    private boolean inActive;

    // Constructor for creating new account
    public Account(String name, String userName, String password,
                   String phoneNumber, String email, int age) {
        setName(name);
        setUserName(userName);
        setPassword(password);
        setPhoneNumber(phoneNumber);
        setEmail(email);
        setAge(age);
        this.balance = 0;
        this.isAdmin = false;
        this.inActive = true;
    }

    public Account(int id, String name, String userName, String password,
                   String phoneNumber, String email, int age,
                   double balance, boolean isAdmin, boolean inActive) {
        this.id = id;
        this.name = name;
        this.userName = userName;
        this.password = password;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.age = age;
        this.balance = balance;
        this.isAdmin = isAdmin;
        this.inActive = inActive;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) {
        if (name != null && name.length() >= 3 && name.matches("[A-Za-z ]+")) {
            this.name = name;
        } else {
            throw new InvalidNameException(name);
        }
    }

    public String getUserName() { return userName; }
    public void setUserName(String userName) {
        if (userName != null && userName.length() >= 3) {
            this.userName = userName;
        } else {
            throw new InvalidNameException(userName);
        }
    }

    public String getPassword() { return password; }
    public void setPassword(String password) {
        if (password != null && password.length() >= 6) {
            this.password = password;
        } else {
            throw new InvalidPasswordException();
        }
    }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) {
        if (phoneNumber != null && phoneNumber.matches("\\d{11}")) {
            this.phoneNumber = phoneNumber;
        } else {
            throw new InvalidPhoneException(phoneNumber);
        }
    }

    public String getEmail() { return email; }
    public void setEmail(String email) {
        if (email != null && email.contains("@")) {
            this.email = email;
        } else {
            throw new InvalidEmailException(email);
        }
    }

    public int getAge() { return age; }
    public void setAge(int age) {
        if (age >= 18 && age <= 100) {
            this.age = age;
        } else {
            throw new InvalidAgeException(age);
        }
    }

    public double getBalance() { return balance; }
    public void setBalance(double balance) {
        if (balance >= 0) {
            this.balance = balance;
        } else {
            throw new InvalidBalanceException(balance);
        }
    }

    public boolean isAdmin() { return isAdmin; }
    public void setAdmin(boolean admin) { isAdmin = admin; }

    public boolean inActive() { return inActive; }
    public void setActive(boolean active) { inActive = active; }
    
 // Alias methods for JSP
    public String getFullName()  { return name; }
    public String getUsername()  { return userName; }
    public String getPhone()     { return phoneNumber; }
    public boolean isActive()    { return inActive; }
    public String getRole()      { return isAdmin ? "ADMIN" : "USER"; }
}
