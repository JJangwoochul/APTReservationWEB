package dao;

import java.util.ArrayList;
import dto.FacilityDTO;

public class FacilityDAO {
    
    private ArrayList<FacilityDTO> listOfFacilityDTOs = new ArrayList<FacilityDTO>();

    private static FacilityDAO instance= new FacilityDAO();

    public static FacilityDAO getInstance() {
        return instance;
    }
    
    public FacilityDAO() {
        FacilityDTO facilityDTO1 = new FacilityDTO(1, "헬스장", 1000);
        facilityDTO1.setDescription("사설 헬스장보다 이용료가 훨씬 저렴하지만 아파트 입주민만 사용할 수 있는 단지 내에 마련된 헬스장 입니다.");
        facilityDTO1.setCondition("정상 운영");
        facilityDTO1.setPeopleInStock(20);
        facilityDTO1.setFileName("facility01.jpg");

        FacilityDTO facilityDTO2 = new FacilityDTO(2, "독서실", 1000);
        facilityDTO2.setDescription("사설 독서실보다 이용료가 훨씬 저렴하지만 아파트 입주민만 사용할 수 있는 단지 내에 마련된 독서실 입니다.");
        facilityDTO2.setCondition("정상 운영");
        facilityDTO2.setPeopleInStock(30);
        facilityDTO2.setFileName("facility02.jpg");

        FacilityDTO facilityDTO3 = new FacilityDTO(3, "게스트하우스", 10000);
        facilityDTO3.setDescription("입주민의 친척이나 지인이 방문했을 때 저렴한 비용으로 편안하게 머무를 수 있도록 단지 내에 마련된 숙박 시설입니다.");
        facilityDTO3.setCondition("정상 운영");
        facilityDTO3.setPeopleInStock(10);
        facilityDTO3.setFileName("facility03.jpg");

        listOfFacilityDTOs.add(facilityDTO1);
        listOfFacilityDTOs.add(facilityDTO2);
        listOfFacilityDTOs.add(facilityDTO3);
    }
    public ArrayList<FacilityDTO> getAllFacility() {
        return listOfFacilityDTOs;
    }
    public FacilityDTO getFacilityDTOByNo(int facilityNo) {
        if (listOfFacilityDTOs != null) {
            for (int i = 0; i < listOfFacilityDTOs.size(); i++) {
                FacilityDTO facilityDTO = listOfFacilityDTOs.get(i);   
        
                if (facilityDTO != null && facilityDTO.getFacilityNo() == facilityNo) {
                    return facilityDTO; 
                }
            }
        }
        return null;
    }
    public void addFacility(FacilityDTO facilityDTO) {
        listOfFacilityDTOs.add(facilityDTO);
    }
}
