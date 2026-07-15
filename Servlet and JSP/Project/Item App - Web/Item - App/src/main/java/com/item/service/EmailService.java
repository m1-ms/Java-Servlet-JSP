package com.item.service;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;
import java.io.UnsupportedEncodingException;

public class EmailService {

    private static final String FROM_EMAIL = "mahmoudsliman060@gmail.com";
    private static final String PASSWORD   = "ctkx pblh axvo iadg";

    public static void sendOTP(String toEmail, String otp) throws MessagingException, UnsupportedEncodingException {

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(FROM_EMAIL, "ItemApp"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject("ItemApp - Your OTP Code");
        message.setText("Your OTP is: " + otp + "\n\nThis code will expire in 5 minutes.");

        Transport.send(message);
    }
}