function CheckAddFacility() {
    var fNo = document.getElementById("facilityNo");
    var fName = document.getElementById("facilityName");
    var desc = document.getElementById("description");
    var fPrice = document.getElementById("facilityPrice");
    var cond = document.getElementById("condition");
    var people = document.getElementById("peopleInStock");

    // 1. 고유번호 확인 (값이 없거나 숫자가 아님)
    if (!fNo.value.trim()) { // .value.trim() == "" 보다 더 깔끔한 방식
        alert("[고유번호]\n값을 입력해주세요.");
        fNo.focus();
        return false;
    }
    if (isNaN(fNo.value)) {
        alert("[고유번호]\n숫자만 입력 가능합니다.");
        fNo.focus();
        return false;
    }

    // 2. 시설명 확인
    if (fName.value.trim().length < 2) {
        alert("[시설명]\n최소 2자 이상 입력해주세요.");
        fName.focus();
        return false;
    }

    // 3. 시설 설명 확인
    if (desc.value.trim().length < 50) {
        alert("[시설 설명]\n최소 50자 이상 입력해주세요.");
        desc.focus();
        return false;
    }

    // 4. 가격 확인
    if (!fPrice.value.trim() || isNaN(fPrice.value) || Number(fPrice.value) < 0) {
        alert("[가격]\n0 이상의 숫자만 입력해주세요.");
        fPrice.focus();
        return false;
    }

    // 5. 시설 상태 확인 (빈 문자열 체크 강화)
    if (cond.value.trim() === "") {
        alert("[시설 상태]를 입력해주세요.");
        cond.focus();
        return false;
    }

    // 6. 수용 인원 확인
    if (!people.value.trim() || isNaN(people.value) || Number(people.value) < 0) {
        alert("[수용 인원]\n0 이상의 숫자만 입력해주세요.");
        people.focus();
        return false;
    }

    return true; // 모든 검사를 통과함
}