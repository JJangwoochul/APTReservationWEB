package dao;

import dto.UserDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// 로그인 확인 , 어드민 권한 확인
public class UserDAO {

    // (1) 회원가입
    public int join(UserDTO user) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "INSERT INTO users (userNo, userId, userPw, userName, phone, dong, ho, role) VALUES (user_seq.nextval, ?, ?, ?, ?, ?, ?, 'USER')";

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getUserId());
            pstmt.setString(2, user.getUserPw());
            pstmt.setString(3, user.getUserName());
            pstmt.setString(4, user.getPhone());
            pstmt.setString(5, user.getDong());
            pstmt.setString(6, user.getHo());
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        return result;
    }

    // (2) 로그인
    public UserDTO login(String userId, String userPw) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM users WHERE userId = ? AND userPw = ?";
        UserDTO dto = null;

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.setString(2, userPw);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                dto = new UserDTO(rs.getInt("userNo"), rs.getString("userId"), rs.getString("userPw"),
                        rs.getString("userName"), rs.getString("phone"), rs.getString("dong"),
                        rs.getString("ho"), rs.getString("role"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        return dto;
    }

    // (3) 회원 목록 조회
    public List<UserDTO> getMemberList() {
        List<UserDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM users ORDER BY userNo DESC";

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(new UserDTO(rs.getInt("userNo"), rs.getString("userId"), rs.getString("userPw"),
                        rs.getString("userName"), rs.getString("phone"), rs.getString("dong"),
                        rs.getString("ho"), rs.getString("role")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        return list;
    }

    // (4) 회원 삭제 (트랜잭션 처리)
    public void deleteMember(int userNo) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt1 = null;
        PreparedStatement pstmt2 = null;

        try {
            conn = DBconn.getConnection();
            conn.setAutoCommit(false);

            String sql1 = "DELETE FROM reserve WHERE userNo = ?";
            pstmt1 = conn.prepareStatement(sql1);
            pstmt1.setInt(1, userNo);
            pstmt1.executeUpdate();

            String sql2 = "DELETE FROM users WHERE userNo = ?";
            pstmt2 = conn.prepareStatement(sql2);
            pstmt2.setInt(1, userNo);
            pstmt2.executeUpdate();

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (pstmt1 != null) pstmt1.close();
            if (pstmt2 != null) pstmt2.close();
            if (conn != null) conn.close();
        }
    }

    // (5) 회원 상세 조회
    public UserDTO getMemberByNo(int userNo) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM users WHERE userNo = ?";
        UserDTO dto = null;

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userNo);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                dto = new UserDTO(rs.getInt("userNo"), rs.getString("userId"), rs.getString("userPw"),
                        rs.getString("userName"), rs.getString("phone"), rs.getString("dong"),
                        rs.getString("ho"), rs.getString("role"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        return dto;
    }

    // (6) 회원 정보 수정
    public void updateMember(UserDTO user) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "UPDATE users SET userName=?, phone=?, dong=?, ho=?, role=? WHERE userNo=?";

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getUserName());
            pstmt.setString(2, user.getPhone());
            pstmt.setString(3, user.getDong());
            pstmt.setString(4, user.getHo());
            pstmt.setString(5, user.getRole());
            pstmt.setInt(6, user.getUserNo());
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    // (7) Id로 회원 조회
    public UserDTO getMemberByUserId(String userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM users WHERE userId = ?";
        UserDTO dto = null;

        try {
            conn = DBconn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                dto = new UserDTO(rs.getInt("userNo"), rs.getString("userId"), "PROTECTED",
                        rs.getString("userName"), rs.getString("phone"), rs.getString("dong"),
                        rs.getString("ho"), rs.getString("role"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        return dto;
    }
}