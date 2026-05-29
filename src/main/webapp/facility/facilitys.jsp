<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.FacilityDTO" %>
<%@ page import="dao.FacilityDAO" %>
<%
    // 로그인 상태 유지 확인
    if (session.getAttribute("sessionId") == null) {
        response.sendRedirect(request.getContextPath() + "/facility/login.jsp");
        return;
    }
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<title>시설 목록</title>
</head>
<body class="bg-light">
<div class="container text-center py-4">
    <%@ include file="header.jsp"%>

    <div class="p-5 mb-4 bg-body-tertiary rounded-3 shadow-sm text-center">
        <div class="container-fluid py-3">
            <h1 class="display-5 fw-bold text-dark">시설 목록</h1>
            <p class="lead">Facility List</p>
        </div>     
    </div>
    <%
        FacilityDAO dao=FacilityDAO.getInstance();
        ArrayList<FacilityDTO> listOfFacilityDTOs = dao.getAllFacility();
    %>
    
    <div class="row row-cols-1 row-cols-md-3 g-4 my-3 text-start">
    <%
        if (listOfFacilityDTOs != null) {
            for (int i=0; i<listOfFacilityDTOs.size(); i++) {
                FacilityDTO facility = listOfFacilityDTOs.get(i);
    %>
        <div class="col">
            <div class="card h-100 shadow-sm border-0">
                <div class="card-body p-4 text-center">
                    <img src="/aptweb/resources/images/<%=facility.getFileName() %>" style="width:350px; height:350px;" />
                    <h5 class="fw-bold text-primary mb-3">No.<%=facility.getFacilityNo()%> <%=facility.getFacilityName()%></h5>
                    <hr>
                    <p class="mb-1"><b>이용 금액 :</b> <%=facility.getFacilityPrice()%>원</p>
                    <p class="mb-1"><b>시설 상태 :</b> <%=facility.getCondition()%></p>
                    <p class="mb-0"><b>수용 인원 :</b> <%=facility.getPeopleInStock()%>명</p>
                    <p class="mt-3">
                        <% if ("게스트하우스".equals(facility.getFacilityName())) { %>
                            <a href="./guesthouse.jsp?no=<%=facility.getFacilityNo() %>" class="btn btn-primary" role="button"> 상세 정보 &raquo;</a>
                        <% } else { %>
                            <a href="./facility.jsp?no=<%=facility.getFacilityNo() %>" class="btn btn-primary" role="button"> 상세 정보 &raquo;</a>
                        <% } %>
                    </p>
                </div>
            </div>
        </div>
    <%
            }
        }
    %>
    </div>    
    <%@ include file="footer.jsp"%>
</div>
</body>
</html>