<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*, java.net.*" %>
<%@ page import="com.google.gson.*" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="dto.UserDTO" %>
<%
    // 1. 카카오 인증 서버에서 전달받은 인가 코드(code) 확인
    String code = request.getParameter("code");

    if (code == null || code.trim().equals("")) {
        response.sendRedirect("login.jsp?error=no_code");
        return;
    }

    String accessToken = "";
    String tokenURL = "https://kauth.kakao.com/oauth/token";

    // 2. [토큰 발급] 인가 코드를 이용해 카카오로부터 액세스 토큰 획득
    try {
        URL url = new URL(tokenURL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
        conn.setDoOutput(true);

        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream(), "UTF-8"));
        StringBuilder sb = new StringBuilder();
        sb.append("grant_type=authorization_code");
        sb.append("&client_id=3304185bc7ec807d4a6b7fb8f9b3bf11"); // REST API 키
        sb.append("&client_secret=KasDJAXMHQMkyjIJzbMQnClo0TASp2eO"); // 시크릿 키
        sb.append("&redirect_uri=http://localhost:8080/aptweb/facility/kakaoCallback.jsp");
        sb.append("&code=").append(code);

        bw.write(sb.toString());
        bw.flush();
        bw.close();

        if (conn.getResponseCode() == 200) {
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            String line;
            StringBuilder result = new StringBuilder();
            while ((line = br.readLine()) != null) {
                result.append(line);
            }
            br.close();
            
            JsonElement element = JsonParser.parseString(result.toString());
            accessToken = element.getAsJsonObject().get("access_token").getAsString();            
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    // 3. [유저 정보 및 DB 처리] 획득한 액세스 토큰으로 프로필 조회 후 가입/로그인 진행
    if (accessToken != null && !accessToken.equals("")) {
        String userURL = "https://kapi.kakao.com/v2/user/me";
        try {
            URL url = new URL(userURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);

            if (conn.getResponseCode() == 200) {
                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
                String line;
                StringBuilder result = new StringBuilder();
                while ((line = br.readLine()) != null) {
                    result.append(line);
                }
                br.close();

                JsonElement element = JsonParser.parseString(result.toString());
                JsonObject userInfo = element.getAsJsonObject();

                String id = userInfo.get("id").getAsString();
                String nickname = userInfo.getAsJsonObject("properties").get("nickname").getAsString();
                
                // DB 연동: 카카오 고유 ID로 기존 회원 여부 확인
                UserDAO dao = new UserDAO();
                UserDTO user = dao.getMemberByUserId(id);
                
                // DB에 없으면 신규 가입 처리
                if (user == null) {
                    dao.join(new UserDTO(id, "1234", nickname, "010-0000-0000", "0", "0"));
                    user = dao.getMemberByUserId(id);
                }
                
                // 세션 설정: 서버에 로그인 상태 유지
                if (user != null) {
                    session.setAttribute("sessionId", user.getUserId());
                    session.setAttribute("sessionUser", user);
                    session.setAttribute("sessionRole", user.getRole());
                    session.setAttribute("userNo", user.getUserNo());
        
                    // 메인 페이지로 이동
                    response.sendRedirect(request.getContextPath() + "/facility/welcome.jsp");
                    return;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 모든 과정 실패 시 로그인 페이지로 리다이렉트
    response.sendRedirect("login.jsp?error=login_failed");
%>