<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.FacilityDTO" %>
<%@ page import="dao.FacilityDAO" %>
<%@ page errorPage="exceptionNoFacilityName.jsp" %>
<%
    // 세션에서 로그인 정보를 가져옵니다.
    Integer userNo = (Integer) session.getAttribute("userNo");

    // 로그인 정보가 없으면 로그인 페이지로 보냅니다.
    if (session.getAttribute("sessionId") == null) {
        response.sendRedirect(request.getContextPath() + "/facility/login.jsp");
        return;
    }
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<title>시설 예약하기</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=82520504bc2544e0b03fb63c86f25417&libraries=services"></script>
<script type="text/javascript">
    function reserve(facilityNo) {
        if (confirm("이 시설을 예약 하시겠습니까?")) {
            // URL 파라미터로 no를 넘겨서 페이지 이동
            location.href = "./reserve.jsp?no=" + facilityNo;
        }
    }
</script>
</head>
<body class="bg-light">
<div class="container py-4">
    <%@ include file="header.jsp"%>

    <div class="p-5 mb-5 bg-body-tertiary rounded-3 shadow-sm text-center">
        <h1 class="display-5 fw-bold text-dark">시설 예약하기</h1>
        <p class="lead">Facility Reservation</p>
    </div>

    <%
        request.setCharacterEncoding("utf-8");
        String fno = request.getParameter("no");
        int no = (fno != null && !fno.isEmpty()) ? Integer.parseInt(fno) : 0;

        FacilityDAO dao = FacilityDAO.getInstance();
        FacilityDTO facility = dao.getFacilityByNo(no);
    %>

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
                            <span class="badge bg-secondary mb-2">고유번호: <%=facility.getFacilityNo()%></span>
                            <h2 class="fw-bold text-primary mb-3"><%=facility.getFacilityName()%></h2>
                            <p class="text-muted mb-4 lead" style="white-space: pre-wrap;"><%=facility.getDescription()%></p>
                            
                            <hr class="my-4">
                            
                            <div class="mb-4">
                                <div class="row py-2 border-bottom align-items-center">
                                    <div class="col-sm-4 fw-bold text-secondary"> 이용 금액</div>
                                    <div class="col-sm-8 fs-5 text-dark fw-bold"><%=facility.getFacilityPrice()%> 원</div>
                                </div>
                                <div class="row py-2 border-bottom align-items-center">
                                    <div class="col-sm-4 fw-bold text-secondary"> 시설 상태</div>
                                    <div class="col-sm-8"><span class="badge bg-success px-3 py-2"><%=facility.getCondition()%></span></div>
                                </div>
                                <div class="row py-2 align-items-center">
                                    <div class="col-sm-4 fw-bold text-secondary"> 수용 인원</div>
                                    <div class="col-sm-8"><%=facility.getPeopleInStock()%> 명</div>
                                </div>
                            </div>
                            
                            <div class="d-grid gap-2">
                                <button type="button" class="btn btn-outline-primary px-3 py-2" onclick="reserve(<%=facility.getFacilityNo()%>)">
                                    예약하기 &raquo;
                                </button>
                                <a href="./facilitys.jsp" class="btn btn-outline-secondary px-3 py-2" role="button">
                                    &laquo; 시설 목록 돌아가기
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div> 
<div class="card shadow-sm border-0 mb-5">
    <div class="card-body">
        <h4 class="card-title fw-bold mb-3 text-primary">
            <i class="bi bi-geo-alt-fill"></i> 대전 크로바아파트
        </h4>
        <div id="map" style="width:100%; height:400px; border-radius:10px;"></div>
    </div>
</div>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(36.352479, 127.393000), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addressSearch('대전광역시 서구 둔산1동 1509', function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">시설위치</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});    
</script>
    <%@ include file="footer.jsp"%>
</div>
</body>
</html>