<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<title>시설 오류</title>
</head>
<body class="bg-light">
<div class="container py-4">
    <%@ include file="header.jsp" %>

    <div class="p-5 mb-5 bg-body-tertiary rounded-3 shadow-sm text-center">
        <div class="container-fluid py-3">
            <h1 class="display-5 fw-bold text-dark">존재하지 않는 시설입니다.</h1>
        </div>     
    </div>

<div class="container">
    <p> <%=request.getRequestURL() %>?<%=request.getQueryString() %>
    <p> <a href="facilitys.jsp" class="btn btn-primary"> 시설 목록 &raquo;</a>
</div>
<%@ include file="footer.jsp" %>
</div>
</body>
</html>
