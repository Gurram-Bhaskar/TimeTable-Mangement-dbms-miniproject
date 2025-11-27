# Database Configuration
# Update these values according to your MySQL setup
import os

DB_CONFIG = {
    'host': os.environ.get('DB_HOST', 'localhost'),
    'user': os.environ.get('DB_USER', 'root'),
    'password': os.environ.get('DB_PASSWORD', 'bhaskar#1234'),
    'database': os.environ.get('DB_NAME', 'timetable_db')
}
