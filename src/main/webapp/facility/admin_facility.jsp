<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="admin_check.jsp" %> <%--관리자만 이용 가능--%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.FacilityDTO" %>
<%@ page import="dao.FacilityDAO" %>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<title>시설 관리자 페이지</title>
</head>
<body class="bg-light">
<div class="container py-4">
    <%@ include file="header.jsp"%>

    <div class="p-4 mb-4 bg-white rounded-3 shadow-sm text-center">
        <h1 class="fw-bold text-dark">시설 관리자 페이지</h1>
        <p class="text-muted">등록된 시설을 수정하거나 삭제할 수 있습니다.</p>
        <a href="addFacility.jsp" class="btn btn-success">+ 시설 신규 등록</a>
    </div>

    <div class="bg-white p-4 rounded-3 shadow-sm">
        <table class="table table-hover align-middle">
            <thead class="table-dark">
                <tr class="text-center">
                    <th>번호</th>
                    <th>이미지</th>
                    <th>시설명</th>
                    <th>가격</th>
                    <th>상태</th>
                    <th>수용인원</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // 1. 데이터 조회: DAO 객체를 통해 등록된 모든 시설 리스트 호출
                    FacilityDAO dao = FacilityDAO.getInstance();
                    ArrayList<FacilityDTO> listOfFacility = dao.getAllFacility();
                    
                    // 2. 동적 렌더링: 시설 리스트를 순회하며 테이블 행(row) 생성
                    if (listOfFacility != null) {
                        for (FacilityDTO facility : listOfFacility) {
                %>
                <tr class="text-center">
                    <td><%=facility.getFacilityNo()%></td>
                    <td><img src="/aptweb/resources/images/<%=facility.getFileName()%>" style="width:50px; height:50px;" class="rounded"></td>
                    <td class="fw-bold"><%=facility.getFacilityName()%></td>
                    <td><%=facility.getFacilityPrice()%>원</td>
                    <td><span class="badge bg-info text-dark"><%=facility.getCondition()%></span></td>
                    <td><%=facility.getPeopleInStock()%>명</td>
                    <td>
                        <%-- 3. 기능 호출: 식별값(no)을 파라미터로 전달하여 수정 및 삭제 페이지로 이동 --%>
                        <a href="updateFacility.jsp?no=<%=facility.getFacilityNo()%>" class="btn btn-sm btn-warning">수정</a>
                        <a href="deleteFacility.jsp?no=<%=facility.getFacilityNo()%>" class="btn btn-sm btn-danger" 
                           onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </div>

    <%@ include file="footer.jsp"%>
</div>
</body>
</html>