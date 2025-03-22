// RequestService.java
package com.qlcc.service;

import com.qlcc.dao.RequestDAO;
import com.qlcc.dao.RequestAssignmentDAO;
import com.qlcc.dao.RequestProgressDAO;
import com.qlcc.dao.ApartmentDAO;
import com.qlcc.model.Request;
import com.qlcc.model.RequestAssignment;
import com.qlcc.model.RequestProgress;
import java.util.Arrays;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RequestService {
    
    @Autowired
    private RequestDAO requestDAO;
    
    @Autowired
    private RequestAssignmentDAO requestAssignmentDAO;
    
    @Autowired
    private RequestProgressDAO requestProgressDAO;
    
    @Autowired
    private ApartmentDAO apartmentDAO;
    
    public List<Request> getAllRequests() {
        return requestDAO.getAllRequests();
    }
    
    public Request getRequestById(int requestId) {
        return requestDAO.getRequestById(requestId);
    }
    
    public List<Request> getRequestsByApartment(int apartmentId) {
        return requestDAO.getRequestsByApartment(apartmentId);
    }
    
    public List<Request> getRequestsByStatus(String status) {
        return requestDAO.getRequestsByStatus(status);
    }
    
    public List<Request> getRequestsByStaff(int staffId) {
        return requestDAO.getRequestsByStaff(staffId);
    }
    
    public List<Request> getRequestsByStaffAndStatus(int staffId, String status) {
        // Tùy chỉnh lại logic nếu cần thiết
        List<Request> requests = requestDAO.getRequestsByStaff(staffId);
        requests.removeIf(request -> !request.getStatus().equals(status));
        return requests;
    }
    
    public int getRequestCountByStatus(String status) {
        return requestDAO.getRequestsByStatus(status).size();
    }
    
    public int getRequestCountByStaffAndStatus(int staffId, String status) {
        return getRequestsByStaffAndStatus(staffId, status).size();
    }
    
    public List<Request> getRecentRequests(int limit) {
        // Lấy tất cả yêu cầu và giới hạn số lượng
        List<Request> allRequests = requestDAO.getAllRequests();
        if (allRequests.size() <= limit) {
            return allRequests;
        }
        return allRequests.subList(0, limit);
    }
    
    public List<Request> getRecentRequestsByApartment(int apartmentId, int limit) {
        // Lấy tất cả yêu cầu theo căn hộ và giới hạn số lượng
        List<Request> apartmentRequests = requestDAO.getRequestsByApartment(apartmentId);
        if (apartmentRequests.size() <= limit) {
            return apartmentRequests;
        }
        return apartmentRequests.subList(0, limit);
    }
    
    public int getApartmentIdByUser(int userId) {
        return apartmentDAO.getApartmentIdByUserId(userId);
    }
    
    public boolean createRequest(Request request) {
        return requestDAO.createRequest(request);
    }
    
    public boolean updateRequest(Request request) {
        return requestDAO.updateRequest(request);
    }
    
    public boolean updateRequestStatus(int requestId, String status) {
        return requestDAO.updateRequestStatus(requestId, status);
    }
    
    public boolean assignRequest(int requestId, int staffId, int managerId) {
        return requestDAO.assignRequest(requestId, staffId, managerId);
    }
    
    public boolean updateRequestProgress(int requestId, String status, String notes, int updatedBy) {
        return requestDAO.updateRequestProgress(requestId, status, notes, updatedBy);
    }
    
    public List<RequestProgress> getRequestProgress(int requestId) {
        return requestProgressDAO.getProgressByRequestId(requestId);
    }
    
    public RequestAssignment getRequestAssignment(int requestId) {
        return requestAssignmentDAO.getAssignmentByRequestId(requestId);
    }
    
    public List<String> getStatusOptions() {
        return Arrays.asList(
            "Đang chờ xử lý",
            "Đang xử lý",
            "Đang tạm hoãn",
            "Hoàn thành",
            "Đã hủy",
            "Từ chối"
        );
    }
    
    public boolean deleteRequest(int requestId) {
        return requestDAO.deleteRequest(requestId);
    }
}