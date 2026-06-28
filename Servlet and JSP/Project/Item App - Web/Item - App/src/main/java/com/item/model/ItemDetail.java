package com.item.model;

public class ItemDetail {

    private long itemId;
    private String description;
    private String manufacturer;

    public ItemDetail() {
    }

    public ItemDetail(long itemId, String description, String manufacturer) {
        this.itemId = itemId;
        this.description = description;
        this.manufacturer = manufacturer;
    }

    public long getItemId() {
        return itemId;
    }

    public void setItemId(long itemId) {
        this.itemId = itemId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        if (description == null || description.trim().isEmpty()) {
            this.description = null;
        } else if (description.trim().length() >= 3 && description.trim().length() <= 500) {
            this.description = description.trim();
        } else {
            System.out.println("Invalid description — must be between 3 and 500 characters");
        }
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        if (manufacturer == null || manufacturer.trim().isEmpty()) {
            this.manufacturer = null;
        } else if (manufacturer.matches("[A-Za-z ]{2,100}")) {
            this.manufacturer = manufacturer.trim();
        } else {
            System.out.println("Invalid manufacturer — letters only, between 2 and 100 characters");
        }
    }
}

