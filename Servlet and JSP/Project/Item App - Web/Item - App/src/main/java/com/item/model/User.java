package com.item.model;

public class User {

    private long id;
    private String firstName;
    private String lastName;
    private String userName;
    private String email;
    private String phone;
    private String password;

    public User() {
    	
    }

    public User(long id, String firstName, String lastName, String userName, String email, String phone, String password) {
        setId(id);
        setFirstName(firstName);
        setLastName(lastName);
        setUserName(userName);
        setEmail(email);
        setPhone(phone);
        setPassword(password);
    }

    public long getId() { return id; }
    public void setId(long id) {
        if (id > 0) this.id = id;
        else System.out.println("Invalid ID");
    }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) {
        if (firstName != null && firstName.matches("[A-Za-z]{3,}")) {
            this.firstName = firstName;
        } else {
            System.out.println("Invalid first name — letters only, min 3");
        }
    }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) {
        if (lastName != null && lastName.matches("[A-Za-z]{3,}")) {
            this.lastName = lastName;
        } else {
            System.out.println("Invalid last name — letters only, min 3");
        }
    }

    public String getUserName() { return userName; }
    public void setUserName(String userName) {
        if (userName != null && userName.matches("[A-Za-z0-9_.]{3,}")) {
            this.userName = userName;
        } else {
            System.out.println("Invalid username — letters, numbers, _ and . only, min 3");
        }
    }

    public String getEmail() { return email; }
    public void setEmail(String email) {
        if (email != null && email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {
            this.email = email;
        } else {
            System.out.println("Invalid email");
        }
    }

    public String getPhone() { return phone; }
    public void setPhone(String phone) {
        if (phone != null && phone.matches("\\d{11}")) {
            this.phone = phone;
        } else {
            System.out.println("Invalid phone — 11 digits only");
        }
    }

    public String getPassword() { return password; }
    public void setPassword(String password) {
        if (password != null && password.length() >= 6) {
            this.password = password;
        } else {
            System.out.println("Invalid password — min 6 characters");
        }
    }
}