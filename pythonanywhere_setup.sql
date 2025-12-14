-- Timetable Management System Database Setup for PythonAnywhere
-- DO NOT include DROP DATABASE or CREATE DATABASE commands
-- Database is already created on PythonAnywhere

-- Re-runnable setup: drop existing tables (FK-safe order)
DROP TABLE IF EXISTS Schedule;
DROP TABLE IF EXISTS Time_Slots;
DROP TABLE IF EXISTS Batches;
DROP TABLE IF EXISTS Rooms;
DROP TABLE IF EXISTS Subjects;
DROP TABLE IF EXISTS Faculty;

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

-- Insert Faculty Data (56 rows)
INSERT INTO Faculty (faculty_id, name, designation, dept) VALUES
('F001', 'Dr. Rajesh Kumar', 'Professor', 'Computer Science'),
('F002', 'Dr. Priya Sharma', 'Associate Professor', 'Computer Science'),
('F003', 'Dr. Amit Verma', 'Assistant Professor', 'Computer Science'),
('F004', 'Ms. Sneha Patel', 'Assistant Professor', 'Computer Science'),
('F005', 'Dr. Anita Roy', 'Professor', 'Computer Science'),
('F006', 'Dr. Mohan Das', 'Associate Professor', 'Mathematics'),
('F007', 'Mr. Suresh Reddy', 'Assistant Professor', 'Computer Science'),
('F008', 'Ms. Kavita Singh', 'Assistant Professor', 'Mathematics'),
('F009', 'Mr. Vikram Gupta', 'Assistant Professor', 'Computer Science'),
('F010', 'Ms. Deepa Menon', 'Assistant Professor', 'Computer Science'),
('F011', 'Ms. Shreya Nair', 'Assistant Professor', 'Humanities'),
('F012', 'Mr. Karthik Rao', 'Assistant Professor', 'Computer Science'),

('F013', 'Dr. Neha Joshi', 'Professor', 'Computer Science'),
('F014', 'Dr. Arjun Mehta', 'Associate Professor', 'Computer Science'),
('F015', 'Ms. Pooja Iyer', 'Assistant Professor', 'Computer Science'),
('F016', 'Mr. Rohan Shah', 'Assistant Professor', 'Computer Science'),
('F017', 'Dr. Meera Kulkarni', 'Associate Professor', 'Computer Science'),
('F018', 'Mr. Naveen Prakash', 'Assistant Professor', 'Mathematics'),
('F019', 'Ms. Aditi Desai', 'Assistant Professor', 'Computer Science'),
('F020', 'Dr. Sanjay Rao', 'Assistant Professor', 'Mathematics'),
('F021', 'Mr. Harish Kumar', 'Assistant Professor', 'Computer Science'),
('F022', 'Ms. Divya Sharma', 'Assistant Professor', 'Computer Science'),
('F023', 'Mr. Sandeep Shetty', 'Assistant Professor', 'Computer Science'),
('F024', 'Ms. Ritu Malhotra', 'Assistant Professor', 'Humanities'),

('F025', 'Dr. Lakshmi Narayan', 'Professor', 'Information Science'),
('F026', 'Mr. Ajay Shekhar', 'Assistant Professor', 'Information Science'),
('F027', 'Ms. Nandini Gupta', 'Assistant Professor', 'Information Science'),
('F028', 'Mr. Imran Khan', 'Assistant Professor', 'Information Science'),
('F029', 'Dr. Sahana Bhat', 'Associate Professor', 'Information Science'),
('F030', 'Dr. Praveen S', 'Assistant Professor', 'Mathematics'),
('F031', 'Ms. Sushma Rao', 'Assistant Professor', 'Information Science'),
('F032', 'Mr. Gagan Rao', 'Assistant Professor', 'Mathematics'),
('F033', 'Ms. Riya Sen', 'Assistant Professor', 'Information Science'),
('F034', 'Mr. Arun Das', 'Assistant Professor', 'Information Science'),
('F035', 'Ms. Monica Jain', 'Assistant Professor', 'Information Science'),
('F036', 'Mr. Prakash N', 'Assistant Professor', 'Humanities'),

('F037', 'Dr. Harini Rao', 'Associate Professor', 'Computer Science'),
('F038', 'Mr. Anil Joseph', 'Assistant Professor', 'Computer Science'),
('F039', 'Ms. Swathi Hegde', 'Assistant Professor', 'Computer Science'),
('F040', 'Dr. Vijay Narayan', 'Associate Professor', 'Mathematics'),
('F041', 'Mr. Shyam Prasad', 'Assistant Professor', 'Computer Science'),
('F042', 'Ms. Kavya Rao', 'Assistant Professor', 'Computer Science'),
('F043', 'Mr. Rohit Kulkarni', 'Assistant Professor', 'Computer Science'),
('F044', 'Ms. Nisha Fernandes', 'Assistant Professor', 'Humanities'),
('F045', 'Dr. Ramesh Iyer', 'Assistant Professor', 'Mathematics'),
('F046', 'Mr. Kiran Shetty', 'Assistant Professor', 'Computer Science'),

('F047', 'Dr. Shalini B', 'Associate Professor', 'Information Science'),
('F048', 'Mr. Mahesh Gowda', 'Assistant Professor', 'Information Science'),
('F049', 'Ms. Ananya S', 'Assistant Professor', 'Information Science'),
('F050', 'Mr. Faiz Ahmed', 'Assistant Professor', 'Information Science'),
('F051', 'Dr. Aparna Nair', 'Associate Professor', 'Mathematics'),
('F052', 'Ms. Shilpa Desai', 'Assistant Professor', 'Humanities'),
('F053', 'Mr. Sumanth Rao', 'Assistant Professor', 'Information Science'),
('F054', 'Ms. Hema Kulkarni', 'Assistant Professor', 'Information Science'),
('F055', 'Mr. Dinesh Kumar', 'Assistant Professor', 'Information Science'),
('F056', 'Ms. Meera P', 'Assistant Professor', 'Information Science');

-- Insert Subjects Data (19 rows)
INSERT INTO Subjects (sub_code, sub_name, sub_type) VALUES
('CS301', 'Database Management Systems', 'Theory'),
('CS303', 'Operating Systems', 'Theory'),
('CS304', 'Computer Networks', 'Theory'),
('CS306', 'Software Engineering', 'Theory'),
('CS307', 'Data Structures', 'Theory'),
('CS311', 'Discrete Mathematics', 'Theory'),
('CS312', 'Object Oriented Programming (Java)', 'Theory'),
('CS313', 'Probability and Statistics', 'Theory'),
('HS301', 'Professional Communication', 'Theory'),
('HS302', 'Environmental Studies', 'Theory'),
('CS302', 'DBMS Lab', 'Lab'),
('CS305', 'Web Technologies Lab', 'Lab'),
('CS308', 'Python Programming Lab', 'Lab'),
('CS309', 'Computer Networks Lab', 'Lab'),
('CS310', 'Java Programming Lab', 'Lab'),
('CS314', 'Cloud Computing', 'Theory'),
('CS315', 'Artificial Intelligence Fundamentals', 'Theory'),
('CS316', 'Data Analytics', 'Theory'),
('HS303', 'Indian Constitution', 'Theory');

-- Insert Rooms Data
INSERT INTO Rooms (room_no, capacity, room_type) VALUES
('R101', 60, 'Lecture Hall'),
('R102', 60, 'Lecture Hall'),
('R103', 70, 'Lecture Hall'),
('R104', 80, 'Seminar Hall'),
('L201', 30, 'Computer Lab'),
('L202', 30, 'Computer Lab'),
('L203', 30, 'Computer Lab'),
('L204', 40, 'Computer Lab'),
('R105', 60, 'Lecture Hall'),
('R106', 60, 'Lecture Hall');

-- Insert Batches Data
INSERT INTO Batches (batch_id, semester, dept) VALUES
('CSE-3A', 3, 'Computer Science'),
('CSE-3B', 3, 'Computer Science'),
('ISE-3A', 3, 'Information Science'),
('CSE-3C', 3, 'Computer Science'),
('ISE-3B', 3, 'Information Science');

-- Insert Time_Slots Data (typical 50-minute periods + breaks)
INSERT INTO Time_Slots (start_time, end_time) VALUES
('09:00:00', '09:50:00'),
('09:50:00', '10:40:00'),
('10:55:00', '11:45:00'),
('11:45:00', '12:35:00'),
('13:25:00', '14:15:00'),
('14:15:00', '15:05:00'),
('15:20:00', '16:10:00'),
('16:10:00', '17:00:00');

-- ========================================
-- REALISTIC SAMPLE TIMETABLES (Mon-Sat)
-- Note: Labs span two consecutive slots.
-- ========================================

-- CSE-3A (Primary room: R101)
INSERT INTO Schedule (day, slot_id, faculty_id, sub_code, room_no, batch_id) VALUES
('Monday',    1, 'F001', 'CS301', 'R101', 'CSE-3A'),
('Monday',    2, 'F002', 'CS303', 'R101', 'CSE-3A'),
('Monday',    3, 'F004', 'CS307', 'R101', 'CSE-3A'),
('Monday',    4, 'F006', 'CS311', 'R101', 'CSE-3A'),
('Monday',    5, 'F003', 'CS304', 'R101', 'CSE-3A'),
('Monday',    6, 'F005', 'CS306', 'R101', 'CSE-3A'),
('Monday',    7, 'F010', 'CS302', 'L201', 'CSE-3A'),
('Monday',    8, 'F010', 'CS302', 'L201', 'CSE-3A'),

('Tuesday',   1, 'F007', 'CS312', 'R101', 'CSE-3A'),
('Tuesday',   2, 'F001', 'CS301', 'R101', 'CSE-3A'),
('Tuesday',   3, 'F003', 'CS304', 'R101', 'CSE-3A'),
('Tuesday',   4, 'F004', 'CS307', 'R101', 'CSE-3A'),
('Tuesday',   5, 'F006', 'CS311', 'R101', 'CSE-3A'),
('Tuesday',   6, 'F011', 'HS301', 'R101', 'CSE-3A'),
('Tuesday',   7, 'F009', 'CS305', 'L202', 'CSE-3A'),
('Tuesday',   8, 'F009', 'CS305', 'L202', 'CSE-3A'),

('Wednesday', 1, 'F002', 'CS303', 'R101', 'CSE-3A'),
('Wednesday', 2, 'F005', 'CS306', 'R101', 'CSE-3A'),
('Wednesday', 3, 'F001', 'CS301', 'R101', 'CSE-3A'),
('Wednesday', 4, 'F007', 'CS312', 'R101', 'CSE-3A'),
('Wednesday', 5, 'F004', 'CS307', 'R101', 'CSE-3A'),
('Wednesday', 6, 'F008', 'CS313', 'R101', 'CSE-3A'),
('Wednesday', 7, 'F012', 'CS308', 'L202', 'CSE-3A'),
('Wednesday', 8, 'F012', 'CS308', 'L202', 'CSE-3A'),

('Thursday',  1, 'F006', 'CS311', 'R101', 'CSE-3A'),
('Thursday',  2, 'F003', 'CS304', 'R101', 'CSE-3A'),
('Thursday',  3, 'F002', 'CS303', 'R101', 'CSE-3A'),
('Thursday',  4, 'F001', 'CS301', 'R101', 'CSE-3A'),
('Thursday',  5, 'F005', 'CS306', 'R101', 'CSE-3A'),
('Thursday',  6, 'F011', 'HS302', 'R101', 'CSE-3A'),

('Friday',    1, 'F001', 'CS301', 'R101', 'CSE-3A'),
('Friday',    2, 'F004', 'CS307', 'R101', 'CSE-3A'),
('Friday',    3, 'F003', 'CS304', 'R101', 'CSE-3A'),
('Friday',    4, 'F002', 'CS303', 'R101', 'CSE-3A'),
('Friday',    5, 'F006', 'CS311', 'R101', 'CSE-3A'),
('Friday',    6, 'F007', 'CS312', 'R101', 'CSE-3A'),

('Saturday',  1, 'F011', 'HS301', 'R101', 'CSE-3A'),
('Saturday',  2, 'F008', 'CS313', 'R101', 'CSE-3A'),
('Saturday',  3, 'F002', 'CS303', 'R101', 'CSE-3A'),
('Saturday',  4, 'F001', 'CS301', 'R101', 'CSE-3A');

-- CSE-3B (Primary room: R102)
INSERT INTO Schedule (day, slot_id, faculty_id, sub_code, room_no, batch_id) VALUES
('Monday',    1, 'F014', 'CS303', 'R102', 'CSE-3B'),
('Monday',    2, 'F016', 'CS307', 'R102', 'CSE-3B'),
('Monday',    3, 'F015', 'CS304', 'R102', 'CSE-3B'),
('Monday',    4, 'F018', 'CS311', 'R102', 'CSE-3B'),
('Monday',    5, 'F013', 'CS301', 'R102', 'CSE-3B'),
('Monday',    6, 'F017', 'CS306', 'R102', 'CSE-3B'),
('Monday',    7, 'F021', 'CS305', 'L203', 'CSE-3B'),
('Monday',    8, 'F021', 'CS305', 'L203', 'CSE-3B'),

('Tuesday',   1, 'F013', 'CS301', 'R102', 'CSE-3B'),
('Tuesday',   2, 'F014', 'CS303', 'R102', 'CSE-3B'),
('Tuesday',   3, 'F019', 'CS312', 'R102', 'CSE-3B'),
('Tuesday',   4, 'F016', 'CS307', 'R102', 'CSE-3B'),
('Tuesday',   5, 'F018', 'CS311', 'R102', 'CSE-3B'),
('Tuesday',   6, 'F024', 'HS301', 'R102', 'CSE-3B'),
('Tuesday',   7, 'F022', 'CS302', 'L204', 'CSE-3B'),
('Tuesday',   8, 'F022', 'CS302', 'L204', 'CSE-3B'),

('Wednesday', 1, 'F015', 'CS304', 'R102', 'CSE-3B'),
('Wednesday', 2, 'F017', 'CS306', 'R102', 'CSE-3B'),
('Wednesday', 3, 'F014', 'CS303', 'R102', 'CSE-3B'),
('Wednesday', 4, 'F013', 'CS301', 'R102', 'CSE-3B'),
('Wednesday', 5, 'F020', 'CS313', 'R102', 'CSE-3B'),
('Wednesday', 6, 'F019', 'CS312', 'R102', 'CSE-3B'),
('Wednesday', 7, 'F023', 'CS308', 'L203', 'CSE-3B'),
('Wednesday', 8, 'F023', 'CS308', 'L203', 'CSE-3B'),

('Thursday',  1, 'F018', 'CS311', 'R102', 'CSE-3B'),
('Thursday',  2, 'F015', 'CS304', 'R102', 'CSE-3B'),
('Thursday',  3, 'F014', 'CS303', 'R102', 'CSE-3B'),
('Thursday',  4, 'F016', 'CS307', 'R102', 'CSE-3B'),
('Thursday',  5, 'F017', 'CS306', 'R102', 'CSE-3B'),
('Thursday',  6, 'F013', 'CS301', 'R102', 'CSE-3B'),

('Friday',    1, 'F019', 'CS312', 'R102', 'CSE-3B'),
('Friday',    2, 'F013', 'CS301', 'R102', 'CSE-3B'),
('Friday',    3, 'F015', 'CS304', 'R102', 'CSE-3B'),
('Friday',    4, 'F014', 'CS303', 'R102', 'CSE-3B'),
('Friday',    5, 'F016', 'CS307', 'R102', 'CSE-3B'),
('Friday',    6, 'F018', 'CS311', 'R102', 'CSE-3B'),

('Saturday',  1, 'F024', 'HS302', 'R102', 'CSE-3B'),
('Saturday',  2, 'F020', 'CS313', 'R102', 'CSE-3B'),
('Saturday',  3, 'F013', 'CS301', 'R102', 'CSE-3B'),
('Saturday',  4, 'F014', 'CS303', 'R102', 'CSE-3B');

-- ISE-3A (Primary room: R103)
INSERT INTO Schedule (day, slot_id, faculty_id, sub_code, room_no, batch_id) VALUES
('Monday',    1, 'F025', 'CS301', 'R103', 'ISE-3A'),
('Monday',    2, 'F026', 'CS303', 'R103', 'ISE-3A'),
('Monday',    3, 'F027', 'CS304', 'R103', 'ISE-3A'),
('Monday',    4, 'F030', 'CS311', 'R103', 'ISE-3A'),
('Monday',    5, 'F028', 'CS307', 'R103', 'ISE-3A'),
('Monday',    6, 'F036', 'HS301', 'R103', 'ISE-3A'),
('Monday',    7, 'F035', 'CS308', 'L202', 'ISE-3A'),
('Monday',    8, 'F035', 'CS308', 'L202', 'ISE-3A'),

('Tuesday',   1, 'F026', 'CS303', 'R103', 'ISE-3A'),
('Tuesday',   2, 'F028', 'CS307', 'R103', 'ISE-3A'),
('Tuesday',   3, 'F031', 'CS312', 'R103', 'ISE-3A'),
('Tuesday',   4, 'F025', 'CS301', 'R103', 'ISE-3A'),
('Tuesday',   5, 'F029', 'CS306', 'R103', 'ISE-3A'),
('Tuesday',   6, 'F032', 'CS313', 'R103', 'ISE-3A'),
('Tuesday',   7, 'F034', 'CS302', 'L201', 'ISE-3A'),
('Tuesday',   8, 'F034', 'CS302', 'L201', 'ISE-3A'),

('Wednesday', 1, 'F027', 'CS304', 'R103', 'ISE-3A'),
('Wednesday', 2, 'F030', 'CS311', 'R103', 'ISE-3A'),
('Wednesday', 3, 'F025', 'CS301', 'R103', 'ISE-3A'),
('Wednesday', 4, 'F026', 'CS303', 'R103', 'ISE-3A'),
('Wednesday', 5, 'F028', 'CS307', 'R103', 'ISE-3A'),
('Wednesday', 6, 'F036', 'HS302', 'R103', 'ISE-3A'),
('Wednesday', 7, 'F033', 'CS305', 'L204', 'ISE-3A'),
('Wednesday', 8, 'F033', 'CS305', 'L204', 'ISE-3A'),

('Thursday',  1, 'F029', 'CS306', 'R103', 'ISE-3A'),
('Thursday',  2, 'F031', 'CS312', 'R103', 'ISE-3A'),
('Thursday',  3, 'F027', 'CS304', 'R103', 'ISE-3A'),
('Thursday',  4, 'F026', 'CS303', 'R103', 'ISE-3A'),
('Thursday',  5, 'F030', 'CS311', 'R103', 'ISE-3A'),
('Thursday',  6, 'F025', 'CS301', 'R103', 'ISE-3A'),

('Friday',    1, 'F025', 'CS301', 'R103', 'ISE-3A'),
('Friday',    2, 'F028', 'CS307', 'R103', 'ISE-3A'),
('Friday',    3, 'F027', 'CS304', 'R103', 'ISE-3A'),
('Friday',    4, 'F026', 'CS303', 'R103', 'ISE-3A'),
('Friday',    5, 'F029', 'CS306', 'R103', 'ISE-3A'),
('Friday',    6, 'F030', 'CS311', 'R103', 'ISE-3A'),

('Saturday',  1, 'F036', 'HS301', 'R103', 'ISE-3A'),
('Saturday',  2, 'F032', 'CS313', 'R103', 'ISE-3A'),
('Saturday',  3, 'F025', 'CS301', 'R103', 'ISE-3A'),
('Saturday',  4, 'F026', 'CS303', 'R103', 'ISE-3A');

-- CSE-3C (Primary room: R105)
INSERT INTO Schedule (day, slot_id, faculty_id, sub_code, room_no, batch_id) VALUES
('Monday',    1, 'F037', 'CS301', 'R105', 'CSE-3C'),
('Monday',    2, 'F038', 'CS303', 'R105', 'CSE-3C'),
('Monday',    3, 'F039', 'CS307', 'R105', 'CSE-3C'),
('Monday',    4, 'F040', 'CS311', 'R105', 'CSE-3C'),
('Monday',    5, 'F041', 'CS304', 'R105', 'CSE-3C'),
('Monday',    6, 'F042', 'CS306', 'R105', 'CSE-3C'),

('Tuesday',   1, 'F043', 'CS312', 'R105', 'CSE-3C'),
('Tuesday',   2, 'F037', 'CS301', 'R105', 'CSE-3C'),
('Tuesday',   3, 'F041', 'CS304', 'R105', 'CSE-3C'),
('Tuesday',   4, 'F039', 'CS307', 'R105', 'CSE-3C'),
('Tuesday',   5, 'F040', 'CS311', 'R105', 'CSE-3C'),
('Tuesday',   6, 'F044', 'HS301', 'R105', 'CSE-3C'),

('Wednesday', 1, 'F038', 'CS303', 'R105', 'CSE-3C'),
('Wednesday', 2, 'F042', 'CS306', 'R105', 'CSE-3C'),
('Wednesday', 3, 'F037', 'CS301', 'R105', 'CSE-3C'),
('Wednesday', 4, 'F043', 'CS312', 'R105', 'CSE-3C'),
('Wednesday', 5, 'F039', 'CS307', 'R105', 'CSE-3C'),
('Wednesday', 6, 'F045', 'CS313', 'R105', 'CSE-3C'),

('Thursday',  1, 'F040', 'CS311', 'R105', 'CSE-3C'),
('Thursday',  2, 'F041', 'CS304', 'R105', 'CSE-3C'),
('Thursday',  3, 'F038', 'CS303', 'R105', 'CSE-3C'),
('Thursday',  4, 'F037', 'CS301', 'R105', 'CSE-3C'),
('Thursday',  5, 'F042', 'CS306', 'R105', 'CSE-3C'),
('Thursday',  6, 'F044', 'HS302', 'R105', 'CSE-3C'),
('Thursday',  7, 'F046', 'CS309', 'L201', 'CSE-3C'),
('Thursday',  8, 'F046', 'CS309', 'L201', 'CSE-3C'),

('Friday',    1, 'F037', 'CS301', 'R105', 'CSE-3C'),
('Friday',    2, 'F039', 'CS307', 'R105', 'CSE-3C'),
('Friday',    3, 'F041', 'CS304', 'R105', 'CSE-3C'),
('Friday',    4, 'F038', 'CS303', 'R105', 'CSE-3C'),
('Friday',    5, 'F040', 'CS311', 'R105', 'CSE-3C'),
('Friday',    6, 'F043', 'CS312', 'R105', 'CSE-3C'),
('Friday',    7, 'F046', 'CS310', 'L202', 'CSE-3C'),
('Friday',    8, 'F046', 'CS310', 'L202', 'CSE-3C'),

('Saturday',  1, 'F046', 'CS314', 'R105', 'CSE-3C'),
('Saturday',  2, 'F046', 'CS315', 'R105', 'CSE-3C'),
('Saturday',  3, 'F038', 'CS303', 'R105', 'CSE-3C'),
('Saturday',  4, 'F037', 'CS301', 'R105', 'CSE-3C');

-- ISE-3B (Primary room: R106)
INSERT INTO Schedule (day, slot_id, faculty_id, sub_code, room_no, batch_id) VALUES
('Monday',    1, 'F047', 'CS301', 'R106', 'ISE-3B'),
('Monday',    2, 'F048', 'CS303', 'R106', 'ISE-3B'),
('Monday',    3, 'F049', 'CS304', 'R106', 'ISE-3B'),
('Monday',    4, 'F051', 'CS311', 'R106', 'ISE-3B'),
('Monday',    5, 'F050', 'CS307', 'R106', 'ISE-3B'),
('Monday',    6, 'F052', 'HS301', 'R106', 'ISE-3B'),

('Tuesday',   1, 'F048', 'CS303', 'R106', 'ISE-3B'),
('Tuesday',   2, 'F050', 'CS307', 'R106', 'ISE-3B'),
('Tuesday',   3, 'F053', 'CS312', 'R106', 'ISE-3B'),
('Tuesday',   4, 'F047', 'CS301', 'R106', 'ISE-3B'),
('Tuesday',   5, 'F054', 'CS306', 'R106', 'ISE-3B'),
('Tuesday',   6, 'F055', 'CS313', 'R106', 'ISE-3B'),

('Wednesday', 1, 'F049', 'CS304', 'R106', 'ISE-3B'),
('Wednesday', 2, 'F051', 'CS311', 'R106', 'ISE-3B'),
('Wednesday', 3, 'F047', 'CS301', 'R106', 'ISE-3B'),
('Wednesday', 4, 'F048', 'CS303', 'R106', 'ISE-3B'),
('Wednesday', 5, 'F050', 'CS307', 'R106', 'ISE-3B'),
('Wednesday', 6, 'F052', 'HS302', 'R106', 'ISE-3B'),

('Thursday',  1, 'F054', 'CS306', 'R106', 'ISE-3B'),
('Thursday',  2, 'F053', 'CS312', 'R106', 'ISE-3B'),
('Thursday',  3, 'F049', 'CS304', 'R106', 'ISE-3B'),
('Thursday',  4, 'F048', 'CS303', 'R106', 'ISE-3B'),
('Thursday',  5, 'F051', 'CS311', 'R106', 'ISE-3B'),
('Thursday',  6, 'F047', 'CS301', 'R106', 'ISE-3B'),
('Thursday',  7, 'F056', 'CS302', 'L203', 'ISE-3B'),
('Thursday',  8, 'F056', 'CS302', 'L203', 'ISE-3B'),

('Friday',    1, 'F047', 'CS301', 'R106', 'ISE-3B'),
('Friday',    2, 'F050', 'CS307', 'R106', 'ISE-3B'),
('Friday',    3, 'F049', 'CS304', 'R106', 'ISE-3B'),
('Friday',    4, 'F048', 'CS303', 'R106', 'ISE-3B'),
('Friday',    5, 'F054', 'CS306', 'R106', 'ISE-3B'),
('Friday',    6, 'F051', 'CS311', 'R106', 'ISE-3B'),
('Friday',    7, 'F056', 'CS308', 'L204', 'ISE-3B'),
('Friday',    8, 'F056', 'CS308', 'L204', 'ISE-3B'),

('Saturday',  1, 'F055', 'CS316', 'R106', 'ISE-3B'),
('Saturday',  2, 'F052', 'HS303', 'R106', 'ISE-3B'),
('Saturday',  3, 'F047', 'CS301', 'R106', 'ISE-3B'),
('Saturday',  4, 'F048', 'CS303', 'R106', 'ISE-3B');
