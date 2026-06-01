<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="admin_check.jsp" %>
<%@ page import="dao.NoticeDAO" %>

<%
    // (1) 삭제할 글 번호 받기 (파라미터명은 'id'를 그대로 유지해도 되지만, 
    // 내부 변수명은 'noticeNo'로 통일하여 명확하게 합니다.)
    String idParam = request.getParameter("id");
    int noticeNo = (idParam != null && !idParam.trim().isEmpty()) ? Integer.parseInt(idParam) : 0;

    if (noticeNo > 0) {
        try {
            // (2) 실제 DB 삭제 로직 호출
            NoticeDAO dao = NoticeDAO.getInstance(); 
            dao.deleteNotice(noticeNo); // 수정된 DAO 메서드 호출
            
            out.println("<script>alert('삭제되었습니다.'); location.href='notice.jsp';</script>");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('삭제 중 오류가 발생했습니다.'); history.back();</script>");
        }
    } else {
        out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
    }
%>