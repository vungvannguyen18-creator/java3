package com.abcnews.util;

import com.abcnews.model.News;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.List;

public class MailService {
    // Remember to update your email and app password here before using the MailService
    private static final String SENDER_EMAIL = "your_email@gmail.com";
    private static final String SENDER_PASSWORD = "your_app_password";

    public static void sendNewsletter(List<String> toEmails, News news) {
        if (toEmails == null || toEmails.isEmpty()) return;

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
            }
        });

        for (String toEmail : toEmails) {
            try {
                Message message = new MimeMessage(session);
                message.setFrom(new InternetAddress(SENDER_EMAIL, "ABC News"));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
                message.setSubject("Bản tin mới từ ABC News: " + news.getTitle());
                
                String htmlContent = "<h3>" + news.getTitle() + "</h3>"
                        + "<p>" + news.getContent() + "</p>"
                        + "<br><p>Cảm ơn bạn đã đăng ký nhận bản tin!</p>";
                        
                message.setContent(htmlContent, "text/html; charset=utf-8");
                Transport.send(message);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
