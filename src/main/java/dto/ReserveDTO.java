package dto;

import java.io.Serializable;

public class ReserveDTO implements Serializable {
    private static final long serialVersionUID = 2L;

    private int reserveNo; //PK
    private int facilityNo; //FK
    private int userNo; //FK
    private String reserveDate; // 예약 시작 날
    private String useDate; // 이용일 추가
    private int startTime; // 시작 시간 추가
    private int endTime; // 종료 시간 추가
    private int price; // 결제 금액 추가
    private String status; // 예약 상태 추가

    public ReserveDTO() {
        super();
    }

    public ReserveDTO(int reserveNo, int facilityNo, int userNo, String reserveDate,
            String useDate, int startTime, int endTime, int price, String status) {
        this.reserveNo = reserveNo;
        this.facilityNo = facilityNo;
        this.userNo = userNo;
        this.reserveDate = reserveDate;
        this.useDate = useDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.price = price;
        this.status = status;
    }

    public ReserveDTO(int reserveNo, int facilityNo, int userNo, String reserveDate) {
        this.reserveNo = reserveNo;
        this.facilityNo = facilityNo;
        this.userNo = userNo;
        this.reserveDate = reserveDate;
    }

    public int getReserveNo() {
        return reserveNo;
    }

    public void setReserveNo(int reserveNo) {
        this.reserveNo = reserveNo;
    }

    public int getFacilityNo() {
        return facilityNo;
    }

    public void setFacilityNo(int facilityNo) {
        this.facilityNo = facilityNo;
    }

    public int getUserNo() {
        return userNo;
    }

    public void setUserNo(int userNo) {
        this.userNo = userNo;
    }

    public String getReserveDate() {
        return reserveDate;
    }

    public void setReserveDate(String reserveDate) {
        this.reserveDate = reserveDate;
    }

    public String getUseDate() {
        return useDate;
    }

    public void setUseDate(String useDate) {
        this.useDate = useDate;
    }

    public int getStartTime() {
        return startTime;
    }

    public void setStartTime(int startTime) {
        this.startTime = startTime;
    }

    public int getEndTime() {
        return endTime;
    }

    public void setEndTime(int endTime) {
        this.endTime = endTime;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}