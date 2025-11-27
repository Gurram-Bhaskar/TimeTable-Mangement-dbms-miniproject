# Database Configuration for PythonAnywhere
# Replace 'yourusername' with your actual PythonAnywhere username
import os

DB_CONFIG = {
    'host': os.environ.get('DB_HOST', 'yourusername.mysql.pythonanywhere-services.com'),
    'user': os.environ.get('DB_USER', 'yourusername'),
    'password': os.environ.get('DB_PASSWORD', 'your_mysql_password'),  # Set this in PythonAnywhere MySQL
    'database': os.environ.get('DB_NAME', 'yourusername$timetable_db')
}

# Example:
# If your username is "john123", it should be:
# 'host': 'john123.mysql.pythonanywhere-services.com'
# 'user': 'john123'
# 'database': 'john123$timetable_db'
