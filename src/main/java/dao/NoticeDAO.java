package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import dto.NoticeDTO;
// DB연동 , 공지사항 목록 확인 , 상세페이지 , 조회수 증가 확인
public class NoticeDAO {

    // (1) 목록 조회: SELECT 이용
    // notice테이블에서 모든 데이터를 가져온 뒤 , 리스트로 반환시킴
    public List<NoticeDTO> getNoticeList() {
        List<NoticeDTO> list = new ArrayList<>();
        // 최신 글이 위로 오도록 noticeNo 기준 DESC(내림차순) 정렬합니다.
        String sql = "SELECT * FROM notice ORDER BY noticeNo DESC";

        try (Connection conn = DBconn.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                list.add(new NoticeDTO(
                        rs.getInt("noticeNo"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getInt("writerNo"),
                        rs.getInt("hit"),
                        rs.getDate("reg_date")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    // (2)상세 조회: SELECT 이용
    // 특정 ID를 가진 글을 상세히 가져옴 (공지사항 제목 클릭 시)
    public NoticeDTO getNotice(int noticeId) {
        String sql = "SELECT * FROM notice WHERE noticeNo = ?";

        try (Connection conn = DBconn.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, noticeId); // ?에 noticeId 값을 매핑

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    // 데이터베이스에서 값을 꺼내 DTO 전체 생성자로 객체를 생성하여 반환합니다.
                    return new NoticeDTO(
                            rs.getInt("noticeNo"),
                            rs.getString("title"),
                            rs.getString("content"),
                            rs.getInt("writerNo"),
                            rs.getInt("hit"),
                            rs.getDate("reg_date"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // 글이 없으면 null 반환
    }

    //(3) 조회수 증가: UPDATE 이용
    // User가 게시글 클릭했을 시 조회수 1 증가
    public void incrementHit(int noticeId) {
        String sql = "UPDATE notice SET hit = hit + 1 WHERE noticeNo = ?";

        try (Connection conn = DBconn.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, noticeId);
            pstmt.executeUpdate(); // DB의 데이터를 수정하는 쿼리 실행
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}