<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.FacilityDTO" %>
<%@ page import="dao.FacilityDAO" %>
<%@ page errorPage="exceptionNoFacilityName.jsp" %>
<%
    String noParam = request.getParameter("no");
    int no = (noParam != null && !noParam.isEmpty()) ? Integer.parseInt(noParam) : 0;

    FacilityDAO dao = FacilityDAO.getInstance();
    FacilityDTO facility = dao.getFacilityByNo(no); 
    
    if (facility == null) {
        response.sendRedirect("facilitys.jsp");
        return;
    }
%>
<%
    // 세션에서 로그인 정보를 가져옵니다.
    Integer userNo = (Integer) session.getAttribute("userNo");

    // 로그인 정보가 없으면 로그인 페이지로 보냅니다.
    if (userNo == null) {
        response.sendRedirect("./login.jsp"); // 로그인 페이지 경로
        return; // 아래 코드가 실행되지 않도록 여기서 중단합니다.
    }
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<title>게스트하우스 예약하기</title>
<script type="text/javascript">
    function reserve() {
        var form = document.reserveForm;
        if (form.reserveDate.value == "") {
            alert("체크인 날짜를 선택해주세요.");
            form.reserveDate.focus();
            return;
        }
        if (confirm("이 시설을 예약 하시겠습니까?")) {
            form.submit();
        }
    }
</script>
</head>
<body class="bg-light">
<div class="container py-4">
    <%@ include file="header.jsp"%>

    <div class="p-5 mb-5 bg-body-tertiary rounded-3 shadow-sm text-center">
        <h1 class="display-5 fw-bold text-dark">게스트하우스 예약</h1>
        <p class="lead">Guesthouse Reservation</p>
    </div>

    <div class="row justify-content-center my-4">
        <div class="col-lg-10">
            <div class="card shadow-sm border-0 overflow-hidden rounded-3">
                <div class="row g-0 align-items-stretch">
                    <div class="col-md-5 bg-dark d-flex align-items-center justify-content-center" style="min-height: 400px;">
                        <img src="/aptweb/resources/images/<%=facility.getFileName() %>" 
                             class="img-fluid" style="height: 100%; width: 100%; object-fit: cover;" alt="<%=facility.getFacilityName()%>" />
                    </div>
                    
                    <div class="col-md-7 d-flex align-items-center">
                        <div class="card-body p-5 text-start w-100">
                            <h2 class="fw-bold text-primary mb-3"><%=facility.getFacilityName()%></h2>
                            <p class="text-muted mb-4 lead" style="white-space: pre-wrap;"><%=facility.getDescription()%></p>
                            
                            <hr class="my-4">
                            
                            <form name="reserveForm" action="reserveDetail.jsp" method="post">
                                <input type="hidden" name="facilityNo" value="<%= facility.getFacilityNo() %>">
                                
                                <div class="mb-3">
                                    <label class="form-label fw-bold text-secondary">체크인 날짜</label>
                                    <input type="date" name="reserveDate" class="form-control form-control-lg" required>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label fw-bold text-secondary">숙박 기간</label>
                                    <select name="stayDays" class="form-select form-select-lg">
                                        <option value="1">1박 2일</option>
                                        <option value="2">2박 3일</option>
                                        <option value="3">3박 4일</option>
                                        <option value="4">4박 5일</option>
                                    </select>
                                </div>

                                <div class="d-grid gap-2">
                                    <button type="button" class="btn btn-outline-primary px-3 py-2" onclick="reserve()">
                                        예약하기 &raquo;
                                    </button>
                                    <a href="./facilitys.jsp" class="btn btn-outline-secondary px-3 py-2">
                                        &laquo; 시설 목록 돌아가기
                                    </a>
                                </div>
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