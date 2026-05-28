package dto;

import java.io.Serializable;

public class UserDTO implements Serializable {
    private static final long serialVersionUID = 3L;

    private String userId; // 회원 아이디(PK)
    private String userPw; // 비밀번호
    private String userName; // 이름
    private String phone; // 연락처
    // 나중에 혹시 Reservation이 생기면 식별하기위해 입주민 인증을 위한 변수
    private int dong; // 현재 살고있는 동
    private int ho; // 현재 살고있는 호수

    public UserDTO() {
        super();
    }

    // (1) 로그인/인증용 생성자
    public UserDTO(String userId, String userPw) {
        this.userId = userId;
        this.userPw = userPw;
    }

    // (2) 회원가입 입력용 생성자 (이름, 연락처 포함)
    public UserDTO(String userId, String userPw, String userName, String phone) {
        this(userId, userPw);
        this.userName = userName;
        this.phone = phone;
    }

    // (3) DB 조회/상세보기용 생성자 (동, 호수까지 모두 포함)
    public UserDTO(String userId, String userPw, String userName, String phone, int dong, int ho) {
        this(userId, userPw, userName, phone);
        this.dong = dong;
        this.ho = ho;
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
}