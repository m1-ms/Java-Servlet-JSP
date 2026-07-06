package exception;

public class InvalidPasswordException extends AccountException{

    public InvalidPasswordException(){
        super(" - Invalid Password " + " \n - [ Min 6 chars | A-Z | a-z | 0-9 | !@#$% ].");
    }

}
