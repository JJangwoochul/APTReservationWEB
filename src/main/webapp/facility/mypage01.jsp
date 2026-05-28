<%@ page contentType="text/html; charset=utf-8" %>
<%@ page language="java" %>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<title>마이페이지</title>
<style>
body{
    background-color:#f5f6f8;
}

.mypage-container{
    width: 1200px;
    margin: 50px auto;
}

.title{
    font-size: 30px;
    font-weight: bold;
    margin-bottom: 30px;
}

.tab-box{
    display: flex;
    gap: 10px;
    margin-bottom: 20px;
}

.tab-btn{
    padding: 10px 25px;
    border-radius: 10px;
    border: none;
    background: #e9ecef;
    font-weight: bold;
    cursor: pointer;
}

.tab-btn.active{
    background: #212529;
    color: white;
}

.card-box{
    background: white;
    border-radius: 15px;
    padding: 20px;
    margin-bottom: 20px;
    transition: 0.3s;
}

.card-box:hover{
    transform: translateY(-5px);
    box-shadow: 0 8px 20px rgba(0,0,0,0.1);
}

.img-box{
    width: 120px;
    height: 120px;
    background: #ddd;
    border-radius: 12px;
}

.facility-name{
    font-size: 22px;
    font-weight: bold;
}

.info{
    color: #666;
    line-height: 1.8;
}

.btn-dark-custom{
    background: #212529;
    color: white;
    width: 120px;
    margin-bottom: 8px;
}

.btn-red-custom{
    background: #dc3545;
    color: white;
    width: 120px;
}

.total-box{
    text-align: right;
    font-size: 24px;
    font-weight: bold;
    margin-top: 30px;
}
</style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="mypage-container">
    <div class="title">마이페이지</div>
    <div class="tab-box">
        <button class="tab-btn active">
            예약내역
        </button>
        <button class="tab-btn">
            이용내역
        </button>
    </div>
    <div class="card-box">
        <div class="row align-items-center">
            <div class="col-md-2">
                <div class="img-box"></div>
            </div>
            <div class="col-md-7">
                <div class="facility-name">헬스장</div>
                <div class="info">
                    예약일 : 2026-05-19 <br>
                    이용시간 : 18:00 ~ 20:00 <br>
                    금액 : 2,000원
                </div>
            </div>
            <div class="col-md-3 text-end">
                <button class="btn btn-dark-custom" onclick="location.href='<%= request.getContextPath() %>/facility/cancel_detail.jsp'">예약취소</button><br>
                <button class="btn btn-dark-custom" onclick="location.href='<%= request.getContextPath() %>/facility/detail.jsp'">상세보기</button>
            </div>
        </div>
    </div>
    <div class="card-box">
        <div class="row align-items-center">
            <div class="col-md-2">
                <div class="img-box"></div>
            </div>
            <div class="col-md-7">
                <div class="facility-name">게스트하우스</div>
                <div class="info">
                    예약일 : 2026-05-21 <br>
                    이용기간 : 05-21 ~ 05-23 <br>
                    금액 : 8,000원
                </div>
            </div>
            <div class="col-md-3 text-end">
                <button class="btn btn-dark-custom" onclick="location.href='cancel_detail.jsp'">예약취소</button><br>
                <button class="btn btn-dark-custom" onclick="location.href='detail.jsp'">상세보기</button>
            </div>
        </div>
    </div>
    <div class="total-box">
        총 결제금액 : 10,000원
    </div>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>