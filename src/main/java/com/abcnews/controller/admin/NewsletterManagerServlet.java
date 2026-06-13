package com.abcnews.controller.admin;

import com.abcnews.util.XJdbc;
import com.abcnews.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet({"/admin/newsletter", "/admin/newsletter/delete", "/admin/newsletter/toggle"})
public class NewsletterManagerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        
        if (currentUser == null || currentUser.getRole() != 2) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        List<Map<String, Object>> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            rs = XJdbc.query("SELECT * FROM newsletters");
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("email", rs.getString("email"));
                map.put("enabled", rs.getBoolean("enabled"));
                list.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.getStatement().getConnection().close(); } catch (Exception e) {}
        }
        
        req.setAttribute("listNewsletter", list);
        req.getRequestDispatcher("/views/admin/newsletter_manager.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        
        if (currentUser == null || currentUser.getRole() != 2) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String path = req.getServletPath();
        String email = req.getParameter("email");
        
        try {
            if ("/admin/newsletter/delete".equals(path)) {
                XJdbc.update("DELETE FROM newsletters WHERE email=?", email);
                session.setAttribute("message", "Xóa email thành công.");
            } else if ("/admin/newsletter/toggle".equals(path)) {
                boolean enabled = Boolean.parseBoolean(req.getParameter("enabled"));
                XJdbc.update("UPDATE newsletters SET enabled=? WHERE email=?", !enabled, email);
                session.setAttribute("message", "Cập nhật trạng thái thành công.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/admin/newsletter");
    }
}
