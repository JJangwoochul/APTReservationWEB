package dao;

import java.sql.*;
import java.util.ArrayList;
import dto.FacilityDTO;

public class FacilityDAO {

    // 싱글톤 패턴: 단 하나의 인스턴스만 생성하여 공유
    private static FacilityDAO instance = new FacilityDAO();

    public static FacilityDAO getInstance() {
        return instance;
    }

    private FacilityDAO() {
    }

    // 1. 전체 목록 조회
    public ArrayList<FacilityDTO> getAllFacility() throws SQLException {
        ArrayList<FacilityDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM facility";

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                FacilityDTO dto = new FacilityDTO();
                dto.setFacilityNo(rs.getInt("facilityNo"));
                dto.setFacilityName(rs.getString("facilityName"));
                dto.setDescription(rs.getString("description"));
                dto.setFacilityPrice(rs.getInt("facilityPrice"));
                dto.setCondition(rs.getString("condition"));
                dto.setPeopleInStock(rs.getInt("peopleInStock"));
                dto.setFileName(rs.getString("fileName"));
                dto.setQuantity(rs.getInt("quantity"));
                list.add(dto);
            }
        } finally {
            if (rs != null)
                rs.close();
            if (pstmt != null)
                pstmt.close();
            if (conn != null)
                conn.close();
        }
        return list;
    }

    // 2. 신규 시설 등록
    public void addFacility(FacilityDTO dto) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "INSERT INTO facility (facilityNo, facilityName, description, facilityPrice, condition, peopleInStock, fileName, quantity) VALUES (facility_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?)";

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getFacilityName());
            pstmt.setString(2, dto.getDescription());
            pstmt.setInt(3, dto.getFacilityPrice());
            pstmt.setString(4, dto.getCondition());
            pstmt.setInt(5, dto.getPeopleInStock());
            pstmt.setString(6, dto.getFileName());
            pstmt.setInt(7, dto.getQuantity());

            pstmt.executeUpdate();
        } finally {
            if (pstmt != null)
                pstmt.close();
            if (conn != null)
                conn.close();
        }
    }

    // 3. 특정 시설 조회 (수정 화면용)
    public FacilityDTO getFacilityByNo(int facilityNo) throws SQLException {
        FacilityDTO dto = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM facility WHERE facilityNo = ?";

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, facilityNo);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dto = new FacilityDTO();
                dto.setFacilityNo(rs.getInt("facilityNo"));
                dto.setFacilityName(rs.getString("facilityName"));
                dto.setDescription(rs.getString("description"));
                dto.setFacilityPrice(rs.getInt("facilityPrice"));
                dto.setCondition(rs.getString("condition"));
                dto.setPeopleInStock(rs.getInt("peopleInStock"));
                dto.setFileName(rs.getString("fileName"));
                dto.setQuantity(rs.getInt("quantity"));
            }
        } finally {
            if (rs != null)
                rs.close();
            if (pstmt != null)
                pstmt.close();
            if (conn != null)
                conn.close();
        }
        return dto;
    }

    // 4. 시설 정보 수정
    public void updateFacility(FacilityDTO dto) throws SQLException {
    Connection conn = null;
    PreparedStatement pstmt1 = null;
    PreparedStatement pstmt2 = null;

    try {
        conn = DBconn.getConnection();
        conn.setAutoCommit(false); 
        
        // 1. 해당 시설의 기존 예약 내역을 모두 삭제
        String sql1 = "DELETE FROM reserve WHERE facilityNo = ?";
        pstmt1 = conn.prepareStatement(sql1);
        pstmt1.setInt(1, dto.getFacilityNo());
        pstmt1.executeUpdate();

        // 2. 시설 정보 수정 및 quantity를 0으로 고정
        String sql2 = "UPDATE facility SET facilityName=?, description=?, facilityPrice=?, condition=?, " +
                      "peopleInStock=?, fileName=?, quantity=0 WHERE facilityNo=?";
        pstmt2 = conn.prepareStatement(sql2);
        pstmt2.setString(1, dto.getFacilityName());
        pstmt2.setString(2, dto.getDescription());
        pstmt2.setInt(3, dto.getFacilityPrice());
        pstmt2.setString(4, dto.getCondition());
        pstmt2.setInt(5, dto.getPeopleInStock());
        pstmt2.setString(6, dto.getFileName());
        pstmt2.setInt(7, dto.getFacilityNo());
        pstmt2.executeUpdate();

        conn.commit(); // 모두 성공 시 커밋
    } catch (SQLException e) {
        if (conn != null) conn.rollback(); // 실패 시 롤백
        throw e;
    } finally {
        if (pstmt1 != null) pstmt1.close();
        if (pstmt2 != null) pstmt2.close();
        if (conn != null) conn.close();
    }
}

    // 5. 삭제
    public void deleteFacility(int facilityNo) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "DELETE FROM facility WHERE facilityNo = ?";

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, facilityNo);
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null)
                pstmt.close();
            if (conn != null)
                conn.close();
        }
    }

    // 6. 최대수용인원과 현재 예약인원 수를 비교해 예약 가능여부 확인
    public boolean isAvailable(int facilityNo) throws SQLException {
        boolean available = false; // 기본값 false 설정
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBconn.getConnection();
            // 수용인원(peopleInStock)에서 현재인원(quantity)을 뺀 값이 0보다 큰지 확인
            String sql = "SELECT (peopleInStock - quantity) AS remain FROM facility WHERE facilityNo = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, facilityNo);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                int remain = rs.getInt("remain");
                if (remain > 0) {
                    available = true;
                }
            }
        } finally {
            if (rs != null)
                rs.close();
            if (pstmt != null)
                pstmt.close();
            if (conn != null)
                conn.close();
        }

        return available;
    }

    // 7. 예약 성공 시 현재 예약 인원 1 증가
    public void increaseQuantity(int facilityNo) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "UPDATE facility SET quantity = quantity + 1 WHERE facilityNo = ?";

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, facilityNo);
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null)
                pstmt.close();
            if (conn != null)
                conn.close();
        }
    }

    // 8. 예약 취소 시 현재 예약 인원 1 감소
    public void decreaseQuantity(int facilityNo) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "UPDATE facility SET quantity = quantity - 1 WHERE facilityNo = ?";

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, facilityNo);
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null)
                pstmt.close();
            if (conn != null)
                conn.close();
        }
    }
}