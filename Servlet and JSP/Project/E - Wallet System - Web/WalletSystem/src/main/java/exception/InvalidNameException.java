package exception;

public class InvalidNameException extends AccountException {
    public InvalidNameException(String name) {
        super("Invalid Name: " + name + " [ Min 3 chars, letters only ]");
    }
}