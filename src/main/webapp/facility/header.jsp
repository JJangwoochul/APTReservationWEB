<%@ page contentType="text/html; charset=utf-8" %>

<%--로그인 상태일때 ,로그아웃했을때 확인 --%>

<%
    //세션에서 로그인 상태,권한 정보 확인
    //세션 정보는 서버에남아있고 , 페이지 이동에도 값 유지
    String sessionId = (String) session.getAttribute("sessionId");
    String role = (String) session.getAttribute("sessionRole");
%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

<div class="container">

<header class="d-flex flex-wrap align-items-center justify-content-between py-3 mb-4 border-bottom">

    <div>
        <a href="welcome.jsp" class="text-decoration-none fw-bold text-dark fs-4">APTWEB</a>
    </div>

    <ul class="nav">
        <li><a href="<%= request.getContextPath() %>/facility/welcome.jsp" class="nav-link text-dark">Home</a></li>
        <li><a href="<%= request.getContextPath() %>/facility/notice.jsp" class="nav-link text-dark">공지사항</a></li>

        <%-- 로그인 상태 처리 --%>
        <% if (sessionId == null) { %>
            <%-- 로그인 전: 방문자에게 보이는 메뉴 --%>
            <li class="nav-item">
                <button class="btn btn-outline-dark me-2" onclick="location.href='<%= request.getContextPath() %>/facility/login.jsp'">로그인</button>
            </li>
            <li class="nav-item">
                <button class="btn btn-dark" onclick="alert('로그인이 필요합니다.'); location.href='<%= request.getContextPath() %>/facility/login.jsp'">마이페이지</button>
            </li>
        <% } else { %>
            <%-- 로그인 후: User에게 보이는 메뉴 --%>
            <li class="nav-item">
                <span class="nav-link text-dark me-2"><strong><%= sessionId %></strong>님 환영합니다.</span>
            </li>

            <%-- 권한별 메뉴 : ADMIN 권한만 회원관리 버튼이 보임 --%>
            <%-- "ADMIN".equals(role) 순서로 작성하면 role이 null이어도 에러가 발생하지 않아 안전합니다. --%>
            <% if ("ADMIN".equals(role)) { %>
                <li class="nav-item">
                    <button class="btn btn-outline-danger me-2" onclick="location.href='<%= request.getContextPath() %>/facility/admin_memberList.jsp'">회원관리</button>
                </li>
            <% } %>

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