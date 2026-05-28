<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.Date" %>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<title>메인화면</title>
</head>
<body class="bg-light">
<div class="container py-4">
    <%@ include file="header.jsp"%>
    
    <%! 
        String greeting = "안녕하세요! 환영합니다.";
        String tagline = "Welcome to Apt Web!";
    %>
    
    <div class="p-5 mb-5 rounded-3 shadow shadow-lg text-center text-white position-relative overflow-hidden" 
         style="background: linear-gradient(rgba(0, 0, 0, 0.55), rgba(0, 0, 0, 0.65)), url('/aptweb/resources/images/apt01.jpg') no-repeat center center; background-size: cover; min-height: 350px;">
        
        <div class="container-fluid py-5 position-relative" style="z-index: 2;">
            <h1 class="display-4 fw-bold mb-3"><%=greeting%></h1>
            <p class="fs-4 mb-4 text-light opacity-90"><%=tagline%></p>
            <p class="lead mb-4 text-white-50 small">우리 아파트 입주민을 위한 스마트한 커뮤니티 공간입니다.</p>
            
            <div class="d-inline-block px-4 py-2 bg-white bg-opacity-10 border border-white border-opacity-25 rounded-pill backdrop-blur mb-4">
                <div class="d-flex align-items-center justify-content-center gap-2 small">
                    <span class="badge bg-danger px-2 py-1 fw-bold rounded-pill animate-pulse">LIVE</span>
                    <span class="fw-medium text-white">
                        <%
                            Date day = new java.util.Date();
                            String am_pm;
                            int hour = day.getHours();
                            int minute = day.getMinutes();
                            int second = day.getSeconds();
                            if (hour / 12 == 0) {
                                am_pm = "AM";
                            } else {
                                am_pm = "PM";
                                hour = hour - 12;
                            }
                            String CT = hour + ":" + minute + ":" + second + " " + am_pm;
                            out.print("현재 접속 시각: " + CT);
                            response.setIntHeader("Refresh", 5);
                        %>
                    </span>
                </div>
            </div>
            
            <div class="d-flex justify-content-center gap-2 mt-2">
                <a href="./facilitys.jsp" class="btn btn-warning btn-lg px-4 py-2.5 fw-bold text-dark shadow">
                    시설 예약하러 가기 &raquo;
                </a>
            </div>
        </div>     
    </div>

    <%@ include file="footer.jsp"%>
</div>
</body>
</html>