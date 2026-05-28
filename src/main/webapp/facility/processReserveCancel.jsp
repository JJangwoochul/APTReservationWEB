<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.ReserveDTO" %>
<%@ page import="dao.ReserveDAO" %>
<%@ page import="dto.FacilityDTO" %>
<%@ page import="dao.FacilityDAO" %>

<%
    request.setCharacterEncoding("utf-8");

    String fno = request.getParameter("no");
    int no = 0;

    if (fno != null && !fno.isEmpty()) {
        no = Integer.parseInt(fno);
    }

    ReserveDAO reserveDAO = ReserveDAO.getInstance();
    ArrayList<ReserveDTO> allReserves = reserveDAO.getAllReserves();
    FacilityDAO facilityDAO = FacilityDAO.getInstance();
    
    FacilityDTO facility = facilityDAO.getFacilityDTOByNo(no);

    if (allReserves != null && facility != null) {
        for (int i = allReserves.size() - 1; i >= 0; i--) {
            ReserveDTO reserve = allReserves.get(i);
            if (reserve.getFacilityNo() == facility.getFacilityNo()) {
                allReserves.remove(i);
                break; 
            }
        }
    }

    response.sendRedirect("cancelCheck.jsp");
%>