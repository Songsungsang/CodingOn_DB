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

def create_user(): # 유저 생성
    # db와 연결하고 query문 날려서 유저 생성
    try:
        conn, cursor = create_conn()

        username = input("사용자 ID를 입력하세요: ")
        password = input("비밀번호를 입력하세요: ")
        name = input("이름을 입력하세요: ")
        email = input("이메일을 입력하세요: ")

        sql = """
        INSERT INTO users (username, password, name, email)
        VALUES (%s, %s, %s, %s)
        """

        user_data = (username, password, name, email)
        cursor.execute(sql, user_data) # 쿼리 실행
        conn.commit() # 값 업데이트

        print("사용자 등록이 완료되었습니다.")

    except Error as e:
        print("유저 생성 오류", e)

    finally: # 위의 동작이 끝나면
        if conn.is_connected():
            cursor.close()
            conn.close()

def get_users(): # 유저 리스트 가져오기
    try:
        conn, cursor = create_conn()

        cursor.execute(" SELECT * FROM users")
        #conn.commit() # 값을 바꾸지 않기 때문에 commit하지 않음
        result = cursor.fetchall()

        for row in result:
            print(row)

        print("사용자를 모두 불러왔습니다.")

    except Error as e:
        print("유저 조회 오류", e)

    finally: # 위의 동작이 끝나면 연결 끊음
        if conn.is_connected():
            cursor.close()
            conn.close()

def update_user(): # 유저 정보 업데이트
    try:
        conn, cursor = create_conn()

        username = input("사용자 ID를 입력하세요: ")
        new_name = input("이름을 입력하세요: ")
        new_email = input("이메일을 입력하세요: ")

        sql = """
        UPDATE users SET name = %s, email = %s WHERE username = %s
        """

        user_data = (new_name, new_email, username) # 쿼리에 사용할 데이터
        cursor.execute(sql, user_data) # 쿼리 실행
        conn.commit() # 값 업데이트

        print("사용자 정보 수정이 완료되었습니다.")

    except Error as e:
        print("유저 정보 수정 오류", e)

    finally: # 위의 동작이 끝나면
        if conn.is_connected():
            cursor.close()
            conn.close()

def delete_user(): # 유저 삭제
    try:
        conn, cursor = create_conn()

        username = input("삭제할 ID를 입력하세요: ")

        sql = """
        DELETE FROM users WHERE username = %s
        """

        cursor.execute(sql, (username,)) # 쿼리 실행
        conn.commit() # 값 업데이트

        print("사용자 정보 수정이 완료되었습니다.")

    except Error as e:
        print("유저 삭제 오류", e)

    finally: # 위의 동작이 끝나면
        if conn.is_connected():
            cursor.close()
            conn.close()

while True:
    print("[메뉴]")
    print("1. 유저 생성")
    print("2. 유저 조회")
    print("3. 유저 수정")
    print("4. 유저 삭제")
    print("0. 종료")

    choice = input("입력을 선택하세요:")

    if choice == "1":
        create_user() # 유저 생성
    elif choice == "2":
        get_users() # 유저 조회
    elif choice == "3":
        update_user() # 유저 정보 수정
    elif choice == "4":
        delete_user() # 유저 삭제
    elif choice == "0":
        break
    else:
        print("잘못된 입력이에요.")