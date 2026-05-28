<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.FacilityDTO" %>
<%@ page import="dao.FacilityDAO" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="jakarta.servlet.http.*"%>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    String realFolder = request.getServletContext().getRealPath("/resources/images");

    File dir = new File(realFolder);
    if (!dir.exists()) {
        dir.mkdirs();
    }

    String facilityNo=request.getParameter("facilityNo"); 
    String facilityName=request.getParameter("facilityName"); 
    String description=request.getParameter("description"); 
    String facilityPrice=request.getParameter("facilityPrice"); 
    String condition=request.getParameter("condition"); 
    String peopleInStock=request.getParameter("peopleInStock"); 

    int no = (facilityNo != null && !facilityNo.isEmpty()) ? Integer.parseInt(facilityNo) : 0;
    int price = (facilityPrice != null && !facilityPrice.isEmpty()) ? Integer.parseInt(facilityPrice) : 0;
    int stock = (peopleInStock != null && !peopleInStock.isEmpty()) ? Integer.parseInt(peopleInStock) : 0;
    
    String fileName = "";
    Part part = request.getPart("fileName");
    
    if (part != null && part.getSubmittedFileName() != null && !part.getSubmittedFileName().isEmpty()) {
        fileName = part.getSubmittedFileName();
        part.write(realFolder + File.separator + fileName);
    }

    FacilityDAO dao=FacilityDAO.getInstance();
    FacilityDTO newFacilityDTO=new FacilityDTO();
    newFacilityDTO.setFacilityNo(no);
    newFacilityDTO.setFacilityName(facilityName);
    newFacilityDTO.setDescription(description);
    newFacilityDTO.setFacilityPrice(price);
    newFacilityDTO.setCondition(condition);
    newFacilityDTO.setPeopleInStock(stock);
    newFacilityDTO.setFileName(fileName);

    dao.addFacility(newFacilityDTO);

    response.sendRedirect("facilitys.jsp");
%>  
