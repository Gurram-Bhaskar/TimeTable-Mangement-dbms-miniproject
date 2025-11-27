from flask import Flask, render_template, request, redirect, url_for, session, flash
import mysql.connector
from db_config import DB_CONFIG

app = Flask(__name__)
app.secret_key = 'your_secret_key_here_change_in_production'  # Change this in production

# Database Connection Function
def get_db_connection():
    """
    Establishes and returns a MySQL database connection.
    Handles connection errors gracefully.
    """
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        return conn
    except mysql.connector.Error as err:
        print(f"Database Connection Error: {err}")
        return None

# ==================== ROUTES ====================

@app.route('/')
def index():
    """Redirect to login page"""
    return redirect(url_for('login'))

@app.route('/login', methods=['GET', 'POST'])
def login():
    """
    Admin Login Page
    Hardcoded credentials: admin / admin123
    """
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        
        # Simple hardcoded authentication
        if username == 'admin' and password == 'admin123':
            session['logged_in'] = True
            session['username'] = username
            flash('Login successful!', 'success')
            return redirect(url_for('dashboard'))
        else:
            flash('Invalid credentials. Please try again.', 'error')
    
    return render_template('login.html')

@app.route('/logout')
def logout():
    """Logout and clear session"""
    session.clear()
    flash('You have been logged out.', 'info')
    return redirect(url_for('login'))

@app.route('/dashboard')
def dashboard():
    """Main Dashboard - Protected Route"""
    if not session.get('logged_in'):
        flash('Please login first.', 'error')
        return redirect(url_for('login'))
    
    return render_template('dashboard.html')

@app.route('/add_schedule', methods=['GET', 'POST'])
def add_schedule():
    """
    Add Schedule Page
    GET: Fetch dropdown data (Faculty, Subjects, Rooms, Batches, Time Slots)
    POST: Validate conflicts and insert new schedule
    """
    if not session.get('logged_in'):
        flash('Please login first.', 'error')
        return redirect(url_for('login'))
    
    conn = get_db_connection()
    if not conn:
        flash('Database connection failed!', 'error')
        return redirect(url_for('dashboard'))
    
    cursor = conn.cursor(dictionary=True)
    
    if request.method == 'POST':
        # Get form data
        day = request.form.get('day')
        slot_id = request.form.get('slot_id')
        faculty_id = request.form.get('faculty_id')
        sub_code = request.form.get('sub_code')
        room_no = request.form.get('room_no')
        batch_id = request.form.get('batch_id')
        
        # CONFLICT DETECTION QUERY
        # Check if Room, Faculty, or Batch is already booked for this Day + Slot
        conflict_query = """
            SELECT 
                (SELECT name FROM Faculty WHERE faculty_id = %s) as faculty_name,
                (SELECT room_no FROM Rooms WHERE room_no = %s) as room_name,
                (SELECT batch_id FROM Batches WHERE batch_id = %s) as batch_name,
                COUNT(*) as conflict_count
            FROM Schedule
            WHERE day = %s AND slot_id = %s
            AND (faculty_id = %s OR room_no = %s OR batch_id = %s)
        """
        
        cursor.execute(conflict_query, (faculty_id, room_no, batch_id, day, slot_id, 
                                       faculty_id, room_no, batch_id))
        result = cursor.fetchone()
        
        if result['conflict_count'] > 0:
            # Determine what is conflicting
            conflict_details = []
            
            # Check specific conflicts
            cursor.execute("SELECT name FROM Faculty f JOIN Schedule s ON f.faculty_id = s.faculty_id WHERE s.day = %s AND s.slot_id = %s AND s.faculty_id = %s", (day, slot_id, faculty_id))
            faculty_conflict = cursor.fetchone()
            if faculty_conflict:
                conflict_details.append(f"Faculty '{faculty_conflict['name']}' is already assigned")
            
            cursor.execute("SELECT room_no FROM Schedule WHERE day = %s AND slot_id = %s AND room_no = %s", (day, slot_id, room_no))
            room_conflict = cursor.fetchone()
            if room_conflict:
                conflict_details.append(f"Room '{room_conflict['room_no']}' is already occupied")
            
            cursor.execute("SELECT batch_id FROM Schedule WHERE day = %s AND slot_id = %s AND batch_id = %s", (day, slot_id, batch_id))
            batch_conflict = cursor.fetchone()
            if batch_conflict:
                conflict_details.append(f"Batch '{batch_conflict['batch_id']}' already has a class")
            
            flash(f"Conflict Detected! {'; '.join(conflict_details)}", 'error')
        else:
            # No conflict - Insert the record
            insert_query = """
                INSERT INTO Schedule (day, slot_id, faculty_id, sub_code, room_no, batch_id)
                VALUES (%s, %s, %s, %s, %s, %s)
            """
            cursor.execute(insert_query, (day, slot_id, faculty_id, sub_code, room_no, batch_id))
            conn.commit()
            flash('Schedule added successfully!', 'success')
        
        cursor.close()
        conn.close()
        return redirect(url_for('add_schedule'))
    
    # GET Request - Fetch all dropdown data
    try:
        # Fetch Faculty
        cursor.execute("SELECT faculty_id, name, dept FROM Faculty ORDER BY name")
        faculties = cursor.fetchall()
        
        # Fetch Subjects
        cursor.execute("SELECT sub_code, sub_name, sub_type FROM Subjects ORDER BY sub_name")
        subjects = cursor.fetchall()
        
        # Fetch Rooms
        cursor.execute("SELECT room_no, capacity, room_type FROM Rooms ORDER BY room_no")
        rooms = cursor.fetchall()
        
        # Fetch Batches
        cursor.execute("SELECT batch_id, semester, dept FROM Batches ORDER BY batch_id")
        batches = cursor.fetchall()
        
        # Fetch Time Slots
        cursor.execute("SELECT slot_id, start_time, end_time FROM Time_Slots ORDER BY slot_id")
        time_slots = cursor.fetchall()
        
        cursor.close()
        conn.close()
        
        return render_template('add_schedule.html', 
                             faculties=faculties,
                             subjects=subjects,
                             rooms=rooms,
                             batches=batches,
                             time_slots=time_slots)
    
    except mysql.connector.Error as err:
        flash(f'Database Error: {err}', 'error')
        cursor.close()
        conn.close()
        return redirect(url_for('dashboard'))

@app.route('/view_timetable', methods=['GET', 'POST'])
def view_timetable():
    """
    View Timetable Page
    Displays a 2D grid (Day x Time Slot) for selected batch
    """
    if not session.get('logged_in'):
        flash('Please login first.', 'error')
        return redirect(url_for('login'))
    
    conn = get_db_connection()
    if not conn:
        flash('Database connection failed!', 'error')
        return redirect(url_for('dashboard'))
    
    cursor = conn.cursor(dictionary=True)
    
    # Fetch all batches for dropdown
    cursor.execute("SELECT batch_id, semester, dept FROM Batches ORDER BY batch_id")
    batches = cursor.fetchall()
    
    timetable_data = None
    selected_batch = None
    
    if request.method == 'POST':
        selected_batch = request.form.get('batch_id')
        
        # Fetch schedule for the selected batch
        query = """
            SELECT 
                s.day,
                s.slot_id,
                ts.start_time,
                ts.end_time,
                sub.sub_name,
                f.name as faculty_name,
                s.room_no
            FROM Schedule s
            JOIN Time_Slots ts ON s.slot_id = ts.slot_id
            JOIN Subjects sub ON s.sub_code = sub.sub_code
            JOIN Faculty f ON s.faculty_id = f.faculty_id
            WHERE s.batch_id = %s
            ORDER BY 
                FIELD(s.day, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'),
                ts.start_time
        """
        cursor.execute(query, (selected_batch,))
        schedule_records = cursor.fetchall()
        
        # Fetch all time slots
        cursor.execute("SELECT slot_id, start_time, end_time FROM Time_Slots ORDER BY start_time")
        all_slots = cursor.fetchall()
        
        # Build timetable grid structure
        days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday']
        timetable_grid = {}
        
        # Initialize grid
        for slot in all_slots:
            slot_key = f"{slot['start_time']}-{slot['end_time']}"
            timetable_grid[slot_key] = {
                'slot_id': slot['slot_id'],
                'Monday': '--',
                'Tuesday': '--',
                'Wednesday': '--',
                'Thursday': '--',
                'Friday': '--'
            }
        
        # Fill in the schedule data
        for record in schedule_records:
            slot_key = f"{record['start_time']}-{record['end_time']}"
            day = record['day']
            cell_data = f"{record['sub_name']}<br><small>{record['room_no']} | {record['faculty_name']}</small>"
            if slot_key in timetable_grid and day in timetable_grid[slot_key]:
                timetable_grid[slot_key][day] = cell_data
        
        timetable_data = {
            'grid': timetable_grid,
            'days': days,
            'slots': all_slots
        }
    
    cursor.close()
    conn.close()
    
    return render_template('view_timetable.html', 
                         batches=batches, 
                         timetable=timetable_data,
                         selected_batch=selected_batch)

# ==================== ERROR HANDLERS ====================

@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404

@app.errorhandler(500)
def internal_error(e):
    return render_template('500.html'), 500

# ==================== MAIN ====================

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
