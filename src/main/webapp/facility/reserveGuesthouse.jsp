<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.FacilityDTO, dao.FacilityDAO" %>
<%@ page errorPage="exceptionNoFacilityName.jsp" %>
<jsp:useBean id="facilityDAO" class="dao.FacilityDAO" scope="session" />
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
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
                <%
                    request.setCharacterEncoding("utf-8");
                    String facilityNoParam = request.getParameter("facilityNo");
                    String reserveDate = request.getParameter("reserveDate"); 
                    int facilityNo = (facilityNoParam != null && !facilityNoParam.isEmpty()) ? Integer.parseInt(facilityNoParam) : 0;
                    
                    FacilityDTO facility = facilityDAO.getFacilityDTOByNo(facilityNo);
                    int userNo = (session.getAttribute("userNo") != null) ? (Integer) session.getAttribute("userNo") : 0;

                    boolean isGuesthouse = (facility != null && "게스트하우스".equals(facility.getFacilityName()));
                    String actionPage = isGuesthouse ? "./processGuesthouse.jsp" : "./processReserve.jsp";
                %>
                
                <div class="card-header <%= isGuesthouse ? "bg-dark" : "bg-primary" %> text-white text-center py-4 border-0">
                    <p class="mb-1 text-uppercase tracking-wider small opacity-75">Reservation Confirmation</p>
                    <h3 class="fw-bold mb-0"><%= isGuesthouse ? "게스트하우스" : "시설" %> 예약 정보 재확인</h3>
                </div>

                <div class="card-body p-4">
                    <div class="text-center my-3">
                        <h4 class="fw-bold text-primary">"<%= (facility != null) ? facility.getFacilityName() : "알 수 없는 시설" %>"</h4>
                        <p class="fs-5 text-dark fw-semibold mb-1">예약 하시겠습니까?</p>
                    </div>

                    <hr class="my-4 opacity-25">

                    <div class="bg-body-tertiary p-3 rounded-3 mb-4">
                        <div class="row py-2 border-bottom border-white">
                            <div class="col-4 text-secondary fw-bold">예약 날짜</div>
                            <div class="col-8 text-dark fw-bold"><%= (reserveDate != null) ? reserveDate : "날짜 미선택" %></div>
                        </div>
                        <div class="row py-2">
                            <div class="col-4 text-secondary fw-bold">이용료</div>
                            <div class="col-8 text-danger fw-bold fs-5">
                                <%= (facility != null) ? facility.getFacilityPrice() : 0 %> 원
                            </div>
                        </div>
                    </div>

                    <div class="row g-2 pt-2">
                        <div class="col-6">
                            <button type="button" class="btn btn-outline-secondary btn-lg w-100" onclick="history.back();">닫기</button>
                        </div>
                        <div class="col-6">
                            <form name="realReserveForm" action="<%= actionPage %>" method="post" class="m-0">
                                <input type="hidden" name="facilityNo" value="<%= (facility != null) ? facility.getFacilityNo() : 0 %>">
                                <input type="hidden" name="userNo" value="<%=userNo%>">
                                <input type="hidden" name="reserveDate" value="<%=reserveDate%>">
                                
                                <button type="button" class="btn <%= isGuesthouse ? "btn-dark" : "btn-primary" %> btn-lg w-100 fw-bold" onclick="confirmReservation()">
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