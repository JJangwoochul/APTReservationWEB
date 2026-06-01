package dao;

import java.sql.*;
import java.util.ArrayList;
import dto.ReserveDTO;

public class ReserveDAO {
    // (1) 싱글톤 인스턴스: 유일한 객체 생성
    private static ReserveDAO instance = new ReserveDAO();

    // (2) 생성자를 private으로 선언하여 외부에서 객체 생성 차단
    private ReserveDAO() {
    }

    // (3) 외부에서 싱글톤 객체에 접근하기 위한 메서드
    public static ReserveDAO getInstance() {
        return instance;
    }

    // 1. 전체 예약 목록 조회
    public ArrayList<ReserveDTO> getAllReserves() throws SQLException {
        ArrayList<ReserveDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM reserve";

        // (4) Try-with-resources 적용으로 자원 누수 완벽 차단
        try (Connection conn = DBconn.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery()) {

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
        }
        return list;
    }

    // 2. 예약 추가 (INSERT)
    public void addReserve(ReserveDTO dto) throws SQLException {
        String sql = "INSERT INTO reserve (reserveNo, facilityNo, userNo, reserveDate, useDate, startTime, endTime, price, status) "
                + "VALUES (reserve_seq.NEXTVAL, ?, ?, SYSDATE, ?, ?, ?, ?, ?)";

        try (Connection conn = DBconn.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, dto.getFacilityNo());
            pstmt.setInt(2, dto.getUserNo());
            pstmt.setString(3, dto.getUseDate());
            pstmt.setInt(4, dto.getStartTime());
            pstmt.setInt(5, dto.getEndTime());
            pstmt.setInt(6, dto.getPrice());
            pstmt.setString(7, dto.getStatus());
            pstmt.executeUpdate();
        }
    }

    // 3. 사용자별 예약 목록 조회
    public ArrayList<ReserveDTO> getActiveReservesByUser(int userNo) throws SQLException {
        ArrayList<ReserveDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM reserve WHERE userNo = ? AND status = 'ACTIVE' ORDER BY reserveDate ASC";

        try (Connection conn = DBconn.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userNo);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    // DTO 부분 생성자 활용
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
            }
        }
        return list;
    }

    // 4. 예약 취소 (DELETE)
    public void deleteReserve(int reserveNo) throws SQLException {
        String sql = "DELETE FROM reserve WHERE reserveNo = ?";

        try (Connection conn = DBconn.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, reserveNo);
            pstmt.executeUpdate();
        }
    }

    // 5. 사용자의 과거/취소된 예약 내역 조회 (이용내역 탭용)
    public ArrayList<ReserveDTO> getHistoryReservesByUser(int userNo) throws SQLException {
        ArrayList<ReserveDTO> list = new ArrayList<>();
        // 상태가 'COMPLETED' 이거나 'CANCELLED'인 데이터만 조회
        String sql = "SELECT * FROM reserve WHERE userNo = ? AND status IN ('COMPLETED', 'CANCELLED') ORDER BY useDate DESC";

        try (Connection conn = DBconn.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userNo);
            try (ResultSet rs = pstmt.executeQuery()) {
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
            }
        }
        return list;
    }

    // 6. 예약 상태 변경 (취소, 완료 처리 등)
    public void updateReserveStatus(int reserveNo, String status) throws SQLException {
        String sql = "UPDATE reserve SET status = ? WHERE reserveNo = ?";

        try (Connection conn = DBconn.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, status);
            pstmt.setInt(2, reserveNo);
            pstmt.executeUpdate();
        }
    }
    
    // 7. 예약 번호로 특정 예약 정보 하나만 조회 (추가)
    public ReserveDTO getReserveByNo(int reserveNo) throws SQLException {
        ReserveDTO dto = null; // 결과가 없을 경우 null 반환
        String sql = "SELECT * FROM reserve WHERE reserveNo = ?";

        try (Connection conn = DBconn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, reserveNo);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) { // 데이터가 존재하면 DTO 생성
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
            }
        }
        return dto;
    }

    // 8. 최근 1개월간의 이용 내역 조회 (이용내역 탭용)
    public ArrayList<ReserveDTO> getRecentHistoryReservesByUser(int userNo) throws SQLException {
        ArrayList<ReserveDTO> list = new ArrayList<>();
    // useDate가 현재 날짜로부터 1개월 이내인 내역만 조회
    // ORACLE 기준: ADD_MONTHS(SYSDATE, -1)
        String sql = "SELECT * FROM reserve WHERE userNo = ? " +
                    "AND status IN ('COMPLETED', 'CANCELLED') " + 
                    "AND useDate >= TRUNC(SYSDATE, 'MM') " +
                    "AND useDate < ADD_MONTHS(TRUNC(SYSDATE, 'MM'), 1) " +
                    "ORDER BY useDate DESC";

        try (Connection conn = DBconn.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userNo);
            try (ResultSet rs = pstmt.executeQuery()) {
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
            }
        }
        return list;
    }
}