<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="admin_check.jsp" %> <%--관리자만 이용 가능--%>
<%@ page import="dao.FacilityDAO" %>
<%
//체크완
    // 1. 파라미터로 넘어온 삭제할 시설 번호 받기
    String fNo = request.getParameter("no");

    // 2. 파라미터 유효성 검사
    if (fNo != null && !fNo.isEmpty()) {
        int facilityNo = Integer.parseInt(fNo);
        
        // 3. DAO 인스턴스 호출 및 삭제 메서드 실행
        FacilityDAO dao = FacilityDAO.getInstance();
        dao.deleteFacility(facilityNo);
        
        // 삭제 성공 로그 (선택사항, 콘솔창 확인용)
        System.out.println("시설 번호 " + facilityNo + " 삭제 완료");
    }

    // 4. 삭제 후 다시 관리자 페이지로 리다이렉트
    response.sendRedirect("admin_facility.jsp");
%>