CREATE TABLE notice (
    noticeNo    NUMBER PRIMARY KEY,         -- PK
    title       VARCHAR2(200) NOT NULL,     -- 공지사항 제목
    content     CLOB,                       -- 긴 글을 위해 CLOB 권장
    writerNo    NUMBER NOT NULL,            -- 작성자(관리자) ID
    hit         NUMBER DEFAULT 0,           -- 조회수
    reg_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 작성일
    CONSTRAINT fk_notice_writer FOREIGN KEY(writerNo) REFERENCES users(userNo)
);

CREATE TABLE users (
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



CREATE TABLE reserve (
    reserveNo       NUMBER PRIMARY KEY,
    facilityNo      NUMBER NOT NULL,
    userNo          NUMBER NOT NULL,
    reserveDate     VARCHAR2(50)
);

CREATE TABLE facility (
    facilityNo      NUMBER          PRIMARY KEY,        
    facilityName    VARCHAR2(100)   NOT NULL,    
    description     VARCHAR2(1000)  ,
    facilityPrice   NUMBER,
    condition       VARCHAR2(50),
    peopleInStock   NUMBER,
    fileName        VARCHAR2(200),
    quantity        NUMBER          DEFAULT 0          
);