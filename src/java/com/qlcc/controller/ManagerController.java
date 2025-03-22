// ManagerController.java
package com.qlcc.controller;

import com.qlcc.model.Request;
import com.qlcc.model.MovingRegistration;
import com.qlcc.model.User;
import com.qlcc.service.RequestService;
import com.qlcc.service.MovingRegistrationService;
import com.qlcc.service.ApartmentService;
import com.qlcc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Controller
@RequestMapping("/manager")
public class ManagerController {
    
    @Autowired
    private RequestService requestService;
    
    @Autowired
    private MovingRegistrationService movingService;
    
    @Autowired
    private ApartmentService apartmentService;
    
    @Autowired
    private UserService userService;
    
    @GetMapping("/dashboard")
    public String showDashboard(Model model) {
        // Đếm số lượng căn hộ
        int apartmentCount = apartmentService.getApartmentCount();
        model.addAttribute("apartmentCount", apartmentCount);
        
        // Đếm số yêu cầu đang chờ xử lý
        int pendingRequestCount = requestService.getRequestCountByStatus("Đang chờ xử lý");
        model.addAttribute("pendingRequestCount", pendingRequestCount);
        
        // Đếm số đăng ký chuyển đồ đang chờ phê duyệt
        int pendingMovingCount = movingService.getMovingRegistrationCountByStatus("Đang chờ phê duyệt");
        model.addAttribute("pendingMovingCount", pendingMovingCount);
        
        // Lấy danh sách các yêu cầu gần đây
        List<Request> recentRequests = requestService.getRecentRequests(5);
        model.addAttribute("recentRequests", recentRequests);
        
        // Lấy danh sách các đăng ký chuyển đồ gần đây
        List<MovingRegistration> recentMovings = movingService.getRecentMovingRegistrations(5);
        model.addAttribute("recentMovings", recentMovings);
        
        return "manager/dashboard";
    }
    
    @GetMapping("/pending-requests")
    public String showPendingRequests(Model model) {
        List<Request> pendingRequests = requestService.getRequestsByStatus("Đang chờ xử lý");
        model.addAttribute("requests", pendingRequests);
        return "manager/pending-requests";
    }
    
    @GetMapping("/pending-movings")
    public String showPendingMovings(Model model) {
        List<MovingRegistration> pendingMovings = movingService.getMovingRegistrationsByStatus("Đang chờ phê duyệt");
        model.addAttribute("registrations", pendingMovings);
        return "manager/pending-movings";
    }
    
    @GetMapping("/staff")
    public String listStaff(Model model) {
        List<User> staffList = userService.getUsersByRole("STAFF");
        model.addAttribute("staffList", staffList);
        return "manager/staff";
    }
    
    @GetMapping("/apartments")
    public String listApartments(Model model) {
        model.addAttribute("apartments", apartmentService.getAllApartments());
        return "manager/apartments";
    }
    
    @GetMapping("/reports")
    public String showReports() {
        return "manager/reports";
    }
}