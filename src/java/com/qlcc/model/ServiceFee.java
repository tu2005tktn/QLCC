// ServiceFee.java
package com.qlcc.model;

import java.math.BigDecimal;
import java.util.Date;

public class ServiceFee {
    private int feeId;
    private int apartmentId;
    private int serviceTypeId;
    private int month;
    private int year;
    private BigDecimal amount;
    private String status;
    private Date issueDate;
    private Date paymentDate;
    private String details;
    
    // Đối tượng quan hệ
    private Apartment apartment;
    private ServiceType serviceType;
    
    // Constructors
    public ServiceFee() {
        this.status = "Chưa thanh toán";
        this.issueDate = new Date();
    }
    
    // Getters and Setters
    public int getFeeId() {
        return feeId;
    }
    
    public void setFeeId(int feeId) {
        this.feeId = feeId;
    }
    
    public int getApartmentId() {
        return apartmentId;
    }
    
    public void setApartmentId(int apartmentId) {
        this.apartmentId = apartmentId;
    }
    
    public int getServiceTypeId() {
        return serviceTypeId;
    }
    
    public void setServiceTypeId(int serviceTypeId) {
        this.serviceTypeId = serviceTypeId;
    }
    
    public int getMonth() {
        return month;
    }
    
    public void setMonth(int month) {
        this.month = month;
    }
    
    public int getYear() {
        return year;
    }
    
    public void setYear(int year) {
        this.year = year;
    }
    
    public BigDecimal getAmount() {
        return amount;
    }
    
    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Date getIssueDate() {
        return issueDate;
    }
    
    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }
    
    public Date getPaymentDate() {
        return paymentDate;
    }
    
    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }
    
    public String getDetails() {
        return details;
    }
    
    public void setDetails(String details) {
        this.details = details;
    }
    
    public Apartment getApartment() {
        return apartment;
    }
    
    public void setApartment(Apartment apartment) {
        this.apartment = apartment;
        if (apartment != null) {
            this.apartmentId = apartment.getApartmentId();
        }
    }
    
    public ServiceType getServiceType() {
        return serviceType;
    }
    
    public void setServiceType(ServiceType serviceType) {
        this.serviceType = serviceType;
        if (serviceType != null) {
            this.serviceTypeId = serviceType.getServiceTypeId();
        }
    }
}