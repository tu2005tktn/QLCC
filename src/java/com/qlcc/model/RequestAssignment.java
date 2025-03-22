// RequestAssignment.java
package com.qlcc.model;

import java.util.Date;

public class RequestAssignment {
    private int assignmentId;
    private int requestId;
    private int staffId;
    private int assignedBy;
    private Date assignedDate;
    private Date deadline;
    private String notes;
    
    // Đối tượng quan hệ
    private Request request;
    private User staff;
    private User manager;
    
    // Constructors
    public RequestAssignment() {
        this.assignedDate = new Date();
    }
    
    // Getters and Setters
    public int getAssignmentId() {
        return assignmentId;
    }
    
    public void setAssignmentId(int assignmentId) {
        this.assignmentId = assignmentId;
    }
    
    public int getRequestId() {
        return requestId;
    }
    
    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }
    
    public int getStaffId() {
        return staffId;
    }
    
    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }
    
    public int getAssignedBy() {
        return assignedBy;
    }
    
    public void setAssignedBy(int assignedBy) {
        this.assignedBy = assignedBy;
    }
    
    public Date getAssignedDate() {
        return assignedDate;
    }
    
    public void setAssignedDate(Date assignedDate) {
        this.assignedDate = assignedDate;
    }
    
    public Date getDeadline() {
        return deadline;
    }
    
    public void setDeadline(Date deadline) {
        this.deadline = deadline;
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
    
    public User getStaff() {
        return staff;
    }
    
    public void setStaff(User staff) {
        this.staff = staff;
        if (staff != null) {
            this.staffId = staff.getUserId();
        }
    }
    
    public User getManager() {
        return manager;
    }
    
    public void setManager(User manager) {
        this.manager = manager;
        if (manager != null) {
            this.assignedBy = manager.getUserId();
        }
    }
}