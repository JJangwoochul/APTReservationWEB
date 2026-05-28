package dao;

import dto.UserDTO;
//0528 코드수정 : 리스트사용
import java.util.ArrayList; 
import java.util.List;

public class UserDAO {

    // (1) 실제 DB 연동을 위한 메서드 (현재는 껍데기)
    public int join(UserDTO user) {
        int result = 0;
        // TODO: DB 연동 시 INSERT 쿼리 구현
        return result;
    }

    // 0528 코드수정 : 타입을 int에서 userDTO로 변경 /로그인테스트
    // 로그인 성공 시 유저정보를 반환해 세션관리를 위해
    public UserDTO login(String userId, String userPw) {
        
        // 테스트용 데이터 db연동시 변경
        String mockUserId = "test";
        String mockUserPw = "12345";
        String mockAdminId = "admin";
        String mockAdminPw = "admin1234";

        // 0528 코드수정 : 로그인 로직에서 권한을 구분하여 반환
        // 관리자 아이디 로그인 시 사용
        if (userId.equals(mockAdminId) && userPw.equals(mockAdminPw)) {
            // ADMIN 권한을 가진 객체 생성
            return new UserDTO(userId, userPw, "관리자", "010-0000-0000", 0, 0, "ADMIN");
        }
        // 일반 사용자 아이디 로그인 시
        else if (userId.equals(mockUserId) && userPw.equals(mockUserPw)) {
            // USER 권한을 가진 객체 생성 (기본값 설정)
            return new UserDTO(userId, userPw, "테스트유저", "010-1234-5678", 101, 1001, "USER");
        }
        // 로그인 실패
        else {
            return null; // 아이디가 없거나 비밀번호가 틀림
        }
    }
    // 0528 코드수정 : Mock 데이터 회원 목록 반환 메서드 / 관리자페이지 테스트
    // DB 연동 전까지 관리자 페이지에서 회원 목록 조회 기능을 테스트하기 위함
    public List<UserDTO> getMemberList() {
        List<UserDTO> list = new ArrayList<UserDTO>();

        // (3) 추가 : 테스트용 회원 데이터 생성
        list.add(new UserDTO("user01", "1111", "홍길동", "010-1111-1111", 102, 1002, "USER"));
        list.add(new UserDTO("admin", "admin1234", "관리자", "010-0000-0000", 0, 0, "ADMIN"));
        list.add(new UserDTO("user02", "2222", "김철수", "010-2222-2222", 103, 1003, "USER"));

        return list; // (4) 완성된 회원 목록 리스트 반환
    }
}