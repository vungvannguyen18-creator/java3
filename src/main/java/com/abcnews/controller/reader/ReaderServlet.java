package com.abcnews.controller.reader;

import com.abcnews.dao.CategoryDAO;
import com.abcnews.dao.NewsDAO;
import com.abcnews.dao.InteractiveDAO;
import com.abcnews.model.Category;
import com.abcnews.model.News;
import com.abcnews.model.Comment;
import com.abcnews.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.LinkedList;

@WebServlet(urlPatterns = { "/reader/home", "/reader/category", "/reader/search", "/reader/detail" })
public class ReaderServlet extends HttpServlet {

    private NewsDAO newsDAO = new NewsDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    private InteractiveDAO interactiveDAO = new InteractiveDAO();

    @SuppressWarnings("unchecked")
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        List<Category> categories = categoryDAO.findAll();
        req.setAttribute("categories", categories);

        List<News> hotNews = newsDAO.findHotNews(5);
        req.setAttribute("hotNews", hotNews);

        List<News> latestNews = newsDAO.findLatestNews(5);
        req.setAttribute("latestNews", latestNews);

        // Lấy danh sách tin đã xem từ Session
        LinkedList<String> recentIds = (LinkedList<String>) req.getSession().getAttribute("recentNewsIds");
        List<News> recentNews = new ArrayList<>();
        if (recentIds != null) {
            for (String newsId : recentIds) {
                News n = newsDAO.findById(newsId);
                if (n != null && n.getStatus() == 3)
                    recentNews.add(n);
            }
        }
        req.setAttribute("recentNews", recentNews);

        switch (path) {
            case "/reader/home":
                showHome(req, resp);
                break;
            case "/reader/category":
                showCategory(req, resp);
                break;
            case "/reader/search":
                searchNews(req, resp);
                break;
            case "/reader/detail":
                showDetail(req, resp);
                break;
            default:
                showHome(req, resp);
                break;
        }
    }

    private void showHome(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<News> listNews = newsDAO.findHomeNews();
        req.setAttribute("listNews", listNews);
        req.setAttribute("pageTitle", "TIN TRANG NHẤT");
        req.getRequestDispatcher("/views/reader/home.jsp").forward(req, resp);
    }

    private void showCategory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String categoryId = req.getParameter("id");
            List<News> listNews = newsDAO.findByCategory(categoryId);
            req.setAttribute("listNews", listNews);
            req.setAttribute("pageTitle", "Tin tức theo danh mục");
            req.getRequestDispatcher("/views/reader/news_list.jsp").forward(req, resp);
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/reader/home");
        }
    }

    private void searchNews(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        if (keyword != null) {
            List<News> listNews = newsDAO.search(keyword);
            req.setAttribute("listNews", listNews);
            req.setAttribute("pageTitle", "Kết quả tìm kiếm: " + keyword);
        }
        req.getRequestDispatcher("/views/reader/news_list.jsp").forward(req, resp);
    }

    @SuppressWarnings("unchecked")
    private void showDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String id = req.getParameter("id");
            newsDAO.updateViewCount(id);
            News news = newsDAO.findById(id);
            if (news != null && news.getStatus() == 3) {
                // Thêm vào danh sách đã xem trong session
                jakarta.servlet.http.HttpSession session = req.getSession();
                LinkedList<String> recentIds = (LinkedList<String>) session.getAttribute("recentNewsIds");
                if (recentIds == null)
                    recentIds = new LinkedList<>();

                // Remove if exists to push to top
                recentIds.remove(id);
                recentIds.addFirst(id);
                // Keep only top 5
                if (recentIds.size() > 5)
                    recentIds.removeLast();
                session.setAttribute("recentNewsIds", recentIds);

                // Fetch related news
                List<News> allInCategory = newsDAO.findByCategory(news.getCategoryId());
                List<News> relatedNews = new ArrayList<>();
                for(News n : allInCategory) {
                    if(!n.getId().equals(news.getId())) {
                        relatedNews.add(n);
                        if(relatedNews.size() == 3) break;
                    }
                }
                req.setAttribute("relatedNews", relatedNews);

                // Fetch comments
                List<Comment> comments = interactiveDAO.getCommentsByNewsId(id);
                req.setAttribute("comments", comments);

                // Fetch favorite status
                User currentUser = (User) req.getSession().getAttribute("currentUser");
                if (currentUser != null) {
                    boolean isFavorite = interactiveDAO.checkFavorite(currentUser.getId(), id);
                    req.setAttribute("isFavorite", isFavorite);
                }

                req.setAttribute("news", news);
                req.getRequestDispatcher("/views/reader/news_detail.jsp").forward(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/reader/home");
            }
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/reader/home");
        }
    }
}
