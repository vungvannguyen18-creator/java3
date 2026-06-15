package com.abcnews.model;

public class Comment {
    private int id;
    private String userId;
    private String newsId;
    private String content;

    public Comment() {
    }

    public Comment(int id, String userId, String newsId, String content) {
        this.id = id;
        this.userId = userId;
        this.newsId = newsId;
        this.content = content;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
