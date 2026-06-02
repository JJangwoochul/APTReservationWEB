<%@ page contentType="text/html; charset=utf-8" %>
<%@ page language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>로그인</title>
</head>
<body class="bg-light">
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

        <a href="<%= kakaoAuthUrl %>" 
   class="btn w-100 d-flex justify-content-center align-items-center" 
   style="background-color: #FEE500; color: #000000; font-weight: bold; border-radius: 6px; height: 45px; text-decoration: none;">
    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-chat-fill me-2" viewBox="0 0 16 16">
        <path d="M8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6-.097 1.016-.417 2.13-.771 2.966-.079.186.074.394.273.362 2.256-.37 3.597-.938 4.18-1.234A9 9 0 0 0 8 15z"/>
    </svg>
    카카오 로그인
</a>
    </div>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>