<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.ReserveDTO, dao.ReserveDAO" %>
<%@ page import="dto.FacilityDTO, dao.FacilityDAO" %>
<%@ page import="java.util.ArrayList" %>
<%
    request.setCharacterEncoding("utf-8");

    String facilityNoParam = request.getParameter("facilityNo");
    String userNoParam = request.getParameter("userNo");
    String reserveDate = request.getParameter("reserveDate"); //예약신청날
    String useDate = request.getParameter("useDate"); // 예약신청한 날에  선택했던 체크인 날
    String stayDays = request.getParameter("stayDays"); // 예약신청할때 머무르는 날 ( ex)1박 ,2박 )
    String price = request.getParameter("price"); // 가격

    int facilityNo = (facilityNoParam != null && !facilityNoParam.isEmpty()) ? Integer.parseInt(facilityNoParam) : 0;
    int userNo = (userNoParam != null && !userNoParam.isEmpty()) ? Integer.parseInt(userNoParam) : 0;

    ReserveDAO reserveDAO = ReserveDAO.getInstance();
    FacilityDAO facilityDAO = FacilityDAO.getInstance();

    FacilityDTO facility = facilityDAO.getFacilityByNo(facilityNo);
    int maxPeople = (facility != null) ? facility.getPeopleInStock() : 0; 

    int currentReservedCount = 0;
    ArrayList<ReserveDTO> allReserves = reserveDAO.getAllReserves();
    
    if (allReserves != null) {
        for (ReserveDTO r : allReserves) {
            if (r.getFacilityNo() == facilityNo && r.getReserveDate().equals(reserveDate)) {
                currentReservedCount++; 
            }
        }
    }

    if (currentReservedCount >= maxPeople) {
%>
        <script type="text/javascript">
            alert("죄송합니다. 해당 날짜는 이미 정원(<%= maxPeople %>명)이 초과되어 예약이 불가능합니다.");
            history.back();
        </script>
<%
        return; 
    }

    ReserveDTO newReserve = new ReserveDTO();
    newReserve.setFacilityNo(facilityNo);
    newReserve.setUserNo(userNo);
    newReserve.setReserveDate(reserveDate); //예약 신청날
    newReserve.setUseDate(useDate);    //사용 날
    newReserve.setStartTime(9);      // 기본 시작 시간 (예시)
    newReserve.setEndTime(18);       // 기본 종료 시간 (예시)
    newReserve.setPrice(Integer.parseInt(price != null ? price : "0"));
    newReserve.setStatus("ACTIVE");

    reserveDAO.addReserve(newReserve);
    // 게스트하우스 예약 성공 시 DB로 데이터가 넘어가면서 게스트하우스 시설의 quantity를 1증가
    facilityDAO.increaseQuantity(facilityNo);

    response.sendRedirect("mypage01.jsp");
%>