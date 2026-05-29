<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.FacilityDTO" %>
<%@ page import="dao.FacilityDAO" %>
<%@ page errorPage="exceptionNoFacilityName.jsp" %>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<title>시설 예약하기</title>
<script type="text/javascript">
    function reserve(facilityNo) {
        if (confirm("이 시설을 예약 하시겠습니까?")) {
            // URL 파라미터로 no를 넘겨서 페이지 이동
            location.href = "./reserve.jsp?no=" + facilityNo;
        }
    }
</script>
</head>
<body class="bg-light">
<div class="container py-4">
    <%@ include file="header.jsp"%>

    <div class="p-5 mb-5 bg-body-tertiary rounded-3 shadow-sm text-center">
        <h1 class="display-5 fw-bold text-dark">시설 예약하기</h1>
        <p class="lead">Facility Reservation</p>
    </div>

    <%
        request.setCharacterEncoding("utf-8");
        String fno = request.getParameter("no");
        int no = (fno != null && !fno.isEmpty()) ? Integer.parseInt(fno) : 0;

        FacilityDAO dao = FacilityDAO.getInstance();
        FacilityDTO facility = dao.getFacilityByNo(no);
    %>

    <div class="row justify-content-center my-4">
        <div class="col-lg-10">
            <div class="card shadow-sm border-0 overflow-hidden rounded-3">
                <div class="row g-0 align-items-stretch">
                    <div class="col-md-5 bg-dark d-flex align-items-center justify-content-center" style="min-height: 400px;">
                        <img src="/aptweb/resources/images/<%=facility.getFileName() %>" 
                             class="img-fluid" style="height: 100%; width: 100%; object-fit: cover;" alt="<%=facility.getFacilityName()%>" />
                    </div>
                    
                    <div class="col-md-7 d-flex align-items-center">
                        <div class="card-body p-5 text-start w-100">
                            <span class="badge bg-secondary mb-2">고유번호: <%=facility.getFacilityNo()%></span>
                            <h2 class="fw-bold text-primary mb-3"><%=facility.getFacilityName()%></h2>
                            <p class="text-muted mb-4 lead" style="white-space: pre-wrap;"><%=facility.getDescription()%></p>
                            
                            <hr class="my-4">
                            
                            <div class="mb-4">
                                <div class="row py-2 border-bottom align-items-center">
                                    <div class="col-sm-4 fw-bold text-secondary"> 이용 금액</div>
                                    <div class="col-sm-8 fs-5 text-dark fw-bold"><%=facility.getFacilityPrice()%> 원</div>
                                </div>
                                <div class="row py-2 border-bottom align-items-center">
                                    <div class="col-sm-4 fw-bold text-secondary"> 시설 상태</div>
                                    <div class="col-sm-8"><span class="badge bg-success px-3 py-2"><%=facility.getCondition()%></span></div>
                                </div>
                                <div class="row py-2 align-items-center">
                                    <div class="col-sm-4 fw-bold text-secondary"> 수용 인원</div>
                                    <div class="col-sm-8"><%=facility.getPeopleInStock()%> 명</div>
                                </div>
                            </div>
                            
                            <div class="d-grid gap-2">
                                <button type="button" class="btn btn-outline-primary px-3 py-2" onclick="reserve(<%=facility.getFacilityNo()%>)">
                                    예약하기 &raquo;
                                </button>
                                <a href="./facilitys.jsp" class="btn btn-outline-secondary px-3 py-2" role="button">
                                    &laquo; 시설 목록 돌아가기
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div> 

    <%@ include file="footer.jsp"%>
</div>
</body>
</html>