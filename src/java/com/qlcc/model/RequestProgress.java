// RequestProgress.java
package com.qlcc.model;

import java.util.Date;

public class RequestProgress {
    private int progressId;
    private int requestId;
    private String status;
    private Date updateDate;
    private int updatedBy;
    private String notes;
    
    // Đối tượng quan hệ
    private Request request;
    private User updater;
    
    // Constructors
    public RequestProgress() {
        this.updateDate = new Date();
    }
    
    // Getters and Setters
    public int getProgressId() {
        return progressId;
    }
    
    public void setProgressId(int progressId) {
        this.progressId = progressId;
    }
    
    public int getRequestId() {
        return requestId;
    }
    
    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Date getUpdateDate() {
        return updateDate;
    }
    
    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }
    
    public int getUpdatedBy() {
        return updatedBy;
    }
    
    public void setUpdatedBy(int updatedBy) {
        this.updatedBy = updatedBy;
    }
    
    public String getNotes() {
        return notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
    }
    
    public Request getRequest() {
        return request;
    }
    
    public void setRequest(Request request) {
        this.request = request;
        if (request != null) {
            this.requestId = request.getRequestId();
        }
    }
    
    public User getUpdater() {
        return updater;
    }
    
    public void setUpdater(User updater) {
        this.updater = updater;
        if (updater != null) {
            this.updatedBy = updater.getUserId();
        }
    }
}