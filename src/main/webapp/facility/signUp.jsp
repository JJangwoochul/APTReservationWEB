<%@ page contentType="text/html; charset=utf-8" %>
<%@ page language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>회원가입</title>
    <style>
        body {
            background-color: #f5f6f8;
        }

        .signup-container {
            width: 500px;
            margin: 80px auto;
        }

        .signup-box {
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }

        .signup-title {
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
            padding: 12px 20px;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            transition: 0.2s;
            width: 100%;
        }

        .btn-dark-custom:hover {
            background: #343a40;
            color: white;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="signup-container">
    <div class="signup-box">
        <div class="signup-title">회원가입</div>
        <%--회원가입 -> 프로세스 파일로 데이터 전송--%>
        <form action="<%= request.getContextPath() %>/facility/signUp_process.jsp" method="post">
            <div class="mb-4">
                <label for="userName" class="form-label fw-bold">name</label>
                <input type="text" class="form-control form-control-lg" id="userName" name="userName" placeholder="이름을 입력하세요" required>
            </div>
            
            <div class="mb-4">
                <label for="userId" class="form-label fw-bold">Id</label>
                <input type="text" class="form-control form-control-lg" id="userId" name="userId" placeholder="아이디를 입력하세요" required>
            </div>
            
            <div class="mb-4">
                <label for="userPw" class="form-label fw-bold">Password</label>
                <input type="password" class="form-control form-control-lg" id="userPw" name="userPw" placeholder="비밀번호를 입력하세요" required>
            </div>

            <div class="mb-4">
                <label for="phone" class="form-label fw-bold">phone</label>
                <input type="text" class="form-control form-control-lg" id="phone" name="phone" placeholder="000-0000-0000" required>
            </div>

            <div class="row">
                <div class="mb-4">
                    <label for="dong" class="form-label fw-bold">동</label>
                    <input type="text" class="form-control form-control-lg" id="dong" name="dong" placeholder="ex) 101" required>
                </div>

                <div class="mb-4">
                    <label for="ho" class="form-label fw-bold">호수</label>
                    <input type="text" class="form-control form-control-lg" id="ho" name="ho" placeholder="ex) 201" required>
                </div>
            </div>

            <div class="text-center mt-5">
                <button type="submit" class="btn btn-dark-custom w-100">회원가입</button>
            </div>
        </form>
    </div>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>