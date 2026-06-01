<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="admin_check.jsp" %>
<%@ page import="dao.NoticeDAO" %>
<%@ page import="dto.NoticeDTO" %>

<%
    // (1) 수정할 글 번호 가져오기
    String idParam = request.getParameter("id");
    int noticeId = (idParam != null) ? Integer.parseInt(idParam) : 0;
    
    NoticeDAO dao = NoticeDAO.getInstance();
    NoticeDTO notice = dao.getNotice(noticeId); // 기존 데이터 가져오기

    if (notice == null) {
        out.println("<script>alert('존재하지 않는 게시글입니다.'); history.back();</script>");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>공지사항 수정</title>
</head>
<body>
<div class="container mt-5" style="width: 800px;">
    <h2>공지사항 수정</h2>
    <hr>
    <form action="admin_notice_edit_process.jsp" method="post">
        <%-- (2) 글 번호는 사용자에게 보이지 않게 숨김값(hidden)으로 전달 --%>
        <input type="hidden" name="noticeId" value="<%= notice.getNoticeNo() %>">
        
        <div class="mb-3">
            <label class="form-label">제목</label>
            <input type="text" name="title" class="form-control" value="<%= notice.getTitle() %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">내용</label>
            <textarea name="content" class="form-control" rows="10" required><%= notice.getContent() %></textarea>
        </div>
        
        <div class="text-end">
            <button type="button" class="btn btn-secondary" onclick="location.href='<%= request.getContextPath() %>/facility/notice.jsp'">취소</button>
            <button type="submit" class="btn btn-warning">수정 완료</button>
        </div>
    </form>
</div>
</body>
</html>