<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.FacilityDTO, dao.FacilityDAO" %>
<%@ page errorPage="exceptionNoFacilityName.jsp" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>예약 확인 및 확정</title>
    <script type="text/javascript">
        // 선택한 시작 시간에 맞춰 종료 시간 자동 계산
        function updateTimeValues() {
            var select = document.getElementById("startTimeSelect");
            if (!select) return; // 게스트하우스인 경우 select가 없으므로 종료
            
            var start = parseInt(select.value);
            var end = start + 2;
            var displayEnd = (end > 24) ? end - 24 : end;
            var dayLabel = (end > 24) ? " (다음날)" : "";
    
            document.getElementById("startTime").value = start;
            document.getElementById("endTime").value = end;
            document.getElementById("timeDisplay").innerText = 
                start + ":00 ~ " + displayEnd + ":00" + dayLabel;
        }
        // 예약 확정 버튼 클릭 시, 해당 유형의 폼을 서버로 전송
        function confirmReservation(formName) {
            // 일반 시설인 경우에만 시간값 업데이트 실행
            if (formName === "facilityForm") {
                updateTimeValues();
            }
            document.forms[formName].submit();
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
                    // (1) 최종 금액 계산 로직 분리
                    int finalPrice = 0;
                    if (facility != null) {
                        if (facility != null) {
                        finalPrice = isGuesthouse ? (facility.getFacilityPrice() * Integer.parseInt(stayDays)) : facility.getFacilityPrice();
                    }
                    }
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
    
                    <% if (isGuesthouse) { %>
                    <%-- 게스트하우스 전용 요약 --%>
                    <div class="row py-2 border-bottom border-white">
                        <div class="col-4 text-secondary fw-bold">숙박 기간</div>
                        <div class="col-8 text-dark fw-bold fs-6">
                            <%= reserveDate %> (체크인) ~ <br>
                            <span class="badge bg-dark"><%= stayDays %>박 <%= Integer.parseInt(stayDays) + 1 %>일</span>
                        </div>
                    </div>
                    <% } else { %>
                        <div class="row py-2 border-bottom border-white">
                            <div class="col-4 text-secondary fw-bold">이용 날짜</div>
                            <div class="col-8 text-dark fw-bold fs-6"><%= reserveDate %></div>
                        </div>
                        <div class="row py-2 border-bottom border-white">
                            <div class="col-4 text-secondary fw-bold">이용 시간</div>
                            <div class="col-8 text-dark fw-bold fs-6" id="timeDisplay">시간을 선택해주세요.</div>
                        </div>
                        <%-- (2) 일반 시설용 시간 선택 옵션 --%>
                        <div class="row py-2 border-bottom border-white">
                            <div class="col-4 text-secondary fw-bold">시간 선택</div>
                            <div class="col-8">
                                <select id="startTimeSelect" class="form-select form-select-sm" onchange="updateTimeValues()">
                                <% 
                                    for(int i = 0; i <= 23; i++) { 
                                    int end = i + 2;
                                    String display = i + ":00 ~ " + (end > 24 ? end - 24 : end) + ":00" + (end > 24 ? " (다음날)" : "");
                                %>
                                <option value="<%= i %>"><%= display %></option>
                                <% } %>
                                </select>
                            </div>
                        </div>
                        <% } %>

                        <div class="row py-2">
                            <div class="col-4 text-secondary fw-bold">최종 금액</div>
                            <div class="col-8 text-danger fw-bold fs-5"><%= finalPrice %> 원</div>
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
                                    <input type="hidden" name="useDate" value="<%= reserveDate %>">
                                    <input type="hidden" name="price" value="<%= facility != null ? facility.getFacilityPrice() * Integer.parseInt(stayDays) : 0 %>">
                                    <button type="button" class="btn btn-dark btn-lg w-100 fw-bold shadow-sm" onclick="confirmReservation()">예약확정</button>
                                </form>
                            <% } else { %>
                                <%-- 일반 시설용 예약 처리 폼 --%>
                                <form name="realReserveForm" action="./processReserve.jsp" method="post" class="m-0">
                                    <input type="hidden" name="facilityNo" value="<%= facility != null ? facility.getFacilityNo() : 0 %>">
                                    <input type="hidden" name="userNo" value="<%= userNo %>">
                                    <input type="hidden" name="reserveDate" value="<%= reserveDate %>">
                                    <input type="hidden" name="useDate" value="<%= reserveDate %>">
                                    <input type="hidden" name="startTime" id="startTime" value="9">
                                    <input type="hidden" name="endTime" id="endTime" value="18">
                                    <input type="hidden" name="price" value="<%= facility != null ? facility.getFacilityPrice() : 0 %>">
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