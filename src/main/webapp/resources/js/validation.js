function CheckAddFacility() {

    var facilityNo=document.getElementById("facilityNo");
    var facilityName=document.getElementById("facilityName");
    var description=document.getElementById("description");
    var facilityPrice=document.getElementById("facilityPrice");
    var condition=document.getElementById("condition");
    var peopleInStock=document.getElementById("peopleInStock");

    if (isNaN(facilityNo.value)) {
        alert("[고유번호]\n숫자만 입력할 수 있습니다.");
        facilityNo.focus();
        return false;
    }

    if (facilityName.value.length < 2) {
        alert("[시설명]\n 최소 2자 이상 입력해주세요.");
        facilityName.focus();
        return false;
    }

    if (description.value.length < 50) {
        alert("[시설 설명]\n 최소 50자 이상 입력해주세요.");
        description.focus();
        return false;
    }

    if (isNaN(facilityPrice.value) || facilityPrice.value < 0) {
        alert("[가격]은 0 이상의 숫자만 입력할 수 있습니다.");
        facilityPrice.focus();
        return false;
    }

    if (condition.value) {
        alert("[시설 상태]를 입력해주세요. (예: 정상운영, 점검중)");
        condition.focus();
        return false;
    }

    if (isNaN(peopleInStock.value) || peopleInStock.value < 0) {
        alert("[수용 인원]은 0 이상의 숫자만 입력할 수 있습니다.");
        peopleInStock.focus();
        return false;
    }

    document.newFacility.submit();
}