<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.FacilityDTO, dao.FacilityDAO, java.time.*" %>
<%@ page errorPage="exceptionNoFacilityName.jsp" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>예약 확인 및 확정</title>
    <script type="text/javascript">
        // [기능] 선택한 시작 시간에 맞춰 종료 시간 자동 계산 및 화면 업데이트
        function updateTimeValues() {
            var select = document.getElementById("startTimeSelect");
            if (!select) return; 
            
            var start = parseInt(select.value);
            var end = start + 2; // 기본 이용 시간 2시간
            var displayEnd = (end > 24) ? end - 24 : end;
            var dayLabel = (end > 24) ? " (다음날)" : "";
    
            // 폼 전송을 위한 숨겨진 필드 값 갱신
            document.getElementById("startTime").value = start;
            document.getElementById("endTime").value = end;
            // 사용자에게 보여줄 텍스트 업데이트
            document.getElementById("timeDisplay").innerText = 
                start + ":00 ~ " + displayEnd + ":00" + dayLabel;
        }

        // [기능] 예약 확정 버튼 클릭 시, 해당 유형(게스트하우스 vs 일반)에 맞는 폼 제출
        function confirmReservation(formName) {
            if (formName === "facilityForm") {
                updateTimeValues(); // 일반 시설일 경우 시간 값 동기화 후 제출
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
                    
                    // 1. 요청 파라미터 획득 (시설번호, 예약날짜, 숙박일수)
                    String facilityNoParam = request.getParameter("facilityNo");
                    String reserveDate = request.getParameter("reserveDate");
                    String stayDays = request.getParameter("stayDays");
                    
                    int facilityNo = (facilityNoParam != null && !facilityNoParam.isEmpty()) ? Integer.parseInt(facilityNoParam) : 0;
                    
                    // 2. DB에서 시설 정보 조회
                    FacilityDAO dao = FacilityDAO.getInstance();
                    FacilityDTO facility = dao.getFacilityByNo(facilityNo);

                    // 오늘 날짜 및 현재 시간 관련 변수 설정
                    java.time.LocalDate today = java.time.LocalDate.now();
                    java.time.LocalDate reserveDateObj = java.time.LocalDate.parse(reserveDate);
                    boolean isToday = reserveDateObj.equals(today);
                    int currentHour = java.time.LocalTime.now().getHour();
                    
                    // 3. 상태값 설정 (게스트하우스 여부 확인 및 최종 금액 계산)
                    int userNo = (session.getAttribute("userNo") != null) ? (Integer) session.getAttribute("userNo") : 0;
                    boolean isGuesthouse = (facility != null && "게스트하우스".equals(facility.getFacilityName()));
                    
                    int finalPrice = 0;
                    if (facility != null) {
                        // 게스트하우스는 [가격 * 숙박일수], 일반 시설은 [기본 가격] 적용
                        finalPrice = isGuesthouse ? (facility.getFacilityPrice() * Integer.parseInt(stayDays)) : facility.getFacilityPrice();
                    }
                %>
                
                <%-- [UI] 예약 유형(게스트하우스 vs 일반)에 따른 헤더 스타일 변경 --%>
                <div class="card-header <%= isGuesthouse ? "bg-dark" : "bg-primary" %> text-white text-center py-4 border-0">
                    <p class="mb-1 text-uppercase tracking-wider small opacity-75">Reservation Confirmation</p>
                    <h3 class="fw-bold mb-0">예약 정보 재확인</h3>
                </div>

                <div class="card-body p-4">
                    <div class="text-center my-3">
                        <h4 class="fw-bold text-primary">"<%= (facility != null) ? facility.getFacilityName() : "알 수 없는 시설" %>"</h4>
                    </div>

                    <%-- [섹션] 예약 요약 정보 표시 영역 --%>
                    <div class="bg-body-tertiary p-3 rounded-3 mb-4">
    
                        <% if (isGuesthouse) { %>
                            <%-- 게스트하우스 전용 상세 요약 --%>
                            <div class="row py-2 border-bottom border-white">
                                <div class="col-4 text-secondary fw-bold">숙박 기간</div>
                                <div class="col-8 text-dark fw-bold fs-6">
                                    <%= reserveDate %> (체크인) ~ <br>
                                    <span class="badge bg-dark"><%= stayDays %>박 <%= Integer.parseInt(stayDays) + 1 %>일</span>
                                </div>
                            </div>
                        <% } else { %>
                            <%-- 일반 시설 전용 상세 요약 --%>
                            <div class="row py-2 border-bottom border-white">
                                <div class="col-4 text-secondary fw-bold">이용 날짜</div>
                                <div class="col-8 text-dark fw-bold fs-6"><%= reserveDate %></div>
                            </div>
                            <div class="row py-2 border-bottom border-white">
                                <div class="col-4 text-secondary fw-bold">이용 시간</div>
                                <div class="col-8 text-dark fw-bold fs-6" id="timeDisplay">시간을 선택해주세요.</div>
                            </div>
                            <%-- 시간 선택 드롭다운 --%>
                            <div class="row py-2 border-bottom border-white">
                                <div class="col-4 text-secondary fw-bold">시간 선택</div>
                                <div class="col-8">
                                    <select id="startTimeSelect" class="form-select form-select-sm" onchange="updateTimeValues()">
                                    <% 
                                        for(int i = 0; i <= 23; i++) { 
                                        // 오늘 날짜이고, 현재 시간보다 작은(이미 지난) 시간은 옵션에서 제외(continue)
                                        if (isToday && i < currentHour) {
                                            continue; 
                                         }
        
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

                    <%-- [영역] 예약 확정 폼 및 이동 버튼 --%>
                    <div class="row g-2 pt-2">
                        <div class="col-6">
                            <button type="button" class="btn btn-outline-secondary btn-lg w-100" onclick="history.back();">닫기</button>
                        </div>
                        <div class="col-6">
                            <% if (isGuesthouse) { %>
                                <%-- 게스트하우스 전용 폼: 전용 서블릿으로 데이터 전송 --%>
                                <form name="guesthouseForm" action="./processGuesthouse.jsp" method="post" class="m-0">
                                    <input type="hidden" name="facilityNo" value="<%= facility != null ? facility.getFacilityNo() : 0 %>">
                                    <input type="hidden" name="userNo" value="<%= userNo %>">
                                    <input type="hidden" name="reserveDate" value="<%= reserveDate %>">
                                    <input type="hidden" name="stayDays" value="<%= stayDays %>">
                                    <input type="hidden" name="useDate" value="<%= reserveDate %>">
                                    <input type="hidden" name="price" value="<%= facility != null ? facility.getFacilityPrice() * Integer.parseInt(stayDays) : 0 %>">
                                    <button type="button" class="btn btn-dark btn-lg w-100 fw-bold shadow-sm" onclick="confirmReservation('guesthouseForm')">예약확정</button>
                                </form>
                            <% } else { %>
                                <%-- 일반 시설 전용 폼: 일반 예약 서블릿으로 데이터 전송 --%>
                                <form name="facilityForm" action="./processReserve.jsp" method="post" class="m-0">
                                    <input type="hidden" name="facilityNo" value="<%= facility != null ? facility.getFacilityNo() : 0 %>">
                                    <input type="hidden" name="userNo" value="<%= userNo %>">
                                    <input type="hidden" name="reserveDate" value="<%= reserveDate %>">
                                    <input type="hidden" name="useDate" value="<%= reserveDate %>">
                                    <input type="hidden" name="startTime" id="startTime" value="9">
                                    <input type="hidden" name="endTime" id="endTime" value="18">
                                    <input type="hidden" name="price" value="<%= facility != null ? facility.getFacilityPrice() : 0 %>">
                                    <button type="button" class="btn btn-primary btn-lg w-100 fw-bold shadow-sm" onclick="confirmReservation('facilityForm')">예약확정</button>
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