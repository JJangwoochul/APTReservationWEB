package dto;

import java.io.Serializable;

public class ReserveDTO implements Serializable {
    private static final long serialVersionUID=2L;

    private int reserveNo; // 고유번호 (pk)
    private int facilityNo; // 고유번호 (fk)
    private int userNo; // 고유번호 (fk)
    private String reserveDate; // 예약 날짜

    public ReserveDTO() {
        super();
    }

    public static long getSerialversionuid() {
        return serialVersionUID;
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
    
}
