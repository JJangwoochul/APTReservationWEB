<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.ReserveDTO, dao.ReserveDAO" %>
<%@ page import="dto.FacilityDTO, dao.FacilityDAO" %>
<%@ page import="java.util.ArrayList" %>
<%
    request.setCharacterEncoding("utf-8");

    // 1. 파라미터 수신: 예약 정보(시설, 사용자, 날짜, 숙박일, 가격) 추출
    String facilityNoParam = request.getParameter("facilityNo");
    String userNoParam = request.getParameter("userNo");
    String reserveDate = request.getParameter("reserveDate"); // 예약 신청일
    String useDate = request.getParameter("useDate");         // 체크인 날짜
    String stayDays = request.getParameter("stayDays");       // 숙박 기간
    String price = request.getParameter("price");

    int facilityNo = (facilityNoParam != null && !facilityNoParam.isEmpty()) ? Integer.parseInt(facilityNoParam) : 0;
    int userNo = (userNoParam != null && !userNoParam.isEmpty()) ? Integer.parseInt(userNoParam) : 0;

    ReserveDAO reserveDAO = ReserveDAO.getInstance();
    FacilityDAO facilityDAO = FacilityDAO.getInstance();

    // 2. 예약 정원 확인을 위한 데이터 조회
    FacilityDTO facility = facilityDAO.getFacilityByNo(facilityNo);
    int maxPeople = (facility != null) ? facility.getPeopleInStock() : 0; 

    // 3. [비즈니스 로직] 예약 가능 여부 검증: 동일 시설, 동일 날짜의 예약 건수 합산
    int currentReservedCount = 0;
    ArrayList<ReserveDTO> allReserves = reserveDAO.getAllReserves();
    
    if (allReserves != null) {
        for (ReserveDTO r : allReserves) {
            // 시설번호와 예약 날짜가 일치하는 건수 체크
            if (r.getFacilityNo() == facilityNo && r.getReserveDate().equals(reserveDate)) {
                currentReservedCount++; 
            }
        }
    }

    // 정원 초과 시 예약 차단 및 이전 페이지로 리다이렉트
    if (currentReservedCount >= maxPeople) {
%>
        <script type="text/javascript">
            alert("죄송합니다. 해당 날짜는 이미 정원(<%= maxPeople %>명)이 초과되어 예약이 불가능합니다.");
            history.back();
        </script>
<%
        return; 
    }

    // 4. 예약 데이터 모델 생성 및 저장
    ReserveDTO newReserve = new ReserveDTO();
    newReserve.setFacilityNo(facilityNo);
    newReserve.setUserNo(userNo);
    newReserve.setReserveDate(reserveDate); // 예약 신청일
    newReserve.setUseDate(useDate);         // 실제 사용 시작일
    newReserve.setStartTime(9);             // [게스트하우스 고정 시간] 시작 09:00
    newReserve.setEndTime(18);              // [게스트하우스 고정 시간] 종료 18:00
    newReserve.setPrice(Integer.parseInt(price != null ? price : "0"));
    newReserve.setStatus("ACTIVE");         // 신규 예약 상태는 활성화(ACTIVE)

    // DB에 예약 건 추가
    reserveDAO.addReserve(newReserve);

    // 5. 데이터 동기화: 시설 예약 수량(quantity) 1 증가
    facilityDAO.increaseQuantity(facilityNo);

    response.sendRedirect("mypage01.jsp");
%>