// ParkingRegistrationController.java
package com.qlcc.controller;

import com.qlcc.model.ParkingRegistration;
import com.qlcc.model.User;
import com.qlcc.service.ApartmentService;
import com.qlcc.service.ParkingRegistrationService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.List;

@Controller
@RequestMapping("/parking")
public class ParkingRegistrationController {
    
    @Autowired
    private ParkingRegistrationService parkingService;
    
    @Autowired
    private ApartmentService apartmentService;
    
    @GetMapping("/list")
    public String listParkingRegistrations(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        List<ParkingRegistration> registrations;
        
        String role = user.getRole().getRoleName();
        if (role.equals("ADMIN") || role.equals("MANAGER")) {
            registrations = parkingService.getAllParkingRegistrations();
        } else {
            // Chủ căn hộ hoặc người thuê
            int apartmentId = parkingService.getApartmentIdByUser(user.getUserId());
            registrations = parkingService.getParkingRegistrationsByApartment(apartmentId);
        }
        
        model.addAttribute("registrations", registrations);
        return "parking/list";
    }
    
    @GetMapping("/view/{id}")
    public String viewParkingRegistration(@PathVariable("id") int parkingId, Model model) {
        ParkingRegistration registration = parkingService.getParkingRegistrationById(parkingId);
        if (registration == null) {
            return "redirect:/parking/list";
        }
        model.addAttribute("registration", registration);
        return "parking/view";
    }
    
    @GetMapping("/create")
    public String showCreateForm(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        int apartmentId = parkingService.getApartmentIdByUser(user.getUserId());
        
        if (apartmentId == -1) {
            return "redirect:/parking/list";
        }
        
        ParkingRegistration registration = new ParkingRegistration();
        registration.setRequesterId(user.getUserId());
        registration.setApartmentId(apartmentId);
        
        model.addAttribute("registration", registration);
        model.addAttribute("apartment", apartmentService.getApartmentById(apartmentId));
        model.addAttribute("vehicleTypes", new String[]{"Ô tô", "Xe máy", "Xe đạp"});
        return "parking/form";
    }
    
    @PostMapping("/create")
    public String createParkingRegistration(@ModelAttribute ParkingRegistration registration, HttpSession session, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        registration.setRequesterId(user.getUserId());
        
        boolean result = parkingService.createParkingRegistration(registration);
        if (result) {
            redirectAttributes.addFlashAttribute("success", "Đăng ký gửi xe thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Đăng ký gửi xe thất bại!");
        }
        
        return "redirect:/parking/list";
    }
    
    @GetMapping("/update/{id}")
    public String showUpdateForm(@PathVariable("id") int parkingId, HttpSession session, Model model) {
        ParkingRegistration registration = parkingService.getParkingRegistrationById(parkingId);
        if (registration == null) {
            return "redirect:/parking/list";
        }
        
        User user = (User) session.getAttribute("user");
        String role = user.getRole().getRoleName();
        
        // Chỉ admin, manager hoặc người tạo yêu cầu mới có thể cập nhật
        if (!role.equals("ADMIN") && !role.equals("MANAGER") && registration.getRequesterId() != user.getUserId()) {
            return "redirect:/parking/view/" + parkingId;
        }
        
        model.addAttribute("registration", registration);
        model.addAttribute("apartment", apartmentService.getApartmentById(registration.getApartmentId()));
        model.addAttribute("vehicleTypes", new String[]{"Ô tô", "Xe máy", "Xe đạp"});
        return "parking/form";
    }
    
    @PostMapping("/update/{id}")
    public String updateParkingRegistration(@PathVariable("id") int parkingId, @ModelAttribute ParkingRegistration registration, RedirectAttributes redirectAttributes) {
        registration.setParkingId(parkingId);
        boolean result = parkingService.updateParkingRegistration(registration);
        if (result) {
            redirectAttributes.addFlashAttribute("success", "Cập nhật đăng ký gửi xe thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Cập nhật đăng ký gửi xe thất bại!");
        }
        
        return "redirect:/parking/view/" + parkingId;
    }
    
    @GetMapping("/cancel/{id}")
    public String cancelParkingRegistration(@PathVariable("id") int parkingId, RedirectAttributes redirectAttributes) {
        boolean result = parkingService.cancelParkingRegistration(parkingId);
        
        if (result) {
            redirectAttributes.addFlashAttribute("success", "Đã hủy đăng ký gửi xe thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Hủy đăng ký gửi xe thất bại!");
        }
        
        return "redirect:/parking/list";
    }
}