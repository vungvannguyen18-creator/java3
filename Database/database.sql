-- Tạo database nếu chưa tồn tại
IF DB_ID('ABCNews') IS NULL
BEGIN
    EXEC('CREATE DATABASE ABCNews');
END
GO

USE ABCNews;
GO

-- Xóa các bảng cũ đi trước (xóa theo thứ tự để không bị lỗi khóa ngoại)
IF OBJECT_ID('dbo.comments', 'U') IS NOT NULL DROP TABLE dbo.comments;
IF OBJECT_ID('dbo.favorites', 'U') IS NOT NULL DROP TABLE dbo.favorites;
IF OBJECT_ID('dbo.news', 'U') IS NOT NULL DROP TABLE dbo.news;
IF OBJECT_ID('dbo.newsletters', 'U') IS NOT NULL DROP TABLE dbo.newsletters;
IF OBJECT_ID('dbo.categories', 'U') IS NOT NULL DROP TABLE dbo.categories;
IF OBJECT_ID('dbo.users', 'U') IS NOT NULL DROP TABLE dbo.users;
GO

-- 1. Bảng người dùng
CREATE TABLE dbo.users (
    id VARCHAR(50) PRIMARY KEY,
    password VARCHAR(255),
    fullname NVARCHAR(100),
    birthday DATE,
    gender BIT,
    mobile VARCHAR(20),
    email VARCHAR(100),
    role INT -- 0: Người dùng (User), 1: Phóng viên (Writer), 2: Quản trị (Admin)
);
GO

-- 2. Bảng loại tin
CREATE TABLE dbo.categories (
    id VARCHAR(50) PRIMARY KEY,
    name NVARCHAR(100)
);
GO

-- 3. Bảng tin tức
CREATE TABLE dbo.news (
    id VARCHAR(50) PRIMARY KEY,
    title NVARCHAR(255),
    content NVARCHAR(MAX),
    image NVARCHAR(255),
    posted_date DATETIME DEFAULT GETDATE(),
    author VARCHAR(50) FOREIGN KEY REFERENCES dbo.users(id),
    view_count INT DEFAULT 0,
    category_id VARCHAR(50) FOREIGN KEY REFERENCES dbo.categories(id),
    home BIT DEFAULT 0, -- true: trang nhất
    status INT DEFAULT 0 -- 0: Chờ duyệt, 1: Đã duyệt (Public), 2: Từ chối
);
GO

-- 4. Bảng Đăng ký nhận tin
CREATE TABLE dbo.newsletters (
    email VARCHAR(100) PRIMARY KEY,
    enabled BIT DEFAULT 1
);
GO

-- 5. Bảng Yêu thích (Favorites)
CREATE TABLE dbo.favorites (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id VARCHAR(50) FOREIGN KEY REFERENCES dbo.users(id),
    news_id VARCHAR(50) FOREIGN KEY REFERENCES dbo.news(id),
    CONSTRAINT UQ_favorites_user_news UNIQUE (user_id, news_id)
);
GO

-- 6. Bảng Bình luận (Comments)
CREATE TABLE dbo.comments (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id VARCHAR(50) FOREIGN KEY REFERENCES dbo.users(id),
    news_id VARCHAR(50) FOREIGN KEY REFERENCES dbo.news(id),
    content NVARCHAR(1000),
    posted_date DATETIME DEFAULT GETDATE()
);
GO

-- Insert sample data
INSERT INTO dbo.users (id, password, fullname, birthday, gender, mobile, email, role)
VALUES 
('admin01', '123456', N'Quản Trị Viên', '1990-01-01', 1, '0123456789', 'admin@abc.com', 2),
('writer01', '123456', N'Phóng Viên Số 1', '1995-05-05', 0, '0987654321', 'writer1@abc.com', 1),
('user01', '123456', N'Độc Giả 1', '2000-10-10', 1, '0111222333', 'user1@abc.com', 0);
GO

select * from dbo.users;


INSERT INTO dbo.categories (id, name)
VALUES 
('CAT01', N'Thời sự'),
('CAT02', N'Thể thao'),
('CAT03', N'Kinh doanh'),
('CAT04', N'Giải trí'),
('CAT05', N'Công nghệ');
GO

-- Xóa dữ liệu cũ nếu có
DELETE FROM dbo.news;

-- Thêm dữ liệu bài báo mẫu (Toàn bộ status = 3 để hiển thị ra trang độc giả)
INSERT INTO dbo.news (id, title, content, image, posted_date, author, view_count, category_id, home, status)
VALUES
-- Bài số 1
('N01', N'Lễ hội công nghệ toàn cầu năm 2026 chính thức khai mạc', N'Hàng ngàn tín đồ công nghệ đã đổ về sự kiện...', 'https://images.unsplash.com/photo-1518770660439-4636190af475?w=800&q=80', '2026-06-10 08:00:00', 'admin01', 9500, 'CAT05', 1, 3),

-- Bài số 2
('N02', N'Đội tuyển Việt Nam lọt vào vòng chung kết World Cup', N'Một kỳ tích lịch sử đã được viết nên...', 'https://images.unsplash.com/photo-1579952363873-27f3bade9f55?w=800&q=80', '2026-06-09 20:30:00', 'writer01', 12500, 'CAT02', 1, 3),

-- Bài số 3
('N03', N'Thị trường chứng khoán bùng nổ, VN-Index vượt đỉnh 1500 điểm', N'Sắc xanh ngập tràn thị trường...', 'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80', '2026-06-08 14:15:00', 'admin01', 4200, 'CAT03', 1, 3),

-- Bài số 4
('N04', N'Top 5 bộ phim chiếu rạp đáng xem nhất tuần này', N'Cùng điểm mặt gọi tên những bom tấn...', 'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=800&q=80', '2026-06-07 10:00:00', 'writer01', 8900, 'CAT04', 0, 3),

-- Bài số 5
('N05', N'Phát hiện mới về hố đen vũ trụ khiến giới khoa học sửng sốt', N'NASA vừa công bố những hình ảnh sắc nét nhất...', 'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=800&q=80', '2026-06-06 09:45:00', 'admin01', 6700, 'CAT01', 1, 3),

-- Bài số 6
('N06', N'Trí tuệ nhân tạo (AI) sẽ thay thế 30% công việc văn phòng?', N'Đây là bài toán đang được rất nhiều chuyên gia tranh luận...', 'https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800&q=80', '2026-06-05 11:20:00', 'writer01', 15600, 'CAT05', 1, 3),

-- Bài số 7 (Bài nháp, không hiện lên trang độc giả)
('N07', N'Giá vàng trong nước biến động nhẹ', N'Nội dung đang viết dở...', 'https://images.unsplash.com/photo-1601597111158-2fceff292cdc?w=800&q=80', GETDATE(), 'writer01', 0, 'CAT03', 0, 0);
GO

