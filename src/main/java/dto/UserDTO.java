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
    private int dong; // 현재 살고있는 동
    private int ho; // 현재 살고있는 호수
    // 0528 추가코드 : 관리자 , 입주민 권한구분 필드
    private String role;

    public UserDTO() {
        super();
        // 0528 추가코드 : 기본권한을 입주민(USER)으로 설정
        this.role = "USER";
    }

    public UserDTO(int userNo, String userId, String userPw, String userName, String phone, int dong, int ho,
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

    public int getDong() {
        return dong;
    }

    public void setDong(int dong) {
        this.dong = dong;
    }

    public int getHo() {
        return ho;
    }

    public void setHo(int ho) {
        this.ho = ho;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

}