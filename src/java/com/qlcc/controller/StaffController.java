// StaffController.java
package com.qlcc.controller;

import com.qlcc.model.Request;
import com.qlcc.model.User;
import com.qlcc.service.RequestService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Controller
@RequestMapping("/staff")
public class StaffController {
    
    @Autowired
    private RequestService requestService;
    
    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        
        // Đếm số yêu cầu đang xử lý
        int processingRequestCount = requestService.getRequestCountByStaffAndStatus(user.getUserId(), "Đang xử lý");
        model.addAttribute("processingRequestCount", processingRequestCount);
        
        // Lấy danh sách các yêu cầu đang được giao
        List<Request> assignedRequests = requestService.getRequestsByStaffAndStatus(user.getUserId(), "Đang xử lý");
        model.addAttribute("assignedRequests", assignedRequests);
        
        // Lấy danh sách các yêu cầu gần đây đã hoàn thành
        List<Request> completedRequests = requestService.getRequestsByStaffAndStatus(user.getUserId(), "Hoàn thành");
        model.addAttribute("completedRequests", completedRequests);
        
        return "staff/dashboard";
    }
    
    @GetMapping("/requests")
    public String listAssignedRequests(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        List<Request> assignedRequests = requestService.getRequestsByStaff(user.getUserId());
        model.addAttribute("requests", assignedRequests);
        return "staff/requests";
    }
    
    @GetMapping("/profile")
    public String showProfile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        model.addAttribute("user", user);
        return "staff/profile";
    }
    
    @PostMapping("/profile")
    public String updateProfile(@ModelAttribute User user, HttpSession session) {
        // Cập nhật thông tin cá nhân của nhân viên
        User currentUser = (User) session.getAttribute("user");
        user.setUserId(currentUser.getUserId());
        user.setRoleId(currentUser.getRoleId());
        
        // TODO: Cập nhật thông tin người dùng
        
        return "redirect:/staff/profile";
    }
    
    @GetMapping("/change-password")
    public String showChangePasswordForm() {
        return "staff/change-password";
    }
    
    @PostMapping("/change-password")
    public String changePassword(
            @RequestParam("currentPassword") String currentPassword,
            @RequestParam("newPassword") String newPassword,
            @RequestParam("confirmPassword") String confirmPassword,
            HttpSession session,
            Model model) {
        
        User user = (User) session.getAttribute("user");
        
        // TODO: Thực hiện đổi mật khẩu
        
        return "redirect:/staff/profile";
    }
}