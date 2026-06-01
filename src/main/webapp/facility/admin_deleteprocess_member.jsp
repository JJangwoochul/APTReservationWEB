<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dao.UserDAO" %>
<%
    request.setCharacterEncoding("utf-8");
    
    String userNoStr = request.getParameter("userNo");
    
    // 정수형 변환
    if (userNoStr != null && !userNoStr.isEmpty()) {
        int userNo = Integer.parseInt(userNoStr);
        
        UserDAO dao = new UserDAO();
        dao.deleteMember(userNo);
    }
    
    response.sendRedirect("admin_memberList.jsp");
%>