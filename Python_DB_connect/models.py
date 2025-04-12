from sqlalchemy import Column, Integer, String, DateTime
from datetime import datetime, UTC
from db import Base

class User(Base): 
    __tablename__ = "users" # DB 연결만 되면 users 테이블을 객체의 형태로 사용할 수 있게 해줌

    user_id = Column(Integer, primary_key=True, index=True)
    username = Column(String(50), unique=True, nullable=False)
    password = Column(String(255), nullable=False)
    name = Column(String(100), nullable=False)
    email = Column(String(100), unique=True, nullable=False)
    created_at = Column(DateTime, default=datetime.now(UTC))