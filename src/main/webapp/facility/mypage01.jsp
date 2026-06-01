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

    // 날짜 표시용
    LocalDate now = LocalDate.now();
    LocalDate oneMonthAgo = now.minusMonths(1);
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
        <% if (activeList.isEmpty()) { %>
            <div class="card p-4 text-center border-0 shadow-sm">진행 중인 예약이 없습니다.</div>
        <% } else { 
             for (ReserveDTO dto : activeList) { 
             FacilityDTO fDto = facilityDAO.getFacilityByNo(dto.getFacilityNo());
             String name = (fDto != null) ? fDto.getFacilityName() : "알 수 없는 시설";
        %>
            <div class="card p-4 mb-3 border-0 shadow-sm rounded-3">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h5 class="fw-bold mb-1"><%= name %></h5>
                        <p class="text-secondary small mb-0">예약일 : <%= dto.getReserveDate() %></p>
                        <p class="text-secondary small">금액 : <%= String.format("%,d", dto.getPrice()) %>원</p>
                    </div>
                    <div class="col-md-4 text-md-end d-grid gap-2 d-md-block">
                        <a href="reserveCancel.jsp?reserveNo=<%= dto.getReserveNo() %>" class="btn btn-outline-danger btn-sm px-3">예약취소</a>
                        <a href="./mypage01_detail.jsp?no=<%= dto.getReserveNo() %>" class="btn btn-outline-primary btn-sm px-3">상세보기</a>
                    </div>
                </div>
            </div>
        <% } } %>
    </div>

    <%-- 2. 이용내역 탭 --%>
    <div id="history" class="tab-content" style="display: none;">
        <div class="alert alert-light border shadow-sm mb-4 small text-secondary">
            <strong>최근 1개월 이용내역:</strong> <%= oneMonthAgo %> ~ <%= now %>
        </div>
        
        <% if (historyList.isEmpty()) { %>
            <div class="card p-4 text-center border-0 shadow-sm">최근 1개월간 이용 내역이 없습니다.</div>
        <% } else { 
             for (ReserveDTO dto : historyList) { 
             FacilityDTO fDto = facilityDAO.getFacilityByNo(dto.getFacilityNo());
             String name = (fDto != null) ? fDto.getFacilityName() : "알 수 없는 시설";
        %>
            <div class="card p-4 mb-3 border-0 shadow-sm rounded-3">
                <h5 class="fw-bold mb-1"><%= name %> <span class="badge bg-light text-dark border"><%= dto.getStatus() %></span></h5>
                <p class="text-secondary small mb-0">이용일 : <%= dto.getUseDate() %></p>
            </div>
        <% } } %>
    </div>
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