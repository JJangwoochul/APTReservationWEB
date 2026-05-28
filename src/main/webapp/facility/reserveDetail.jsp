<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.FacilityDTO" %>
<%@ page import="dao.FacilityDAO" %>
<%@ page errorPage="exceptionNoFacilityName.jsp" %>
<jsp:useBean id="facilityDAO" class="dao.FacilityDAO" scope="session" />
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<title>예약 확인 및 확정</title>
<script type="text/javascript">
    function confirmReservation() {
        document.realReserveForm.submit();
    }
</script>
</head>
<body class="bg-light">
<div class="container py-5">
<%@ include file="header.jsp"%>
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            
            <div class="card shadow border-0 rounded-3 overflow-hidden">
                
                <div class="card-header bg-primary text-white text-center py-4 border-0">
                    <p class="mb-1 text-uppercase tracking-wider small opacity-75">Reservation Confirmation</p>
                    <h3 class="fw-bold mb-0">예약 정보 재확인</h3>
                </div>

                <%
                    request.setCharacterEncoding("utf-8");
                    
                    String facilityNoParam = request.getParameter("facilityNo");
                    String reserveDate = request.getParameter("reserveDate"); 
                    
                    int facilityNo = 0;
                    if (facilityNoParam != null && !facilityNoParam.isEmpty()) {
                        facilityNo = Integer.parseInt(facilityNoParam);
                    }
                    
                    if (reserveDate == null || reserveDate.isEmpty()) {
                        reserveDate = "선택된 날짜 없음";
                    }
                    
                    FacilityDTO facility = facilityDAO.getFacilityDTOByNo(facilityNo);
                    
                    int userNo = 0;
                    if (session.getAttribute("userNo") != null) {
                        userNo = (Integer) session.getAttribute("userNo");
                    }
                    
                    int userCount = 1; 
                %>

                <div class="card-body p-4">
                    
                    <div class="text-center my-3">
                        <h4 class="fw-bold text-primary">"<%= (facility != null) ? facility.getFacilityName() : "알 수 없는 시설" %>"</h4>
                        <p class="fs-5 text-dark fw-semibold mb-1">예약 하시겠습니까?</p>
                        <p class="h6">(선택하신 정보가 맞는지 다시 한번 확인해 주세요.)</p>
                    </div>

                    <hr class="my-4 opacity-25">

                    <div class="bg-body-tertiary p-3 rounded-3 mb-4">
                        <div class="row py-2 align-items-center border-bottom border-white">
                            <div class="col-4 text-secondary fw-bold">예약 날짜</div>
                            <div class="col-8 text-dark fw-bold fs-6"><%=reserveDate%></div>
                        </div>
                        <div class="row py-2 align-items-center border-bottom border-white">
                            <div class="col-4 text-secondary fw-bold">이달 이용 내역</div>
                            <div class="col-8 text-dark fw-semibold">이용 중 (<%=userCount%>회)</div>
                        </div>
                        <div class="row py-2 align-items-center">
                        <div class="col-4 text-secondary fw-bold">이용료</div>
                            <div class="col-8 text-danger fw-bold fs-5">
                                <%= (facility != null) ? facility.getFacilityPrice() : 0 %> 원
                            </div>
                        </div>
                    </div>

                    <div class="alert alert-warning border-0 shadow-sm rounded-3 mb-4 small" role="alert">
                        <div class="d-flex gap-2">
                            <i class="bi bi-exclamation-triangle-fill text-warning fs-5"></i>
                            <div>
                                <p class="mb-1 fw-bold text-dark">이용 안내 및 주의사항</p>
                                <ul class="mb-0 ps-3 text-muted">
                                    <li>이용료는 매달 관리비에 포함되어 정산됩니다.</li>
                                    <li>예약 날짜 3일 전으로는 취소가 불가능합니다.</li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="row g-2 pt-2">
                        <div class="col-6">
                            <button type="button" class="btn btn-outline-secondary btn-lg w-100 fs-6 py-2.5" onclick="history.back();">
                                닫기
                            </button>
                        </div>
                        <div class="col-6">
                            <form name="realReserveForm" action="./processReserve.jsp" method="post" class="m-0">
                                <input type="hidden" name="facilityNo" value="<%= (facility != null) ? facility.getFacilityNo() : 0 %>">
                                <input type="hidden" name="userNo" value="<%=userNo%>">
                                <input type="hidden" name="reserveDate" value="<%=reserveDate%>">
                                
                                <button type="button" class="btn btn-primary btn-lg w-100 fs-6 py-2.5 fw-bold shadow-sm" onclick="confirmReservation()">
                                    예약확정
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