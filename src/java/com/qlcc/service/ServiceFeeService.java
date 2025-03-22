// ServiceFeeService.java
package com.qlcc.service;

import com.qlcc.dao.ServiceFeeDAO;
import com.qlcc.dao.ApartmentDAO;
import com.qlcc.dao.ServiceTypeDAO;
import com.qlcc.model.Apartment;
import com.qlcc.model.ServiceFee;
import com.qlcc.model.ServiceType;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ServiceFeeService {
    
    @Autowired
    private ServiceFeeDAO serviceFeeDAO;
    
    @Autowired
    private ApartmentDAO apartmentDAO;
    
    @Autowired
    private ServiceTypeDAO serviceTypeDAO;
    
    public List<ServiceFee> getAllServiceFees() {
        return serviceFeeDAO.getAllServiceFees();
    }
    
    public ServiceFee getServiceFeeById(int feeId) {
        return serviceFeeDAO.getServiceFeeById(feeId);
    }
    
    public List<ServiceFee> getServiceFeesByApartment(int apartmentId) {
        return serviceFeeDAO.getServiceFeesByApartment(apartmentId);
    }
    
    public List<ServiceFee> getUnpaidServiceFeesByApartment(int apartmentId) {
        List<ServiceFee> serviceFees = serviceFeeDAO.getServiceFeesByApartment(apartmentId);
        return serviceFees.stream()
                .filter(fee -> "Chưa thanh toán".equals(fee.getStatus()))
                .collect(Collectors.toList());
    }
    
    public List<ServiceFee> getServiceFeesByMonthYear(int month, int year) {
        return serviceFeeDAO.getServiceFeesByMonthYear(month, year);
    }
    
    public boolean addServiceFee(ServiceFee serviceFee) {
        return serviceFeeDAO.addServiceFee(serviceFee);
    }
    
    public boolean updateServiceFee(ServiceFee serviceFee) {
        return serviceFeeDAO.updateServiceFee(serviceFee);
    }
    
    public boolean markAsPaid(int feeId) {
        return serviceFeeDAO.markAsPaid(feeId);
    }
    
    public boolean deleteServiceFee(int feeId) {
        return serviceFeeDAO.deleteServiceFee(feeId);
    }
    
    public int generateServiceFees(int month, int year, int serviceTypeId) {
        List<Apartment> apartments = apartmentDAO.getAllApartments();
        ServiceType serviceType = serviceTypeDAO.getServiceTypeById(serviceTypeId);
        
        if (serviceType == null) {
            return 0;
        }
        
        int count = 0;
        
        for (Apartment apartment : apartments) {
            // Kiểm tra xem đã có phí dịch vụ cho tháng/năm/loại dịch vụ/căn hộ chưa
            boolean exists = checkServiceFeeExists(apartment.getApartmentId(), serviceTypeId, month, year);
            
            if (!exists && "Đang sử dụng".equals(apartment.getStatus())) {
                ServiceFee serviceFee = new ServiceFee();
                serviceFee.setApartmentId(apartment.getApartmentId());
                serviceFee.setServiceTypeId(serviceTypeId);
                serviceFee.setMonth(month);
                serviceFee.setYear(year);
                serviceFee.setIssueDate(new Date());
                serviceFee.setStatus("Chưa thanh toán");
                
                // Thiết lập số tiền dựa trên loại dịch vụ và diện tích căn hộ
                BigDecimal amount = calculateServiceFeeAmount(serviceType, apartment);
                serviceFee.setAmount(amount);
                
                // Thiết lập mô tả
                String details = "Phí " + serviceType.getTypeName() + " tháng " + month + "/" + year;
                serviceFee.setDetails(details);
                
                if (serviceFeeDAO.addServiceFee(serviceFee)) {
                    count++;
                }
            }
        }
        
        return count;
    }
    
    private boolean checkServiceFeeExists(int apartmentId, int serviceTypeId, int month, int year) {
        List<ServiceFee> fees = serviceFeeDAO.getServiceFeesByApartment(apartmentId);
        
        for (ServiceFee fee : fees) {
            if (fee.getServiceTypeId() == serviceTypeId && fee.getMonth() == month && fee.getYear() == year) {
                return true;
            }
        }
        
        return false;
    }
    
    private BigDecimal calculateServiceFeeAmount(ServiceType serviceType, Apartment apartment) {
        // Tính toán phí dịch vụ dựa trên loại dịch vụ và diện tích căn hộ
        // Đây chỉ là một ví dụ, bạn có thể tùy chỉnh công thức tính toán
        
        String typeName = serviceType.getTypeName();
        double area = apartment.getArea();
        
        if ("Phí quản lý".equals(typeName)) {
            return new BigDecimal(area * 15000); // 15,000 VND/m2
        } else if ("Phí nước".equals(typeName)) {
            return new BigDecimal(area * 10000); // 10,000 VND/m2
        } else if ("Phí gửi xe".equals(typeName)) {
            return new BigDecimal(120000); // 120,000 VND/tháng
        } else if ("Phí điện".equals(typeName)) {
            return new BigDecimal(area * 20000); // 20,000 VND/m2
        } else {
            return new BigDecimal(50000); // Mặc định 50,000 VND
        }
    }
}