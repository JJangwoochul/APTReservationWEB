package dao;

import java.sql.*;
import java.util.ArrayList;
import dto.FacilityDTO;

public class FacilityDAO {

    // 싱글톤 패턴: 단 하나의 인스턴스만 생성하여 공유
    private static FacilityDAO instance = new FacilityDAO();
    public static FacilityDAO getInstance() { return instance; }
    private FacilityDAO() {}

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
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
        return list;
    }

    // 2. 신규 등록
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
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
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
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
        return dto;
    }

    // 4. 시설 정보 수정
    public void updateFacility(FacilityDTO dto) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "UPDATE facility SET facilityName=?, description=?, facilityPrice=?, condition=?, " +
                     "peopleInStock=?, fileName=?, quantity=? WHERE facilityNo=?";
        
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
            pstmt.setInt(8, dto.getFacilityNo());
            
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
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
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
}