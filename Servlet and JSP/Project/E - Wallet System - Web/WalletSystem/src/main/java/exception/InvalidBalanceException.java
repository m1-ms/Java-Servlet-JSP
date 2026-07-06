package exception;

public class InvalidBalanceException extends AccountException{

    public InvalidBalanceException(double balance){
        super(" - Invalid Balance " + balance + "\n - [ Can't be negative , must be [balance >=0] ] ");
    }

}
