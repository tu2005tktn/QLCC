// Role.java
package com.qlcc.model;

public class Role {
    private int roleId;
    private String roleName;
    
    // Constructors
    public Role() {}
    
    public Role(int roleId) {
        this.roleId = roleId;
    }
    
    public Role(int roleId, String roleName) {
        this.roleId = roleId;
        this.roleName = roleName;
    }
    
    // Getters and Setters
    public int getRoleId() {
        return roleId;
    }
    
    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }
    
    public String getRoleName() {
        return roleName;
    }
    
    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
    
    @Override
    public String toString() {
        return roleName;
    }
}