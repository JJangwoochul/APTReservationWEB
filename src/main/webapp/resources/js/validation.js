function CheckAddFacility() {
    var fName = document.getElementById("facilityName");
    var desc = document.getElementById("description");
    var fPrice = document.getElementById("facilityPrice");
    var cond = document.getElementById("condition");
    var people = document.getElementById("peopleInStock");

    // 1. 시설명 확인 (고유번호 로직 삭제됨)
    if (fName.value.trim().length < 2) {
        alert("[시설명]\n최소 2자 이상 입력해주세요.");
        fName.focus();
        return false;
    }

    // 2. 시설 설명 확인
    if (desc.value.trim().length < 50) {
        alert("[시설 설명]\n최소 50자 이상 입력해주세요.");
        desc.focus();
        return false;
    }

    // 3. 가격 확인
    if (!fPrice.value.trim() || isNaN(fPrice.value) || Number(fPrice.value) < 0) {
        alert("[가격]\n0 이상의 숫자만 입력해주세요.");
        fPrice.focus();
        return false;
    }

    // 4. 시설 상태 확인
    if (cond.value.trim() === "") {
        alert("[시설 상태]를 입력해주세요.");
        cond.focus();
        return false;
    }

    // 5. 수용 인원 확인
    if (!people.value.trim() || isNaN(people.value) || Number(people.value) < 0) {
        alert("[수용 인원]\n0 이상의 숫자만 입력해주세요.");
        people.focus();
        return false;
    }

    return true; // 모든 검사를 통과함
}