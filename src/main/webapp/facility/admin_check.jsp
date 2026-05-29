<%@ page contentType="text/html; charset=utf-8" %>
<%
    // (1) 세션에서 현재 로그인한 사용자의 권한(role) 정보를 가져옴
    // header.jsp의 'role' 변수와 충돌하지 않도록 변수명 변경
    String adminCheckRole = (String) session.getAttribute("sessionRole");

    // (2) 권한 체크 로직
    // "ADMIN".equals(...) 방식을 사용하여 adminCheckRole이 null일 경우에도 안전하게 비교
    if (!"ADMIN".equals(adminCheckRole)) {
        // (3) 보안 처리 : 유저 접근임을 알리고 로그인 페이지나 메인으로 이동
        out.println("<script>");
        out.println("alert('관리자 전용 페이지입니다. 접근 권한이 없습니다.');");
        out.println("location.href='" + request.getContextPath() + "/facility/login.jsp';"); 
        out.println("</script>");
        return; // 페이지 로딩 즉시 중단
    }
%>