<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dao.UserDAO, dto.UserDTO" %>
<%
    request.setCharacterEncoding("utf-8");

    try {
        //파라미터 수신 , 데이터 변환
        String userId = request.getParameter("userId");
        String userPw = request.getParameter("userPw");
        String userName = request.getParameter("userName");
        String phone = request.getParameter("phone");
        //동,호수를 int로 변환
        int dong = Integer.parseInt(request.getParameter("dong"));
        int ho = Integer.parseInt(request.getParameter("ho"));
        //유효성 검사
        if (userId == null || userId.trim().isEmpty() || userPw == null || userPw.trim().isEmpty()) {
            out.println("<script>alert('필수 입력 항목을 확인해주세요.'); history.back();</script>");
            return;
        }

        UserDTO newUser = new UserDTO(userId, userPw, userName, phone, dong, ho);
        UserDAO dao = new UserDAO();
        int result = dao.join(newUser);
        
        if (result == 1) {
            // 회원가입 성공
            response.sendRedirect(request.getContextPath() + "/facility/login.jsp");
        } else {
            out.println("<script>alert('회원가입 실패.'); history.back();</script>");
        }
        
    } catch (NumberFormatException e) {
        // 동 호수 적는 숫자칸에 ex)101동< 한글같이넣을 시 입력오류
        out.println("<script>alert('동/호수는 반드시 숫자로 입력해주세요.'); history.back();</script>");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('시스템 장애가 발생했습니다. 잠시 후 다시 시도해주세요.'); history.back();</script>");
    }
%>