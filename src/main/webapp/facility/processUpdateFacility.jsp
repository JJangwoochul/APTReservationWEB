<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="admin_check.jsp" %> <%--관리자만 이용 가능--%>
<%@ page import="dto.FacilityDTO" %>
<%@ page import="dao.FacilityDAO" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 1. 저장 경로 설정
    String realFolder = request.getServletContext().getRealPath("/resources/images");
    File dir = new File(realFolder);
    if (!dir.exists()) { dir.mkdirs(); }

    // 2. 파라미터 수집
    String facilityNo = request.getParameter("facilityNo");
    String facilityName = request.getParameter("facilityName");
    String description = request.getParameter("description");
    String facilityPrice = request.getParameter("facilityPrice");
    String condition = request.getParameter("condition");
    String peopleInStock = request.getParameter("peopleInStock");

    // 3. 숫자형 데이터 변환
    int no = (facilityNo != null) ? Integer.parseInt(facilityNo) : 0;
    int price = (facilityPrice != null && !facilityPrice.isEmpty()) ? Integer.parseInt(facilityPrice) : 0;
    int stock = (peopleInStock != null && !peopleInStock.isEmpty()) ? Integer.parseInt(peopleInStock) : 0;

    // 4. 파일 처리 (기존 파일 유지 or 새 파일 업로드)
    FacilityDAO dao = FacilityDAO.getInstance();
    FacilityDTO oldFacility = dao.getFacilityByNo(no); // 기존 정보를 가져옴
    String fileName = oldFacility.getFileName(); // 기본값은 기존 파일명

    Part part = request.getPart("fileName");
    if (part != null && part.getSubmittedFileName() != null && !part.getSubmittedFileName().isEmpty()) {
        fileName = part.getSubmittedFileName();
        part.write(realFolder + File.separator + fileName); // 새 파일 저장
    }

    // 5. DTO 업데이트
    FacilityDTO dto = new FacilityDTO();
    dto.setFacilityNo(no);
    dto.setFacilityName(facilityName);
    dto.setDescription(description);
    dto.setFacilityPrice(price);
    dto.setCondition(condition);
    dto.setPeopleInStock(stock);
    dto.setFileName(fileName);
    dto.setQuantity(stock);

    // 6. DB 수정(Update) 호출
    try {
        dao.updateFacility(dto); // DAO에 updateFacility 메서드 구현 필요
        response.sendRedirect("admin_facility.jsp");
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<script>alert('수정 실패'); history.back();</script>");
    }
%>