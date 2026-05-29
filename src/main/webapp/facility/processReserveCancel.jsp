<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dao.ReserveDAO" %>
<%
    // 1. 요청 인코딩 설정
    request.setCharacterEncoding("utf-8");

    // 2. 예약 번호(reserveNo) 파라미터 받기
    String rNo = request.getParameter("reserveNo");
    
    // 3. 파라미터가 유효한지 확인 후 삭제 로직 수행
    if (rNo != null && !rNo.isEmpty()) {
        try {
            int reserveNo = Integer.parseInt(rNo);
            
            // DAO를 사용하여 데이터베이스에서 삭제
            ReserveDAO reserveDAO = ReserveDAO.getInstance();
            reserveDAO.deleteReserve(reserveNo);
            
        } catch (NumberFormatException e) {
            // 숫자 변환 중 오류 발생 시 에러 로그 기록
            e.printStackTrace();
        }
    }

    // 4. 처리 완료 후 취소 확인 페이지로 즉시 이동
    response.sendRedirect("cancelCheck.jsp");
%>