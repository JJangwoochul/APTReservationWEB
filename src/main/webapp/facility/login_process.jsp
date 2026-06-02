<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="dto.UserDTO" %>
<%
// 로그인 결과 확인
    request.setCharacterEncoding("utf-8");

    // 파라미터: login.jsp에서 보낸 ID와 PW를 가져옴
    String userId = request.getParameter("userId");
    String userPw = request.getParameter("userPw");

    // 유효성 검사: 필수 입력값 확인
    // trim()을 이용해 공백만 입력한 경우도 필터링
    if(userId == null || userId.trim().isEmpty() || userPw == null || userPw.trim().isEmpty()) {
        response.sendRedirect("login.jsp?error=empty_fields");
        return; // 아래 로직이 실행되지 않도록 중단합니다.
    }

    // DAO를 통한 DB 조회
    // UserDAO.login() 내부에서 DB SELECT 쿼리를 실행
    UserDAO dao = new UserDAO();
    UserDTO loginUser = dao.login(userId, userPw);

    // 로그인 결과 처리
    if (loginUser != null) {
        // 성공: 세션(Session)에 정보를 저장, 로그인 상태를 유지
        // 세션은 브라우저를 닫거나 로그아웃 전까지 유지
        session.setAttribute("sessionId", loginUser.getUserId());
        session.setAttribute("sessionUser", loginUser); // 객체 전체를 담아두면 어디서든 정보 활용 가능
        session.setAttribute("sessionRole", loginUser.getRole()); // 권한 확인용 세션

        // 예약 기능에서 사용할 userNo 세션 추가 저장(민관 추가)
        session.setAttribute("userNo", loginUser.getUserNo());
        
        // 메인 페이지로 이동
        response.sendRedirect(request.getContextPath() + "/facility/welcome.jsp");
    } else {
        // 실패: 경고창을 띄우고 이전 페이지로 돌아가기
        response.sendRedirect("login.jsp?error=login_failed");
    }
%>