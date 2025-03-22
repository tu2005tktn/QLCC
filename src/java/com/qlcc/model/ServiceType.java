// ServiceType.java
package com.qlcc.model;

public class ServiceType {
    private int serviceTypeId;
    private String typeName;
    private String description;
    
    // Constructors
    public ServiceType() {}
    
    // Getters and Setters
    public int getServiceTypeId() {
        return serviceTypeId;
    }
    
    public void setServiceTypeId(int serviceTypeId) {
        this.serviceTypeId = serviceTypeId;
    }
    
    public String getTypeName() {
        return typeName;
    }
    
    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
}