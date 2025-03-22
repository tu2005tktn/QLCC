// UserService.java
package com.qlcc.service;

import com.qlcc.dao.UserDAO;
import com.qlcc.model.User;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    
    @Autowired
    private UserDAO userDAO;
    
    public User authenticate(String username, String password) {
        return userDAO.authenticate(username, password);
    }
    
    public User getUserById(int userId) {
        return userDAO.getUserById(userId);
    }
    
    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }
    
    public List<User> getUsersByRole(String roleName) {
        return userDAO.getUsersByRole(roleName);
    }
    
    public boolean addUser(User user) {
        return userDAO.addUser(user);
    }
    
    public boolean updateUser(User user) {
        return userDAO.updateUser(user);
    }
    
    public boolean changePassword(int userId, String currentPassword, String newPassword) {
        // Kiểm tra mật khẩu hiện tại
        User user = userDAO.getUserById(userId);
        if (user != null && user.getPassword().equals(currentPassword)) {
            return userDAO.changePassword(userId, newPassword);
        }
        return false;
    }
    
    public boolean deleteUser(int userId) {
        return userDAO.deleteUser(userId);
    }
}