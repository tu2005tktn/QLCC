// ParkingRegistrationService.java
package com.qlcc.service;

import com.qlcc.dao.ParkingRegistrationDAO;
import com.qlcc.dao.ApartmentDAO;
import com.qlcc.model.ParkingRegistration;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ParkingRegistrationService {
    
    @Autowired
    private ParkingRegistrationDAO parkingDAO;
    
    @Autowired
    private ApartmentDAO apartmentDAO;
    
    public List<ParkingRegistration> getAllParkingRegistrations() {
        return parkingDAO.getAllParkingRegistrations();
    }
    
    public ParkingRegistration getParkingRegistrationById(int parkingId) {
        return parkingDAO.getParkingRegistrationById(parkingId);
    }
    
    public List<ParkingRegistration> getParkingRegistrationsByApartment(int apartmentId) {
        return parkingDAO.getParkingRegistrationsByApartment(apartmentId);
    }
    
    public List<ParkingRegistration> getActiveParkingRegistrations() {
        return parkingDAO.getParkingRegistrationsByStatus("Đang hoạt động");
    }
    
    public int getApartmentIdByUser(int userId) {
        return apartmentDAO.getApartmentIdByUserId(userId);
    }
    
    public boolean createParkingRegistration(ParkingRegistration registration) {
        return parkingDAO.createParkingRegistration(registration);
    }
    
    public boolean updateParkingRegistration(ParkingRegistration registration) {
        return parkingDAO.updateParkingRegistration(registration);
    }
    
    public boolean cancelParkingRegistration(int parkingId) {
        ParkingRegistration registration = parkingDAO.getParkingRegistrationById(parkingId);
        if (registration != null) {
            registration.setStatus("Đã hủy");
            return parkingDAO.updateParkingRegistration(registration);
        }
        return false;
    }
}