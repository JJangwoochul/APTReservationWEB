<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.FacilityDTO" %>
<%@ page import="dao.FacilityDAO" %>
<%@ page import="dto.ReserveDTO" %>
<%@ page import="dao.ReserveDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page errorPage="exceptionNoFacilityName.jsp" %>
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

    <%
        request.setCharacterEncoding("utf-8");
        
        // 1. 파라미터 및 세션 정보 확보
        String fno = request.getParameter("no");
        int no = (fno != null && !fno.isEmpty()) ? Integer.parseInt(fno) : 0;
        int userNo = (session.getAttribute("userNo") != null) ? (Integer) session.getAttribute("userNo") : 0;

        // 2. 시설 정보 조회
        FacilityDAO dao = FacilityDAO.getInstance();
        FacilityDTO facility = dao.getFacilityDTOByNo(no);

        // 3. 내 예약 목록에서 해당 시설의 예약 번호 찾기 (DAO 수정 없이 로직 처리)
        ReserveDAO reserveDAO = ReserveDAO.getInstance();
        ArrayList<ReserveDTO> userReserves = reserveDAO.getReservesByUser(userNo);
        
        int targetReserveNo = 0;
        for (ReserveDTO r : userReserves) {
            if (r.getFacilityNo() == no) {
                targetReserveNo = r.getReserveNo(); // 일치하는 예약 번호 추출
                break;
            }
        }
    %>

    <div class="p-5 mb-5 bg-body-tertiary rounded-3 shadow-sm text-center">
        <h1 class="display-5 fw-bold text-dark">예약 취소</h1>
        <p class="lead">Reservation Canceled</p>
    </div>

    <div class="row justify-content-center my-4">
        <div class="col-lg-10">
            <div class="card shadow-sm border-0 overflow-hidden rounded-3">
                <div class="row g-0 align-items-stretch">
                    <div class="col-md-5 bg-dark d-flex align-items-center justify-content-center" style="min-height: 400px;">
                        <img src="/aptweb/resources/images/<%=facility.getFileName() %>" class="img-fluid" style="height: 100%; width: 100%; object-fit: cover; max-height: 500px;" alt="<%=facility.getFacilityName()%>" />
                    </div>
                    
                    <div class="col-md-7 d-flex align-items-center">
                        <div class="card-body p-5 text-start w-100">
                            <h2 class="fw-bold text-danger mb-3"><%=facility.getFacilityName()%></h2>
                            <p class="text-muted mb-4 lead" style="white-space: pre-wrap;"><%=facility.getDescription()%></p>
                            <hr class="my-4">
                            
                            <form name="cancelForm" action="./processReserveCancel.jsp?reserveNo=<%= targetReserveNo %>" method="post">
                                <button type="button" class="btn btn-danger px-4 py-2 fw-bold text-white" onclick="cancel()">
                                    예약취소 &raquo;
                                </button>
                            </form>
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