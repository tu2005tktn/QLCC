// ParkingRegistration.java
package com.qlcc.model;

import java.math.BigDecimal;
import java.util.Date;

public class ParkingRegistration {
    private int parkingId;
    private int apartmentId;
    private int requesterId;
    private String vehicleType;
    private String licensePlate;
    private String vehicleBrand;
    private String vehicleModel;
    private String vehicleColor;
    private Date registrationDate;
    private String status;
    private BigDecimal monthlyFee;
    
    // Đối tượng quan hệ
    private Apartment apartment;
    private User requester;
    
    // Constructors
    public ParkingRegistration() {
        this.registrationDate = new Date();
        this.status = "Đang hoạt động";
    }
    
    // Getters and Setters
    public int getParkingId() {
        return parkingId;
    }
    
    public void setParkingId(int parkingId) {
        this.parkingId = parkingId;
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
    
    public String getVehicleType() {
        return vehicleType;
    }
    
    public void setVehicleType(String vehicleType) {
        this.vehicleType = vehicleType;
    }
    
    public String getLicensePlate() {
        return licensePlate;
    }
    
    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }
    
    public String getVehicleBrand() {
        return vehicleBrand;
    }
    
    public void setVehicleBrand(String vehicleBrand) {
        this.vehicleBrand = vehicleBrand;
    }
    
    public String getVehicleModel() {
        return vehicleModel;
    }
    
    public void setVehicleModel(String vehicleModel) {
        this.vehicleModel = vehicleModel;
    }
    
    public String getVehicleColor() {
        return vehicleColor;
    }
    
    public void setVehicleColor(String vehicleColor) {
        this.vehicleColor = vehicleColor;
    }
    
    public Date getRegistrationDate() {
        return registrationDate;
    }
    
    public void setRegistrationDate(Date registrationDate) {
        this.registrationDate = registrationDate;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public BigDecimal getMonthlyFee() {
        return monthlyFee;
    }
    
   public void setMonthlyFee(BigDecimal monthlyFee) {
       this.monthlyFee = monthlyFee;
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
}