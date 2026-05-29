package dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import dto.NoticeDTO;

public class NoticeDAO {

    // (1) 목록 조회 기능: 전체 생성자를 사용하여 코드량을 획기적으로 줄임
    public List<NoticeDTO> getNoticeList() {
        List<NoticeDTO> list = new ArrayList<>();

        // 생성자를 활용하여 객체 생성과 동시에 값을 초기화 (가독성 향상)
        // 전체 생성자 순서: noticeId, title, content, writerNo, hit, upLoadDate
        list.add(new NoticeDTO(1, "아파트 공지사항 테스트입니다.", "현재 가짜 데이터를 사용하여 목록을 불러오는 중입니다.", 1, 10, new Date()));
        list.add(new NoticeDTO(2, "시스템 점검 안내", "내일 오전 2시부터 시스템 점검이 있습니다.", 1, 5, new Date()));

        return list;
    }

    // (2) 상세 조회 기능: 특정 ID에 맞는 데이터를 생성하여 반환
    public NoticeDTO getNotice(int noticeId) {
        // 실제 DB 연동 시에는 여기서 'SELECT * FROM notice WHERE noticeId = ?' 쿼리를 수행
        return new NoticeDTO(noticeId,
                "상세보기 테스트 글 번호: " + noticeId,
                "이 글은 상세 조회 기능을 테스트하기 위한 가짜 데이터입니다.",
                1,
                99,
                new Date());
    }
}