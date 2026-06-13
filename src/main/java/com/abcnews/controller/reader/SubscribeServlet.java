package com.abcnews.controller.reader;

import com.abcnews.dao.NewsletterDAO;
import com.abcnews.model.Newsletter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/reader/subscribe")
public class SubscribeServlet extends HttpServlet {

    private NewsletterDAO newsletterDAO = new NewsletterDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        if (email != null && !email.trim().isEmpty()) {
            try {
                Newsletter newsletter = new Newsletter(email, true);
                newsletterDAO.insert(newsletter);
                req.getSession().setAttribute("message", "Đăng ký nhận bản tin thành công!");
            } catch (Exception e) {
                // Ignore if already exists or other errors
                req.getSession().setAttribute("error", "Có lỗi xảy ra hoặc email đã được đăng ký.");
            }
        }
        // Redirect back to referring page or home
        String referer = req.getHeader("Referer");
        if (referer != null) {
            resp.sendRedirect(referer);
        } else {
            resp.sendRedirect(req.getContextPath() + "/reader/home");
        }
    }
}
