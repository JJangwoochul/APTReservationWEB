<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.FacilityDTO" %>
<%@ page import="dao.FacilityDAO" %>

<%
    // 로그인 체크 로직
    Integer userNo = (Integer) session.getAttribute("userNo");
    if (userNo == null) {
        response.sendRedirect("./login.jsp");
        return;
    }
    request.setCharacterEncoding("utf-8");
    
    String fno = request.getParameter("no");
    int no = 0;

    if (fno != null && !fno.isEmpty()) {
        no = Integer.parseInt(fno);
    }

    FacilityDAO dao = FacilityDAO.getInstance();
    FacilityDTO facility = dao.getFacilityByNo(no);
    
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