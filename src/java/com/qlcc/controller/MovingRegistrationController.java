// MovingRegistrationController.java
package com.qlcc.controller;

import com.qlcc.model.MovingRegistration;
import com.qlcc.model.User;
import com.qlcc.service.ApartmentService;
import com.qlcc.service.MovingRegistrationService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.List;

@Controller
@RequestMapping("/moving")
public class MovingRegistrationController {
    
    @Autowired
    private MovingRegistrationService movingService;
    
    @Autowired
    private ApartmentService apartmentService;
    
    @GetMapping("/list")
    public String listMovingRegistrations(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        List<MovingRegistration> registrations;
        
        String role = user.getRole().getRoleName();
        if (role.equals("ADMIN") || role.equals("MANAGER")) {
            registrations = movingService.getAllMovingRegistrations();
        } else {
            // Chủ căn hộ hoặc người thuê
            int apartmentId = movingService.getApartmentIdByUser(user.getUserId());
            registrations = movingService.getMovingRegistrationsByApartment(apartmentId);
        }
        
        model.addAttribute("registrations", registrations);
        return "moving/list";
    }
    
    @GetMapping("/view/{id}")
    public String viewMovingRegistration(@PathVariable("id") int movingId, Model model) {
        MovingRegistration registration = movingService.getMovingRegistrationById(movingId);
        if (registration == null) {
            return "redirect:/moving/list";
        }
        model.addAttribute("registration", registration);
        return "moving/view";
    }
    
    @GetMapping("/create")
    public String showCreateForm(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        int apartmentId = movingService.getApartmentIdByUser(user.getUserId());
        
        if (apartmentId == -1) {
            return "redirect:/moving/list";
        }
        
        MovingRegistration registration = new MovingRegistration();
        registration.setRequesterId(user.getUserId());
        registration.setApartmentId(apartmentId);
        
        model.addAttribute("registration", registration);
        model.addAttribute("apartment", apartmentService.getApartmentById(apartmentId));
       model.addAttribute("movingTypes", new String[]{"Vào", "Ra"});
       return "moving/form";
   }
   
   @PostMapping("/create")
   public String createMovingRegistration(@ModelAttribute MovingRegistration registration, HttpSession session, RedirectAttributes redirectAttributes) {
       User user = (User) session.getAttribute("user");
       registration.setRequesterId(user.getUserId());
       
       boolean result = movingService.createMovingRegistration(registration);
       if (result) {
           redirectAttributes.addFlashAttribute("success", "Đăng ký chuyển đồ thành công!");
       } else {
           redirectAttributes.addFlashAttribute("error", "Đăng ký chuyển đồ thất bại!");
       }
       
       return "redirect:/moving/list";
   }
   
   @GetMapping("/update/{id}")
   public String showUpdateForm(@PathVariable("id") int movingId, HttpSession session, Model model) {
       MovingRegistration registration = movingService.getMovingRegistrationById(movingId);
       if (registration == null) {
           return "redirect:/moving/list";
       }
       
       User user = (User) session.getAttribute("user");
       String role = user.getRole().getRoleName();
       
       // Chỉ admin, manager hoặc người tạo yêu cầu mới có thể cập nhật
       if (!role.equals("ADMIN") && !role.equals("MANAGER") && registration.getRequesterId() != user.getUserId()) {
           return "redirect:/moving/view/" + movingId;
       }
       
       model.addAttribute("registration", registration);
       model.addAttribute("apartment", apartmentService.getApartmentById(registration.getApartmentId()));
       model.addAttribute("movingTypes", new String[]{"Vào", "Ra"});
       return "moving/form";
   }
   
   @PostMapping("/update/{id}")
   public String updateMovingRegistration(@PathVariable("id") int movingId, @ModelAttribute MovingRegistration registration, RedirectAttributes redirectAttributes) {
       registration.setMovingId(movingId);
       boolean result = movingService.updateMovingRegistration(registration);
       if (result) {
           redirectAttributes.addFlashAttribute("success", "Cập nhật đăng ký chuyển đồ thành công!");
       } else {
           redirectAttributes.addFlashAttribute("error", "Cập nhật đăng ký chuyển đồ thất bại!");
       }
       
       return "redirect:/moving/view/" + movingId;
   }
   
   @GetMapping("/approve/{id}")
   public String approveMovingRegistration(@PathVariable("id") int movingId, HttpSession session, RedirectAttributes redirectAttributes) {
       User manager = (User) session.getAttribute("user");
       boolean result = movingService.approveMovingRegistration(movingId, manager.getUserId());
       
       if (result) {
           redirectAttributes.addFlashAttribute("success", "Đã phê duyệt đăng ký chuyển đồ!");
       } else {
           redirectAttributes.addFlashAttribute("error", "Phê duyệt đăng ký chuyển đồ thất bại!");
       }
       
       return "redirect:/moving/view/" + movingId;
   }
   
   @GetMapping("/reject/{id}")
   public String rejectMovingRegistration(@PathVariable("id") int movingId, HttpSession session, RedirectAttributes redirectAttributes) {
       User manager = (User) session.getAttribute("user");
       boolean result = movingService.rejectMovingRegistration(movingId, manager.getUserId());
       
       if (result) {
           redirectAttributes.addFlashAttribute("success", "Đã từ chối đăng ký chuyển đồ!");
       } else {
           redirectAttributes.addFlashAttribute("error", "Từ chối đăng ký chuyển đồ thất bại!");
       }
       
       return "redirect:/moving/view/" + movingId;
   }
   
   @GetMapping("/cancel/{id}")
   public String cancelMovingRegistration(@PathVariable("id") int movingId, HttpSession session, RedirectAttributes redirectAttributes) {
       User user = (User) session.getAttribute("user");
       boolean result = movingService.cancelMovingRegistration(movingId);
       
       if (result) {
           redirectAttributes.addFlashAttribute("success", "Đã hủy đăng ký chuyển đồ thành công!");
       } else {
           redirectAttributes.addFlashAttribute("error", "Hủy đăng ký chuyển đồ thất bại!");
       }
       
       return "redirect:/moving/list";
   }
}