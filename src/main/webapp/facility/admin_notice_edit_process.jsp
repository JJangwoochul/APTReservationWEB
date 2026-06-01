<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="admin_check.jsp" %>
<%@ page import="dao.NoticeDAO, dto.NoticeDTO" %>
<%
    request.setCharacterEncoding("utf-8");

    // (1) 파라미터 수신: 변수명을 noticeNo로 통일
    String idParam = request.getParameter("noticeId");
    int noticeNo = (idParam != null && !idParam.isEmpty()) ? Integer.parseInt(idParam) : 0;
    String title = request.getParameter("title");
    String content = request.getParameter("content");

    // (2) 유효성 검사
    if (noticeNo <= 0 || title == null || title.trim().isEmpty() || content == null || content.trim().isEmpty()) {
        out.println("<script>alert('잘못된 접근이거나 제목/내용이 비어있습니다.'); history.back();</script>");
        return;
    }

    // (3) 수정 로직 수행
    try {
        NoticeDTO dto = new NoticeDTO();
        dto.setNoticeNo(noticeNo); // DTO의 수정된 setter 사용
        dto.setTitle(title);
        dto.setContent(content);

        NoticeDAO dao = NoticeDAO.getInstance();
        dao.updateNotice(dto);

        // 수정 완료 후 상세 페이지로 이동 (id 대신 noticeNo 파라미터 사용)
        out.println("<script>alert('수정되었습니다.'); location.href='notice_detail.jsp?id=" + noticeNo + "';</script>");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('수정 중 오류가 발생했습니다.'); history.back();</script>");
    }
%>