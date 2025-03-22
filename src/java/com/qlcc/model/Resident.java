// Resident.java
package com.qlcc.model;

import java.util.Date;

public class Resident {
    private int residentId;
    private int apartmentId;
    private String fullName;
    private Date dob;
    private String gender;
    private String idCard;
    private String relationship;
    private String phone;
    
    // Đối tượng quan hệ
    private Apartment apartment;
    
    // Constructors
    public Resident() {}
    
    // Getters and Setters
    public int getResidentId() {
        return residentId;
    }
    
    public void setResidentId(int residentId) {
        this.residentId = residentId;
    }
    
    public int getApartmentId() {
        return apartmentId;
    }
    
    public void setApartmentId(int apartmentId) {
        this.apartmentId = apartmentId;
    }
    
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    
    public Date getDob() {
        return dob;
    }
    
    public void setDob(Date dob) {
        this.dob = dob;
    }
    
    public String getGender() {
        return gender;
    }
    
    public void setGender(String gender) {
        this.gender = gender;
    }
    
    public String getIdCard() {
        return idCard;
    }
    
    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }
    
    public String getRelationship() {
        return relationship;
    }
    
    public void setRelationship(String relationship) {
        this.relationship = relationship;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
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