<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dao.UserDAO" %>
<%
    request.setCharacterEncoding("utf-8");
    String userId = request.getParameter("userId");
    
    UserDAO dao = new UserDAO();
    dao.deleteMember(userId); // DAO에 메서드 추가 필요
    
    response.sendRedirect("admin_memberList.jsp");
%>