package dto;

import java.io.Serializable;

public class FacilityDTO implements Serializable {
    private static final long serialVersionUID=1L;

    private int facilityNo; // 고유번호 (pk)
    private String facilityName; // 시설명
    private String description; // 시설 설명
    private int facilityPrice; // 가격
    private String condition; // 시설 상태
    private int peopleInStock; // 수용인원
    private String fileName; // 파일명
    private int quantity;

    public FacilityDTO() {
        super();
    }

    public FacilityDTO(Integer facilityNo ,String facilityName, Integer facilityPrice) {
        this.facilityNo=facilityNo;
        this.facilityName=facilityName;
        this.facilityPrice=facilityPrice;
    }

    public static long getSerialversionuid() {
        return serialVersionUID;
    }

    public int getFacilityNo() {
        return facilityNo;
    }

    public void setFacilityNo(int facilityNo) {
        this.facilityNo = facilityNo;
    }

    public String getFacilityName() {
        return facilityName;
    }

    public void setFacilityName(String facilityName) {
        this.facilityName = facilityName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getFacilityPrice() {
        return facilityPrice;
    }

    public void setFacilityPrice(int facilityPrice) {
        this.facilityPrice = facilityPrice;
    }

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public int getPeopleInStock() {
        return peopleInStock;
    }

    public void setPeopleInStock(int peopleInStock) {
        this.peopleInStock = peopleInStock;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

}