from fastapi import FastAPI, HTTPException
from db import create_conn
from pydantic import BaseModel

app = FastAPI()

class UserCreate(BaseModel):
    username: str
    password: str
    name: str
    email: str

class UserUpdate(BaseModel):
    name: str
    email: str

@app.get("/") # 데코레이터. 클라이언트가 get 요청으로 / 를 하였다면 루트 경로로 보냈어
def root():
    return {"messsage" : "FastAPI 앱이 정상 작동중입니다."}

@app.post("/users") # 이 경로로(users) 이 요청이(post) 오면 create_user가 자동으로 작동함 
def create_user(user: UserCreate): # 유저 생성. 클라이언트가 user 정보를 보내줘야만 한다
    # db와 연결하고 query문 날려서 유저 생성
    try:
        conn, cursor = create_conn()

        sql = """
        INSERT INTO users (username, password, name, email)
        VALUES (%s, %s, %s, %s)
        """

        user_data = (user.username, user.password, user.name, user.email)
        cursor.execute(sql, user_data) # 쿼리 실행
        conn.commit() # 값 업데이트

        return {"message" : "사용자 등록이 완료되었습니다."}

    except Exception as e: # 에러가 생기면
        raise HTTPException(status_code = 400, detail=str(e)) # 400 에러 제목 및 내용 반환

    finally: # 위의 동작이 끝나면
        if conn.is_connected():
            cursor.close()
            conn.close()

@app.get("/users") # 데코레이터. 클라이언트가 get 요청으로 /users 를 하였다면 유저 목록 반환해주기
def get_users(): # 유저 리스트 가져오기
    try:
        conn, cursor = create_conn()

        cursor.execute(" SELECT * FROM users")
        #conn.commit() # 값을 바꾸지 않기 때문에 commit하지 않음
        return cursor.fetchall() # cursor 결과를 그대로 전부 return 하기

    except Exception as e:
        raise HTTPException(status_code = 400, detail=str(e)) # 400 에러 제목 및 내용 반환

    finally: # 위의 동작이 끝나면 연결 끊음
        if conn.is_connected():
            cursor.close()
            conn.close()

@app.put("/users/{username}") # 데코레이터. 클라이언트가 put 요청으로 /users 를 하였다면 유저 수정하기
def update_user(username:str, user:UserUpdate): # 유저 정보 업데이트. UserUpdate는 위에 정의된 class를 가리킴
    try:
        conn, cursor = create_conn()

        sql = """
        UPDATE users SET name = %s, email = %s WHERE username = %s
        """

        user_data = (user.name, user.email, username) # 쿼리에 사용할 데이터
        cursor.execute(sql, user_data) # 쿼리 실행
        conn.commit() # 값 업데이트

        return {"message" : "사용자 정보 수정이 완료되었습니다."}

    except Exception as e:
        raise HTTPException(status_code = 400, detail=str(e)) # 400 에러 제목 및 내용 반환

    finally: # 위의 동작이 끝나면
        if conn.is_connected():
            cursor.close()
            conn.close()

@app.delete("/users/{username}") # 데코레이터. 클라이언트가 put 요청으로 /users 를 하였다면 유저 수정하기
def delete_user(username:str): # 유저 삭제
    try:
        conn, cursor = create_conn()

        sql = """
        DELETE FROM users WHERE username = %s
        """

        cursor.execute(sql, (username,)) # 쿼리 실행
        conn.commit() # 값 업데이트

        return {"message" : "사용자가 삭제 되었습니다."}

    except Exception as e:
        raise HTTPException(status_code = 400, detail=str(e)) # 400 에러 제목 및 내용 반환

    finally: # 위의 동작이 끝나면
        if conn.is_connected():
            cursor.close()
            conn.close()