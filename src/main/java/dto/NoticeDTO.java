package dto;

import java.io.Serializable;
import java.util.Date;

public class NoticeDTO implements Serializable {
    private static final long serialVersionUID = 4L;

    private int noticeId; // 글 번호 (PK)
    private String title; // 제목
    private String content; // 내용
    private int writerNo; // 작성자 번호 (FK)
    private int hit; // 조회수
    private Date upLoadDate; // 작성일

    public NoticeDTO() {
        super();
    }

    // (3) 전체 생성자: DB에서 모든 정보를 조회할 때 사용
    public NoticeDTO(int noticeId, String title, String content, int writerNo, int hit, Date upLoadDate) {
        this.noticeId = noticeId;
        this.title = title;
        this.content = content;
        this.writerNo = writerNo;
        this.hit = hit;
        this.upLoadDate = upLoadDate;
    }

    public static long getSerialversionuid() {
        return serialVersionUID;
    }

    public int getNoticeId() {
        return noticeId;
    }

    public void setNoticeId(int noticeId) {
        this.noticeId = noticeId;
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

    public Date getupLoadDate() {
        return upLoadDate;
    }

    public void setupLoadDate(Date upLoadDate) {
        this.upLoadDate = upLoadDate;
    }
}