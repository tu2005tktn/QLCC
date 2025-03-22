// MovingRegistrationService.java
package com.qlcc.service;

import com.qlcc.dao.MovingRegistrationDAO;
import com.qlcc.dao.ApartmentDAO;
import com.qlcc.model.MovingRegistration;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MovingRegistrationService {
    
    @Autowired
    private MovingRegistrationDAO movingDAO;
    
    @Autowired
    private ApartmentDAO apartmentDAO;
    
    public List<MovingRegistration> getAllMovingRegistrations() {
        return movingDAO.getAllMovingRegistrations();
    }
    
    public MovingRegistration getMovingRegistrationById(int movingId) {
        return movingDAO.getMovingRegistrationById(movingId);
    }
    
    public List<MovingRegistration> getMovingRegistrationsByApartment(int apartmentId) {
        return movingDAO.getMovingRegistrationsByApartment(apartmentId);
    }
    
    public List<MovingRegistration> getMovingRegistrationsByStatus(String status) {
        return movingDAO.getMovingRegistrationsByStatus(status);
    }
    
    public int getMovingRegistrationCountByStatus(String status) {
        return movingDAO.getMovingRegistrationsByStatus(status).size();
    }
    
    public List<MovingRegistration> getRecentMovingRegistrations(int limit) {
        // Lấy tất cả yêu cầu và giới hạn số lượng
        List<MovingRegistration> allRegistrations = movingDAO.getAllMovingRegistrations();
        if (allRegistrations.size() <= limit) {
            return allRegistrations;
        }
        return allRegistrations.subList(0, limit);
    }
    
    public int getApartmentIdByUser(int userId) {
        return apartmentDAO.getApartmentIdByUserId(userId);
    }
    
    public boolean createMovingRegistration(MovingRegistration registration) {
        return movingDAO.createMovingRegistration(registration);
    }
    
    public boolean updateMovingRegistration(MovingRegistration registration) {
        return movingDAO.updateMovingRegistration(registration);
    }
    
    public boolean approveMovingRegistration(int movingId, int approvedBy) {
        MovingRegistration registration = movingDAO.getMovingRegistrationById(movingId);
        if (registration != null) {
            registration.setStatus("Đã duyệt");
            registration.setApprovalDate(new Date());
            registration.setApprovedBy(approvedBy);
            return movingDAO.updateMovingRegistration(registration);
        }
        return false;
    }
    
    public boolean rejectMovingRegistration(int movingId, int approvedBy) {
        MovingRegistration registration = movingDAO.getMovingRegistrationById(movingId);
        if (registration != null) {
            registration.setStatus("Từ chối");
            registration.setApprovalDate(new Date());
            registration.setApprovedBy(approvedBy);
            return movingDAO.updateMovingRegistration(registration);
        }
        return false;
    }
    
    public boolean cancelMovingRegistration(int movingId) {
        MovingRegistration registration = movingDAO.getMovingRegistrationById(movingId);
        if (registration != null) {
            registration.setStatus("Đã hủy");
            return movingDAO.updateMovingRegistration(registration);
        }
        return false;
    }
}