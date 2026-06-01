package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import dto.NoticeDTO;

public class NoticeDAO {
    // 싱글톤 인스턴스
    private static NoticeDAO instance = new NoticeDAO();

    private NoticeDAO() {
    }

    public static NoticeDAO getInstance() {
        return instance;
    }

    // (1) 목록 조회
    public List<NoticeDTO> getNoticeList() throws SQLException {
        List<NoticeDTO> list = new ArrayList<>();
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
        }
        return list;
    }

    // (2) 상세 조회
    public NoticeDTO getNotice(int noticeNo) throws SQLException { // 파라미터명 변경
        String sql = "SELECT * FROM notice WHERE noticeNo = ?";
        try (Connection conn = DBconn.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, noticeNo); // 파라미터명 변경
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new NoticeDTO(
                            rs.getInt("noticeNo"),
                            rs.getString("title"),
                            rs.getString("content"),
                            rs.getInt("writerNo"),
                            rs.getInt("hit"),
                            rs.getDate("reg_date"));
                }
            }
        }
        return null;
    }

    // (3) 조회수 증가
    public void incrementHit(int noticeNo) throws SQLException { // 파라미터명 변경
        String sql = "UPDATE notice SET hit = hit + 1 WHERE noticeNo = ?";
        try (Connection conn = DBconn.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, noticeNo); // 파라미터명 변경
            pstmt.executeUpdate();
        }
    }

    // (4) 공지 삭제 메서드
    public void deleteNotice(int noticeNo) throws SQLException { // 파라미터명 변경
        String sql = "DELETE FROM notice WHERE noticeNo = ?";

        try (Connection conn = DBconn.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, noticeNo); // 파라미터명 변경
            pstmt.executeUpdate();
        }
    }

    // (5) 공지 업데이트(수정) 메서드
    public void updateNotice(NoticeDTO dto) throws SQLException {
        String sql = "UPDATE notice SET title = ?, content = ? WHERE noticeNo = ?";

        try (Connection conn = DBconn.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getContent());
            pstmt.setInt(3, dto.getNoticeNo()); // DTO의 바뀐 메서드 사용
            pstmt.executeUpdate();
        }
    }

    // (6) 공지사항 등록 메서드
    public void insertNotice(NoticeDTO dto) throws SQLException {
        // noticeNo는 시퀀스(Sequence)를 사용해 자동 증가시킨다고 가정합니다.
        String sql = "INSERT INTO notice (noticeNo, title, content, writerNo, hit, reg_date) " +
                "VALUES (notice_seq.NEXTVAL, ?, ?, ?, 0, SYSDATE)";

        try (Connection conn = DBconn.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getContent());
            pstmt.setInt(3, dto.getWriterNo()); // 작성자 번호 추가
            pstmt.executeUpdate();
        }
    }
}