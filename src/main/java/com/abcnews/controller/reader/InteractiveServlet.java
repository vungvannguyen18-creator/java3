package com.abcnews.controller.reader;

import com.abcnews.dao.InteractiveDAO;
import com.abcnews.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = { "/reader/favorite", "/reader/comment", "/reader/author_request" })
public class InteractiveServlet extends HttpServlet {

    private InteractiveDAO interactiveDAO = new InteractiveDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        
        User currentUser = (User) req.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            // Must be logged in to interact
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String path = req.getServletPath();
        String newsId = req.getParameter("newsId");

        if ("/reader/favorite".equals(path)) {
            String action = req.getParameter("action"); // 'add' or 'remove'
            if ("add".equals(action)) {
                interactiveDAO.addFavorite(currentUser.getId(), newsId);
            } else if ("remove".equals(action)) {
                interactiveDAO.removeFavorite(currentUser.getId(), newsId);
            }
            resp.sendRedirect(req.getContextPath() + "/reader/detail?id=" + newsId);
        } else if ("/reader/comment".equals(path)) {
            String content = req.getParameter("content");
            if (content != null && !content.trim().isEmpty()) {
                interactiveDAO.addComment(currentUser.getId(), newsId, content);
            }
            resp.sendRedirect(req.getContextPath() + "/reader/detail?id=" + newsId);
        } else if ("/reader/author_request".equals(path)) {
            if (currentUser.getRole() == 0) {
                com.abcnews.dao.UserDAO userDAO = new com.abcnews.dao.UserDAO();
                currentUser.setRole(3); // 3 = Pending Writer
                userDAO.update(currentUser);
                req.getSession().setAttribute("currentUser", currentUser);
            }
            resp.sendRedirect(req.getContextPath() + "/reader/home");
        }
    }
}
