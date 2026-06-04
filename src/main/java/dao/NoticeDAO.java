package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import dto.NoticeDTO;

// Notice관련 관리 클래스
public class NoticeDAO {
    // 싱글톤 인스턴스
    private static NoticeDAO instance = new NoticeDAO();

    private NoticeDAO() {
    }

    public static NoticeDAO getInstance() {
        return instance;
    }

    // (1) 목록 조회 , 최신글 우선(DESC)
    public List<NoticeDTO> getNoticeList() throws SQLException {
        List<NoticeDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM notice ORDER BY noticeNo DESC";

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(new NoticeDTO(
                        rs.getInt("noticeNo"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getInt("writerNo"),
                        rs.getInt("hit"),
                        rs.getDate("reg_date")));
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
        return list;
    }

    // (2) 상세 조회 , PK인 noticeNo를 이용해 1개의 데이터만 가져옴
    public NoticeDTO getNotice(int noticeNo) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM notice WHERE noticeNo = ?";
        NoticeDTO dto = null;

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, noticeNo);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                dto = new NoticeDTO(
                        rs.getInt("noticeNo"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getInt("writerNo"),
                        rs.getInt("hit"),
                        rs.getDate("reg_date"));
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
        return dto;
    }

    // (3) 조회수 증가 , 게시물 클릭시 , hit 1 증가
    public void incrementHit(int noticeNo) throws SQLException { 
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "UPDATE notice SET hit = hit + 1 WHERE noticeNo = ?";
        
        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, noticeNo);
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    // (4) 공지 삭제 메서드
    public void deleteNotice(int noticeNo) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "DELETE FROM notice WHERE noticeNo = ?";

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, noticeNo);
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    // (5) 공지 업데이트(수정) 메서드
    public void updateNotice(NoticeDTO dto) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "UPDATE notice SET title = ?, content = ? WHERE noticeNo = ?";

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getContent());
            pstmt.setInt(3, dto.getNoticeNo());
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    // (6) 공지사항 등록 메서드
    public void insertNotice(NoticeDTO dto) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "INSERT INTO notice (noticeNo, title, content, writerNo, hit, reg_date) " +
                "VALUES (notice_seq.NEXTVAL, ?, ?, ?, 0, SYSDATE)";

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getContent());
            pstmt.setInt(3, dto.getWriterNo());
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
}