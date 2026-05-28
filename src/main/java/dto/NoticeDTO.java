package dto;

import java.io.Serializable;
import java.util.Date;

public class NoticeDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private int noticeId;       // 글 번호
    private String title;       // 제목
    private String content;     // 내용
    private Date upLoadDate;    // 작성일

    public NoticeDTO() {
        super();
    }

    public NoticeDTO(int noticeId, String title, Date upLoadDate) {
        this.noticeId = noticeId;
        this.title = title;
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

    public Date getupLoadDate() {
        return upLoadDate;
    }

    public void setupLoadDate(Date upLoadDate) {
        this.upLoadDate = upLoadDate;
    }
}