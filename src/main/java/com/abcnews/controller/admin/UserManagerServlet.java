package com.abcnews.controller.admin;

import com.abcnews.dao.UserDAO;
import com.abcnews.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet({"/admin/user", "/admin/user/insert", "/admin/user/update", "/admin/user/delete"})
public class UserManagerServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

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

        List<User> list = userDAO.findAll();
        req.setAttribute("listUser", list);
        req.getRequestDispatcher("/views/admin/user_manager.jsp").forward(req, resp);
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
        
        try {
            if ("/admin/user/delete".equals(path)) {
                String id = req.getParameter("id");
                userDAO.delete(id);
                session.setAttribute("message", "Xóa người dùng thành công.");
            } else {
                User user = new User();
                user.setId(req.getParameter("id"));
                user.setPassword(req.getParameter("password"));
                user.setFullname(req.getParameter("fullname"));
                user.setEmail(req.getParameter("email"));
                user.setMobile(req.getParameter("mobile"));
                user.setGender(req.getParameter("gender") != null);
                
                String roleParam = req.getParameter("role");
                if (roleParam != null) {
                    user.setRole(Integer.parseInt(roleParam));
                } else {
                    user.setRole(0);
                }
                
                String dob = req.getParameter("birthday");
                if(dob != null && !dob.isEmpty()) {
                    Date date = new SimpleDateFormat("yyyy-MM-dd").parse(dob);
                    user.setBirthday(date);
                } else {
                    user.setBirthday(new Date());
                }

                if ("/admin/user/insert".equals(path)) {
                    // Tự động tạo mã đăng nhập
                    String newId = "USR" + System.currentTimeMillis();
                    user.setId(newId);

                    if (userDAO.findByEmail(user.getEmail()) != null) {
                        session.setAttribute("error", "Email này đã được sử dụng! Vui lòng nhập Email khác.");
                    } else {
                        userDAO.insert(user);
                        session.setAttribute("message", "Thêm người dùng thành công.");
                    }
                } else if ("/admin/user/update".equals(path)) {
                    User existingByEmail = userDAO.findByEmail(user.getEmail());
                    if (existingByEmail != null && !existingByEmail.getId().equals(user.getId())) {
                        session.setAttribute("error", "Email này đã được người khác sử dụng! Vui lòng nhập Email khác.");
                    } else {
                        userDAO.update(user);
                        session.setAttribute("message", "Cập nhật người dùng thành công.");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/admin/user");
    }
}
