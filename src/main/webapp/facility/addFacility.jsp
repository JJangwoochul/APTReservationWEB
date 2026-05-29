<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="admin_check.jsp" %> <%--관리자만 이용 가능--%>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="/aptweb/resources/js/validation.js?v=1"></script>
    <title>시설 등록</title>
</head>
<body class="bg-light">
<div class="container py-4">
    <%@ include file="header.jsp"%>

    <div class="p-4 mb-4 bg-white rounded-3 shadow-sm text-center">
        <h1 class="fw-bold text-dark">시설 등록</h1>
        <p class="text-muted">새로운 시설 정보를 입력해주세요.</p>
    </div>

    <div class="row justify-content-center my-4">
        <div class="col-md-8 bg-white p-5 rounded-3 shadow-sm border">
            <form name="newFacility" action="./processAddFacility.jsp" method="post" 
                  enctype="multipart/form-data" onsubmit="return CheckAddFacility()">
                
                <div class="mb-3">
                    <label class="form-label fw-bold">고유번호</label>
                    <input type="text" id="facilityNo" name="facilityNo" class="form-control" placeholder="숫자만 입력">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">시설명</label>
                    <input type="text" id="facilityName" name="facilityName" class="form-control">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">시설 설명</label>
                    <textarea id="description" name="description" rows="5" class="form-control" placeholder="50자 이상 입력해주세요"></textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">가격</label>
                    <input type="text" id="facilityPrice" name="facilityPrice" class="form-control">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">시설 상태</label>
                    <input type="text" id="condition" name="condition" class="form-control">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">수용 인원</label>
                    <input type="text" id="peopleInStock" name="peopleInStock" class="form-control">
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold">파일명</label>
                    <input type="file" name="fileName" class="form-control">
                </div>

                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <a href="admin_facility.jsp" class="btn btn-secondary">취소</a>
                    <button type="submit" class="btn btn-primary">등록하기</button>
                </div>
            </form>
        </div>
    </div>
    <%@ include file="footer.jsp"%>
</div>
</body>
</html>