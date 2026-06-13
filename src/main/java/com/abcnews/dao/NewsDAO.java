package com.abcnews.dao;

import com.abcnews.model.News;
import com.abcnews.util.XJdbc;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class NewsDAO {

    private News readFromResultSet(ResultSet rs) throws Exception {
        return new News(
            rs.getString("id"),
            rs.getString("title"),
            rs.getString("content"),
            rs.getString("image"),
            rs.getTimestamp("posted_date"),
            rs.getString("author"),
            rs.getInt("view_count"),
            rs.getString("category_id"),
            rs.getBoolean("home"),
            rs.getInt("status")
        );
    }

    public List<News> findAll() {
        List<News> list = new ArrayList<>();
        String sql = "SELECT * FROM news ORDER BY posted_date DESC";
        ResultSet rs = null;
        try {
            rs = XJdbc.query(sql);
            while (rs.next()) {
                list.add(readFromResultSet(rs));
            }
        } catch (Exception e) { e.printStackTrace(); } 
        finally { if (rs != null) try { rs.getStatement().getConnection().close(); } catch(Exception ex) {} }
        return list;
    }

    public List<News> findHomeNews() {
        List<News> list = new ArrayList<>();
        String sql = "SELECT * FROM news WHERE home = 1 AND status = 3 ORDER BY posted_date DESC";
        ResultSet rs = null;
        try {
            rs = XJdbc.query(sql);
            while (rs.next()) {
                list.add(readFromResultSet(rs));
            }
        } catch (Exception e) { e.printStackTrace(); } 
        finally { if (rs != null) try { rs.getStatement().getConnection().close(); } catch(Exception ex) {} }
        return list;
    }

    public List<News> findByAuthor(String authorId) {
        List<News> list = new ArrayList<>();
        String sql = "SELECT * FROM news WHERE author=? ORDER BY posted_date DESC";
        ResultSet rs = null;
        try {
            rs = XJdbc.query(sql, authorId);
            while (rs.next()) {
                list.add(readFromResultSet(rs));
            }
        } catch (Exception e) { e.printStackTrace(); } 
        finally { if (rs != null) try { rs.getStatement().getConnection().close(); } catch(Exception ex) {} }
        return list;
    }

    public News findById(String id) {
        String sql = "SELECT * FROM news WHERE id=?";
        ResultSet rs = null;
        try {
            rs = XJdbc.query(sql, id);
            if (rs.next()) {
                return readFromResultSet(rs);
            }
        } catch (Exception e) { e.printStackTrace(); } 
        finally { if (rs != null) try { rs.getStatement().getConnection().close(); } catch(Exception ex) {} }
        return null;
    }

    public List<News> findByCategory(String categoryId) {
        List<News> list = new ArrayList<>();
        String sql = "SELECT * FROM news WHERE category_id=? AND status = 3 ORDER BY posted_date DESC";
        ResultSet rs = null;
        try {
            rs = XJdbc.query(sql, categoryId);
            while (rs.next()) {
                list.add(readFromResultSet(rs));
            }
        } catch (Exception e) { e.printStackTrace(); } 
        finally { if (rs != null) try { rs.getStatement().getConnection().close(); } catch(Exception ex) {} }
        return list;
    }

    public List<News> search(String keyword) {
        List<News> list = new ArrayList<>();
        String sql = "SELECT * FROM news WHERE title LIKE ? AND status = 3 ORDER BY posted_date DESC";
        ResultSet rs = null;
        try {
            rs = XJdbc.query(sql, "%" + keyword + "%");
            while (rs.next()) {
                list.add(readFromResultSet(rs));
            }
        } catch (Exception e) { e.printStackTrace(); } 
        finally { if (rs != null) try { rs.getStatement().getConnection().close(); } catch(Exception ex) {} }
        return list;
    }

    public List<News> findHotNews(int limit) {
        List<News> list = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM news WHERE status = 3 ORDER BY view_count DESC";
        ResultSet rs = null;
        try {
            rs = XJdbc.query(sql, limit);
            while (rs.next()) {
                list.add(readFromResultSet(rs));
            }
        } catch (Exception e) { e.printStackTrace(); } 
        finally { if (rs != null) try { rs.getStatement().getConnection().close(); } catch(Exception ex) {} }
        return list;
    }

    public List<News> findLatestNews(int limit) {
        List<News> list = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM news WHERE status = 3 ORDER BY posted_date DESC";
        ResultSet rs = null;
        try {
            rs = XJdbc.query(sql, limit);
            while (rs.next()) {
                list.add(readFromResultSet(rs));
            }
        } catch (Exception e) { e.printStackTrace(); } 
        finally { if (rs != null) try { rs.getStatement().getConnection().close(); } catch(Exception ex) {} }
        return list;
    }

    public void updateViewCount(String id) {
        String sql = "UPDATE news SET view_count = view_count + 1 WHERE id=?";
        XJdbc.update(sql, id);
    }

    public void insert(News entity) {
        String sql = "INSERT INTO news (id, title, content, image, posted_date, author, view_count, category_id, home, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        XJdbc.update(sql, entity.getId(), entity.getTitle(), entity.getContent(), entity.getImage(), new java.sql.Timestamp(entity.getPostedDate().getTime()), entity.getAuthor(), entity.getViewCount(), entity.getCategoryId(), entity.isHome(), entity.getStatus());
    }

    public void update(News entity) {
        String sql = "UPDATE news SET title=?, content=?, image=?, category_id=?, home=?, status=? WHERE id=?";
        XJdbc.update(sql, entity.getTitle(), entity.getContent(), entity.getImage(), entity.getCategoryId(), entity.isHome(), entity.getStatus(), entity.getId());
    }

    public void delete(String id) {
        String sql = "DELETE FROM news WHERE id=?";
        XJdbc.update(sql, id);
    }
}
