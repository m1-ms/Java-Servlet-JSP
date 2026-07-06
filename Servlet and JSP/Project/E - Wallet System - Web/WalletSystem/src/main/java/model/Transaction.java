package model;

public class Transaction {

    private int id;
    private int accountId;
    private String type;
    private double amount;
    private double balanceAfter;
    private String details;

    // Constructor for creating new transaction
    public Transaction(int accountId, String type, double amount,
                       double balanceAfter, String details) {
        this.accountId   = accountId;
        this.type        = type;
        this.amount      = amount;
        this.balanceAfter = balanceAfter;
        this.details     = details;
    }

    // Constructor for loading from DB (includes id)
    public Transaction(int id, int accountId, String type, double amount,
                       double balanceAfter, String details) {
        this.id           = id;
        this.accountId    = accountId;
        this.type         = type;
        this.amount       = amount;
        this.balanceAfter = balanceAfter;
        this.details      = details;
    }

    // Getters
    public int getId()             { return id; }
    public int getAccountId()      { return accountId; }
    public String getType()        { return type; }
    public double getAmount()      { return amount; }
    public double getBalanceAfter(){ return balanceAfter; }
    public String getDetails()     { return details; }
    
 // Alias for JSP
    public String getDescription() { return details; }
}