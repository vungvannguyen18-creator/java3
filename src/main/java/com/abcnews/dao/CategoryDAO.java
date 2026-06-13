package com.abcnews.dao;

import com.abcnews.model.Category;
import com.abcnews.util.XJdbc;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    public List<Category> findAll() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM categories";
        ResultSet rs = null;
        try {
            rs = XJdbc.query(sql);
            while (rs.next()) {
                list.add(new Category(rs.getString("id"), rs.getString("name")));
            }
        } catch (Exception e) { e.printStackTrace(); } 
        finally { if (rs != null) try { rs.getStatement().getConnection().close(); } catch(Exception ex) {} }
        return list;
    }

    public Category findById(String id) {
        String sql = "SELECT * FROM categories WHERE id = ?";
        ResultSet rs = null;
        try {
            rs = XJdbc.query(sql, id);
            if (rs.next()) {
                return new Category(rs.getString("id"), rs.getString("name"));
            }
        } catch (Exception e) { e.printStackTrace(); } 
        finally { if (rs != null) try { rs.getStatement().getConnection().close(); } catch(Exception ex) {} }
        return null;
    }

    public void insert(Category entity) {
        String sql = "INSERT INTO categories (id, name) VALUES (?, ?)";
        XJdbc.update(sql, entity.getId(), entity.getName());
    }

    public void update(Category entity) {
        String sql = "UPDATE categories SET name=? WHERE id=?";
        XJdbc.update(sql, entity.getName(), entity.getId());
    }

    public void delete(String id) {
        String sql = "DELETE FROM categories WHERE id=?";
        XJdbc.update(sql, id);
    }
}
