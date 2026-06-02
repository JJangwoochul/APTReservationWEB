<%@ page contentType="text/html; charset=utf-8" %>
<%@ page language="java" %>
<%@ page import="dao.NoticeDAO" %>
<%@ page import="dto.NoticeDTO" %>
<%
// 공지사항 상세보기

    // 파라미터 받기 및 데이터 조회
    //id가 null이면 잘못된접근 메세지 출력 (보안강화)
    String idParam = request.getParameter("id");
    if (idParam == null || idParam.trim().isEmpty()) {
        out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
        return; // 아래의 DB 로직이 실행전 중단
    }
    int noticeId = Integer.parseInt(idParam);
    // 상세페이지에 들어올 떄 DB에서 조회수 업데이트
    NoticeDAO dao = NoticeDAO.getInstance();
    dao.incrementHit(noticeId);
    // 게시글 조회
    NoticeDTO notice = dao.getNotice(noticeId);
    // null 체크 보완: 데이터가 없을 경우 이전 페이지로 이동
    if (notice == null) {
        out.println("<script>alert('존재하지 않는 공지사항입니다.'); history.back();</script>");
        return;
    }
%>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>공지사항 상세보기</title>
    <style>
        body {
            background-color: #f5f6f8;
        }

        .detail-container {
            width: 1000px;
            margin: 50px auto;
        }

        .detail-box {
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }

        .detail-header {
            border-bottom: 2px solid #212529;
            padding-bottom: 15px;
            margin-bottom: 30px;
        }

        .detail-title {
            font-size: 26px;
            font-weight: bold;
            color: #212529;
            margin-bottom: 15px;
        }

        .detail-info {
            font-size: 14px;
            color: #6c757d;
        }

        .detail-content {
            min-height: 300px;
            padding: 20px 10px;
            font-size: 16px;
            line-height: 1.8;
            color: #333333;
            border-bottom: 1px solid #dee2e6;
            margin-bottom: 30px;
        }

        .btn-light-custom {
            background: #e9ecef;
            color: #212529;
            padding: 10px 25px;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            transition: 0.2s;
        }

        .btn-light-custom:hover {
            background: #dee2e6;
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="detail-container">
    <div class="detail-box">
        
        <div class="detail-header">
            <div class="detail-title"><%= notice.getNoticeNo() %>. <%= notice.getTitle() %></div>
            <div class="detail-info d-flex justify-content-between">
                <div><strong>작성자:</strong> 관리사무소</div>
                <div><strong>작성일:</strong> <%= notice.getRegDate() != null ? notice.getRegDate().toString().substring(0, 10) : "날짜없음" %></div>
            </div>
        </div>

        <div class="detail-content">
            <%= notice.getContent() %>
        </div>

        <div class="text-end">
            <button type="button" class="btn btn-light-custom" onclick="location.href='<%= request.getContextPath() %>/facility/notice.jsp'">돌아가기</button>
    
             <%-- 관리자일 경우에만 수정/삭제 버튼 노출 --%>
             <% if ("ADMIN".equals(session.getAttribute("sessionRole"))) { %>
              <button type="button" class="btn btn-outline-warning" onclick="location.href='admin_notice_edit.jsp?id=<%= noticeId %>'">수정</button>
              <%-- 삭제 버튼: confirm 창으로 한 번 더 확인 --%>
              <button type="button" class="btn btn-outline-danger" onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='admin_notice_delete_process.jsp?id=<%= noticeId %>'">삭제</button>
            <% } %>
        </div>
        
    </div>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>