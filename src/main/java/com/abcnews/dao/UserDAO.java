package com.abcnews.dao;

import com.abcnews.model.User;
import com.abcnews.util.XJdbc;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    private User readFromResultSet(ResultSet rs) throws Exception {
        return new User(
            rs.getString("id"), rs.getString("password"), rs.getString("fullname"),
            rs.getDate("birthday"), rs.getBoolean("gender"),
            rs.getString("mobile"), rs.getString("email"), rs.getInt("role")
        );
    }

    public List<User> findAll() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users";
        ResultSet rs = null;
        try {
            rs = XJdbc.query(sql);
            while (rs.next()) {
                list.add(readFromResultSet(rs));
            }
        } catch (Exception e) { 
            e.printStackTrace(); 
        } finally {
            if (rs != null) try { rs.getStatement().getConnection().close(); } catch(Exception ex) {}
        }
        return list;
    }

    public User login(String id, String password) {
        String sql = "SELECT * FROM users WHERE id = ? AND password = ?";
        ResultSet rs = null;
        try {
            rs = XJdbc.query(sql, id, password);
            if (rs.next()) {
                return readFromResultSet(rs);
            }
        } catch (Exception e) { 
            e.printStackTrace(); 
        } finally {
            if (rs != null) try { rs.getStatement().getConnection().close(); } catch(Exception ex) {}
        }
        return null;
    }

    public User loginByEmail(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        ResultSet rs = null;
        try {
            rs = XJdbc.query(sql, email, password);
            if (rs.next()) {
                return readFromResultSet(rs);
            }
        } catch (Exception e) { 
            e.printStackTrace(); 
        } finally {
            if (rs != null) try { rs.getStatement().getConnection().close(); } catch(Exception ex) {}
        }
        return null;
    }

    public User findById(String id) {
        String sql = "SELECT * FROM users WHERE id = ?";
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

    public User findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        ResultSet rs = null;
        try {
            rs = XJdbc.query(sql, email);
            if (rs.next()) {
                return readFromResultSet(rs);
            }
        } catch (Exception e) { e.printStackTrace(); } 
        finally { if (rs != null) try { rs.getStatement().getConnection().close(); } catch(Exception ex) {} }
        return null;
    }

    public void insert(User entity) {
        String sql = "INSERT INTO users (id, password, fullname, birthday, gender, mobile, email, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        XJdbc.update(sql, 
            entity.getId(), entity.getPassword(), entity.getFullname(), 
            new java.sql.Date(entity.getBirthday().getTime()), entity.isGender(), entity.getMobile(), entity.getEmail(), entity.getRole());
    }

    public void update(User entity) {
        String sql = "UPDATE users SET password=?, fullname=?, birthday=?, gender=?, mobile=?, email=?, role=? WHERE id=?";
        XJdbc.update(sql, 
            entity.getPassword(), entity.getFullname(), 
            new java.sql.Date(entity.getBirthday().getTime()), entity.isGender(), entity.getMobile(), entity.getEmail(), entity.getRole(), entity.getId());
    }

    public void delete(String id) {
        String sql = "DELETE FROM users WHERE id=?";
        XJdbc.update(sql, id);
    }
}
