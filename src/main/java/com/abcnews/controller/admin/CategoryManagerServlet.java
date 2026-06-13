package com.abcnews.controller.admin;

import com.abcnews.dao.CategoryDAO;
import com.abcnews.model.Category;
import com.abcnews.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet({"/admin/category", "/admin/category/insert", "/admin/category/update", "/admin/category/delete"})
public class CategoryManagerServlet extends HttpServlet {
    private CategoryDAO categoryDAO = new CategoryDAO();

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

        List<Category> list = categoryDAO.findAll();
        req.setAttribute("listCategory", list);
        req.getRequestDispatcher("/views/admin/category_manager.jsp").forward(req, resp);
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
        String id = req.getParameter("id");
        String name = req.getParameter("name");
        Category category = new Category(id, name);

        try {
            if ("/admin/category/insert".equals(path)) {
                if (categoryDAO.findById(category.getId()) != null) {
                    session.setAttribute("error", "Mã loại tin này đã tồn tại! Vui lòng chọn mã khác.");
                } else {
                    categoryDAO.insert(category);
                    session.setAttribute("message", "Thêm loại tin thành công.");
                }
            } else if ("/admin/category/update".equals(path)) {
                categoryDAO.update(new Category(id, name));
                session.setAttribute("message", "Cập nhật loại tin thành công.");
            } else if ("/admin/category/delete".equals(path)) {
                categoryDAO.delete(id);
                session.setAttribute("message", "Xóa loại tin thành công.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/admin/category");
    }
}
