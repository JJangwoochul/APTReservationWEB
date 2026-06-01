<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.FacilityDTO" %>
<%@ page import="dao.FacilityDAO" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 1. 파일 저장 경로 설정
    String realFolder = request.getServletContext().getRealPath("/resources/images");
    File dir = new File(realFolder);
    if (!dir.exists()) {
        dir.mkdirs();
    }

    // 2. 파라미터 수집
    String facilityName = request.getParameter("facilityName");
    String description = request.getParameter("description");
    String facilityPrice = request.getParameter("facilityPrice");
    String condition = request.getParameter("condition");
    String peopleInStock = request.getParameter("peopleInStock");
    

    // 3. 숫자형 데이터 변환
    int price = (facilityPrice != null && !facilityPrice.isEmpty()) ? Integer.parseInt(facilityPrice) : 0;
    int stock = (peopleInStock != null && !peopleInStock.isEmpty()) ? Integer.parseInt(peopleInStock) : 0;
    

    // 4. 파일 업로드 처리
    String fileName = "";
    Part part = request.getPart("fileName");
    if (part != null && part.getSubmittedFileName() != null && !part.getSubmittedFileName().isEmpty()) {
        fileName = part.getSubmittedFileName();
        part.write(realFolder + File.separator + fileName);
    }

    // 5. DTO 객체 생성 및 값 설정
    FacilityDTO dto = new FacilityDTO();
    dto.setFacilityName(facilityName);
    dto.setDescription(description);
    dto.setFacilityPrice(price);
    dto.setCondition(condition);
    dto.setPeopleInStock(stock);
    dto.setFileName(fileName);
    dto.setQuantity(0); 

    // 6. DB 저장 (DAO 호출)
    try {
        FacilityDAO dao = FacilityDAO.getInstance();
        dao.addFacility(dto); // DAO 내부 SQL에서 facility_seq.NEXTVAL이 실행됨
        
        response.sendRedirect("facilitys.jsp");
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>