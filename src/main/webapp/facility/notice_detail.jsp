<%@ page contentType="text/html; charset=utf-8" %>
<%@ page language="java" %>
<%@ page import="dao.NoticeDAO" %>
<%@ page import="dto.NoticeDTO" %>
<%
    // (1) 파라미터 받기 및 데이터 조회
    String idParam = request.getParameter("id");
    int noticeId = (idParam != null) ? Integer.parseInt(idParam) : 1; // 파라미터가 없으면 1번 글 표시
    
    NoticeDAO dao = new NoticeDAO();
    NoticeDTO notice = dao.getNotice(noticeId); // 해당 ID의 데이터를 DAO에서 가져옴
    // (2) null 체크 보완: 데이터가 없을 경우 이전 페이지로 이동
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
            <div class="detail-title"><%= notice.getNoticeId() %>. <%= notice.getTitle() %></div>
            <div class="detail-info d-flex justify-content-between">
                <div><strong>작성자:</strong> 관리사무소</div>
                <div><strong>작성일:</strong> <%= notice.getupLoadDate().toString().substring(0,10) %></div>
            </div>
        </div>

        <div class="detail-content">
            <%= notice.getContent() %>
        </div>

        <div class="text-end">
            <button type="button" class="btn btn-light-custom" onclick="location.href='<%= request.getContextPath() %>/notice.jsp'">이전 페이지로</button>
        </div>
        
    </div>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>