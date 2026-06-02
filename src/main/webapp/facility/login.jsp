<%@ page contentType="text/html; charset=utf-8" %>
<%@ page language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>로그인</title>
</head>
<body class="bg-light">
<%
    // 서버에서 전달된 에러 코드 확인 및 알림 처리
    String error = request.getParameter("error");
    if (error != null) {
        String msg = "";
        if (error.equals("login_failed")) msg = "아이디 또는 비밀번호가 일치하지 않습니다.";
        else if (error.equals("empty_fields")) msg = "아이디와 비밀번호를 모두 입력하세요.";
        
        if (!msg.isEmpty()) {
%>
            <script>
                alert("<%= msg %>");
                history.replaceState({}, null, location.pathname); // URL 깔끔하게 정리
            </script>
<%
        }
    }
%>

<%
    // 카카오 앱 정보 설정
    String clientId = "3304185bc7ec807d4a6b7fb8f9b3bf11"; 
    String redirectUri = "http://localhost:8080/aptweb/facility/kakaoCallback.jsp";
    
    // 카카오 인증 URL 생성
    String kakaoAuthUrl = "https://kauth.kakao.com/oauth/authorize"
                          + "?client_id=" + clientId 
                          + "&redirect_uri=" + redirectUri 
                          + "&response_type=code";
%>

<%@ include file="header.jsp" %>

<div class="container mt-5" style="max-width: 500px;">
    <div class="bg-white p-5 shadow-sm rounded-4">
        <h2 class="fw-bold text-center mb-4">로그인 하기</h2>
        
        <form action="<%= request.getContextPath() %>/facility/login_process.jsp" method="post">
            <div class="mb-3">
                <label for="userId" class="form-label fw-bold text-secondary">Id</label>
                <input type="text" class="form-control form-control-lg" id="userId" name="userId" placeholder="아이디를 입력하세요">
            </div>
            
            <div class="mb-3">
                <label for="userPw" class="form-label fw-bold text-secondary">Password</label>
                <input type="password" class="form-control form-control-lg" id="userPw" name="userPw" placeholder="비밀번호를 입력하세요">
            </div>

            <div class="mb-4 form-check">
                <input type="checkbox" class="form-check-input" id="rememberId">
                <label class="form-check-label text-muted" for="rememberId">아이디 기억하기</label>
            </div>
            
            <div class="d-flex justify-content-between align-items-center mt-4">
                <button type="button" class="btn btn-secondary px-4 fw-bold" 
                        onclick="location.href='<%= request.getContextPath() %>/facility/signUp.jsp'">회원가입</button>
                
                <button type="submit" class="btn btn-dark px-4 fw-bold">로그인</button>
            </div>
        </form>

        <a href="<%= kakaoAuthUrl %>" class="btn w-100" style="background-color: #FEE500; color: #000000; font-weight: bold; border-radius: 6px; height: 45px; text-decoration: none; display: flex; align-items: center; justify-content: center;">
            <img src="https://developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png" style="width: 20px; margin-right: 10px;">
            카카오 로그인
        </a>
    </div>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>