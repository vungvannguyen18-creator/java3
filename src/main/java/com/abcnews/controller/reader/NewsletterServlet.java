package com.abcnews.controller.reader;

import com.abcnews.util.XJdbc;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/newsletter/subscribe")
public class NewsletterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        if (email != null && !email.trim().isEmpty()) {
            try {
                // Check if exists
                Object exists = XJdbc.value("SELECT email FROM newsletters WHERE email = ?", email);
                if (exists == null) {
                    XJdbc.update("INSERT INTO newsletters (email, enabled) VALUES (?, 1)", email);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        // Quay về trang hiện tại
        String referer = req.getHeader("Referer");
        if(referer != null) {
            resp.sendRedirect(referer);
        } else {
            resp.sendRedirect(req.getContextPath() + "/reader/home");
        }
    }
}
