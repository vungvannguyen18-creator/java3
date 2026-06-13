package com.abcnews.model;

public class Comment {
    private int id;
    private int userId;
    private int newsId;
    private String content;
    private boolean status;

    public Comment() {
    }

    public Comment(int id, int userId, int newsId, String content, boolean status) {
        this.id = id;
        this.userId = userId;
        this.newsId = newsId;
        this.content = content;
        this.status = status;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}
