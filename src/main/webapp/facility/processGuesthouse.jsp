<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.ReserveDTO, dao.ReserveDAO" %>
<%@ page import="dto.FacilityDTO, dao.FacilityDAO" %>
<%@ page import="java.util.ArrayList" %>
<%
    request.setCharacterEncoding("utf-8");

    String facilityNoParam = request.getParameter("facilityNo");
    String userNoParam = request.getParameter("userNo");
    String reserveDate = request.getParameter("reserveDate");

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
    newReserve.setReserveDate(reserveDate);

    reserveDAO.addReserve(newReserve);

    response.sendRedirect("mypage01.jsp");
%>