package dto;

import java.io.Serializable;
import java.util.Date;

public class NoticeDTO implements Serializable {
    private static final long serialVersionUID = 4L;

    private int noticeNo; // 글 번호 (PK)
    private String title; // 공지사항 제목
    private String content; // 공지사항 내용
    private int writerNo; // 작성자 번호 (FK)
    private int hit; // 조회수
    private Date regDate; // 작성일

    public NoticeDTO() {
        super();
    }

    public NoticeDTO(int noticeNo, String title, String content, int writerNo, int hit, Date regDate) {
        this.noticeNo = noticeNo;
        this.title = title;
        this.content = content;
        this.writerNo = writerNo;
        this.hit = hit;
        this.regDate = regDate;
    }

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