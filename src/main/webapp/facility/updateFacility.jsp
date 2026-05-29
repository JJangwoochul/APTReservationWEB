<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="admin_check.jsp" %> <%--관리자만 이용 가능--%>
<%@ page import="dto.FacilityDTO" %>
<%@ page import="dao.FacilityDAO" %>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<title>시설 수정</title>
</head>
<body class="bg-light">
<div class="container py-4">
    <h3 class="fw-bold mb-4">시설 정보 수정</h3>
    
    <%
        String fNo = request.getParameter("no");
        FacilityDAO dao = FacilityDAO.getInstance();
        FacilityDTO facility = dao.getFacilityByNo(Integer.parseInt(fNo));
    %>

    <form action="processUpdateFacility.jsp" method="post" enctype="multipart/form-data">
        <input type="hidden" name="facilityNo" value="<%=facility.getFacilityNo()%>">
        
        <div class="mb-3">
            <label class="form-label">시설명</label>
            <input type="text" name="facilityName" class="form-control" value="<%=facility.getFacilityName()%>" required>
        </div>
        
        <div class="mb-3">
            <label class="form-label">설명</label>
            <textarea name="description" class="form-control" rows="5" required><%=facility.getDescription()%></textarea>
        </div>
        
        <div class="mb-3">
            <label class="form-label">이용 금액</label>
            <input type="number" name="facilityPrice" class="form-control" value="<%=facility.getFacilityPrice()%>" required>
        </div>
        
        <div class="mb-3">
            <label class="form-label">시설 상태</label>
            <input type="text" name="condition" class="form-control" value="<%=facility.getCondition()%>" required>
        </div>
        
        <div class="mb-3">
            <label class="form-label">수용 인원</label>
            <input type="number" name="peopleInStock" class="form-control" value="<%=facility.getPeopleInStock()%>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">현재 이미지</label><br>
            <img src="/aptweb/resources/images/<%=facility.getFileName()%>" width="100"><br><br>
            <label class="form-label">이미지 변경 (선택)</label>
            <input type="file" name="fileName" class="form-control">
        </div>
        
        <button type="submit" class="btn btn-primary">수정 완료</button>
        <a href="admin_facility.jsp" class="btn btn-secondary">취소</a>
    </form>
</div>
</body>
</html>