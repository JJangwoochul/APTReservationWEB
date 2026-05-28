<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dao.UserDAO, dto.UserDTO" %>
<%
    request.setCharacterEncoding("utf-8");

    try {
        String userId = request.getParameter("userId");
        String userPw = request.getParameter("userPw");
        String userName = request.getParameter("userName");
        String phone = request.getParameter("phone");
        int dong = Integer.parseInt(request.getParameter("dong"));
        int ho = Integer.parseInt(request.getParameter("ho"));
        
        UserDTO newUser = new UserDTO(userId, userPw, userName, phone, dong, ho);
        UserDAO dao = new UserDAO();
        int result = dao.join(newUser);
        
        if (result == 1) {
            // 회원가입 성공
            response.sendRedirect(request.getContextPath() + "/facility/login.jsp");
        } else if (result == 0) {
            // 회원가입 실패 (로직상 실패)
            out.println("<script>alert('회원가입 처리 중 오류가 발생했습니다. (result: 0)'); history.back();</script>");
        } else {
            // 기타 오류 (result == -1 등)
            out.println("<script>alert('알 수 없는 오류가 발생했습니다. (result: " + result + ")'); history.back();</script>");
        }
        
    } catch (NumberFormatException e) {
        out.println("<script>alert('동/호수는 반드시 숫자로 입력해주세요.'); history.back();</script>");
    } catch (Exception e) {
        out.println("<script>console.error('" + e.getMessage() + "');</script>"); // 개발자 도구 콘솔에 기록
        out.println("<script>alert('시스템 장애가 발생했습니다. 잠시 후 다시 시도해주세요.'); history.back();</script>");
    }
%>