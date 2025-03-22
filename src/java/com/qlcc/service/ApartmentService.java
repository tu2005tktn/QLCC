// ApartmentService.java
package com.qlcc.service;

import com.qlcc.dao.ApartmentDAO;
import com.qlcc.dao.ApartmentOwnerDAO;
import com.qlcc.dao.ResidentDAO;
import com.qlcc.dao.TenantDAO;
import com.qlcc.dao.ServiceFeeDAO;
import com.qlcc.dao.RequestDAO;
import com.qlcc.model.Apartment;
import com.qlcc.model.ApartmentOwner;
import com.qlcc.model.Resident;
import com.qlcc.model.Tenant;
import com.qlcc.model.ServiceFee;
import com.qlcc.model.Request;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ApartmentService {
    
    @Autowired
    private ApartmentDAO apartmentDAO;
    
    @Autowired
    private ApartmentOwnerDAO apartmentOwnerDAO;
    
    @Autowired
    private ResidentDAO residentDAO;
    
    @Autowired
    private TenantDAO tenantDAO;
    
    @Autowired
    private ServiceFeeDAO serviceFeeDAO;
    
    @Autowired
    private RequestDAO requestDAO;
    
    public List<Apartment> getAllApartments() {
        return apartmentDAO.getAllApartments();
    }
    
    public Apartment getApartmentById(int apartmentId) {
        return apartmentDAO.getApartmentById(apartmentId);
    }
    
    public int getApartmentCount() {
        return apartmentDAO.getAllApartments().size();
    }
    
    public boolean addApartment(Apartment apartment) {
        return apartmentDAO.addApartment(apartment);
    }
    
    public boolean updateApartment(Apartment apartment) {
        return apartmentDAO.updateApartment(apartment);
    }
    
    public boolean deleteApartment(int apartmentId) {
        return apartmentDAO.deleteApartment(apartmentId);
    }
    
    public ApartmentOwner getOwnerByApartmentId(int apartmentId) {
        return apartmentOwnerDAO.getOwnerByApartmentId(apartmentId);
    }
    
    public Tenant getTenantByApartmentId(int apartmentId) {
        return tenantDAO.getRepresentativeTenantByApartmentId(apartmentId);
    }
    
    public List<Resident> getResidentsByApartmentId(int apartmentId) {
        return residentDAO.getResidentsByApartment(apartmentId);
    }
    
    public List<ServiceFee> getServiceFeesByApartmentId(int apartmentId) {
        return serviceFeeDAO.getServiceFeesByApartment(apartmentId);
    }
    
    public List<Request> getRequestsByApartmentId(int apartmentId) {
        return requestDAO.getRequestsByApartment(apartmentId);
    }
    
    public int getApartmentIdByUser(int userId) {
        return apartmentDAO.getApartmentIdByUserId(userId);
    }
}