// ServiceTypeService.java
package com.qlcc.service;

import com.qlcc.dao.ServiceTypeDAO;
import com.qlcc.model.ServiceType;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ServiceTypeService {
    
    @Autowired
    private ServiceTypeDAO serviceTypeDAO;
    
    public List<ServiceType> getAllServiceTypes() {
        return serviceTypeDAO.getAllServiceTypes();
    }
    
    public ServiceType getServiceTypeById(int serviceTypeId) {
        return serviceTypeDAO.getServiceTypeById(serviceTypeId);
    }
    
    public boolean addServiceType(ServiceType serviceType) {
        return serviceTypeDAO.addServiceType(serviceType);
    }
    
    public boolean updateServiceType(ServiceType serviceType) {
        return serviceTypeDAO.updateServiceType(serviceType);
    }
    
    public boolean deleteServiceType(int serviceTypeId) {
        return serviceTypeDAO.deleteServiceType(serviceTypeId);
    }
}