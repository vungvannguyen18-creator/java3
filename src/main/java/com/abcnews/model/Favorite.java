package com.abcnews.model;

public class Favorite {
    private int id;
    private String userId;
    private String newsId;

    public Favorite() {
    }

    public Favorite(int id, String userId, String newsId) {
        this.id = id;
        this.userId = userId;
        this.newsId = newsId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getNewsId() {
        return newsId;
    }

    public void setNewsId(String newsId) {
        this.newsId = newsId;
    }
}
