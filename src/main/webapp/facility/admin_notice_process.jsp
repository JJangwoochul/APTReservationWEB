<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="admin_check.jsp" %>
<%@ page import="dao.NoticeDAO, dto.NoticeDTO" %>
<%
    request.setCharacterEncoding("utf-8");

    // (1) 데이터 수신
    String title = request.getParameter("title");
    String content = request.getParameter("content");

    // (2) 유효성 검사 (입력값이 비어있는지 확인)
    if (title == null || title.trim().isEmpty() || content == null || content.trim().isEmpty()) {
        out.println("<script>alert('제목과 내용을 모두 입력해주세요.'); history.back();</script>");
        return;
    }

    // (3) 세션에서 로그인한 사용자의 고유 번호(userNo) 가져오기
    // 로그인 프로세스에서 저장한 키값인 "userNo"를 사용합니다.
    Integer adminNo = (Integer) session.getAttribute("userNo");

    // (4) DTO에 데이터 담기
    NoticeDTO dto = new NoticeDTO();
    dto.setTitle(title);
    dto.setContent(content);
    
    // 세션 정보 확인 후 작성자 번호(writerNo) 설정
    if (adminNo != null) {
        dto.setWriterNo(adminNo);
    } else {
        // 비정상적인 접근(로그인 안 됨) 차단
        out.println("<script>alert('로그인 정보가 만료되었습니다. 다시 로그인해주세요.'); location.href='login.jsp';</script>");
        return;
    }

    // (5) DB 연동 실행 (등록)
    try {
        NoticeDAO dao = NoticeDAO.getInstance();
        dao.insertNotice(dto);
        
        // (6) 완료 후 목록으로 이동
        out.println("<script>alert('공지사항이 등록되었습니다.'); location.href='notice.jsp';</script>");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('등록 중 오류가 발생했습니다.'); history.back();</script>");
    }
%>