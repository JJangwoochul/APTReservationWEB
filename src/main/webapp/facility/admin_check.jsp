<%@ page contentType="text/html; charset=utf-8" %>
<%
    // (1) 세션에서 현재 로그인한 사용자의 권한(role) 정보를 가져옴
    String role = (String) session.getAttribute("sessionRole");

    // (2) 권한 체크 로직
    // 로그인을 안했거나, 권한이 "ADMIN"이 아닐 경우 (일반 유저 또는 권한 없음)
    if (role == null || !role.equals("ADMIN")) {
        // (3) 보안 처리 :유저 접근임을 알리고 로그인 페이지나 메인으로 이동
        out.println("<script>");
        out.println("alert('관리자 전용 페이지입니다. 접근 권한이 없습니다.');");
        out.println("location.href='" + request.getContextPath() + "/facility/login.jsp';"); // 로그인 페이지로 퇴거
        out.println("</script>");
        return; 
    }
%>