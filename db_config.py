import os

# Database Configuration
# Local defaults are provided for development.
# For PythonAnywhere / production, set environment variables in the Web tab:
# DB_HOST, DB_USER, DB_PASSWORD, DB_NAME

DB_CONFIG = {
    'host': os.environ.get('DB_HOST', '127.0.0.1'),
    'user': os.environ.get('DB_USER', 'root'),
    'password': os.environ.get('DB_PASSWORD', ''),
    'database': os.environ.get('DB_NAME', 'timetable_db'),
}
