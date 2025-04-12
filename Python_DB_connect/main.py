from fastapi import FastAPI, HTTPException, Depends
from db import Base, engine, SessionLocal
from pydantic import BaseModel
from models import User
from sqlalchemy.orm import Session

Base.metadata.create_all(bind=engine)

app = FastAPI()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

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
def create_user(user: UserCreate, db: Session = Depends(get_db)): # 유저 생성. 클라이언트가 user 정보를 보내줘야만 한다
    # db와 연결하고 query문 날려서 유저 생성
    user_data = User(
        username=user.username,
        password=user.password,
        name=user.name,
        email=user.email
    )
    try:
        db.add(user_data)
        db.commit()

        return {"message" : "사용자 등록이 완료되었습니다."}

    except Exception as e: # 에러가 생기면
        raise HTTPException(status_code = 400, detail=str(e)) # 400 에러 제목 및 내용 반환

@app.get("/users") # 데코레이터. 클라이언트가 get 요청으로 /users 를 하였다면 유저 목록 반환해주기
def get_users(db: Session = Depends(get_db)): # 유저 리스트 가져오기
    try:
        result = db.query(User).all()
        return result # 결과를 그대로 전부 return 하기

    except Exception as e:
        raise HTTPException(status_code = 400, detail=str(e)) # 400 에러 제목 및 내용 반환

@app.put("/users/{username}") # 데코레이터. 클라이언트가 put 요청으로 /users 를 하였다면 유저 수정하기
def update_user(username:str, user:UserUpdate, db: Session = Depends(get_db)): # 유저 정보 업데이트. UserUpdate는 위에 정의된 class를 가리킴
    try:
        db_user = db.query(User).filter(User.username == username).first()
        db_user.name = user.name
        db_user.email = user.email
        db.commit()

        return {"message" : "사용자 정보 수정이 완료되었습니다."}

    except Exception as e:
        raise HTTPException(status_code = 400, detail=str(e)) # 400 에러 제목 및 내용 반환


@app.delete("/users/{username}") # 데코레이터. 클라이언트가 put 요청으로 /users 를 하였다면 유저 수정하기
def delete_user(username:str, db: Session = Depends(get_db)): # 유저 삭제
    try:
        db_user = db.query(User).filter(User.username == username).first()
        db.delete(db_user)
        db.commit()

        return {"message" : "사용자가 삭제 되었습니다."}

    except Exception as e:
        raise HTTPException(status_code = 400, detail=str(e)) # 400 에러 제목 및 내용 반환
