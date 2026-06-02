<%@ page contentType="text/html; charset=utf-8" %>
<%-- (1) 관리자 권한 확인 (문지기 역할) --%>
<%@ include file="admin_check.jsp" %> 
<%-- 공지사항 작성 페이지--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>공지사항 작성</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f5f6f8; }
        .write-container { width: 800px; margin: 50px auto; background: white; padding: 40px; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
    </style>
</head>
<body>

<div class="container write-container">
    <h2>공지사항 등록</h2>
    <hr>
    
    <%-- (2) 폼 전송: 관리자 전용 처리 페이지로 데이터 전달 --%>
    <form action="admin_notice_process.jsp" method="post">
        <div class="mb-3">
            <label class="form-label fw-bold">제목</label>
            <input type="text" name="title" class="form-control" placeholder="공지사항 제목을 입력하세요" required>
        </div>
        <div class="mb-3">
            <label class="form-label fw-bold">내용</label>
            <textarea name="content" class="form-control" rows="10" placeholder="공지사항 내용을 입력하세요" required></textarea>
        </div>
        
        <div class="text-end mt-4">
            <%-- (3) 취소 버튼: notice.jsp로 바로 이동하도록 경로 지정 --%>
            <button type="button" class="btn btn-secondary" onclick="location.href='<%= request.getContextPath() %>/facility/notice.jsp'">취소</button>
            <button type="submit" class="btn btn-dark">등록하기</button>
        </div>
    </form>
</div>

</body>
</html>