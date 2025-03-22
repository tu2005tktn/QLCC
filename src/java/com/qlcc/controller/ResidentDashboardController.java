// ResidentDashboardController.java
package com.qlcc.controller;

import com.qlcc.model.Request;
import com.qlcc.model.ServiceFee;
import com.qlcc.model.User;
import com.qlcc.service.ApartmentService;
import com.qlcc.service.RequestService;
import com.qlcc.service.ServiceFeeService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Controller
@RequestMapping("/resident")
public class ResidentDashboardController {
    
    @Autowired
    private RequestService requestService;
    
    @Autowired
    private ServiceFeeService serviceFeeService;
    
    @Autowired
    private ApartmentService apartmentService;
    
    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        int apartmentId = requestService.getApartmentIdByUser(user.getUserId());
        
        if (apartmentId == -1) {
            return "redirect:/login";
        }
        
        // Lấy thông tin căn hộ
        model.addAttribute("apartment", apartmentService.getApartmentById(apartmentId));
        
        // Lấy danh sách yêu cầu gần đây
        List<Request> recentRequests = requestService.getRecentRequestsByApartment(apartmentId, 5);
        model.addAttribute("recentRequests", recentRequests);
        
        // Lấy danh sách phí dịch vụ chưa thanh toán
        List<ServiceFee> unpaidFees = serviceFeeService.getUnpaidServiceFeesByApartment(apartmentId);
        model.addAttribute("unpaidFees", unpaidFees);
        
        return "resident/dashboard";
    }
    
    @GetMapping("/requests")
    public String listRequests(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        int apartmentId = requestService.getApartmentIdByUser(user.getUserId());
        
        if (apartmentId == -1) {
            return "redirect:/login";
        }
        
        List<Request> requests = requestService.getRequestsByApartment(apartmentId);
        model.addAttribute("requests", requests);
        return "resident/requests";
    }
    
    @GetMapping("/service-fees")
    public String listServiceFees(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        int apartmentId = requestService.getApartmentIdByUser(user.getUserId());
        
        if (apartmentId == -1) {
            return "redirect:/login";
        }
        
        List<ServiceFee> serviceFees = serviceFeeService.getServiceFeesByApartment(apartmentId);
        model.addAttribute("serviceFees", serviceFees);
        model.addAttribute("apartment", apartmentService.getApartmentById(apartmentId));
        return "resident/service-fees";
    }
    
    @GetMapping("/profile")
    public String showProfile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        model.addAttribute("user", user);
        return "resident/profile";
    }
    
    @PostMapping("/profile")
    public String updateProfile(@ModelAttribute User user, HttpSession session) {
        // Cập nhật thông tin cá nhân của cư dân
        User currentUser = (User) session.getAttribute("user");
        user.setUserId(currentUser.getUserId());
        user.setRoleId(currentUser.getRoleId());
        
        // TODO: Cập nhật thông tin người dùng
        
        return "redirect:/resident/profile";
    }
    
    @GetMapping("/change-password")
    public String showChangePasswordForm() {
        return "resident/change-password";
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
        
        return "redirect:/resident/profile";
    }
}