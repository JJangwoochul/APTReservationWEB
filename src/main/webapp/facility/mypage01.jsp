<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*, java.time.*" %>
<%@ page import="dto.ReserveDTO, dao.ReserveDAO" %>
<%@ page import="dto.FacilityDTO, dao.FacilityDAO" %>
<%
    // (1) 싱글톤 패턴으로 DAO 객체 가져오기
    ReserveDAO dao = ReserveDAO.getInstance();
    FacilityDAO facilityDAO = FacilityDAO.getInstance();
    
    Integer userNo = (Integer) session.getAttribute("userNo");
    
    if (userNo == null) {
        response.sendRedirect("../member/login.jsp");
        return;
    }

    // (2) 상태별 리스트 조회 (이용내역은 최근 1개월 메서드 호출)
    ArrayList<ReserveDTO> activeList = dao.getActiveReservesByUser(userNo);
    ArrayList<ReserveDTO> historyList = dao.getRecentHistoryReservesByUser(userNo);

    // 날짜 표시용: 지난달 기준으로 계산
    LocalDate now = LocalDate.now();
    LocalDate lastMonthDate = now.minusMonths(1); // 현재의 한 달 전 날짜
    LocalDate firstDay = lastMonthDate.withDayOfMonth(1);          // 지난달 1일
    LocalDate lastDay = lastMonthDate.withDayOfMonth(lastMonthDate.lengthOfMonth()); // 지난달 말일
    
    // 화면에 보여줄 '몇 월' 인지 계산
    int targetMonth = lastMonthDate.getMonthValue();
%>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>마이페이지</title>
</head>
<body class="bg-light">
<%@ include file="header.jsp" %>

<div class="container py-5" style="max-width: 1000px;">
    <h2 class="fw-bold mb-4">마이페이지</h2>
    
    <div class="d-flex gap-2 mb-4 border-bottom">
        <button class="btn btn-link text-decoration-none text-dark fw-bold border-bottom border-2 border-dark" 
                onclick="openTab(event, 'reservation')" id="defaultOpen">예약내역</button>
        <button class="btn btn-link text-decoration-none text-muted fw-bold" 
                onclick="openTab(event, 'history')">이용내역</button>
    </div>

    <%-- 1. 예약내역 탭 --%>
    <div id="reservation" class="tab-content">
        <div class="alert alert-info border shadow-sm mb-4 small">
            <strong>현재 진행 중인 예약:</strong> 총 <%= activeList.size() %>건
        </div>
        <% if (activeList.isEmpty()) { %>
            <div class="card p-4 text-center border-0 shadow-sm">진행 중인 예약이 없습니다.</div>
        <% } else { 
             int activeTotal = 0;
             for (ReserveDTO dto : activeList) { 
                 activeTotal += dto.getPrice();
                 FacilityDTO fDto = facilityDAO.getFacilityByNo(dto.getFacilityNo());
                 String name = (fDto != null) ? fDto.getFacilityName() : "알 수 없는 시설";
                 
                 // (2) 실시간 상태 판별 로직
                 boolean isCompleted = "COMPLETED".equals(dto.getStatus()) || (dto.getEndTime() <= currentHour);
        %>
            <div class="card p-4 mb-3 border-0 shadow-sm rounded-3">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h5 class="fw-bold mb-1"><%= name %>
                            <%-- (3) 상태 배지 적용 --%>
                            <span class="badge <%= isCompleted ? "bg-secondary" : "bg-success" %> ms-2">
                                <%= isCompleted ? "이용 완료" : "예약 중" %>
                            </span>
                        </h5>
                        <p class="text-secondary small mb-0">예약일 : <%= dto.getReserveDate().substring(0, 10) %></p>
                        <p class="text-secondary small">금액 : <%= String.format("%,d", dto.getPrice()) %>원 | 시간 : <%= dto.getStartTime() %>:00 ~ <%= dto.getEndTime() %>:00</p>
                    </div>
                    <div class="col-md-4 text-md-end d-grid gap-2 d-md-block">
                        <%-- (4) 완료된 예약은 취소 버튼 숨기기 --%>
                        <% if (!isCompleted) { %>
                            <a href="reserveCancel.jsp?reserveNo=<%= dto.getReserveNo() %>" class="btn btn-outline-danger btn-sm px-3">예약취소</a>
                        <% } %>
                        <a href="./mypage01_detail.jsp?no=<%= dto.getReserveNo() %>" class="btn btn-outline-primary btn-sm px-3">상세보기</a>
                    </div>
                </div>
            </div>
        <% } %>
        <div class="card p-3 mb-3 bg-primary text-white text-end">
            <span class="fs-5">총 예약 금액 : <strong><%= String.format("%,d", activeTotal) %>원</strong></span>
        </div>
        <% } %>
    </div>

    <%-- 2. 이용내역 탭 --%>
<div id="history" class="tab-content" style="display: none;">
    <div class="alert alert-light border shadow-sm mb-4 small text-secondary">
        <strong><%= targetMonth %>월 이용내역:</strong> <%= firstDay %> ~ <%= lastDay %>
    </div>
    
    <% if (historyList.isEmpty()) { %>
        <div class="card p-4 text-center border-0 shadow-sm"><%= targetMonth %>월 이용 내역이 없습니다.</div>
    <% } else { 
         // 총합 계산용 변수 선언
         int total = 0;
            for (ReserveDTO dto : historyList) { 
            FacilityDTO fDto = facilityDAO.getFacilityByNo(dto.getFacilityNo());
            String name = (fDto != null) ? fDto.getFacilityName() : "알 수 없는 시설";
    
        // 상태에 따라 총액 누적 (취소 건은 합계에서 제외)
            if ("COMPLETED".equals(dto.getStatus())) {
            total += dto.getPrice();
            }
    %>
        <div class="card p-4 mb-3 border-0 shadow-sm rounded-3">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="fw-bold mb-1"><%= name %></h5>
                <%-- 상태에 따른 배지 --%>
                <span class="badge <%= "CANCELLED".equals(dto.getStatus()) ? "bg-danger" : "bg-secondary" %>">
                    <%= "CANCELLED".equals(dto.getStatus()) ? "취소됨" : "이용 완료" %>
                </span>
            </div>
            <p class="text-secondary small mb-0">일시 : <%= dto.getReserveDate().substring(0, 10) %></p>
            <p class="text-secondary small mb-0">
                <%= "CANCELLED".equals(dto.getStatus()) ? "취소" : "결제" %> 금액 : 
                <%= String.format("%,d", dto.getPrice()) %>원
            </p>
        </div>
    <% } %>
    
    <div class="card p-3 mb-3 bg-dark text-white text-end">
        <span class="fs-5">총 이용 금액(취소 제외) : <strong><%= String.format("%,d", total) %>원</strong></span>
    </div>
    <% } %>
</div>

<script>
function openTab(evt, tabId) {
    document.querySelectorAll('.tab-content').forEach(c => c.style.display = 'none');
    document.querySelectorAll('.btn-link').forEach(b => {
        b.classList.remove('border-bottom', 'border-2', 'border-dark', 'text-dark');
        b.classList.add('text-muted');
    });
    document.getElementById(tabId).style.display = 'block';
    evt.currentTarget.classList.add('border-bottom', 'border-2', 'border-dark', 'text-dark');
    evt.currentTarget.classList.remove('text-muted');
}
</script>

<%@ include file="footer.jsp" %>
</body>
</html>