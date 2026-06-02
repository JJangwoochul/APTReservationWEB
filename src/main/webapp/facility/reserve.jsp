<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.FacilityDTO" %>
<%@ page import="dao.FacilityDAO" %>

<%
    // 1. 세션 기반 로그인 상태 검증: 로그인하지 않은 사용자는 로그인 페이지로 리다이렉트
    Integer userNo = (Integer) session.getAttribute("userNo");
    if (userNo == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    // 2. 인코딩 설정 및 파라미터 처리
    request.setCharacterEncoding("utf-8");
    String fno = request.getParameter("no");
    int no = 0;

    if (fno != null && !fno.isEmpty()) {
        no = Integer.parseInt(fno);
    }

    // 3. 시설 정보 조회 및 유효성 검사: 존재하지 않는 시설 번호일 경우 예외 페이지로 이동
    FacilityDAO dao = FacilityDAO.getInstance();
    FacilityDTO facility = dao.getFacilityByNo(no);
    
    if (facility == null) {
        response.sendRedirect("exceptionNoFacilityName.jsp");
        return;
    }

    // 4. 예약 날짜 설정: 파라미터가 없으면 오늘 날짜를 기본값으로 지정
    String reserveDate = request.getParameter("reserveDate");
    if (reserveDate == null || reserveDate.trim().equals("")) {
        reserveDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
    }

    // 5. 상세 예약 페이지로 데이터 전달 및 화면 이동
    response.sendRedirect("reserveDetail.jsp?facilityNo=" + facility.getFacilityNo() + "&reserveDate=" + reserveDate);
%>