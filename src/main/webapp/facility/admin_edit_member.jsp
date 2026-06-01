<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dao.UserDAO, dto.UserDTO" %>
<%@ include file="admin_check.jsp" %>
<%
    // 1. 파라미터 받기 및 회원 정보 조회
    int userNo = Integer.parseInt(request.getParameter("userNo"));
    UserDAO dao = new UserDAO();
    UserDTO user = dao.getMemberByNo(userNo);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>회원 정보 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>회원 정보 수정</h2>
    <hr>
    <form action="admin_editprocess_member.jsp" method="post">
        <input type="hidden" name="userNo" value="<%= user.getUserNo() %>">
        
        <div class="mb-3">
            <label class="form-label">아이디</label>
            <input type="text" class="form-control" value="<%= user.getUserId() %>" disabled>
            <small class="text-muted">아이디는 변경할 수 없습니다.</small>
        </div>
        
        <div class="mb-3">
            <label class="form-label">이름</label>
            <input type="text" name="userName" class="form-control" value="<%= user.getUserName() %>" required>
        </div>
        
        <div class="mb-3">
            <label class="form-label">연락처</label>
            <input type="text" name="phone" class="form-control" value="<%= user.getPhone() %>" required>
        </div>
        
        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">동</label>
                <input type="text" name="dong" class="form-control" value="<%= user.getDong() %>" required>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">호</label>
                <input type="text" name="ho" class="form-control" value="<%= user.getHo() %>" required>
            </div>
        </div>
        
        <div class="mb-4">
            <label class="form-label">권한</label>
            <select name="role" class="form-select">
                <option value="USER" <%= "USER".equals(user.getRole()) ? "selected" : "" %>>USER (입주민)</option>
                <option value="ADMIN" <%= "ADMIN".equals(user.getRole()) ? "selected" : "" %>>ADMIN (관리자)</option>
            </select>
        </div>
        
        <button type="submit" class="btn btn-primary">수정 완료</button>
        <a href="admin_memberList.jsp" class="btn btn-secondary">취소</a>
    </form>
</div>
</body>
</html>