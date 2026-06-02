<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.ReserveDTO" %>
<%@ page import="dao.ReserveDAO" %>
<%@ page import="dto.FacilityDTO" %>
<%@ page import="dao.FacilityDAO" %>
<%@ page import="java.util.*" %>

<%
    request.setCharacterEncoding("utf-8");

    // 1. 파라미터 수신
    String facilityNoParam = request.getParameter("facilityNo");
    Integer userNo = (Integer) session.getAttribute("userNo"); 
    String reserveDate = request.getParameter("reserveDate");
    String useDate = request.getParameter("useDate");
    String startTimeParam = request.getParameter("startTime");
    String endTimeParam = request.getParameter("endTime");
    String priceParam = request.getParameter("price");

    // 2. 로그인 체크
    if (userNo == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='../login/login.jsp';</script>");
        return;
    }

    // 3. 데이터 변환 및 초기화
    int facilityNo = (facilityNoParam != null && !facilityNoParam.isEmpty()) ? Integer.parseInt(facilityNoParam) : 0;
    int startTime = Integer.parseInt(startTimeParam);
    int endTime = Integer.parseInt(endTimeParam);
    int price = Integer.parseInt(priceParam);

    ReserveDAO reserveDAO = ReserveDAO.getInstance();
    FacilityDAO facilityDAO = FacilityDAO.getInstance();
    FacilityDTO facility = facilityDAO.getFacilityByNo(facilityNo);

    // 4. [수정] 정원 체크 로직 (시간대별로 인원 확인)
    // DAO의 getReservedCount(int, String, int) 메서드를 호출하여 해당 시간대의 예약 건수를 가져옵니다.
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

    // 5. 예약 상태 자동 판별 로직 (현재 시간 기준)
    Calendar cal = Calendar.getInstance();
    int currentHour = cal.get(Calendar.HOUR_OF_DAY); 
    String status = "ACTIVE"; 

    if (endTime <= currentHour) {
        status = "COMPLETED";
    }

    // 6. 예약 정보 저장
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
    
    // 시설 예약 수량 증가 (필요한 경우만 유지)
    facilityDAO.increaseQuantity(facilityNo);

    response.sendRedirect("mypage01.jsp");
%>