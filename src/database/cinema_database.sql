-- 1. Tạo và sử dụng Database
CREATE DATABASE CinemaDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE CinemaDB;
-- 2. Bảng Limited_age (Độ tuổi giới hạn)
CREATE TABLE Limited_age (
    Limited_age_id VARCHAR(3) NOT NULL PRIMARY KEY,
    Context VARCHAR(50)
);
-- 3. Bảng Seats_type (Loại ghế: VIP, thường...)
CREATE TABLE Seats_type (
    type_id VARCHAR(8) NOT NULL PRIMARY KEY,
    seat_type VARCHAR(10),
    price DECIMAL(8, 2)
);
-- 4. Bảng Discount (Mã giảm giá)
CREATE TABLE Discount (
    Discount_id VARCHAR(8) NOT NULL PRIMARY KEY,
    Discount_name VARCHAR(50),
    Discount_rate DOUBLE,
    Description VARCHAR(255),
    Start_date DATE,
    End_date DATE
);
-- 5. Bảng Cities (Thành phố)
CREATE TABLE Cities (
    City_id INT NOT NULL PRIMARY KEY, -- Trong diagram không ghi rõ type, mình để INT cho chuẩn
    City_name VARCHAR(20)
);
-- 6. Bảng Foods (Đồ ăn)
CREATE TABLE Foods (
    food_id VARCHAR(8) NOT NULL PRIMARY KEY,
    name VARCHAR(20),
    type_name VARCHAR(20),
    price DECIMAL(8, 2)
);
-- 7. Bảng Users (Người dùng)
CREATE TABLE Users (
    User_id VARCHAR(8) NOT NULL PRIMARY KEY,
    Full_Name VARCHAR(50),
    birthday DATE,
    Email VARCHAR(30),
    Phone_number VARCHAR(10),
    Password VARCHAR(30),
    address VARCHAR(100),
    User_type_id VARCHAR(8), -- Lưu ý: Diagram có FK này nhưng không thấy bảng User_Type
    Discount_id VARCHAR(8),
    FOREIGN KEY (Discount_id) REFERENCES Discount(Discount_id) ON DELETE SET NULL
);
-- 8. Bảng Theaters (Rạp chiếu phim)
CREATE TABLE Theaters (
    cinema_id VARCHAR(8) NOT NULL PRIMARY KEY,
    Cinema_name VARCHAR(30),
    City_id INT,
    cinema_add VARCHAR(100),
    FOREIGN KEY (City_id) REFERENCES Cities(City_id) ON DELETE CASCADE
);
-- 9. Bảng Movies (Phim)
CREATE TABLE Movies (
    Movie_id VARCHAR(8) NOT NULL PRIMARY KEY,
    Movie_name VARCHAR(50),
    Type VARCHAR(10),
    duration INT,
    description TEXT,
    Year INT,
    Limited_age_id VARCHAR(3),
    director VARCHAR(100),
    Actors VARCHAR(255),
    cinema_id VARCHAR(8), -- Quan hệ: Phim thuộc rạp nào
    release_date DATE,
    end_date DATE,
    FOREIGN KEY (Limited_age_id) REFERENCES Limited_age(Limited_age_id),
    FOREIGN KEY (cinema_id) REFERENCES Theaters(cinema_id)
);
-- 10. Bảng Rooms (Phòng chiếu)
CREATE TABLE Rooms (
    Room_id VARCHAR(8) NOT NULL PRIMARY KEY,
    Room_num VARCHAR(8),
    cinema_id VARCHAR(8),
    FOREIGN KEY (cinema_id) REFERENCES Theaters(cinema_id) ON DELETE CASCADE
);
-- 11. Bảng Seats (Ghế ngồi)
CREATE TABLE Seats (
    Seat_id VARCHAR(8) NOT NULL PRIMARY KEY,
    Seat_row VARCHAR(3),
    Seat_num INT,
    status BOOLEAN, -- Diagram ghi boolean
    type_id VARCHAR(8),
    Room_id VARCHAR(8),
    FOREIGN KEY (type_id) REFERENCES Seats_type(type_id),
    FOREIGN KEY (Room_id) REFERENCES Rooms(Room_id) ON DELETE CASCADE
);
-- 12. Bảng Schedule (Lịch chiếu)
CREATE TABLE Schedule (
    Schedule_id VARCHAR(8) NOT NULL PRIMARY KEY,
    Movie_name VARCHAR(50), -- Diagram ghi Movie_name thay vì Movie_id
    Showdate DATE,
    StartTime TIME,
    EndTime TIME,
    Room_id VARCHAR(8),
    FOREIGN KEY (Room_id) REFERENCES Rooms(Room_id) ON DELETE CASCADE
);
-- 13. Bảng Orders (Đơn hàng)
CREATE TABLE Orders (
    order_id VARCHAR(8) NOT NULL PRIMARY KEY,
    movie_id VARCHAR(8),
    total_price DECIMAL(8, 2),
    Seat_id VARCHAR(8),
    user_id VARCHAR(8),
    FOREIGN KEY (movie_id) REFERENCES Movies(Movie_id),
    FOREIGN KEY (Seat_id) REFERENCES Seats(Seat_id),
    FOREIGN KEY (user_id) REFERENCES Users(User_id)
);


