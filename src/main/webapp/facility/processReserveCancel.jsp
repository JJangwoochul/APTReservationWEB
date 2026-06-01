<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dao.ReserveDAO, dao.FacilityDAO, dto.ReserveDTO" %>
<%
    request.setCharacterEncoding("utf-8");

    String rNo = request.getParameter("reserveNo");
    
    if (rNo != null && !rNo.isEmpty()) {
        try {
            int reserveNo = Integer.parseInt(rNo);
            
            ReserveDAO reserveDAO = ReserveDAO.getInstance();
            FacilityDAO facilityDAO = FacilityDAO.getInstance();
            ReserveDTO reserve = reserveDAO.getReserveByNo(reserveNo);
            
            if (reserve != null && "ACTIVE".equals(reserve.getStatus())) {
                // 1. 예약 상태를 CANCELLED로 변경
                reserveDAO.updateReserveStatus(reserveNo, "CANCELLED");
                
                // 2. 시설 인원 복구
                facilityDAO.decreaseQuantity(reserve.getFacilityNo());
                
                // 3. 기획대로 취소 확인 페이지로 이동
                response.sendRedirect("cancelCheck.jsp");
                return; // 리다이렉트 후 코드 실행 방지
            } else {
                out.println("<script>alert('취소할 수 없는 예약입니다.'); history.back();</script>");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('오류가 발생했습니다.'); history.back();</script>");
        }
    } else {
        out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
    }
%>