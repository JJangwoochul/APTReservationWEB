package dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import dto.NoticeDTO;

public class NoticeDAO {

    // (1) 목록 조회 기능
    public List<NoticeDTO> getNoticeList() {
        List<NoticeDTO> list = new ArrayList<>();

        //공지사항 1
        NoticeDTO n1 = new NoticeDTO();
        n1.setNoticeId(1);
        n1.setTitle("아파트 공지사항 테스트입니다.");
        n1.setContent("현재 가짜 데이터를 사용하여 목록을 불러오는 중입니다.");
        n1.setupLoadDate(new Date());

        //공지사항 2
        NoticeDTO n2 = new NoticeDTO();
        n2.setNoticeId(2);
        n2.setTitle("시스템 점검 안내");
        n2.setContent("내일 오전 2시부터 시스템 점검이 있습니다.");
        n2.setupLoadDate(new Date());

        list.add(n1);
        list.add(n2);

        return list;
    }

    // (2) 상세 조회 기능
    public NoticeDTO getNotice(int noticeId) {
        // 특정 ID에 해당하는 가상의 데이터 생성
        NoticeDTO notice = new NoticeDTO();
        notice.setNoticeId(noticeId);
        notice.setTitle("상세보기 테스트 글 번호: " + noticeId);
        notice.setContent("이 글은 상세 조회 기능을 테스트하기 위한 가짜 데이터입니다.");
        notice.setupLoadDate(new Date());
        
        return notice;
    }
}