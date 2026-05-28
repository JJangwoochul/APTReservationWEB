<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="dto.UserDTO" %> <%--0528 추가코드--%>
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
    //0528수정코드 : 객체반환
    UserDTO loginUser = dao.login(userId, userPw);

    // 0528 수정코드 : 객체가 null이 아닐 시 성공
    if (loginUser != null) {
        // 세션에 아이디 , UserDTO 객체 전체와 권한을 저장
        session.setAttribute("sessionId", loginUser.getUserId());
        session.setAttribute("sessionUser", loginUser); // 객체 전체 저장
        session.setAttribute("sessionRole", loginUser.getRole()); // 권한을 별도로 저장하여 관리
        
        response.sendRedirect(request.getContextPath() + "/facility/welcome.jsp");
    } else {
        // 0528 수정코드 : 로그인 실패 시 로직
        out.println("<script>alert('아이디 또는 비밀번호가 일치하지 않습니다.'); history.back();</script>");
    }
%>