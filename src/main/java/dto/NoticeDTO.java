package dto;

import java.io.Serializable;
import java.util.Date;

// (1) DTO(Data Transfer Object): DB의 테이블과 1:1로 매핑되는 객체
public class NoticeDTO implements Serializable {
    private static final long serialVersionUID = 4L;

    // (2) 필드명 통일: DB 컬럼명과 일치시켜 가독성 확보
    private int noticeNo; // 글 번호 (PK)
    private String title; // 제목
    private String content; // 내용
    private int writerNo; // 작성자 번호 (FK)
    private int hit; // 조회수
    private Date regDate; // 작성일

    public NoticeDTO() {
        super();
    }

    // (3) 전체 생성자: DB 조회 결과(ResultSet)를 객체로 변환할 때 사용
    public NoticeDTO(int noticeNo, String title, String content, int writerNo, int hit, Date regDate) {
        this.noticeNo = noticeNo;
        this.title = title;
        this.content = content;
        this.writerNo = writerNo;
        this.hit = hit;
        this.regDate = regDate;
    }

    // (4) Getter / Setter: 캡슐화(Encapsulation) 원칙 준수
    public int getNoticeNo() {
        return noticeNo;
    }

    public void setNoticeNo(int noticeNo) {
        this.noticeNo = noticeNo;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getWriterNo() {
        return writerNo;
    }

    public void setWriterNo(int writerNo) {
        this.writerNo = writerNo;
    }

    public int getHit() {
        return hit;
    }

    public void setHit(int hit) {
        this.hit = hit;
    }

    public Date getRegDate() {
        return regDate;
    }

    public void setRegDate(Date regDate) {
        this.regDate = regDate;
    }
}