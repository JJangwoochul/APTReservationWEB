<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<script type="text/javascript" src="/aptweb/resources/js/validation.js"></script>
<title>시설 등록</title>
</head>
<body class="bg-light">
<div class="container text-center py-4">
    <%@ include file="header.jsp"%>

    <div class="p-5 mb-4 bg-body-tertiary rounded-3 shadow-sm text-center">
        <div class="container-fluid py-3">
            <h1 class="display-5 fw-bold text-dark">시설 등록</h1>
            <p class="lead">Facility Addition</p>
        </div>     
    </div>

    <div class="row justify-content-center my-4">
        <div class="col-md-8 bg-white p-5 rounded-3 shadow-sm">
        <form name="newFacility" action="./processAddFacility.jsp" method="post" enctype="multipart/form-data">
        <div class="mb-3 row align-items-center">
            <label class="col-sm-3 col-form-label fw-bold">고유번호</label>
            <div class="col-sm-9">
                <input type="text" id="facilityNo" name="facilityNo" class="form-control">
            </div>
        </div>

        <div class="mb-3 row align-items-center">
            <label class="col-sm-3 col-form-label fw-bold">시설명</label>
            <div class="col-sm-9">
                <input type="text" id="facilityName" name="facilityName" class="form-control">
            </div>
        </div>

        <div class="mb-3 row align-items-center">
            <label class="col-sm-3 col-form-label fw-bold">시설 설명</label>
            <div class="col-sm-9">
                <textarea id= "description" name="description" cols="50" rows="2" class="form-control" placeholder="50자 이상 적어주세요"></textarea>
            </div>
        </div>

        <div class="mb-3 row align-items-center">
            <label class="col-sm-3 col-form-label fw-bold">가격</label>
            <div class="col-sm-9">
                <input type="text" id="facilityPrice" name="facilityPrice" class="form-control">
            </div>
        </div>

        <div class="mb-3 row align-items-center">
            <label class="col-sm-3 col-form-label fw-bold">시설 상태</label>
            <div class="col-sm-9">
                <input type="text" id="condition" name="condition" class="form-control">
            </div>
        </div>

        <div class="mb-3 row align-items-center">
            <label class="col-sm-3 col-form-label fw-bold">수용 인원</label>
            <div class="col-sm-9">
                <input type="text" id="peopleInStock" name="peopleInStock" class="form-control">
            </div>
        </div>

        <div class="mb-3 row align-items-center">
            <label class="col-sm-3 col-form-label fw-bold">파일명</label>
            <div class="col-sm-9">
                <input type="file" name="fileName" class="form-control">
            </div>
        </div>
        <div class="row pt-2">
            <div class="col-sm-9 offset-sm-3">
                <input type="button" class="btn btn-primary" value="등록" onclick="CheckAddFacility()">
            </div>
        </div>
    </form>
    </div>
    </div>
    <%@ include file="footer.jsp"%>
</div>
</body>
</html>
