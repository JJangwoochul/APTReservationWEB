package dao;

import java.sql.*;
import java.util.ArrayList;
import dto.ReserveDTO;

public class ReserveDAO {
    // 싱글톤 패턴: 어디서든 동일한 인스턴스를 사용하기 위함
    private static ReserveDAO instance = new ReserveDAO();
    public static ReserveDAO getInstance() { return instance; }
    private ReserveDAO() {}

    // 1. 전체 예약 목록 조회
    // 데이터베이스의 모든 예약 데이터를 가져와 ReserveDTO 리스트로 반환
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
                    rs.getString("reserveDate")
                );
                list.add(dto);
            }
        } finally {
            // 자원 해제
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
        return list;
    }

    // 2. 예약 추가 (INSERT)
    // 새로운 예약 건을 reserve 테이블에 삽입
    public void addReserve(ReserveDTO dto) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "INSERT INTO reserve (reserveNo, facilityNo, userNo, reserveDate) VALUES (reserve_seq.NEXTVAL, ?, ?, ?)";
        
        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, dto.getFacilityNo());
            pstmt.setInt(2, dto.getUserNo());
            pstmt.setString(3, dto.getReserveDate());
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    // 3. 사용자별 예약 목록 조회
    // 마이페이지 등에서 특정 유저가 신청한 예약 내역만 필터링하여 조회
    public ArrayList<ReserveDTO> getReservesByUser(int userNo) throws SQLException {
        ArrayList<ReserveDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM reserve WHERE userNo = ? ORDER BY reserveDate DESC";
        
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
                    rs.getString("reserveDate")
                );
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
    // 시설 번호가 아닌, 예약 고유 번호(reserveNo)를 기준으로 삭제하여 데이터 무결성 보장
    public void deleteReserve(int reserveNo) {
        String sql = "DELETE FROM reserve WHERE reserveNo = ?";
        
        try (Connection conn = DBconn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, reserveNo);
            pstmt.executeUpdate(); // DB에서 즉시 삭제 실행
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}