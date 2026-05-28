<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.FacilityDTO" %>
<%@ page import="dao.FacilityDAO" %>
<%@ page errorPage="exceptionNoFacilityName.jsp" %>
<jsp:useBean id="facilityDAO" class="dao.FacilityDAO" scope="session" />
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<title>시설 예약 취소</title>
<script type="text/javascript">
    function cancel() {
        if (confirm("예약을 취소 하시겠습니까?")) {
            document.cancelForm.submit();
        }
    }
</script>
</head>
<body class="bg-light">
<div class="container py-4">
    <%@ include file="header.jsp"%>

    <div class="p-5 mb-5 bg-body-tertiary rounded-3 shadow-sm text-center">
        <div class="container-fluid py-3">
            <h1 class="display-5 fw-bold text-dark">예약 취소</h1>
            <p class="lead">Reservation Canceled</p>
        </div>     
    </div>

    <%
        request.setCharacterEncoding("utf-8");

        String fno = request.getParameter("no");
        int no = 0;

        if (fno != null && !fno.isEmpty()) {
            no = Integer.parseInt(fno);
        }

        FacilityDAO dao = FacilityDAO.getInstance();
        FacilityDTO facility = dao.getFacilityDTOByNo(no);
    %>

    <div class="row justify-content-center my-4">
        <div class="col-lg-10">
            <div class="card shadow-sm border-0 overflow-hidden rounded-3">
                <div class="row g-0 align-items-stretch">
                    
                    <div class="col-md-5 bg-dark d-flex align-items-center justify-content-center" style="min-height: 400px;">
                        <img src="/aptweb/resources/images/<%=facility.getFileName() %>" 
                             class="img-fluid" 
                             style="height: 100%; width: 100%; object-fit: cover; max-height: 500px;" 
                             alt="<%=facility.getFacilityName()%>" />
                    </div>
                    
                    <div class="col-md-7 d-flex align-items-center">
                        <div class="card-body p-5 text-start w-100">
                            <span class="badge bg-secondary mb-2">고유번호: <%=facility.getFacilityNo()%></span>
                            <h2 class="fw-bold text-danger mb-3"><%=facility.getFacilityName()%></h2>
                            
                            <p class="text-muted mb-4 lead" style="white-space: pre-wrap;"><%=facility.getDescription()%></p>
                            
                            <hr class="my-4">
                            
                            <div class="mb-4">
                                <div class="row py-2 border-bottom align-items-center">
                                    <div class="col-sm-4 fw-bold text-secondary"> 반환/취소 금액</div>
                                    <div class="col-sm-8 fs-5 text-dark fw-bold"><%=facility.getFacilityPrice()%> 원</div>
                                </div>
                                <div class="row py-2 border-bottom align-items-center">
                                    <div class="col-sm-4 fw-bold text-secondary"> 시설 상태</div>
                                    <div class="col-sm-8"><span class="badge bg-success px-3 py-2"><%=facility.getCondition()%></span></div>
                                </div>
                                <div class="row py-2 align-items-center">
                                    <div class="col-sm-4 fw-bold text-secondary"> 예약 인원</div>
                                    <div class="col-sm-8"><%=facility.getPeopleInStock()%> 명</div>
                                </div>
                            </div>
                            
                            <div class="pt-2">
                                <form name="cancelForm" action="./processReserveCancel.jsp?no=<%=facility.getFacilityNo() %>" method="post">
                                    <button type="button" class="btn btn-danger px-4 py-2 fw-bold text-white me-2" onclick="cancel()">
                                        예약취소 &raquo;
                                    </button>
                                </form>
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