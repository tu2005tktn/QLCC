/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/SQLTemplate.sql to edit this template
 */
/**
 * Author:  tungu
 * Created: Mar 21, 2025
 */

CREATE DATABASE QLCC;
GO
USE QLCC;
GO

-- Bảng Roles (Vai trò người dùng)
CREATE TABLE Roles (
    role_id INT PRIMARY KEY IDENTITY,
    role_name NVARCHAR(50) NOT NULL
);

-- Bảng Users (Người dùng)
CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    full_name NVARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    role_id INT FOREIGN KEY REFERENCES Roles(role_id),
    status BIT DEFAULT 1
);

-- Bảng Apartments (Căn hộ)
CREATE TABLE Apartments (
    apartment_id INT PRIMARY KEY IDENTITY,
    apartment_number VARCHAR(20) UNIQUE NOT NULL,
    floor_number INT NOT NULL,
    area FLOAT NOT NULL,
    status NVARCHAR(50) DEFAULT N'Đang sử dụng'
);

-- Bảng ApartmentOwners (Chủ căn hộ)
CREATE TABLE ApartmentOwners (
    owner_id INT PRIMARY KEY IDENTITY,
    user_id INT FOREIGN KEY REFERENCES Users(user_id),
    apartment_id INT FOREIGN KEY REFERENCES Apartments(apartment_id),
    ownership_date DATE NOT NULL
);

-- Bảng Tenants (Người thuê/đại diện thuê)
CREATE TABLE Tenants (
    tenant_id INT PRIMARY KEY IDENTITY,
    user_id INT FOREIGN KEY REFERENCES Users(user_id),
    apartment_id INT FOREIGN KEY REFERENCES Apartments(apartment_id),
    rental_start_date DATE NOT NULL,
    rental_end_date DATE,
    is_representative BIT DEFAULT 1
);

-- Bảng Residents (Người cư trú)
CREATE TABLE Residents (
    resident_id INT PRIMARY KEY IDENTITY,
    apartment_id INT FOREIGN KEY REFERENCES Apartments(apartment_id),
    full_name NVARCHAR(100) NOT NULL,
    dob DATE,
    gender NVARCHAR(10),
    id_card VARCHAR(20),
    relationship NVARCHAR(50),
    phone VARCHAR(20)
);

-- Bảng ServiceTypes (Loại dịch vụ)
CREATE TABLE ServiceTypes (
    service_type_id INT PRIMARY KEY IDENTITY,
    type_name NVARCHAR(100) NOT NULL,
    description NVARCHAR(255)
);

-- Bảng ServiceFees (Phí dịch vụ)
CREATE TABLE ServiceFees (
    fee_id INT PRIMARY KEY IDENTITY,
    apartment_id INT FOREIGN KEY REFERENCES Apartments(apartment_id),
    service_type_id INT FOREIGN KEY REFERENCES ServiceTypes(service_type_id),
    month INT NOT NULL,
    year INT NOT NULL,
    amount DECIMAL(18,2) NOT NULL,
    status NVARCHAR(50) DEFAULT N'Chưa thanh toán',
    issue_date DATE NOT NULL,
    payment_date DATE,
    details NVARCHAR(MAX)
);

-- Bảng RequestTypes (Loại yêu cầu)
CREATE TABLE RequestTypes (
    request_type_id INT PRIMARY KEY IDENTITY,
    type_name NVARCHAR(100) NOT NULL,
    description NVARCHAR(255)
);

-- Bảng Requests (Yêu cầu)
CREATE TABLE Requests (
    request_id INT PRIMARY KEY IDENTITY,
    apartment_id INT FOREIGN KEY REFERENCES Apartments(apartment_id),
    requester_id INT FOREIGN KEY REFERENCES Users(user_id),
    request_type_id INT FOREIGN KEY REFERENCES RequestTypes(request_type_id),
    title NVARCHAR(200) NOT NULL,
    description NVARCHAR(MAX),
    request_date DATETIME NOT NULL,
    status NVARCHAR(50) DEFAULT N'Đang chờ xử lý',
    priority NVARCHAR(20) DEFAULT N'Bình thường'
);

-- Bảng RequestAssignments (Phân công xử lý yêu cầu)
CREATE TABLE RequestAssignments (
    assignment_id INT PRIMARY KEY IDENTITY,
    request_id INT FOREIGN KEY REFERENCES Requests(request_id),
    staff_id INT FOREIGN KEY REFERENCES Users(user_id),
    assigned_by INT FOREIGN KEY REFERENCES Users(user_id),
    assigned_date DATETIME NOT NULL,
    deadline DATETIME,
    notes NVARCHAR(MAX)
);

-- Bảng RequestProgress (Tiến độ xử lý yêu cầu)
CREATE TABLE RequestProgress (
    progress_id INT PRIMARY KEY IDENTITY,
    request_id INT FOREIGN KEY REFERENCES Requests(request_id),
    status NVARCHAR(50) NOT NULL,
    update_date DATETIME NOT NULL,
    updated_by INT FOREIGN KEY REFERENCES Users(user_id),
    notes NVARCHAR(MAX)
);

-- Bảng MovingRegistrations (Đăng ký chuyển đồ)
CREATE TABLE MovingRegistrations (
    moving_id INT PRIMARY KEY IDENTITY,
    apartment_id INT FOREIGN KEY REFERENCES Apartments(apartment_id),
    requester_id INT FOREIGN KEY REFERENCES Users(user_id),
    moving_type NVARCHAR(20) NOT NULL, -- Vào/Ra
    moving_date DATE NOT NULL,
    moving_time_start TIME NOT NULL,
    moving_time_end TIME NOT NULL,
    items_description NVARCHAR(MAX),
    status NVARCHAR(50) DEFAULT N'Đang chờ phê duyệt',
    approval_date DATETIME,
    approved_by INT FOREIGN KEY REFERENCES Users(user_id)
);

-- Bảng ParkingRegistrations (Đăng ký gửi xe)
CREATE TABLE ParkingRegistrations (
    parking_id INT PRIMARY KEY IDENTITY,
    apartment_id INT FOREIGN KEY REFERENCES Apartments(apartment_id),
    requester_id INT FOREIGN KEY REFERENCES Users(user_id),
    vehicle_type NVARCHAR(50) NOT NULL,
    license_plate VARCHAR(20) NOT NULL,
    vehicle_brand NVARCHAR(50),
    vehicle_model NVARCHAR(50),
    vehicle_color NVARCHAR(30),
    registration_date DATE NOT NULL,
    status NVARCHAR(50) DEFAULT N'Đang hoạt động',
    monthly_fee DECIMAL(18,2) NOT NULL
);

-- Chèn dữ liệu mẫu vào bảng Roles
INSERT INTO Roles (role_name) VALUES 
(N'ADMIN'),
(N'MANAGER'),
(N'STAFF'),
(N'OWNER'),
(N'TENANT');

-- Chèn dữ liệu mẫu vào bảng Users
INSERT INTO Users (username, password, email, full_name, phone, role_id, status) VALUES
('admin', '123456', 'admin@qlcc.com', N'Quản trị viên', '0901234567', 1, 1),
('manager', '123456', 'manager@qlcc.com', N'Quản lý chung cư', '0901234568', 2, 1),
('staff1', '123456', 'staff1@qlcc.com', N'Nhân viên kỹ thuật', '0901234569', 3, 1),
('staff2', '123456', 'staff2@qlcc.com', N'Nhân viên lễ tân', '0901234570', 3, 1),
('owner1', '123456', 'owner1@gmail.com', N'Nguyễn Văn A', '0901234571', 4, 1),
('owner2', '123456', 'owner2@gmail.com', N'Trần Thị B', '0901234572', 4, 1),
('tenant1', '123456', 'tenant1@gmail.com', N'Lê Văn C', '0901234573', 5, 1),
('tenant2', '123456', 'tenant2@gmail.com', N'Phạm Thị D', '0901234574', 5, 1);

-- Chèn dữ liệu mẫu vào bảng Apartments
INSERT INTO Apartments (apartment_number, floor_number, area, status) VALUES
('A101', 1, 75.5, N'Đang sử dụng'),
('A102', 1, 85.0, N'Đang sử dụng'),
('A201', 2, 75.5, N'Đang sử dụng'),
('A202', 2, 85.0, N'Đang sử dụng'),
('B101', 1, 95.0, N'Đang sử dụng'),
('B102', 1, 100.0, N'Đang sử dụng');

-- Chèn dữ liệu mẫu vào bảng ApartmentOwners
INSERT INTO ApartmentOwners (user_id, apartment_id, ownership_date) VALUES
(5, 1, '2023-01-15'),
(6, 2, '2023-02-20');

-- Chèn dữ liệu mẫu vào bảng Tenants
INSERT INTO Tenants (user_id, apartment_id, rental_start_date, rental_end_date, is_representative) VALUES
(7, 3, '2023-03-10', '2024-03-10', 1),
(8, 4, '2023-04-05', '2024-04-05', 1);

-- Chèn dữ liệu mẫu vào bảng Residents
INSERT INTO Residents (apartment_id, full_name, dob, gender, id_card, relationship, phone) VALUES
(1, N'Nguyễn Văn A', '1980-05-15', N'Nam', '001080123456', N'Chủ hộ', '0901234571'),
(1, N'Nguyễn Thị A1', '1985-06-20', N'Nữ', '001085123457', N'Vợ', '0901234575'),
(1, N'Nguyễn Văn A2', '2010-07-25', N'Nam', NULL, N'Con', NULL),
(2, N'Trần Thị B', '1982-08-10', N'Nữ', '001082123458', N'Chủ hộ', '0901234572'),
(2, N'Trần Văn B1', '1979-09-15', N'Nam', '001079123459', N'Chồng', '0901234576');

-- Chèn dữ liệu mẫu vào bảng ServiceTypes
INSERT INTO ServiceTypes (type_name, description) VALUES
(N'Phí quản lý', N'Phí quản lý chung cư hàng tháng'),
(N'Phí nước', N'Phí sử dụng nước sinh hoạt'),
(N'Phí gửi xe', N'Phí gửi xe ô tô/xe máy'),
(N'Phí điện', N'Phí sử dụng điện cho các khu vực công cộng');

-- Chèn dữ liệu mẫu vào bảng RequestTypes
INSERT INTO RequestTypes (type_name, description) VALUES
(N'Sửa chữa', N'Yêu cầu sửa chữa kỹ thuật trong căn hộ'),
(N'Phản ánh', N'Phản ánh về dịch vụ, tiện ích'),
(N'Chuyển đồ', N'Đăng ký chuyển đồ vào/ra căn hộ'),
(N'Đăng ký gửi xe', N'Đăng ký gửi xe ô tô/xe máy');