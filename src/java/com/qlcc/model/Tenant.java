// Tenant.java
package com.qlcc.model;

import java.util.Date;

public class Tenant {
    private int tenantId;
    private int userId;
    private int apartmentId;
    private Date rentalStartDate;
    private Date rentalEndDate;
    private boolean isRepresentative;
    
    // Đối tượng quan hệ
    private User user;
    private Apartment apartment;
    
    // Constructors
    public Tenant() {
        this.isRepresentative = true;
    }
    
    // Getters and Setters
    public int getTenantId() {
        return tenantId;
    }
    
    public void setTenantId(int tenantId) {
        this.tenantId = tenantId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public int getApartmentId() {
        return apartmentId;
    }
    
    public void setApartmentId(int apartmentId) {
        this.apartmentId = apartmentId;
    }
    
    public Date getRentalStartDate() {
        return rentalStartDate;
    }
    
    public void setRentalStartDate(Date rentalStartDate) {
        this.rentalStartDate = rentalStartDate;
    }
    
    public Date getRentalEndDate() {
        return rentalEndDate;
    }
    
    public void setRentalEndDate(Date rentalEndDate) {
        this.rentalEndDate = rentalEndDate;
    }
    
    public boolean isRepresentative() {
        return isRepresentative;
    }
    
    public void setRepresentative(boolean representative) {
        isRepresentative = representative;
    }
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
        if (user != null) {
            this.userId = user.getUserId();
        }
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
}