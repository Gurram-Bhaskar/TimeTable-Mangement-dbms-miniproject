-- Timetable Management System Database Setup for PythonAnywhere
-- DO NOT include DROP DATABASE or CREATE DATABASE commands
-- Database is already created on PythonAnywhere

-- Table 1: Faculty
CREATE TABLE Faculty (
    faculty_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    designation VARCHAR(50),
    dept VARCHAR(50)
);

-- Table 2: Subjects
CREATE TABLE Subjects (
    sub_code VARCHAR(10) PRIMARY KEY,
    sub_name VARCHAR(100) NOT NULL,
    sub_type ENUM('Theory', 'Lab') NOT NULL
);

-- Table 3: Rooms
CREATE TABLE Rooms (
    room_no VARCHAR(10) PRIMARY KEY,
    capacity INT NOT NULL,
    room_type VARCHAR(30)
);

-- Table 4: Batches
CREATE TABLE Batches (
    batch_id VARCHAR(10) PRIMARY KEY,
    semester INT NOT NULL,
    dept VARCHAR(50)
);

-- Table 5: Time_Slots
CREATE TABLE Time_Slots (
    slot_id INT PRIMARY KEY AUTO_INCREMENT,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL
);

-- Table 6: Schedule
CREATE TABLE Schedule (
    alloc_id INT PRIMARY KEY AUTO_INCREMENT,
    day VARCHAR(10) NOT NULL,
    slot_id INT NOT NULL,
    faculty_id VARCHAR(10) NOT NULL,
    sub_code VARCHAR(10) NOT NULL,
    room_no VARCHAR(10) NOT NULL,
    batch_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (slot_id) REFERENCES Time_Slots(slot_id) ON DELETE CASCADE,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id) ON DELETE CASCADE,
    FOREIGN KEY (sub_code) REFERENCES Subjects(sub_code) ON DELETE CASCADE,
    FOREIGN KEY (room_no) REFERENCES Rooms(room_no) ON DELETE CASCADE,
    FOREIGN KEY (batch_id) REFERENCES Batches(batch_id) ON DELETE CASCADE
);

-- ========================================
-- INSERT DUMMY DATA
-- ========================================

-- Insert Faculty Data (10 rows)
INSERT INTO Faculty (faculty_id, name, designation, dept) VALUES
('F001', 'Dr. Rajesh Kumar', 'Professor', 'Computer Science'),
('F002', 'Dr. Priya Sharma', 'Associate Professor', 'Computer Science'),
('F003', 'Mr. Amit Verma', 'Assistant Professor', 'Information Science'),
('F004', 'Ms. Sneha Patel', 'Assistant Professor', 'Computer Science'),
('F005', 'Dr. Mohan Das', 'Professor', 'Information Science'),
('F006', 'Dr. Anita Roy', 'Professor', 'Computer Science'),
('F007', 'Mr. Suresh Reddy', 'Assistant Professor', 'Computer Science'),
('F008', 'Ms. Kavita Singh', 'Associate Professor', 'Information Science'),
('F009', 'Dr. Vikram Gupta', 'Professor', 'Computer Science'),
('F010', 'Ms. Deepa Menon', 'Assistant Professor', 'Information Science');

-- Insert Subjects Data (10 rows)
INSERT INTO Subjects (sub_code, sub_name, sub_type) VALUES
('CS301', 'Database Management Systems', 'Theory'),
('CS302', 'DBMS Lab', 'Lab'),
('CS303', 'Operating Systems', 'Theory'),
('CS304', 'Computer Networks', 'Theory'),
('CS305', 'Web Technologies', 'Lab'),
('CS306', 'Software Engineering', 'Theory'),
('CS307', 'Data Structures', 'Theory'),
('CS308', 'Python Programming', 'Lab'),
('CS309', 'Computer Architecture', 'Theory'),
('CS310', 'Machine Learning', 'Theory');

-- Insert Rooms Data (8 rows)
INSERT INTO Rooms (room_no, capacity, room_type) VALUES
('R101', 60, 'Lecture Hall'),
('R102', 60, 'Lecture Hall'),
('R103', 80, 'Seminar Hall'),
('R104', 60, 'Lecture Hall'),
('L201', 30, 'Computer Lab'),
('L202', 30, 'Computer Lab'),
('L203', 30, 'Computer Lab'),
('L204', 40, 'Advanced Lab');

-- Insert Batches Data (5 rows)
INSERT INTO Batches (batch_id, semester, dept) VALUES
('CSE-3A', 3, 'Computer Science'),
('CSE-3B', 3, 'Computer Science'),
('ISE-3A', 3, 'Information Science'),
('CSE-5A', 5, 'Computer Science'),
('ISE-5A', 5, 'Information Science');

-- Insert Time_Slots Data (8 rows)
INSERT INTO Time_Slots (start_time, end_time) VALUES
('09:00:00', '10:00:00'),
('10:00:00', '11:00:00'),
('11:15:00', '12:15:00'),
('12:15:00', '13:15:00'),
('14:00:00', '15:00:00'),
('15:00:00', '16:00:00'),
('16:15:00', '17:15:00'),
('17:15:00', '18:15:00');

-- Insert Complete Schedule Data for CSE-3A (Full Week Timetable)
-- Monday Schedule for CSE-3A
INSERT INTO Schedule (day, slot_id, faculty_id, sub_code, room_no, batch_id) VALUES
('Monday', 1, 'F001', 'CS301', 'R101', 'CSE-3A'),
('Monday', 2, 'F004', 'CS303', 'R101', 'CSE-3A'),
('Monday', 3, 'F006', 'CS306', 'R101', 'CSE-3A'),
('Monday', 4, 'F007', 'CS307', 'R101', 'CSE-3A'),
('Monday', 5, 'F009', 'CS309', 'R101', 'CSE-3A');

-- Tuesday Schedule for CSE-3A
INSERT INTO Schedule (day, slot_id, faculty_id, sub_code, room_no, batch_id) VALUES
('Tuesday', 1, 'F006', 'CS306', 'R101', 'CSE-3A'),
('Tuesday', 2, 'F001', 'CS301', 'R101', 'CSE-3A'),
('Tuesday', 3, 'F004', 'CS302', 'L201', 'CSE-3A'),
('Tuesday', 4, 'F004', 'CS302', 'L201', 'CSE-3A'),
('Tuesday', 5, 'F007', 'CS307', 'R101', 'CSE-3A');

-- Wednesday Schedule for CSE-3A
INSERT INTO Schedule (day, slot_id, faculty_id, sub_code, room_no, batch_id) VALUES
('Wednesday', 1, 'F009', 'CS309', 'R101', 'CSE-3A'),
('Wednesday', 2, 'F004', 'CS303', 'R101', 'CSE-3A'),
('Wednesday', 3, 'F007', 'CS308', 'L202', 'CSE-3A'),
('Wednesday', 4, 'F007', 'CS308', 'L202', 'CSE-3A'),
('Wednesday', 5, 'F001', 'CS301', 'R101', 'CSE-3A');

-- Thursday Schedule for CSE-3A
INSERT INTO Schedule (day, slot_id, faculty_id, sub_code, room_no, batch_id) VALUES
('Thursday', 1, 'F007', 'CS307', 'R101', 'CSE-3A'),
('Thursday', 2, 'F006', 'CS306', 'R101', 'CSE-3A'),
('Thursday', 3, 'F009', 'CS309', 'R101', 'CSE-3A'),
('Thursday', 4, 'F001', 'CS301', 'R101', 'CSE-3A'),
('Thursday', 5, 'F004', 'CS303', 'R101', 'CSE-3A');

-- Friday Schedule for CSE-3A
INSERT INTO Schedule (day, slot_id, faculty_id, sub_code, room_no, batch_id) VALUES
('Friday', 1, 'F001', 'CS302', 'L201', 'CSE-3A'),
('Friday', 2, 'F001', 'CS302', 'L201', 'CSE-3A'),
('Friday', 3, 'F006', 'CS306', 'R101', 'CSE-3A'),
('Friday', 4, 'F007', 'CS307', 'R101', 'CSE-3A'),
('Friday', 5, 'F009', 'CS310', 'R101', 'CSE-3A');

-- Additional schedules for other batches
-- Monday Schedule for CSE-3B
INSERT INTO Schedule (day, slot_id, faculty_id, sub_code, room_no, batch_id) VALUES
('Monday', 1, 'F002', 'CS303', 'R102', 'CSE-3B'),
('Monday', 2, 'F006', 'CS301', 'R102', 'CSE-3B'),
('Monday', 3, 'F007', 'CS307', 'R102', 'CSE-3B'),
('Monday', 4, 'F009', 'CS306', 'R102', 'CSE-3B');

-- Tuesday Schedule for CSE-3B
INSERT INTO Schedule (day, slot_id, faculty_id, sub_code, room_no, batch_id) VALUES
('Tuesday', 1, 'F007', 'CS307', 'R102', 'CSE-3B'),
('Tuesday', 2, 'F002', 'CS303', 'R102', 'CSE-3B'),
('Tuesday', 3, 'F006', 'CS301', 'R102', 'CSE-3B'),
('Tuesday', 4, 'F009', 'CS306', 'R102', 'CSE-3B');

-- ISE-3A Schedule samples
INSERT INTO Schedule (day, slot_id, faculty_id, sub_code, room_no, batch_id) VALUES
('Monday', 1, 'F003', 'CS304', 'R103', 'ISE-3A'),
('Monday', 2, 'F005', 'CS301', 'R103', 'ISE-3A'),
('Monday', 3, 'F008', 'CS303', 'R103', 'ISE-3A'),
('Tuesday', 1, 'F005', 'CS301', 'R103', 'ISE-3A'),
('Tuesday', 2, 'F003', 'CS304', 'R103', 'ISE-3A'),
('Wednesday', 1, 'F008', 'CS303', 'R103', 'ISE-3A'),
('Wednesday', 2, 'F003', 'CS305', 'L203', 'ISE-3A'),
('Wednesday', 3, 'F003', 'CS305', 'L203', 'ISE-3A');
