package com.abcnews.controller.admin;

import com.abcnews.dao.CategoryDAO;
import com.abcnews.dao.NewsDAO;
import com.abcnews.model.Category;
import com.abcnews.model.News;
import com.abcnews.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Date;
import java.util.List;

@WebServlet({"/admin/news", "/admin/news/insert", "/admin/news/update", "/admin/news/delete"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 50, // 50MB
    maxRequestSize = 1024 * 1024 * 100 // 100MB
)
public class NewsManagerServlet extends HttpServlet {

    private NewsDAO newsDAO = new NewsDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        List<Category> categories = categoryDAO.findAll();
        req.setAttribute("categories", categories);

        List<News> listNews;
        if (currentUser.getRole() == 2) {
            // Admin can see all
            listNews = newsDAO.findAll(); 
        } else {
            // Writer can only see their own
            listNews = newsDAO.findByAuthor(currentUser.getId());
        }
        
        req.setAttribute("listNews", listNews);
        req.getRequestDispatcher("/views/admin/news_manager.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String path = req.getServletPath();
        
        try {
            if ("/admin/news/insert".equals(path)) {
                News news = new News();
                news.setId(req.getParameter("id"));
                news.setTitle(req.getParameter("title"));
                news.setContent(req.getParameter("content"));
                news.setCategoryId(req.getParameter("categoryId"));
                news.setAuthor(currentUser.getId());
                
                // Xử lý upload ảnh hoặc lấy URL
                String imageUrl = req.getParameter("imageUrl");
                Part filePart = req.getPart("image");
                String fileName = (filePart != null && filePart.getSubmittedFileName() != null) ? Paths.get(filePart.getSubmittedFileName()).getFileName().toString() : "";
                
                if (fileName != null && !fileName.isEmpty()) {
                    String uploadPath = getServletContext().getRealPath("/") + "images";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdir();
                    filePart.write(uploadPath + File.separator + fileName);
                    news.setImage("images/" + fileName);
                } else if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                    news.setImage(imageUrl);
                } else {
                    news.setImage("https://images.unsplash.com/photo-1508921340878-ba53e1f016ec?w=800&q=80"); // Ảnh mặc định
                }
                
                news.setViewCount(0);
                news.setPostedDate(new Date());
                news.setHome(req.getParameter("home") != null);
                
                if (currentUser.getRole() == 2) {
                    news.setStatus(3); // Admin tạo thì tự động Công khai
                } else {
                    news.setStatus(1); // Phóng viên tạo thì mặc định Chờ duyệt
                }
                
                if (newsDAO.findById(news.getId()) != null) {
                    session.setAttribute("error", "Mã bản tin này đã tồn tại! Vui lòng chọn mã khác.");
                } else {
                    newsDAO.insert(news);
                    session.setAttribute("message", "Thêm bản tin thành công.");
                }
            } else if ("/admin/news/update".equals(path)) {
                String id = req.getParameter("id");
                News news = newsDAO.findById(id);
                if (news != null && (news.getAuthor().equals(currentUser.getId()) || currentUser.getRole() == 2)) {
                    news.setTitle(req.getParameter("title"));
                    news.setContent(req.getParameter("content"));
                    news.setCategoryId(req.getParameter("categoryId"));
                    news.setHome(req.getParameter("home") != null);
                    
                    // Xử lý upload ảnh hoặc URL
                    String imageUrl = req.getParameter("imageUrl");
                    Part filePart = req.getPart("image");
                    String fileName = (filePart != null && filePart.getSubmittedFileName() != null) ? Paths.get(filePart.getSubmittedFileName()).getFileName().toString() : "";
                    
                    if (fileName != null && !fileName.isEmpty()) {
                        String uploadPath = getServletContext().getRealPath("/") + "images";
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) uploadDir.mkdir();
                        filePart.write(uploadPath + File.separator + fileName);
                        news.setImage("images/" + fileName);
                    } else if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                        news.setImage(imageUrl);
                    }
                    
                    if (currentUser.getRole() != 2) {
                        news.setStatus(1); // Phóng viên sửa thì quay về Chờ duyệt
                    }
                    
                    newsDAO.update(news);
                    session.setAttribute("message", "Cập nhật thành công.");
                }
            } else if ("/admin/news/delete".equals(path)) {
                String id = req.getParameter("id");
                newsDAO.delete(id);
                session.setAttribute("message", "Xóa bản tin thành công.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/admin/news");
    }
}
