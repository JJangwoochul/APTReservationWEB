<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.ReserveDTO" %>
<%@ page import="dao.ReserveDAO" %>
<%@ page import="dto.FacilityDTO" %>
<%@ page import="dao.FacilityDAO" %>
<%@ page import="java.util.ArrayList" %>

<%
    request.setCharacterEncoding("utf-8");

    String facilityNoParam = request.getParameter("facilityNo");
    Integer userNo = (Integer) session.getAttribute("userNo"); 
    String reserveDate = request.getParameter("reserveDate");
    String useDate = request.getParameter("useDate");
    String startTimeParam = request.getParameter("startTime");
    String endTimeParam = request.getParameter("endTime");
    String priceParam = request.getParameter("price");

    if (userNo == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='../login/login.jsp';</script>");
        return;
    }

    int facilityNo = (facilityNoParam != null && !facilityNoParam.isEmpty()) ? Integer.parseInt(facilityNoParam) : 0;

    ReserveDAO reserveDAO = ReserveDAO.getInstance();
    FacilityDAO facilityDAO = FacilityDAO.getInstance();
    FacilityDTO facility = facilityDAO.getFacilityByNo(facilityNo);

    // (3) 정원 체크 로직 (성능을 위해 DAO에서 카운트 조회)
    int currentReservedCount = reserveDAO.getReservedCount(facilityNo, useDate);
    if (currentReservedCount >= facility.getPeopleInStock()) {
%>
        <script type="text/javascript">
            alert("죄송합니다. 해당 날짜는 정원이 초과되었습니다.");
            history.back();
        </script>
<%
        return; 
    }

    // (4) 예약 상태 자동 판별 로직 (현재 시간 기준)
    Calendar cal = Calendar.getInstance();
    int currentHour = cal.get(Calendar.HOUR_OF_DAY); // 서버의 현재 시(0~23)
    int endTime = Integer.parseInt(endTimeParam);
    
    String status = "ACTIVE"; // 기본값

    // 이용 종료 시간이 현재 시간보다 작거나 같으면 '이용 완료' 상태로 저장
    if (endTime <= currentHour) {
        status = "COMPLETED";
    }

    // 예약 정보 저장
    // (5) 예약 정보 저장 DTO 구성
    ReserveDTO newReserve = new ReserveDTO();
    newReserve.setFacilityNo(facilityNo);
    newReserve.setUserNo(userNo);
    newReserve.setReserveDate(reserveDate);
    newReserve.setUseDate(useDate);
    newReserve.setStartTime(Integer.parseInt(startTimeParam));
    newReserve.setEndTime(endTime);
    newReserve.setPrice(Integer.parseInt(priceParam));
    newReserve.setStatus(status); // 기본 상태값 설정

    reserveDAO.addReserve(newReserve);
    // 예약확정 성공 이후 , DB에 저장하면서 해당 시설의 quantity를 1 증가시킴
    facilityDAO.increaseQuantity(facilityNo);

    response.sendRedirect("mypage01.jsp");
%>