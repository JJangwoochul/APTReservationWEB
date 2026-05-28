<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.FacilityDTO" %>
<%@ page import="dao.FacilityDAO" %>

<%
    request.setCharacterEncoding("utf-8");
    
    String fno = request.getParameter("no");
    int no = 0;

    if (fno != null && !fno.isEmpty()) {
        no = Integer.parseInt(fno);
    }

    FacilityDAO dao = FacilityDAO.getInstance();
    FacilityDTO facility = dao.getFacilityDTOByNo(no);
    
    if (facility == null) {
        response.sendRedirect("exceptionNoFacilityName.jsp");
        return;
    }

    String reserveDate = request.getParameter("reserveDate");
    if (reserveDate == null || reserveDate.trim().equals("")) {
        reserveDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
    }

    response.sendRedirect("reserveDetail.jsp?facilityNo=" + facility.getFacilityNo() + "&reserveDate=" + reserveDate);
%>