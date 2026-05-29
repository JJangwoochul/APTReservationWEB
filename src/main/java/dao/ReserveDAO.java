package dao;

import java.sql.*;
import java.util.ArrayList;
import dto.ReserveDTO;

public class ReserveDAO {
    // 싱글톤 패턴
    private static ReserveDAO instance = new ReserveDAO();
    public static ReserveDAO getInstance() { return instance; }
    private ReserveDAO() {}

    // 1. 전체 예약 목록 조회 (DB 연동)
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
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
        return list;
    }

    // 2. 예약 추가 (DB 연동)
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
}