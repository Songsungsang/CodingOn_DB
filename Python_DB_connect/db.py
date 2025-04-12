import mysql.connector
from mysql.connector import Error

def create_conn(): # db와 연결
    try:
        conn = mysql.connector.connect( # DB 연결을 위한 데이터
            host = "localhost",
            user = "root",
            password = "4613mnbv",
            database = "python_db"
        )

        cursor = conn.cursor()

        return conn, cursor

    except Error as e:
        print("DB 연결 오류", e)