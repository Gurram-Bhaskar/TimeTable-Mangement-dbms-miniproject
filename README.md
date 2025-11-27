# Timetable Management System

A comprehensive web-based Timetable Management System built with Flask and MySQL. This DBMS Mini-Project features automatic conflict detection to prevent scheduling clashes for faculty, rooms, and student batches.

## 🎓 Project Information

**Course:** Database Management Systems (DBMS) Laboratory  
**Institution:** REVA University  
**Semester:** 3  
**Tech Stack:** Python Flask, MySQL, HTML5, CSS3, Vanilla JavaScript

## ✨ Features

- **Admin Authentication** - Secure login system with session management
- **Schedule Management** - Add, view, and manage class schedules
- **Conflict Detection** - Automatic detection of scheduling conflicts for:
  - Faculty (professors cannot be in two places at once)
  - Rooms (no double-booking of classrooms)
  - Batches (students cannot attend multiple classes simultaneously)
- **Visual Timetable Grid** - Interactive weekly timetable view
- **Raw SQL Queries** - No ORM used, all database operations use raw SQL
- **Responsive Design** - Clean, modern UI that works on all devices

## 📁 Project Structure

```
Mini_project/
├── app.py                    # Main Flask application
├── db_config.py              # Database configuration
├── database_setup.sql        # SQL schema and dummy data
├── requirements.txt          # Python dependencies
├── README.md                 # This file
├── templates/
│   ├── layout.html          # Base template with navbar & footer
│   ├── login.html           # Admin login page
│   ├── dashboard.html       # Main dashboard
│   ├── add_schedule.html    # Schedule creation form
│   └── view_timetable.html  # Timetable grid view
└── static/
    └── style.css            # Custom CSS styling
```

## 🗄️ Database Schema

### Tables

1. **Faculty** - Faculty information
   - `faculty_id` (PK), `name`, `designation`, `dept`

2. **Subjects** - Course subjects
   - `sub_code` (PK), `sub_name`, `sub_type` (Theory/Lab)

3. **Rooms** - Classroom/Lab details
   - `room_no` (PK), `capacity`, `room_type`

4. **Batches** - Student batch information
   - `batch_id` (PK), `semester`, `dept`

5. **Time_Slots** - Class time periods
   - `slot_id` (PK), `start_time`, `end_time`

6. **Schedule** - Class assignments
   - `alloc_id` (PK), `day`, `slot_id` (FK), `faculty_id` (FK), `sub_code` (FK), `room_no` (FK), `batch_id` (FK)

## 🚀 Installation & Setup

### Prerequisites

- Python 3.8 or higher
- MySQL Server 5.7 or higher
- pip (Python package manager)

### Step 1: Install Python Dependencies

```powershell
pip install -r requirements.txt
```

### Step 2: Configure Database

1. Open MySQL and create the database:

```powershell
mysql -u root -p
```

2. Run the setup script:

```sql
source database_setup.sql
```

Or manually execute the SQL file in your MySQL client.

### Step 3: Update Database Credentials

Edit `db_config.py` and update with your MySQL credentials:

```python
DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',           # Your MySQL username
    'password': 'yourpass',   # Your MySQL password
    'database': 'timetable_db'
}
```

### Step 4: Run the Application

```powershell
python app.py
```

The application will start on `http://localhost:5000`

## 🔐 Login Credentials

**Username:** `admin`  
**Password:** `admin123`

## 📋 Usage Guide

### 1. Login
- Navigate to `http://localhost:5000`
- Enter admin credentials

### 2. Add Schedule
- Click "Add Schedule" from dashboard
- Fill in all required fields:
  - Day (Monday-Saturday)
  - Time Slot
  - Faculty
  - Subject
  - Room
  - Batch
- Click "Add Schedule"
- System will automatically check for conflicts

### 3. View Timetable
- Click "View Timetable" from dashboard
- Select a batch from dropdown
- Click "View Timetable"
- View the weekly schedule grid
- Print using the print button

## 🔍 Conflict Detection Logic

The system prevents three types of conflicts:

1. **Faculty Conflict**: A professor cannot teach two classes simultaneously
2. **Room Conflict**: A classroom cannot host multiple classes at the same time
3. **Batch Conflict**: Students cannot attend multiple classes simultaneously

The validation query checks all three conditions before inserting a new schedule entry.

## 🎨 Design Philosophy

- **Clean & Professional**: Academic-themed color scheme (blues, grays, whites)
- **User-Friendly**: Intuitive navigation and clear visual feedback
- **Responsive**: Works seamlessly on desktop, tablet, and mobile
- **Accessible**: Clear labels, good contrast, and keyboard navigation

## 🛠️ Technologies Used

- **Backend**: Python 3.x, Flask 3.0.0
- **Database**: MySQL 8.x
- **Database Driver**: mysql-connector-python 8.2.0
- **Frontend**: HTML5, CSS3 (Custom Grid), Vanilla JavaScript
- **Session Management**: Flask Sessions
- **No ORM**: Pure SQL queries for DBMS lab requirement

## 📝 Key Implementation Details

### Raw SQL Queries
All database operations use `cursor.execute()` with raw SQL:
- No SQLAlchemy or other ORM
- Direct SQL for INSERT, SELECT, UPDATE operations
- Prepared statements to prevent SQL injection

### Conflict Detection Algorithm
```python
1. Receive schedule parameters (day, slot, faculty, room, batch)
2. Query Schedule table for matching day + slot
3. Check if ANY of (faculty_id OR room_no OR batch_id) matches
4. If count > 0: Show error with specific conflict details
5. Else: Insert new schedule record
```

## 📊 Sample Data

The `database_setup.sql` includes dummy data:
- 5 Faculty members
- 5 Subjects (Theory and Lab)
- 5 Rooms (Lecture Halls and Labs)
- 5 Batches (CSE and ISE)
- 5 Time Slots
- 5 Sample schedule entries

## 🐛 Troubleshooting

### Database Connection Error
- Verify MySQL is running
- Check credentials in `db_config.py`
- Ensure database `timetable_db` exists

### Import Errors
- Run `pip install -r requirements.txt`
- Use a virtual environment if needed

### Port Already in Use
- Change port in `app.py`: `app.run(port=5001)`

## 📚 Future Enhancements

- Faculty and Room management pages
- Edit and delete schedule entries
- Multiple batch timetable comparison
- Export to PDF/Excel
- Email notifications
- Student login portal

## 👨‍💻 Author

**REVA University Student**  
DBMS Laboratory Mini-Project  
Semester 3

## 📄 License

This project is created for educational purposes as part of DBMS Laboratory coursework.

## 🙏 Acknowledgments

- REVA University DBMS Faculty
- Flask Documentation
- MySQL Documentation

---

**Note:** This project uses raw SQL queries as per DBMS lab requirements. No ORM (SQLAlchemy) is used.
