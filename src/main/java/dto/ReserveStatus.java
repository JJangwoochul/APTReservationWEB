package dto;
//예약상태 확인 , processReserveCancel -> 예약 취소 후 예약취소로 변경
public class ReserveStatus {
    public static final String ACTIVE = "ACTIVE";       // 예약 중
    public static final String COMPLETED = "COMPLETED"; // 이용 완료
    public static final String CANCELLED = "CANCELLED"; // 예약 취소
}
