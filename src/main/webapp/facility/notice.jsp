<%@ page contentType="text/html; charset=utf-8" %>
<%@ page language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.NoticeDAO" %>
<%@ page import="dto.NoticeDTO" %>

<%
    NoticeDAO dao = new NoticeDAO();
    List<NoticeDTO> list = dao.getNoticeList();
%>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>공지사항</title>
    <style>
        body {
            background-color: #f5f6f8;
        }

        .notice-container {
            width: 1000px;
            margin: 50px auto;
        }

        .notice-box {
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }

        .notice-title {
            font-size: 30px;
            font-weight: bold;
            margin-bottom: 30px;
            color: #212529;
        }

        .table {
            margin-bottom: 30px;
        }

        .table th {
            background-color: #212529;
            color: white;
            text-align: center;
        }

        .table td {
            vertical-align: middle;
        }

        .notice-link {
            text-decoration: none;
            color: #212529;
            font-weight: 500;
        }

        .notice-link:hover {
            text-decoration: underline;
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

<div class="notice-container">
    <div class="notice-box">
        <div class="notice-title">공지사항</div>
        
        <table class="table table-hover">
            <thead>
                <tr>
                    <th style="width: 10%;">번호</th>
                    <th style="width: 65%;">제목</th>
                    <th style="width: 25%;">작성일</th>
                </tr>
            </thead>
            <tbody>
                <% if(list != null && !list.isEmpty()) { 
                    for(NoticeDTO notice : list) { %>
                    <tr>
                        <td class="text-center text-muted"><%= notice.getNoticeId() %></td>
                        <td><a href="<%= request.getContextPath() %>/facility/notice_detail.jsp?id=<%= notice.getNoticeId() %>" class="notice-link"><%= notice.getTitle() %></a></td>
                        <td class="text-center text-muted"><%= notice.getupLoadDate().toString().substring(0, 10) %></td>
                    </tr>
                <%  } 
                } else { %>
                    <tr><td colspan="3" class="text-center">등록된 공지사항이 없습니다.</td></tr>
                <% } %>
            </tbody>
        </table>

       <%-- (1) 수정: 버튼 영역에 관리자 권한 체크 로직 추가 --%>
        <div class="d-flex justify-content-between">
            <button type="button" class="btn btn-light-custom" onclick="location.href='<%= request.getContextPath() %>/facility/welcome.jsp'">이전 페이지로</button>
            
            <%-- (2) 추가: ADMIN 권한을 가진 경우에만 '공지사항 등록' 버튼 노출 --%>
            <% if ("ADMIN".equals(session.getAttribute("sessionRole"))) { %>
                <button type="button" class="btn btn-dark" onclick="location.href='<%= request.getContextPath() %>/facility/admin_notice_write.jsp'">공지사항 등록</button>
            <% } %>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>