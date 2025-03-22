// AdminController.java
package com.qlcc.controller;

import com.qlcc.model.User;
import com.qlcc.model.Role;
import com.qlcc.service.UserService;
import com.qlcc.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private RoleService roleService;
    
    @GetMapping("/dashboard")
    public String showDashboard(Model model) {
        model.addAttribute("title", "Admin Dashboard");
        return "admin/dashboard";
    }
    
    @GetMapping("/users")
    public String listUsers(Model model) {
        model.addAttribute("users", userService.getAllUsers());
        return "admin/users";
    }
    
    @GetMapping("/users/add")
    public String showAddUserForm(Model model) {
        model.addAttribute("user", new User());
        model.addAttribute("roles", roleService.getAllRoles());
        return "admin/user-form";
    }
    
    @PostMapping("/users/add")
    public String addUser(@ModelAttribute User user, RedirectAttributes redirectAttributes) {
        boolean result = userService.addUser(user);
        if (result) {
            redirectAttributes.addFlashAttribute("success", "Thêm người dùng thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Thêm người dùng thất bại!");
        }
        return "redirect:/admin/users";
    }
    
    @GetMapping("/users/edit/{id}")
    public String showEditUserForm(@PathVariable("id") int userId, Model model) {
        User user = userService.getUserById(userId);
        if (user == null) {
            return "redirect:/admin/users";
        }
        model.addAttribute("user", user);
        model.addAttribute("roles", roleService.getAllRoles());
        return "admin/user-form";
    }
    
    @PostMapping("/users/edit/{id}")
    public String updateUser(@PathVariable("id") int userId, @ModelAttribute User user, RedirectAttributes redirectAttributes) {
        user.setUserId(userId);
        boolean result = userService.updateUser(user);
        if (result) {
            redirectAttributes.addFlashAttribute("success", "Cập nhật người dùng thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Cập nhật người dùng thất bại!");
        }
        return "redirect:/admin/users";
    }
    
    @GetMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable("id") int userId, RedirectAttributes redirectAttributes) {
        boolean result = userService.deleteUser(userId);
        if (result) {
            redirectAttributes.addFlashAttribute("success", "Xóa người dùng thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Xóa người dùng thất bại!");
        }
        return "redirect:/admin/users";
    }
    
    @GetMapping("/apartments")
    public String listApartments() {
        return "admin/apartments";
    }
    
    @GetMapping("/requests")
    public String listRequests() {
        return "admin/requests";
    }
    
    @GetMapping("/service-fees")
    public String listServiceFees() {
        return "admin/service-fees";
    }
    
    @GetMapping("/parking")
    public String listParking() {
        return "admin/parking";
    }
    
    @GetMapping("/reports")
    public String showReports() {
        return "admin/reports";
    }
}