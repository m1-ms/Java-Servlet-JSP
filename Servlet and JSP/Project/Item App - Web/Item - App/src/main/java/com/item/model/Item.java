package com.item.model;
public class Item {

    private long id;
    private String name;
    private double price;
    private int totalNumber;
    
    public Item() {}

    public Item(String name, double price, int totalNumber) {
        setName(name);
        setPrice(price);
        setTotalNumber(totalNumber);
    }

    public Item(long id, String name, double price, int totalNumber) {
        setId(id);
        setName(name);
        setPrice(price);
        setTotalNumber(totalNumber);
    }
    
    public long getId() {
        return id;
    }

    public void setId(long id) {
        if (id > 0) {
            this.id = id;
        } else {
            System.out.println(" - Invalid ID, must be > 0");
        }
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        if (name != null && name.length() >= 3 && name.matches("[A-Za-z ]+")) {
            this.name = name;
        } else {
            System.out.println(" - Invalid Name, must be >= 3 letters (letters only)");
        }
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        if (price > 0) {
            this.price = price;
        } else {
            System.out.println(" - Invalid Price, must be > 0");
        }
    }

    public int getTotalNumber() {
        return totalNumber;
    }

    public void setTotalNumber(int totalNumber) {
        if (totalNumber >= 0) {
            this.totalNumber = totalNumber;
        } else {
            System.out.println(" - Invalid Total Number, must be >= 0");
        }
    }
    
//    @Override
//    public String toString() {
//        return " Item [ " + " ID = " + id + " , Name = ' " + name + '\'' + ", Price = " + price + " , TotalNumber =" + totalNumber + ' ] ';
//    }
}