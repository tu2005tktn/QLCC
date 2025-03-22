// RequestType.java
package com.qlcc.model;

public class RequestType {
    private int requestTypeId;
    private String typeName;
    private String description;
    
    // Constructors
    public RequestType() {}
    
    public RequestType(int requestTypeId) {
        this.requestTypeId = requestTypeId;
    }
    
    public RequestType(int requestTypeId, String typeName, String description) {
        this.requestTypeId = requestTypeId;
        this.typeName = typeName;
        this.description = description;
    }
    
    // Getters and Setters
    public int getRequestTypeId() {
        return requestTypeId;
    }
    
    public void setRequestTypeId(int requestTypeId) {
        this.requestTypeId = requestTypeId;
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
    
    @Override
    public String toString() {
        return typeName;
    }
}