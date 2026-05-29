<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.FacilityDTO, dao.FacilityDAO" %>
<%@ page errorPage="exceptionNoFacilityName.jsp" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>예약 확인 및 확정</title>
    <script type="text/javascript">
        // 예약 확정 버튼 클릭 시, 숨겨진 폼을 서버로 전송하는 함수
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
                    // 이전 페이지에서 전달받은 파라미터(시설번호, 예약날짜, 숙박일수) 획득
                    String facilityNoParam = request.getParameter("facilityNo");
                    String reserveDate = request.getParameter("reserveDate");
                    String stayDays = request.getParameter("stayDays");
                    
                    int facilityNo = (facilityNoParam != null && !facilityNoParam.isEmpty()) ? Integer.parseInt(facilityNoParam) : 0;
                    
                    // DAO 인스턴스를 가져와 해당 시설 정보를 DB에서 조회
                    FacilityDAO dao = FacilityDAO.getInstance();
                    FacilityDTO facility = dao.getFacilityByNo(facilityNo);
                    
                    // 세션에서 사용자 정보 확인 및 게스트하우스 여부 판별(조건부 UI 변경용)
                    int userNo = (session.getAttribute("userNo") != null) ? (Integer) session.getAttribute("userNo") : 0;
                    boolean isGuesthouse = (facility != null && "게스트하우스".equals(facility.getFacilityName()));
                %>
                
                <%-- 예약 유형(게스트하우스 여부)에 따라 헤더 스타일 변경 --%>
                <div class="card-header <%= isGuesthouse ? "bg-dark" : "bg-primary" %> text-white text-center py-4 border-0">
                    <p class="mb-1 text-uppercase tracking-wider small opacity-75">Reservation Confirmation</p>
                    <h3 class="fw-bold mb-0">예약 정보 재확인</h3>
                </div>

                <div class="card-body p-4">
                    <div class="text-center my-3">
                        <h4 class="fw-bold text-primary">"<%= (facility != null) ? facility.getFacilityName() : "알 수 없는 시설" %>"</h4>
                    </div>

                    <%-- 예약 요약 정보 섹션 --%>
                    <div class="bg-body-tertiary p-3 rounded-3 mb-4">
                        <div class="row py-2 border-bottom border-white">
                            <div class="col-4 text-secondary fw-bold">예약 날짜</div>
                            <div class="col-8 text-dark fw-bold fs-6">
                                <%= (reserveDate != null) ? reserveDate : "날짜 미선택" %>
                                <% if (stayDays != null && !stayDays.isEmpty()) { %>
                                    <span class="badge bg-secondary ms-2"><%= stayDays %>박 <%= Integer.parseInt(stayDays) + 1 %>일</span>
                                <% } %>
                            </div>
                        </div>
                        <div class="row py-2">
                            <div class="col-4 text-secondary fw-bold">이용료</div>
                            <div class="col-8 text-danger fw-bold fs-5">
                                <%= (facility != null) ? facility.getFacilityPrice() : 0 %> 원
                            </div>
                        </div>
                    </div>

                    <%-- 하단 버튼 및 예약 확정 폼 전송 --%>
                    <div class="row g-2 pt-2">
                        <div class="col-6">
                            <button type="button" class="btn btn-outline-secondary btn-lg w-100" onclick="history.back();">닫기</button>
                        </div>
                        <div class="col-6">
                            <% if (isGuesthouse) { %>
                                <%-- 게스트하우스용 예약 처리 폼 --%>
                                <form name="realReserveForm" action="./processGuesthouse.jsp" method="post" class="m-0">
                                    <input type="hidden" name="facilityNo" value="<%= facility != null ? facility.getFacilityNo() : 0 %>">
                                    <input type="hidden" name="userNo" value="<%= userNo %>">
                                    <input type="hidden" name="reserveDate" value="<%= reserveDate %>">
                                    <input type="hidden" name="stayDays" value="<%= stayDays %>">
                                    <button type="button" class="btn btn-dark btn-lg w-100 fw-bold shadow-sm" onclick="confirmReservation()">예약확정</button>
                                </form>
                            <% } else { %>
                                <%-- 일반 시설용 예약 처리 폼 --%>
                                <form name="realReserveForm" action="./processReserve.jsp" method="post" class="m-0">
                                    <input type="hidden" name="facilityNo" value="<%= facility != null ? facility.getFacilityNo() : 0 %>">
                                    <input type="hidden" name="userNo" value="<%= userNo %>">
                                    <input type="hidden" name="reserveDate" value="<%= reserveDate %>">
                                    <button type="button" class="btn btn-primary btn-lg w-100 fw-bold shadow-sm" onclick="confirmReservation()">예약확정</button>
                                </form>
                            <% } %>
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