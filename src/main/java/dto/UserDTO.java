package dto;

import java.io.Serializable;

public class UserDTO implements Serializable {
    private static final long serialVersionUID = 3L;

    private int userNo; // 0529 수정코드 : userNo (유저테이블의 pk)
    private String userId; // 회원 아이디
    private String userPw; // 비밀번호
    private String userName; // 이름
    private String phone; // 연락처
    // 나중에 혹시 Reservation이 생기면 식별하기위해 입주민 인증을 위한 변수
    private String dong; // 현재 살고있는 동
    private String ho; // 현재 살고있는 호수
    // 0528 추가코드 : 관리자 , 입주민 권한구분 필드
    private String role;

    public UserDTO() {
        super();
        // 0528 추가코드 : 기본권한을 입주민(USER)으로 설정
        this.role = "USER";
    }
    //생성자 :회원가입 시 사용할 생성자 (userNo와 role 제외)
    public UserDTO(String userId, String userPw, String userName, String phone, String dong, String ho) {
        super();
        this.userId = userId;
        this.userPw = userPw;
        this.userName = userName;
        this.phone = phone;
        this.dong = dong;
        this.ho = ho;
        this.role = "USER"; // 기본 권한 설정
    }
    //생성자 : 로그인 이후 , 세션저장 , 목록조회 시 사용
    public UserDTO(int userNo, String userId, String userPw, String userName, String phone, String dong, String ho,
            String role) {
        this.userNo = userNo;
        this.userId = userId;
        this.userPw = userPw;
        this.userName = userName;
        this.phone = phone;
        this.dong = dong;
        this.ho = ho;
        this.role = role;
    }

    public int getUserNo() {
        return userNo;
    }

    public void setUserNo(int userNo) {
        this.userNo = userNo;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserPw() {
        return userPw;
    }

    public void setUserPw(String userPw) {
        this.userPw = userPw;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getDong() {
        return dong;
    }

    public void setDong(String dong) {
        this.dong = dong;
    }

    public String getHo() {
        return ho;
    }

    public void setHo(String ho) {
        this.ho = ho;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

}