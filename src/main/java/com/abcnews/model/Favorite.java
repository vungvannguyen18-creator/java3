package com.abcnews.model;

public class Favorite {
    private int id;
    private int userId;
    private int newsId;

    public Favorite() {
    }

    public Favorite(int id, int userId, int newsId) {
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

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getNewsId() {
        return newsId;
    }

    public void setNewsId(int newsId) {
        this.newsId = newsId;
    }
}
