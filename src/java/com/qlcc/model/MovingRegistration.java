// MovingRegistration.java
package com.qlcc.model;

import java.util.Date;
import java.sql.Time;

public class MovingRegistration {
    private int movingId;
    private int apartmentId;
    private int requesterId;
    private String movingType;
    private Date movingDate;
    private Time movingTimeStart;
    private Time movingTimeEnd;
    private String itemsDescription;
    private String status;
    private Date approvalDate;
    private Integer approvedBy;
    
    // Đối tượng quan hệ
    private Apartment apartment;
    private User requester;
    private User approver;
    
    // Constructors
    public MovingRegistration() {
        this.status = "Đang chờ phê duyệt";
    }
    
    // Getters and Setters
    public int getMovingId() {
        return movingId;
    }
    
    public void setMovingId(int movingId) {
        this.movingId = movingId;
    }
    
    public int getApartmentId() {
        return apartmentId;
    }
    
    public void setApartmentId(int apartmentId) {
        this.apartmentId = apartmentId;
    }
    
    public int getRequesterId() {
        return requesterId;
    }
    
    public void setRequesterId(int requesterId) {
        this.requesterId = requesterId;
    }
    
    public String getMovingType() {
        return movingType;
    }
    
    public void setMovingType(String movingType) {
        this.movingType = movingType;
    }
    
    public Date getMovingDate() {
        return movingDate;
    }
    
    public void setMovingDate(Date movingDate) {
        this.movingDate = movingDate;
    }
    
    public Time getMovingTimeStart() {
        return movingTimeStart;
    }
    
    public void setMovingTimeStart(Time movingTimeStart) {
        this.movingTimeStart = movingTimeStart;
    }
    
    public Time getMovingTimeEnd() {
        return movingTimeEnd;
    }
    
    public void setMovingTimeEnd(Time movingTimeEnd) {
        this.movingTimeEnd = movingTimeEnd;
    }
    
    public String getItemsDescription() {
        return itemsDescription;
    }
    
    public void setItemsDescription(String itemsDescription) {
        this.itemsDescription = itemsDescription;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Date getApprovalDate() {
        return approvalDate;
    }
    
    public void setApprovalDate(Date approvalDate) {
        this.approvalDate = approvalDate;
    }
    
    public Integer getApprovedBy() {
        return approvedBy;
    }
    
    public void setApprovedBy(Integer approvedBy) {
        this.approvedBy = approvedBy;
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
    
    public User getRequester() {
        return requester;
    }
    
    public void setRequester(User requester) {
        this.requester = requester;
        if (requester != null) {
            this.requesterId = requester.getUserId();
        }
    }
    
    public User getApprover() {
        return approver;
    }
    
    public void setApprover(User approver) {
        this.approver = approver;
        if (approver != null) {
            this.approvedBy = approver.getUserId();
        }
    }
}