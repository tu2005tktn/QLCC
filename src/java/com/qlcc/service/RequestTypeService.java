// RequestTypeService.java
package com.qlcc.service;

import com.qlcc.dao.RequestTypeDAO;
import com.qlcc.model.RequestType;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RequestTypeService {
    
    @Autowired
    private RequestTypeDAO requestTypeDAO;
    
    public List<RequestType> getAllRequestTypes() {
        return requestTypeDAO.getAllRequestTypes();
    }
    
    public RequestType getRequestTypeById(int requestTypeId) {
        return requestTypeDAO.getRequestTypeById(requestTypeId);
    }
    
    public boolean addRequestType(RequestType requestType) {
        return requestTypeDAO.addRequestType(requestType);
    }
    
    public boolean updateRequestType(RequestType requestType) {
        return requestTypeDAO.updateRequestType(requestType);
    }
    
    public boolean deleteRequestType(int requestTypeId) {
        return requestTypeDAO.deleteRequestType(requestTypeId);
    }
}