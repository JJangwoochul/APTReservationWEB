package dao;

import dto.UserDTO;

public class UserDAO {

    // (1) 실제 DB 연동을 위한 메서드 (현재는 껍데기)
    public int join(UserDTO user) {
        int result = 0;
        // TODO: DB 연동 시 INSERT 쿼리 구현
        return result;
    }
    // (2) 로그인 /아이디와 비번을 받아 검증
    public int login(String userId, String userPw) {
        
        // 테스트용 데이터 db연동시 변경
        String mockId = "test";
        String mockPw = "1234";

        UserDTO loginUser = new UserDTO(userId, userPw);

        // 테스트용 아이디와 비밀번호가 일치할때 ->1
        if (loginUser.getUserId().equals(mockId) && loginUser.getUserPw().equals(mockPw)) {
            return 1; // 로그인 성공
        //테스트용 아이디는 일치하나 비밀번호가 다를때 -> 0
        } else if (loginUser.getUserId().equals(mockId) && !loginUser.getUserPw().equals(mockPw)) {
            return 0; // 비밀번호 불일치
        } else {
            return -1; // 아이디 없음 (데이터베이스 오류 등)
        }
    }
}