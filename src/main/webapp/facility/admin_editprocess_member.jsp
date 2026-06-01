<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dao.UserDAO, dto.UserDTO" %>
<%@ include file="admin_check.jsp" %>
<%
    request.setCharacterEncoding("utf-8");

    // (1) 폼에서 전달받은 파라미터 값 추출
    int userNo = Integer.parseInt(request.getParameter("userNo"));
    String userName = request.getParameter("userName");
    String phone = request.getParameter("phone");
    String dong = request.getParameter("dong");
    String ho = request.getParameter("ho");
    String role = request.getParameter("role");

    // (2) DTO 객체 생성 및 값 세팅
    UserDTO user = new UserDTO();
    user.setUserNo(userNo);
    user.setUserName(userName);
    user.setPhone(phone);
    user.setDong(dong);
    user.setHo(ho);
    user.setRole(role);

    // (3) DAO 호출하여 업데이트 실행
    UserDAO dao = new UserDAO();
    dao.updateMember(user);

    // (4) 수정 완료 후 다시 목록 페이지로 리다이렉트
    response.sendRedirect("admin_memberList.jsp");
%>