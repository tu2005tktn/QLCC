// Request.java
package com.qlcc.model;

import java.util.Date;

public class Request {
    private int requestId;
    private int apartmentId;
    private int requesterId;
    private int requestTypeId;
    private String title;
    private String description;
    private Date requestDate;
    private String status;
    private String priority;
    
    // Đối tượng quan hệ
    private Apartment apartment;
    private User requester;
    private RequestType requestType;
    
    // Constructors
    public Request() {
        this.requestDate = new Date();
        this.status = "Đang chờ xử lý";
        this.priority = "Bình thường";
    }
    
    // Getters and Setters
    public int getRequestId() {
        return requestId;
    }
    
    public void setRequestId(int requestId) {
        this.requestId = requestId;
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
    
    public int getRequestTypeId() {
        return requestTypeId;
    }
    
    public void setRequestTypeId(int requestTypeId) {
        this.requestTypeId = requestTypeId;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public Date getRequestDate() {
        return requestDate;
    }
    
    public void setRequestDate(Date requestDate) {
        this.requestDate = requestDate;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getPriority() {
        return priority;
    }
    
    public void setPriority(String priority) {
        this.priority = priority;
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
    
    public RequestType getRequestType() {
        return requestType;
    }
    
    public void setRequestType(RequestType requestType) {
        this.requestType = requestType;
        if (requestType != null) {
            this.requestTypeId = requestType.getRequestTypeId();
        }
    }
}