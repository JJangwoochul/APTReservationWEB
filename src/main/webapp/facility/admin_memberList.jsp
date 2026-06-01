<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<%@ page import="dto.UserDTO" %>
<%@ page import="dao.UserDAO" %>

<%-- 관리자만 접근 가능한 jsp호출 --%>
<%@ include file="admin_check.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>회원 목록 관리</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center">
        <h2>회원 목록 관리</h2>
        <a href="<%= request.getContextPath() %>/facility/welcome.jsp" class="btn btn-outline-dark">메인 화면으로</a>
    </div>
    
    <%
        UserDAO dao = new UserDAO();
        List<UserDTO> memberList = dao.getMemberList();
    %>

    <table class="table table-hover mt-4">
        <thead class="table-dark">
            <tr>
                <th>아이디</th>
                <th>이름</th>
                <th>권한</th>
                <th>연락처</th>
                <th>동</th>
                <th>호</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
            <% if(memberList != null && !memberList.isEmpty()) { %>
                <% for(UserDTO user : memberList) { %>
                <tr>
                    <%-- (1) 수정: UserDTO의 실제 getter 메서드명인 getUserId(), getUserName(), getDong(), getHo()로 변경 --%>
                    <td><%= user.getUserId() %></td>
                    <td><%= user.getUserName() %></td>
                    <td><span class="badge <%= "ADMIN".equals(user.getRole()) ? "bg-danger" : "bg-primary" %>"><%= user.getRole() %></span></td>
                    <td><%= user.getPhone() %></td>
                    <td><%= user.getDong() %></td>
                    <td><%= user.getHo() %></td>
                    <td>
                        <a href="admin_edit_member.jsp?userNo=<%= user.getUserNo() %>" class="btn btn-sm btn-outline-secondary">수정</a>
                        <a href="admin_deleteprocess_member.jsp?userNo=<%= user.getUserNo() %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('정말 삭제하시겠습니까? 관련 예약 내역도 함께 삭제됩니다.')">삭제</a>
                    </td>
                </tr>
                <% } %>
            <% } else { %>
                <tr><td colspan="7" class="text-center">조회된 회원이 없습니다.</td></tr>
            <% } %>
        </tbody>
    </table>
</div>

</body>
</html>