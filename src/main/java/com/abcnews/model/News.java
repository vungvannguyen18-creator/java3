package com.abcnews.model;

import java.util.Date;

public class News {
    private String id;
    private String title;
    private String content;
    private String image;
    private Date postedDate;
    private String author;
    private int viewCount;
    private String categoryId;
    private boolean home;
    private int status;

    public News() {}

    public News(String id, String title, String content, String image, Date postedDate, String author, int viewCount, String categoryId, boolean home, int status) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.image = image;
        this.postedDate = postedDate;
        this.author = author;
        this.viewCount = viewCount;
        this.categoryId = categoryId;
        this.home = home;
        this.status = status;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public Date getPostedDate() { return postedDate; }
    public void setPostedDate(Date postedDate) { this.postedDate = postedDate; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public int getViewCount() { return viewCount; }
    public void setViewCount(int viewCount) { this.viewCount = viewCount; }

    public String getCategoryId() { return categoryId; }
    public void setCategoryId(String categoryId) { this.categoryId = categoryId; }

    public boolean isHome() { return home; }
    public void setHome(boolean home) { this.home = home; }

    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }

    public String getSummary() {
        if (content == null) return "";
        String text = content.replaceAll("<[^>]*>", "").replaceAll("&nbsp;", " ");
        if (text.length() > 120) {
            return text.substring(0, 120) + "...";
        }
        return text;
    }
}
