// Apartment.java
package com.qlcc.model;

public class Apartment {
    private int apartmentId;
    private String apartmentNumber;
    private int floorNumber;
    private double area;
    private String status;
    
    // Constructors
    public Apartment() {}
    
    public Apartment(int apartmentId) {
        this.apartmentId = apartmentId;
    }
    
    // Getters and Setters
    public int getApartmentId() {
        return apartmentId;
    }
    
    public void setApartmentId(int apartmentId) {
        this.apartmentId = apartmentId;
    }
    
    public String getApartmentNumber() {
        return apartmentNumber;
    }
    
    public void setApartmentNumber(String apartmentNumber) {
        this.apartmentNumber = apartmentNumber;
    }
    
    public int getFloorNumber() {
        return floorNumber;
    }
    
    public void setFloorNumber(int floorNumber) {
        this.floorNumber = floorNumber;
    }
    
    public double getArea() {
        return area;
    }
    
    public void setArea(double area) {
        this.area = area;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
}