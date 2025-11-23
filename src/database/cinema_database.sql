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
    City_id INT NOT NULL PRIMARY KEY, 
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
    User_type_id VARCHAR(8), 
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
--insert data 
--insert table Cities
insert into Cities (City_id , City_name) values
    (65,'Cần Thơ'),
    (50,'Hồ Chí Minh'),
    (14,'Quảng Ninh'),
    (69,'Cà Mau'),
    (43,'Đà Nẵng'),
    (94,'Bạc Liêu');
--insert table Limited_age
INSERT INTO Limited_age (Limited_age_id, Context) VALUES 
('P',   'Mọi lứa tuổi'),
('T13', 'Cấm khán giả dưới 13 tuổi'),
('T16', 'Cấm khán giả dưới 16 tuổi'),
('T18', 'Cấm khán giả dưới 18 tuổi');
--insert table seat_type
INSERT INTO Seats_type (type_id, seat_type, price) VALUES 
('NOR', 'Thường', 55000),
('VIP', 'VIP',    90000),
('SWT', 'Sweetbox', 120000);
--insert table food
INSERT INTO Foods (food_id, name, type_name, price) VALUES 
('F001', 'Bắp Ngọt',   'Bắp',  45000),
('F002', 'Bắp Phô Mai', 'Bắp', 55000),
('D001', 'Coca Cola',   'Nước', 30000),
('D002', 'Dasani',      'Nước', 20000);
--insert table discount 
INSERT INTO Discount (Discount_id, Discount_name, Discount_rate, Description, Start_date, End_date) VALUES 
('DIS01', 'Chào bạn mới', 0.10, 'Giảm 10% cho thành viên mới', '2024-01-01', '2025-12-31'),
('DIS02', 'Mùa hè sôi động', 0.20, 'Giảm 20% vé phim', '2024-06-01', '2024-08-31');
--insert table users
INSERT INTO Users (User_id, Full_Name, birthday, Email, Phone_number, Password, address, User_type_id, Discount_id) VALUES 
('U001', 'Nguyễn Bảo Toàn', '2005-02-08', 'baotoan08020802@gmail.com', '0909123456', '123456', 'Q1, TP.HCM', 'CUST01', NULL),
('U002', 'Bùi Dương Quốc Khánh', '2005-10-30', 'khanhb2306669@student.ctu.edu.vn',  '0987654321', '123456', 'Ninh Kiều, Cần Thơ', 'CUST', 'DIS01');
--insert table theaters
INSERT INTO Theaters (cinema_id, Cinema_name, City_id, cinema_add) VALUES 
('CIN01', 'CGV Aeon Hồ Chí Minh', 50, 'Số 1 Đường 17A, Bình Tân, TP.HCM'),
('CIN02', 'Lotte Ninh Kiều',65, '84 Mậu Thân, An Hòa, Cần Thơ');
--insert table rooms
INSERT INTO Rooms (Room_id, Room_num, cinema_id) VALUES 
('R001', 'Room 01', 'CIN01'),
('R002', 'Room 02', 'CIN01'),
('R003', 'Room 01', 'CIN02');
--insert table movies
INSERT INTO Movies (Movie_id, Movie_name, Type, duration, description, Year, Limited_age_id, director, Actors, cinema_id, release_date, end_date) VALUES 
('M001', 'Mai', 'Tình Cảm', 131, 'Phim về cuộc đời cô Mai', 2024, 'T18', 'Trấn Thành', 'Phương Anh Đào, Tuấn Trần', 'CIN01', '2024-02-10', '2024-04-10'),
('M002', 'Dune: Part Two', 'Hành Động', 166, 'Hành trình của Paul Atreides', 2024, 'T16', 'Denis Villeneuve', 'Timothée Chalamet, Zendaya', 'CIN01', '2024-03-01', '2024-05-01'),
('M003', 'Kung Fu Panda 4', 'Hoạt Hình', 94, 'Gấu Po đi tu hành', 2024, 'P', 'Mike Mitchell', 'Jack Black', 'CIN02', '2024-03-08', '2024-05-08');
--insert table schedule
INSERT INTO Schedule (Schedule_id, Movie_name, Showdate, StartTime, EndTime, Room_id) VALUES 
('SCH01', 'Mai', '2024-05-01', '19:00:00', '21:15:00', 'R001'),
('SCH02', 'Dune: Part Two', '2024-05-01', '20:00:00', '23:00:00', 'R002'),
('SCH03', 'Mai', '2024-05-02', '10:00:00', '12:15:00', 'R001');
--insert table seat
INSERT INTO Seats (Seat_id, Seat_row, Seat_num, status, type_id, Room_id) VALUES 
('S001', 'A', 1, 0, 'NOR', 'R001'),
('S002', 'A', 2, 0, 'NOR', 'R001'),
('S003', 'A', 3, 0, 'VIP', 'R001'),
('S004', 'A', 4, 0, 'VIP', 'R001'),
('S005', 'A', 5, 0, 'SWT', 'R001');
--insert table orders
INSERT INTO Orders (order_id, movie_id, total_price, Seat_id, user_id) VALUES 
('ORD01', 'M001', 90000, 'S003', 'U002');
select * from foods;