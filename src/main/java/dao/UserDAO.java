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
        //user_seq.nextval을 이용해 PK인 No를 DB에서 자동생성
        String sql = "INSERT INTO users (userNo, userId, userPw, userName, phone, dong, ho, role) VALUES (user_seq.nextval, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBconn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, user.getUserId());
            pstmt.setString(2, user.getUserPw());
            pstmt.setString(3, user.getUserName());
            pstmt.setString(4, user.getPhone());
            pstmt.setInt(5, user.getDong());
            pstmt.setInt(6, user.getHo());
            pstmt.setString(7, user.getRole());
            
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
                if (rs.next()) {    //로그인 성공했을 때 데이터가 1개만 반환
                    //DB에서 가져온 데이터를 UserDTO객체로 변환시킴
                    return new UserDTO(rs.getInt("userNo"), rs.getString("userId"), rs.getString("userPw"),
                                       rs.getString("userName"), rs.getString("phone"), rs.getInt("dong"),
                                       rs.getInt("ho"), rs.getString("role"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;    //일치하는 회원이 없어 객체변환이 없으면 null리턴후 로그인실패알림
    }

    // (3) 회원 목록 조회: 전체 회원 SELECT 구현
    // 전체 회원 목록을 리스트로 반환
    public List<UserDTO> getMemberList() {
        List<UserDTO> list = new ArrayList<>();
        //PK인 userNo기준으로 DESC(내림차순) 정렬 ->최신회원부터 출력됨
        String sql = "SELECT * FROM users ORDER BY userNo DESC";
        
        try (Connection conn = DBconn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                list.add(new UserDTO(rs.getInt("userNo"), rs.getString("userId"), rs.getString("userPw"),
                                     rs.getString("userName"), rs.getString("phone"), rs.getInt("dong"),
                                     rs.getInt("ho"), rs.getString("role")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}