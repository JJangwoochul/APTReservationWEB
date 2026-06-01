package dao;

import dto.UserDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

// 로그인 확인 , 어드민 권한 확인
public class UserDAO {

    // (1) 회원가입: DB INSERT 구현 회원가입 성공시 1 반환, 실패시 0반환
    public int join(UserDTO user) {
        int result = 0;
        // user_seq.nextval을 이용해 PK인 No를 DB에서 자동생성 , role에 USER를 넣어 가입하는 사람은 기본적으로
        // user권한을 갖고 가입
        String sql = "INSERT INTO users (userNo, userId, userPw, userName, phone, dong, ho, role) VALUES (user_seq.nextval, ?, ?, ?, ?, ?, ?, 'USER')";

        try (Connection conn = DBconn.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, user.getUserId());
            pstmt.setString(2, user.getUserPw());
            pstmt.setString(3, user.getUserName());
            pstmt.setString(4, user.getPhone());
            pstmt.setString(5, user.getDong());
            pstmt.setString(6, user.getHo());

            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // (2) 로그인: DB SELECT 구현
    // 일치하는 회원이 있으면 UserDTO 객체반환 없으면 null값을 반환시킴
    public UserDTO login(String userId, String userPw) {
        String sql = "SELECT * FROM users WHERE userId = ? AND userPw = ?";

        try (Connection conn = DBconn.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userId);
            pstmt.setString(2, userPw);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) { // 로그인 성공했을 때 데이터가 1개만 반환
                    // DB에서 가져온 데이터를 UserDTO객체로 변환시킴
                    return new UserDTO(rs.getInt("userNo"), rs.getString("userId"), rs.getString("userPw"),
                            rs.getString("userName"), rs.getString("phone"), rs.getString("dong"),
                            rs.getString("ho"), rs.getString("role"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // 일치하는 회원이 없어 객체변환이 없으면 null리턴후 로그인실패알림
    }

    // (3) 회원 목록 조회: 전체 회원 SELECT 구현
    // 전체 회원 목록을 리스트로 반환
    public List<UserDTO> getMemberList() {
        List<UserDTO> list = new ArrayList<>();
        // PK인 userNo기준으로 DESC(내림차순) 정렬 ->최신회원부터 출력됨
        String sql = "SELECT * FROM users ORDER BY userNo DESC";

        try (Connection conn = DBconn.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                list.add(new UserDTO(rs.getInt("userNo"), rs.getString("userId"), rs.getString("userPw"),
                        rs.getString("userName"), rs.getString("phone"), rs.getString("dong"),
                        rs.getString("ho"), rs.getString("role")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // (4) 회원 삭제: DELETE 구현 (PK인 userNo 기준)
    public void deleteMember(int userNo) throws java.sql.SQLException {
        Connection conn = null;
        PreparedStatement pstmt1 = null; // 예약 내역 삭제용
        PreparedStatement pstmt2 = null; // 회원 정보 삭제용

        try {
            conn = DBconn.getConnection();
            conn.setAutoCommit(false); // 트랜잭션 시작

            // 1. 해당 회원의 예약 내역 먼저 삭제 (reserve 테이블의 userNo FK 참조)
            String sql1 = "DELETE FROM reserve WHERE userNo = ?";
            pstmt1 = conn.prepareStatement(sql1);
            pstmt1.setInt(1, userNo);
            pstmt1.executeUpdate();

            // 2. 회원 정보 삭제 (users 테이블의 userNo PK 참조)
            String sql2 = "DELETE FROM users WHERE userNo = ?";
            pstmt2 = conn.prepareStatement(sql2);
            pstmt2.setInt(1, userNo);
            pstmt2.executeUpdate();

            conn.commit(); // 모두 성공 시 커밋
        } catch (Exception e) {
            if (conn != null)
                conn.rollback(); // 실패 시 롤백
            e.printStackTrace();
            throw e;
        } finally {
            if (pstmt1 != null)
                pstmt1.close();
            if (pstmt2 != null)
                pstmt2.close();
            if (conn != null)
                conn.close();
        }
    }

    // (5) 회원 상세 조회: 1명의 회원 정보 가져오기
    public UserDTO getMemberByNo(int userNo) {
        String sql = "SELECT * FROM users WHERE userNo = ?";
        try (Connection conn = DBconn.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userNo);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new UserDTO(rs.getInt("userNo"), rs.getString("userId"), rs.getString("userPw"),
                            rs.getString("userName"), rs.getString("phone"), rs.getString("dong"),
                            rs.getString("ho"), rs.getString("role"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // (6) 회원 정보 수정: UPDATE 구현
    // 관리자가 수정 가능한 필드들을 업데이트합니다.
    public void updateMember(UserDTO user) throws java.sql.SQLException {
        String sql = "UPDATE users SET userName=?, phone=?, dong=?, ho=?, role=? WHERE userNo=?";

        try (Connection conn = DBconn.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

           
            pstmt.setString(1, user.getUserName());
            pstmt.setString(2, user.getPhone());
            pstmt.setString(3, user.getDong());
            pstmt.setString(4, user.getHo());
            pstmt.setString(5, user.getRole());
            pstmt.setInt(6, user.getUserNo()); // WHERE절의 PK 조건

            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw e; 
        }
    }
}