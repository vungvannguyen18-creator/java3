package com.abcnews.dao;

import com.abcnews.model.Newsletter;
import com.abcnews.util.XJdbc;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class NewsletterDAO {

    public List<Newsletter> findAll() {
        List<Newsletter> list = new ArrayList<>();
        String sql = "SELECT * FROM newsletters";
        ResultSet rs = null;
        try {
            rs = XJdbc.query(sql);
            while (rs.next()) {
                list.add(new Newsletter(
                    rs.getString("email"), rs.getBoolean("enabled")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.getStatement().getConnection().close(); } catch(Exception ex) {}
        }
        return list;
    }

    public void insert(Newsletter entity) {
        String sql = "INSERT INTO newsletters (email, enabled) VALUES (?, ?)";
        XJdbc.update(sql, entity.getEmail(), entity.isEnabled());
    }

    public void update(Newsletter entity) {
        String sql = "UPDATE newsletters SET enabled=? WHERE email=?";
        XJdbc.update(sql, entity.isEnabled(), entity.getEmail());
    }

    public void delete(String email) {
        String sql = "DELETE FROM newsletters WHERE email=?";
        XJdbc.update(sql, email);
    }
}
