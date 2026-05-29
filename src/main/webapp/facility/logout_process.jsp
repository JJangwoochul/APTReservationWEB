<%@ page contentType="text/html; charset=utf-8" %>
<%
    //세션 무효화 -> 서버에 저장된 사용자의 세션을 삭제
    session.invalidate();
    //로그아웃 이후 welcome.jsp페이지로 돌아가게함
    response.sendRedirect(request.getContextPath() + "/facility/welcome.jsp");
%>