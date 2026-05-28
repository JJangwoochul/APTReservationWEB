<%@ page contentType="text/html; charset=utf-8" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

<div class="container">

<header class="d-flex flex-wrap align-items-center justify-content-between py-3 mb-4 border-bottom">

    <div>
        <a href="welcome.jsp" class="text-decoration-none fw-bold text-dark fs-4">
            APTWEB
        </a>
    </div>

    <ul class="nav">
        <li><a href="<%= request.getContextPath() %>/facility/welcome.jsp" class="nav-link text-dark">Home</a></li>
        <li><a href="<%= request.getContextPath() %>/facility/notice.jsp" class="nav-link text-dark">공지사항</a></li>

    <% if (session.getAttribute("sessionId") == null) { %>
        <li class="nav-item">
            <button class="btn btn-outline-dark me-2" onclick="location.href='<%= request.getContextPath() %>/facility/login.jsp'">로그인</button>
        </li>
        <li class="nav-item">
            <button class="btn btn-dark" onclick="alert('로그인이 필요합니다.'); location.href='<%= request.getContextPath() %>/facility/login.jsp'">마이페이지</button>
        </li>
    <% } else { %>
        <li class="nav-item">
            <span class="nav-link text-dark me-2"><strong><%= session.getAttribute("sessionId") %></strong>님</span>
        </li>
        <li class="nav-item">
            <button class="btn btn-outline-dark me-2" onclick="location.href='<%= request.getContextPath() %>/facility/logout_process.jsp'">로그아웃</button>
        </li>
        <li class="nav-item">
            <button class="btn btn-dark" onclick="location.href='<%= request.getContextPath() %>/facility/mypage01.jsp'">마이페이지</button>
        </li>
    <% } %>
    </ul>
</header>

</div>