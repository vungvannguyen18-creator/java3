package com.abcnews.dao;

import com.abcnews.model.Comment;
import com.abcnews.util.XJdbc;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class InteractiveDAO {

    // [NGƯỜI DÙNG] Thêm vào yêu thích
    public void addFavorite(int userId, int newsId) {
        String sql = "INSERT INTO favorites (user_id, news_id) VALUES (?, ?)";
        try {
            XJdbc.update(sql, userId, newsId);
        } catch(Exception e) {
            // Có thể bị lỗi do trùng lặp (UNIQUE) nên ta có thể bỏ qua hoặc xử lý
            e.printStackTrace();
        }
    }

    // [NGƯỜI DÙNG] Bỏ yêu thích
    public void removeFavorite(int userId, int newsId) {
        String sql = "DELETE FROM favorites WHERE user_id = ? AND news_id = ?";
        XJdbc.update(sql, userId, newsId);
    }

    // [NGƯỜI DÙNG] Thêm bình luận
    public void addComment(int userId, int newsId, String content) {
        String sql = "INSERT INTO comments (user_id, news_id, content, status) VALUES (?, ?, ?, 1)";
        XJdbc.update(sql, userId, newsId, content);
    }

    // Lấy danh sách bình luận của 1 bài viết
    public List<Comment> getCommentsByNewsId(int newsId) {
        List<Comment> list = new ArrayList<>();
        String sql = "SELECT * FROM comments WHERE news_id = ? AND status = 1 ORDER BY id DESC";
        ResultSet rs = null;
        try {
            rs = XJdbc.query(sql, newsId);
            while (rs.next()) {
                list.add(new Comment(
                    rs.getInt("id"), rs.getInt("user_id"), rs.getInt("news_id"),
                    rs.getString("content"), rs.getBoolean("status")
                ));
            }
        } catch (Exception e) { 
            e.printStackTrace(); 
        } finally {
            if (rs != null) try { rs.getStatement().getConnection().close(); } catch(Exception ex) {}
        }
        return list;
    }
}
