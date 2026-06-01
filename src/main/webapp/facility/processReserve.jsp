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
    int maxPeople = (facility != null) ? facility.getPeopleInStock() : 0; 

    // 1. 예약 가능 여부 확인
    int currentReservedCount = 0;
    ArrayList<ReserveDTO> allReserves = reserveDAO.getAllReserves();
    
    if (allReserves != null) {
        for (ReserveDTO r : allReserves) {
            if (r.getFacilityNo() == facilityNo && r.getReserveDate().equals(reserveDate)) {
                currentReservedCount++; 
            }
        }
    }

    // 2. 정원 초과 시 예약 차단
    if (currentReservedCount >= maxPeople) {
%>
        <script type="text/javascript">
            alert("죄송합니다. 해당 날짜는 이미 정원(<%= maxPeople %>명)이 초과되어 예약이 불가능합니다.");
            history.back();
        </script>
<%
        return; 
    }

    // 3. 예약 정보 저장
    ReserveDTO newReserve = new ReserveDTO();
    newReserve.setFacilityNo(facilityNo);
    newReserve.setUserNo(userNo);
    newReserve.setReserveDate(reserveDate);
    newReserve.setUseDate(request.getParameter("useDate")); // 이용일
    newReserve.setStartTime(Integer.parseInt(request.getParameter("startTime"))); // 시작시간
    newReserve.setEndTime(Integer.parseInt(request.getParameter("endTime"))); // 종료시간
    newReserve.setPrice(Integer.parseInt(request.getParameter("price"))); // 가격
    newReserve.setStatus("ACTIVE"); // 기본 상태값 설정

    reserveDAO.addReserve(newReserve);
    // 예약확정 성공 이후 , DB에 저장하면서 해당 시설의 quantity를 1 증가시킴
    facilityDAO.increaseQuantity(facilityNo);

    response.sendRedirect("mypage01.jsp");
%>