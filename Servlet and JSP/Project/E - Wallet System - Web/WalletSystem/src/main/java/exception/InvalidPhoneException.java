package exception;

public class InvalidPhoneException extends AccountException{

    public InvalidPhoneException(String phone){
        super(" - Invalid PhoneNumber " + phone + " \n - [ Must be Egyptian format : 010, 011, 012, 015 ] ");
    }

}
