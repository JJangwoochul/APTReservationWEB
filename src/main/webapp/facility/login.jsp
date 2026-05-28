<%@ page contentType="text/html; charset=utf-8" %>
<%@ page language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>로그인</title>
    <style>
        body {
            background-color: #f5f6f8;
        }

        .login-container {
            width: 500px;
            margin: 100px auto; 
        }

        .login-box {
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }

        .login-title {
            font-size: 28px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 30px;
            color: #212529;
        }

        .form-control:focus {
            border-color: #212529;
            box-shadow: none;
        }

        .btn-dark-custom {
            background: #212529;
            color: white;
            padding: 10px 20px;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            transition: 0.2s;
        }

        .btn-dark-custom:hover {
            background: #343a40;
            color: white;
        }

        .btn-light-custom {
            background: #e9ecef;
            color: #212529;
            padding: 10px 20px;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            transition: 0.2s;
        }

        .btn-light-custom:hover {
            background: #dee2e6;
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="login-container">
    <div class="login-box">
        <div class="login-title">로그인 하기</div>
        
        <form action="<%= request.getContextPath() %>/facility/login_process.jsp" method="post">
            <div class="mb-4">
                <label for="userId" class="form-label fw-bold">Id</label>
                <input type="text" class="form-control form-control-lg" id="userId" name="userId" placeholder="아이디를 입력하세요">
            </div>
            
            <div class="mb-4">
                <label for="userPw" class="form-label fw-bold">Password</label>
                <input type="password" class="form-control form-control-lg" id="userPw" name="userPw" placeholder="비밀번호를 입력하세요">
            </div>

            <div class="mb-4 form-check">
                <input type="checkbox" class="form-check-input" id="rememberId">
                <label class="form-check-label text-muted" for="rememberId">아이디 기억하기</label>
            </div>
            
            <div class="d-flex justify-content-between align-items-center mt-4">
                <button type="button" class="btn btn-light-custom" onclick="location.href='<%= request.getContextPath() %>/facility/signUp.jsp'">회원가입</button>
                
                <button type="submit" class="btn btn-dark-custom">로그인</button>
            </div>
        </form>
    </div>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>
