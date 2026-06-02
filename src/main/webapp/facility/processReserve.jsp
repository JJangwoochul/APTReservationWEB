<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.ReserveDTO, dao.ReserveDAO, dto.FacilityDTO, dao.FacilityDAO, java.util.*" %>

<%
    request.setCharacterEncoding("utf-8");

    // 1. 파라미터 수신 및 세션 데이터 확인
    String facilityNoParam = request.getParameter("facilityNo");
    Integer userNo = (Integer) session.getAttribute("userNo"); 
    String reserveDate = request.getParameter("reserveDate");
    String useDate = request.getParameter("useDate");
    String startTimeParam = request.getParameter("startTime");
    String endTimeParam = request.getParameter("endTime");
    String priceParam = request.getParameter("price");

    // 2. [보안] 로그인 상태 검증: 비로그인 사용자의 예약 시도 차단
    if (userNo == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='../login/login.jsp';</script>");
        return;
    }

    // 3. 데이터 형변환: 연산 및 DB 처리를 위한 숫자형 변환
    int facilityNo = (facilityNoParam != null && !facilityNoParam.isEmpty()) ? Integer.parseInt(facilityNoParam) : 0;
    int startTime = Integer.parseInt(startTimeParam);
    int endTime = Integer.parseInt(endTimeParam);
    int price = Integer.parseInt(priceParam);

    ReserveDAO reserveDAO = ReserveDAO.getInstance();
    FacilityDAO facilityDAO = FacilityDAO.getInstance();
    FacilityDTO facility = facilityDAO.getFacilityByNo(facilityNo);

    // 4. [비즈니스 로직] 예약 정원 체크: 시간대별 예약 인원이 정원을 초과했는지 확인
    int currentReservedCount = reserveDAO.getReservedCount(facilityNo, useDate, startTime);
    
    if (currentReservedCount >= facility.getPeopleInStock()) {
%>
        <script type="text/javascript">
            alert("죄송합니다. 선택하신 시간대(<%= startTime %>~<%= endTime %>시)는 정원이 초과되었습니다.");
            history.back();
        </script>
<%
        return; 
    }

    // 5. [상태 관리] 시스템 시간 기반 예약 상태 자동 판별
    // 현재 시간과 이용 종료 시간을 비교하여 예약 상태(ACTIVE/COMPLETED) 결정
    Calendar cal = Calendar.getInstance();
    int currentHour = cal.get(Calendar.HOUR_OF_DAY); 
    String status = "ACTIVE"; 

    if (endTime <= currentHour) {
        status = "COMPLETED";
    }

    // 6. 예약 객체 생성 및 DB 저장
    ReserveDTO newReserve = new ReserveDTO();
    newReserve.setFacilityNo(facilityNo);
    newReserve.setUserNo(userNo);
    newReserve.setReserveDate(reserveDate);
    newReserve.setUseDate(useDate);
    newReserve.setStartTime(startTime);
    newReserve.setEndTime(endTime);
    newReserve.setPrice(price);
    newReserve.setStatus(status);

    reserveDAO.addReserve(newReserve);
    
    // 7. 데이터 동기화: 예약 생성 완료 후 해당 시설 이용 수량 증가
    facilityDAO.increaseQuantity(facilityNo);

    response.sendRedirect("mypage01.jsp");
%>