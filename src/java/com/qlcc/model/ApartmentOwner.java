// ApartmentOwner.java
package com.qlcc.model;

import java.util.Date;

public class ApartmentOwner {
    private int ownerId;
    private int userId;
    private int apartmentId;
    private Date ownershipDate;
    
    // Đối tượng quan hệ
    private User user;
    private Apartment apartment;
    
    // Constructors
    public ApartmentOwner() {}
    
    // Getters and Setters
    public int getOwnerId() {
        return ownerId;
    }
    
    public void setOwnerId(int ownerId) {
        this.ownerId = ownerId;
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
    
    public Date getOwnershipDate() {
        return ownershipDate;
    }
    
    public void setOwnershipDate(Date ownershipDate) {
        this.ownershipDate = ownershipDate;
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