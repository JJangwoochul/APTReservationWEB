<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="admin_check.jsp" %>
<%
    request.setCharacterEncoding("utf-8");

    // (3) 수정된 데이터 및 ID 파라미터 수신
    int noticeId = Integer.parseInt(request.getParameter("noticeId"));
    String title = request.getParameter("title");
    String content = request.getParameter("content");

    // (4) 수정 로직 수행 (지금은 Mock이므로 출력만)
    System.out.println("글 수정 진행 ID: " + noticeId);
    System.out.println("수정된 제목: " + title);
    System.out.println("수정된 내용: " + content);

    out.println("<script>alert('수정되었습니다.'); location.href='notice.jsp';</script>");
%>