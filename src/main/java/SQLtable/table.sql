CREATE TABLE notice ( --공지사항 DB
    noticeNo    NUMBER PRIMARY KEY,         -- PK
    title       VARCHAR2(200) NOT NULL,     -- 공지사항 제목
    content     CLOB,                       -- 긴 글을 위해 CLOB 권장
    writerNo    NUMBER NOT NULL,            -- 작성자(관리자) ID
    hit         NUMBER DEFAULT 0,           -- 조회수
    reg_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 작성일
    CONSTRAINT fk_notice_writer FOREIGN KEY(writerNo) REFERENCES users(userNo)
);

CREATE TABLE users (    --USER DB
    userNo      NUMBER PRIMARY KEY,         -- PK
    userId      VARCHAR2(50) UNIQUE NOT NULL, -- 로그인 ID (중복방지)
    userPw      VARCHAR2(100) NOT NULL,    -- 비밀번호 (암호화 대비 넉넉하게)
    userName    VARCHAR2(50) NOT NULL,  --유저이름
    phone       VARCHAR2(20),           --핸드폰번호(회원가입때 기입)
    dong        VARCHAR2(10),           --사는 아파트 동(201동)
    ho          VARCHAR2(10),           --사는 아파드 호(101호)
    role        VARCHAR2(20) DEFAULT 'USER', -- 'USER' 또는 'ADMIN' 구분
    reg_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP --회원가입 날
);
CREATE TABLE facility ( --Facility DB
    facilityNo      NUMBER          PRIMARY KEY,  -- 시설번호      
    facilityName    VARCHAR2(100)   NOT NULL,      -- 시설 이름
    description     VARCHAR2(1000)  ,           -- 시설 상세설명
    facilityPrice   NUMBER,                     -- 시설 이용 가격
    condition       VARCHAR2(50),               -- 시설 상태
    peopleInStock   NUMBER,                     -- 수용인원
    fileName        VARCHAR2(200),              -- 시설 사진 파일이름
    quantity        NUMBER          DEFAULT 0   -- 예약중인 인원
);

CREATE TABLE reserve (  --Reserve DB
    reserveNo       NUMBER PRIMARY KEY,         --PK
    facilityNo      NUMBER NOT NULL,            --FK
    userNo          NUMBER NOT NULL,            --FK
    reserveDate     DATE DEFAULT SYSDATE,      -- 예약 신청일 (기존 것 유지!)
    useDate         DATE NOT NULL,             -- 실제 이용일
    startTime       NUMBER NOT NULL,           -- 이용 시작 시간
    endTime         NUMBER NOT NULL,           -- 이용 종료 시간
    price           NUMBER DEFAULT 0,          -- 결제 금액
    status          VARCHAR2(20) DEFAULT 'ACTIVE', -- 예약 상태
    CONSTRAINT chk_status_type CHECK (status IN ('ACTIVE', 'COMPLETED', 'CANCELLED')),
    -- 외래키 설정
    CONSTRAINT fk_facility FOREIGN KEY (facilityNo) REFERENCES facility(facilityNo),
    CONSTRAINT fk_user FOREIGN KEY (userNo) REFERENCES users(userNo)
);

-- 공지사항 번호용 시퀀스
CREATE SEQUENCE notice_seq START WITH 1 INCREMENT BY 1;

-- 회원 번호용 시퀀스
CREATE SEQUENCE user_seq START WITH 1 INCREMENT BY 1;

-- 시설 번호 시퀀스
CREATE SEQUENCE facility_seq START WITH 1 INCREMENT BY 1;

-- 예약 번호 시퀀스
CREATE SEQUENCE reserve_seq START WITH 1 INCREMENT BY 1;

-- 관리자 유저 추가
INSERT INTO users (userNo, userId, userPw, userName, phone, dong, ho, role) 
VALUES (user_seq.NEXTVAL, 'admin', '1234', '관리자', '010-0000-0000', '000', '000', 'ADMIN');

-- 일반 유저 추가
INSERT INTO users (userNo, userId, userPw, userName, phone, dong, ho, role) 
VALUES (user_seq.NEXTVAL, 'user', '1234', '홍길동', '010-1234-5678', '101', '201', 'USER');

-- 공지사항 추가 (관리자 userNo가 1번이라고 가정)
INSERT INTO notice (noticeNo, title, content, writerNo) 
VALUES (notice_seq.NEXTVAL, '아파트 단지 내 시설 이용 안내', '안녕하세요. 시설 이용 시 주의사항입니다.', 1);

-- 시설 3개 추가
-- 구현할 당시 게스트하우스는 따로 날짜단위이기 때문에 facilityNo가 3번만 날짜단위가 나오게함
-- 따라서 1,2,4,5 이후 facilityNo들은 일반시설처럼 시간단위 , facilityNo가 3인 게스트하우스만 날짜단위
INSERT INTO facility (facilityNo, facilityName, description, facilityPrice, condition, peopleInStock) 
VALUES (facility_seq.NEXTVAL, '헬스장', '최신형 러닝머신 완비', 5000, 'OPEN', 20);

INSERT INTO facility (facilityNo, facilityName, description, facilityPrice, condition, peopleInStock) 
VALUES (facility_seq.NEXTVAL, '독서실', '조용한 환경의 학습 공간', 2000, 'OPEN', 10);

INSERT INTO facility (facilityNo, facilityName, description, facilityPrice, condition, peopleInStock) 
VALUES (facility_seq.NEXTVAL, '게스트하우스', '게스트하우스입니다.', 10000, 'OPEN', 10);