<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="admin_check.jsp" %>
<%@ page import="dao.NoticeDAO" %>

<%
    // (2) 삭제할 글 번호 받기
    String idParam = request.getParameter("id");
    int noticeId = (idParam != null) ? Integer.parseInt(idParam) : 0;

    if (noticeId > 0) {
        // (3) 삭제 로직 수행 (지금은 Mock이므로 출력만)
        System.out.println("글 삭제 진행 ID: " + noticeId);
        
        // 여기에 나중에 dao.deleteNotice(noticeId); 코드가 들어갈 예정입니다.
        
        out.println("<script>alert('삭제되었습니다.'); location.href='notice.jsp';</script>");
    } else {
        out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
    }
%>