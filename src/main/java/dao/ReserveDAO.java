package dao;

import java.sql.*;
import java.util.ArrayList;
import dto.ReserveDTO;

// 예약 시스템 클래스 , 예약 생성,조회,취소,완료 등 
public class ReserveDAO {
    private static ReserveDAO instance = new ReserveDAO();

    private ReserveDAO() {
    }

    public static ReserveDAO getInstance() {
        return instance;
    }

    // 1. 전체 예약 목록 조회
    public ArrayList<ReserveDTO> getAllReserves() throws SQLException {
        ArrayList<ReserveDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM reserve";

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ReserveDTO dto = new ReserveDTO(
                        rs.getInt("reserveNo"),
                        rs.getInt("facilityNo"),
                        rs.getInt("userNo"),
                        rs.getString("reserveDate"),
                        rs.getString("useDate"),
                        rs.getInt("startTime"),
                        rs.getInt("endTime"),
                        rs.getInt("price"),
                        rs.getString("status"));
                list.add(dto);
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
        return list;
    }

    // 2. 예약 추가 (INSERT)
    public void addReserve(ReserveDTO dto) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "INSERT INTO reserve (reserveNo, facilityNo, userNo, reserveDate, useDate, startTime, endTime, price, status) "
                + "VALUES (reserve_seq.NEXTVAL, ?, ?, SYSDATE, ?, ?, ?, ?, ?)";
        
        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, dto.getFacilityNo());
            pstmt.setInt(2, dto.getUserNo());
            pstmt.setString(3, dto.getUseDate());
            pstmt.setInt(4, dto.getStartTime());
            pstmt.setInt(5, dto.getEndTime());
            pstmt.setInt(6, dto.getPrice());
            pstmt.setString(7, dto.getStatus());
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    // 3. 사용자별 예약 목록 조회
    public ArrayList<ReserveDTO> getActiveReservesByUser(int userNo) throws SQLException {
        ArrayList<ReserveDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM reserve WHERE userNo = ? AND status = 'ACTIVE' ORDER BY reserveDate ASC";

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userNo);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ReserveDTO dto = new ReserveDTO(
                        rs.getInt("reserveNo"),
                        rs.getInt("facilityNo"),
                        rs.getInt("userNo"),
                        rs.getString("reserveDate"),
                        rs.getString("useDate"),
                        rs.getInt("startTime"),
                        rs.getInt("endTime"),
                        rs.getInt("price"),
                        rs.getString("status"));
                list.add(dto);
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
        return list;
    }

    // 4. 예약 취소 (DELETE)
    public void deleteReserve(int reserveNo) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "DELETE FROM reserve WHERE reserveNo = ?";

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, reserveNo);
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    // 5. 사용자의 과거/취소된 예약 내역 조회
    public ArrayList<ReserveDTO> getHistoryReservesByUser(int userNo) throws SQLException {
        ArrayList<ReserveDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM reserve WHERE userNo = ? AND status IN ('COMPLETED', 'CANCELLED') ORDER BY useDate DESC";

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userNo);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ReserveDTO dto = new ReserveDTO(
                        rs.getInt("reserveNo"),
                        rs.getInt("facilityNo"),
                        rs.getInt("userNo"),
                        rs.getString("reserveDate"),
                        rs.getString("useDate"),
                        rs.getInt("startTime"),
                        rs.getInt("endTime"),
                        rs.getInt("price"),
                        rs.getString("status"));
                list.add(dto);
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
        return list;
    }

    // 6. 예약 상태 변경
    public void updateReserveStatus(int reserveNo, String status) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "UPDATE reserve SET status = ? WHERE reserveNo = ?";

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            pstmt.setInt(2, reserveNo);
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    // 7. 예약 번호로 특정 예약 정보 하나만 조회
    public ReserveDTO getReserveByNo(int reserveNo) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ReserveDTO dto = null;
        String sql = "SELECT * FROM reserve WHERE reserveNo = ?";

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, reserveNo);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                dto = new ReserveDTO(
                        rs.getInt("reserveNo"),
                        rs.getInt("facilityNo"),
                        rs.getInt("userNo"),
                        rs.getString("reserveDate"),
                        rs.getString("useDate"),
                        rs.getInt("startTime"),
                        rs.getInt("endTime"),
                        rs.getInt("price"),
                        rs.getString("status"));
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
        return dto;
    }

    // 8. 최근 1개월간의 이용 내역 조회
    public ArrayList<ReserveDTO> getRecentHistoryReservesByUser(int userNo) throws SQLException {
        ArrayList<ReserveDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM reserve WHERE userNo = ? " +
                "AND status IN ('COMPLETED', 'CANCELLED') " +
                "AND TRUNC(useDate) >= ADD_MONTHS(TRUNC(SYSDATE, 'MM'), -1) " +
                "AND TRUNC(useDate) < TRUNC(SYSDATE, 'MM') " +
                "ORDER BY useDate DESC";

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userNo);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ReserveDTO dto = new ReserveDTO(
                        rs.getInt("reserveNo"),
                        rs.getInt("facilityNo"),
                        rs.getInt("userNo"),
                        rs.getString("reserveDate"),
                        rs.getString("useDate"),
                        rs.getInt("startTime"),
                        rs.getInt("endTime"),
                        rs.getInt("price"),
                        rs.getString("status"));
                list.add(dto);
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
        return list;
    }

    // 9. 특정 시설의 특정 날짜 예약 건수 조회
    public int getReservedCount(int facilityNo, String useDate, int startTime) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count = 0;
        String sql = "SELECT COUNT(*) FROM reserve WHERE facilityNo = ? AND useDate = ? AND startTime = ? AND status = 'ACTIVE'";

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, facilityNo);
            pstmt.setString(2, useDate);
            pstmt.setInt(3, startTime);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
        return count;
    }
}