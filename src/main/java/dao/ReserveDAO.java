package dao;

import java.util.ArrayList;
import dto.ReserveDTO;

public class ReserveDAO {

    private ArrayList<ReserveDTO> listOfReserves = new ArrayList<ReserveDTO>();

    private static ReserveDAO instance = new ReserveDAO();
    
    public static ReserveDAO getInstance() {
        return instance;
    }

    private ReserveDAO() {}

    public ArrayList<ReserveDTO> getAllReserves() {
        return listOfReserves;
    }

    public ReserveDTO getReserveDTObyDate(String reserveDate) {
        ReserveDTO reserveDTOByDate = null;

        for (int i = 0; i < listOfReserves.size(); i++) {
            ReserveDTO reserveDTO = listOfReserves.get(i);

            if (reserveDTO != null && reserveDTO.getReserveDate() != null && reserveDTO.getReserveDate().equals(reserveDate)) {
                reserveDTOByDate = reserveDTO;
                break;
            }
        }

        return reserveDTOByDate; 
    }
    public void addReserve(ReserveDTO reserveDTO) {
        listOfReserves.add(reserveDTO);
    }
}