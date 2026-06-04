<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.Date" %>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<title>메인화면</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=82520504bc2544e0b03fb63c86f25417&libraries=services"></script>
</head>
<body class="bg-light">
<div class="container py-4">
    <%@ include file="header.jsp"%>
    
    <%! 
        String greeting = "안녕하세요! 환영합니다.";
        String tagline = "Welcome to Apt Web!";
    %>
    
    <div class="p-5 mb-5 rounded-3 shadow shadow-lg text-center text-white position-relative overflow-hidden" 
         style="background: linear-gradient(rgba(0, 0, 0, 0.55), rgba(0, 0, 0, 0.65)), url('/aptweb/resources/images/apt01.jpg') no-repeat center center; background-size: cover; min-height: 350px;">
        
        <div class="container-fluid py-5 position-relative" style="z-index: 2;">
            <h1 class="display-4 fw-bold mb-3"><%=greeting%></h1>
            <p class="fs-4 mb-4 text-light opacity-90"><%=tagline%></p>
            <p class="lead mb-4 text-white-50 small">우리 아파트 입주민을 위한 스마트한 커뮤니티 공간입니다.</p>
            
            <div class="d-inline-block px-4 py-2 bg-white bg-opacity-10 border border-white border-opacity-25 rounded-pill backdrop-blur mb-4">
                <div class="d-flex align-items-center justify-content-center gap-2 small">
                    <span class="badge bg-danger px-2 py-1 fw-bold rounded-pill animate-pulse">LIVE</span>
                    <span class="fw-medium text-white">
                        <%
                            Date day = new java.util.Date();
                            String am_pm;
                            int hour = day.getHours();
                            int minute = day.getMinutes();
                            int second = day.getSeconds();
                            if (hour / 12 == 0) {
                                am_pm = "AM";
                            } else {
                                am_pm = "PM";
                                hour = hour - 12;
                            }
                            String CT = hour + ":" + minute + ":" + second + " " + am_pm;
                            out.print("현재 접속 시각: " + CT);
                            response.setIntHeader("Refresh", 60);
                        %>
                    </span>
                </div>
            </div>
            
            <div class="d-flex justify-content-center gap-2 mt-2">
                <a href="./facilitys.jsp" class="btn btn-warning btn-lg px-4 py-2.5 fw-bold text-dark shadow">
                    시설 예약하러 가기 &raquo;
                </a>
            </div>
        </div>     
    </div>
<div class="card shadow-sm border-0 mb-5">
    <div class="card-body">
        <h4 class="card-title fw-bold mb-3 text-primary">
            <i class="bi bi-geo-alt-fill"></i> 전국 크로바아파트
        </h4>
        <div id="map" style="width:100%; height:400px; border-radius:10px;"></div>
    </div>
</div>
<script>
// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(36.352479, 127.393000), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places(); 

// 키워드로 장소를 검색합니다
ps.keywordSearch('크로바아파트', placesSearchCB); 

// 키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB (data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        var bounds = new kakao.maps.LatLngBounds();

        for (var i=0; i<data.length; i++) {
            displayMarker(data[i]);    
            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
        }       

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    } 
}

// 지도에 마커를 표시하는 함수입니다
function displayMarker(place) {
    
    // 마커를 생성하고 지도에 표시합니다
    var marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng(place.y, place.x) 
    });

    // 마커에 클릭이벤트를 등록합니다
    kakao.maps.event.addListener(marker, 'click', function() {
        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
        infowindow.open(map, marker);
    });
}
</script>

    <%@ include file="footer.jsp"%>
</div>
</body>
</html>