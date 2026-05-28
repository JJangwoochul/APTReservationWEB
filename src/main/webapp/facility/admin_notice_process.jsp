<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="admin_check.jsp" %>
<%@ page import="dao.NoticeDAO" %>
<%@ page import="dto.NoticeDTO" %>
<%@ page import="java.util.Date" %>

<%
    request.setCharacterEncoding("utf-8");

    String title = request.getParameter("title");
    String content = request.getParameter("content");

    // (4) 유효성 검사 (입력값이 비어있는지 확인)
    if (title == null || title.trim().isEmpty() || content == null || content.trim().isEmpty()) {
        out.println("<script>alert('제목과 내용을 모두 입력해주세요.'); history.back();</script>");
        return;
    }

    // (5) DB 저장 로직 (현재는 Mock 데이터 작업 중이므로 콘솔 출력으로 대체)
    // 추후 NoticeDAO에 insertNotice(NoticeDTO) 메서드를 만들면 이곳에서 호출합니다.
    System.out.println("공지사항 등록 요청");
    System.out.println("제목: " + title);
    System.out.println("내용: " + content);
    
    // (6) 등록 완료 알림 후 공지사항 목록으로 이동
    out.println("<script>alert('공지사항이 등록되었습니다.'); location.href='notice.jsp';</script>");
%>