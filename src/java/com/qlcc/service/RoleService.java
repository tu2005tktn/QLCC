// RoleService.java
package com.qlcc.service;

import com.qlcc.dao.RoleDAO;
import com.qlcc.model.Role;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RoleService {
    
    @Autowired
    private RoleDAO roleDAO;
    
    public List<Role> getAllRoles() {
        return roleDAO.getAllRoles();
    }
    
    public Role getRoleById(int roleId) {
        return roleDAO.getRoleById(roleId);
    }
    
    public boolean addRole(Role role) {
        return roleDAO.addRole(role);
    }
    
    public boolean updateRole(Role role) {
        return roleDAO.updateRole(role);
    }
    
    public boolean deleteRole(int roleId) {
        return roleDAO.deleteRole(roleId);
    }
}