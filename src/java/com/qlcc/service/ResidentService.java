// ResidentService.java
package com.qlcc.service;

import com.qlcc.dao.ResidentDAO;
import com.qlcc.dao.ApartmentDAO;
import com.qlcc.model.Resident;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ResidentService {
    
    @Autowired
    private ResidentDAO residentDAO;
    
    @Autowired
    private ApartmentDAO apartmentDAO;
    
    public List<Resident> getAllResidents() {
        return residentDAO.getAllResidents();
    }
    
    public Resident getResidentById(int residentId) {
        return residentDAO.getResidentById(residentId);
    }
    
    public List<Resident> getResidentsByApartment(int apartmentId) {
        return residentDAO.getResidentsByApartment(apartmentId);
    }
    
    public boolean addResident(Resident resident) {
        return residentDAO.addResident(resident);
    }
    
    public boolean updateResident(Resident resident) {
        return residentDAO.updateResident(resident);
    }
    
    public boolean deleteResident(int residentId) {
        return residentDAO.deleteResident(residentId);
    }
    
    public int getApartmentIdByUser(int userId) {
        return apartmentDAO.getApartmentIdByUserId(userId);
    }
}