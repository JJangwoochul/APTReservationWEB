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
        
        // 1. 예약 번호를 받아옵니다. (마이페이지에서 보낸 reserveNo)
        String rNoParam = request.getParameter("reserveNo");
        int reserveNo = (rNoParam != null && !rNoParam.isEmpty()) ? Integer.parseInt(rNoParam) : 0;

        // 2. 예약 번호로 예약 정보(ReserveDTO)를 직접 조회
        ReserveDAO reserveDAO = ReserveDAO.getInstance();
        ReserveDTO reserve = reserveDAO.getReserveByNo(reserveNo); // DAO에 이 메서드가 있어야 합니다!
        
        // 만약 reserveByNo 메서드가 없으면 리스트 전체 조회 후 찾기
        if (reserve == null) {
            // 예약 정보가 없을 경우
            out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
            return;
        }

        // 3. 예약 정보에서 시설 번호를 꺼내 시설 정보 조회
        FacilityDAO facilityDAO = FacilityDAO.getInstance();
        FacilityDTO facility = facilityDAO.getFacilityByNo(reserve.getFacilityNo());
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
                            
                            <form name="cancelForm" action="./processReserveCancel.jsp?reserveNo=<%= reserveNo %>" method="post">
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