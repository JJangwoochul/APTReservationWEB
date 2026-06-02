<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dao.ReserveDAO, dao.FacilityDAO, dto.ReserveDTO" %>
<%
    request.setCharacterEncoding("utf-8");

    String rNo = request.getParameter("reserveNo");
    
    // 1. 파라미터 검증: 전달받은 예약 번호가 유효한지 확인
    if (rNo != null && !rNo.isEmpty()) {
        try {
            int reserveNo = Integer.parseInt(rNo);
            
            ReserveDAO reserveDAO = ReserveDAO.getInstance();
            FacilityDAO facilityDAO = FacilityDAO.getInstance();
            ReserveDTO reserve = reserveDAO.getReserveByNo(reserveNo);
            
            // 2. 비즈니스 로직 실행 조건: 예약이 존재하고 현재 상태가 'ACTIVE'일 경우에만 취소 허용
            if (reserve != null && "ACTIVE".equals(reserve.getStatus())) {
                
                // [트랜잭션 단위 작업]
                // 1) 예약 상태를 CANCELLED로 업데이트
                reserveDAO.updateReserveStatus(reserveNo, "CANCELLED");
                
                // 2) 시설 인원 복구: 취소된 예약만큼 잔여 수량 증가(재고 반영)
                facilityDAO.decreaseQuantity(reserve.getFacilityNo());
                
                // 3) 처리 완료 후 확인 페이지로 리다이렉트
                response.sendRedirect("cancelCheck.jsp");
                return; // 리다이렉트 후 아래 코드 실행 방지
            } else {
                // 예약이 이미 취소되었거나 존재하지 않는 경우 처리
                out.println("<script>alert('취소할 수 없는 예약입니다.'); history.back();</script>");
            }
            
        } catch (Exception e) {
            // [예외 처리] 데이터베이스 연결 오류 등 발생 시 사용자 알림 및 이전 페이지 이동
            e.printStackTrace();
            out.println("<script>alert('오류가 발생했습니다.'); history.back();</script>");
        }
    } else {
        // 예약 번호 파라미터가 누락된 비정상적 접근 차단
        out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
    }
%>