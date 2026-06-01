<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*" %>
<%@ page import="dto.ReserveDTO, dao.ReserveDAO" %>
<%@ page import="dto.FacilityDTO, dao.FacilityDAO" %>
<%
    // (1) 싱글톤 패턴으로 DAO 객체 가져오기
    ReserveDAO dao = ReserveDAO.getInstance();
    FacilityDAO facilityDAO = FacilityDAO.getInstance(); // 시설정보조회 인스턴스
    
    // (2) 로그인 세션에서 유저 번호 가져오기 (예시: 세션에 userNo가 저장되어 있다고 가정)
    // 실제 프로젝트 환경에 맞게 세션 키를 확인하세요.
    Integer userNo = (Integer) session.getAttribute("userNo");
    
    // 로그인이 안 되어 있을 경우 예외 처리
    if (userNo == null) {
        response.sendRedirect("../member/login.jsp");
        return;
    }
   // (3) 상태별로 리스트 분리하여 조회
    ArrayList<ReserveDTO> activeList = dao.getActiveReservesByUser(userNo); // 진행 중인 예약
    ArrayList<ReserveDTO> historyList = dao.getHistoryReservesByUser(userNo); // 과거/취소 내역
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<title>마이페이지</title>
<style>
    body {
        background-color: #f5f6f8;
    }

    .mypage-container {
        width: 1200px;
        margin: 50px auto;
    }

    .title {
        font-size: 30px;
        font-weight: bold;
        margin-bottom: 30px;
    }

    .tab-box {
        display: flex;
        gap: 10px;
        margin-bottom: 20px;
    }

    .tab-btn {
        padding: 10px 25px;
        border-radius: 10px;
        border: none;
        background: #e9ecef;
        font-weight: bold;
        cursor: pointer;
    }

    .tab-btn.active {
        background: #212529;
        color: white;
    }

    .tab-content {
        display: none;
    }

    .tab-content.active {
        display: block;
    }

    .card-box {
        background: white;
        border-radius: 15px;
        padding: 20px;
        margin-bottom: 20px;
        transition: 0.3s;
    }

    .card-box:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
    }

    .img-box {
        width: 120px;
        height: 120px;
        background: #ddd;
        border-radius: 12px;
    }

    .facility-name {
        font-size: 22px;
        font-weight: bold;
    }

    .info {
        color: #666;
        line-height: 1.8;
    }

    .btn-dark-custom {
        background: #212529;
        color: white;
        width: 120px;
        margin-bottom: 8px;
    }

    .total-box {
        text-align: right;
        font-size: 24px;
        font-weight: bold;
        margin-top: 30px;
    }
</style>
</head>
<body>
<%@ include file="header.jsp" %>

<div class="mypage-container">
    <div class="title">마이페이지</div>
    
    <div class="tab-box">
        <button class="tab-btn active" onclick="openTab(event, 'reservation')">예약내역</button>
        <button class="tab-btn" onclick="openTab(event, 'history')">이용내역</button>
    </div>

    <%-- 1. 예약내역(Active) 탭 --%>
    <div id="reservation" class="tab-content active">
        <% if (activeList.isEmpty()) { %>
            <div class="card-box text-center">진행 중인 예약이 없습니다.</div>
        <% } else { 
             for (ReserveDTO dto : activeList) { 
             FacilityDTO fDto = facilityDAO.getFacilityByNo(dto.getFacilityNo());
             String facilityName = (fDto != null) ? fDto.getFacilityName() : "알 수 없는 시설";
        %>
            <div class="card-box">
                <div class="row align-items-center">
                    <div class="col-md-7">
                        <div class="facility-name"><%= facilityName %></div>
                        <div class="info">예약일 : <%= dto.getReserveDate() %> <br> 금액 : <%= String.format("%,d", dto.getPrice()) %>원</div>
                    </div>
                    <div class="col-md-3 text-end">
                        <button class="btn btn-dark-custom" onclick="location.href='reserveCancel.jsp?reserveNo=<%= dto.getReserveNo() %>'">예약취소</button>
                    </div>
                </div>
            </div>
        <% } } %>
    </div>

    <%-- 2. 이용내역(History) 탭 --%>
    <div id="history" class="tab-content">
        <% if (historyList.isEmpty()) { %>
            <div class="card-box text-center">이용 내역이 없습니다.</div>
        <% } else { 
             for (ReserveDTO dto : historyList) { 
                 FacilityDTO fDto = facilityDAO.getFacilityByNo(dto.getFacilityNo());
                 String facilityName = (fDto != null) ? fDto.getFacilityName() : "알 수 없는 시설";
        %>
            <div class="card-box">
                <div class="row align-items-center">
                    <div class="col-md-7">
                        <div class="facility-name"><%= facilityName %> (<%= dto.getStatus() %>)</div>
                        <div class="info">이용일 : <%= dto.getReserveDate() %></div>
                    </div>
                </div>
            </div>
        <% } } %>
    </div>
</div>

<script>
function openTab(evt, tabId) {
    document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
    document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
    document.getElementById(tabId).classList.add('active');
    evt.currentTarget.classList.add('active');
}
</script>

<%@ include file="footer.jsp" %>
</body>
</html>