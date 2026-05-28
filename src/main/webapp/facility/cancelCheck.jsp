<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<title>예약 취소 완료</title>
</head>
<body class="bg-light">
<div class="container py-4">
    <%@ include file="header.jsp"%>

    <div class="p-5 mb-5 bg-body-tertiary rounded-3 shadow-sm text-center">
        <div class="container-fluid py-3">
            <h1 class="display-5 fw-bold text-secondary">예약 취소</h1>
            <p class="lead text-muted">Reservation Canceled</p>
        </div>     
    </div>

    <div class="row justify-content-center my-5">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow border-0 rounded-3 overflow-hidden">
                <div class="bg-secondary p-2"></div>
                
                <div class="card-body p-5 text-center">
                    <h4 class="fw-bold text-dark mb-2">예약이 취소되었습니다.</h4>
                    <hr class="my-4 text-muted opacity-25">                    
                    <div class="d-grid gap-2">
                        <a href="./myPage.jsp" class="btn btn-primary py-2 fw-bold" role="button">
                            예약내역확인
                        </a>
                        <a href="./welcome.jsp" class="btn btn-outline-secondary py-2" role="button">
                            메인화면으로
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div> <%@ include file="footer.jsp"%>
</div>
</body>
</html>