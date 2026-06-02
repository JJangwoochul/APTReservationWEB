<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.*, dao.*" %>
<%
    // 1. 파라미터로 예약 번호(no)를 받아옴
    String reserveNoParam = request.getParameter("no");
    int reserveNo = (reserveNoParam != null && !reserveNoParam.isEmpty()) ? Integer.parseInt(reserveNoParam) : 0;
    
    // 2. DAO 객체 생성 및 데이터 조회
    ReserveDAO reserveDAO = ReserveDAO.getInstance();
    ReserveDTO reserveDTO = reserveDAO.getReserveByNo(reserveNo);
    
    FacilityDAO facilityDAO = FacilityDAO.getInstance();
    FacilityDTO facilityDTO = facilityDAO.getFacilityByNo(reserveDTO.getFacilityNo());

    boolean isGuesthouse = (facilityDTO != null && "게스트하우스".equals(facilityDTO.getFacilityName()));
%>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>예약 상세 정보</title>
</head>
<body class="bg-light">
<div class="container py-5">
    <%@ include file="header.jsp"%>
    
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card shadow-sm border-0 rounded-4 overflow-hidden">
                <div class="row g-0">
                    <div class="col-md-5 bg-dark d-flex align-items-center">
                        <img src="/aptweb/resources/images/<%= facilityDTO.getFileName() %>" 
                             class="img-fluid" style="width:100%; height:100%; object-fit:cover;" alt="시설 이미지">
                    </div>
                    
                    <div class="col-md-7">
                        <div class="card-body p-5">
                            <h2 class="fw-bold text-primary mb-3"><%= facilityDTO.getFacilityName() %></h2>
                            <p class="text-muted mb-4" style="white-space: pre-wrap;"><%= facilityDTO.getDescription() %></p>
                            <hr class="mb-4">
                            
                            <div class="row mb-3">
                                <div class="col-sm-4 fw-bold text-secondary">예약 일자</div>
                                <div class="col-sm-8"><%= reserveDTO.getReserveDate() %></div>
                            </div>

                            <%-- (3) 조건부 렌더링 , 게스트하우스 표시 --%>
                            <% if (isGuesthouse) { %>
                                <div class="row mb-3">
                                    <div class="col-sm-4 fw-bold text-secondary">체크인 날짜</div>
                                    <div class="col-sm-8"><%= reserveDTO.getUseDate().substring(0,10) %></div>
                                </div>
                            <% } else { %>
                            <%-- 일반시설 표시--%>
                            <div class="row mb-3">
                                <div class="col-sm-4 fw-bold text-secondary">이용 시간</div>
                                <div class="col-sm-8"><%= reserveDTO.getStartTime() %>:00 ~ <%= reserveDTO.getEndTime() %>:00</div>
                            </div>
                            <% } %>
                            <div class="row mb-4">
                                <div class="col-sm-4 fw-bold text-secondary">결제 금액</div>
                                <div class="col-sm-8 fw-bold text-danger fs-5"><%= String.format("%,d", reserveDTO.getPrice()) %> 원</div>
                            </div>
                            
                            <div class="d-flex gap-2">
                                <a href="mypage01.jsp" class="btn btn-secondary px-4">마이페이지</a>
                                <button class="btn btn-warning px-4" onclick="location.href='reserveCancel.jsp?reserveNo=<%= reserveDTO.getReserveNo() %>'">예약취소</button>
                            </div>
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