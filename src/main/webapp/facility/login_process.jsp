<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dao.UserDAO" %>
<%
    request.setCharacterEncoding("utf-8");

    String userId = request.getParameter("userId");
    String userPw = request.getParameter("userPw");

    // (1) 입력값 null 체크 입력값이 없을 시 안내문
    if(userId == null || userId.trim().isEmpty() || userPw == null) {
        out.println("<script>alert('아이디와 비밀번호를 모두 입력하세요.'); history.back();</script>");
        return;
    }

    UserDAO dao = new UserDAO();
    int result = dao.login(userId, userPw);

    // (3) 결과에 따른 처리
    if (result == 1) {
        session.setAttribute("sessionId", userId);
        response.sendRedirect(request.getContextPath() + "/facility/welcome.jsp");
    } else if (result == 0) {
        out.println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
    } else {
        out.println("<script>alert('존재하지 않는 아이디입니다.'); history.back();</script>");
    }
%>