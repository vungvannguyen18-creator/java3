package com.abcnews.controller.auth;

import com.abcnews.dao.UserDAO;
import com.abcnews.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/auth/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String id = req.getParameter("username"); // name='username' in form maps to 'Id'
        String password = req.getParameter("password");
        
        User user = userDAO.login(id, password);
        
        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("currentUser", user);
            
            if (user.getRole() == 0) {
                resp.sendRedirect(req.getContextPath() + "/reader/home");
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/news");
            }
        } else {
            req.setAttribute("error", "Sai mã đăng nhập hoặc mật khẩu!");
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
        }
    }
}
