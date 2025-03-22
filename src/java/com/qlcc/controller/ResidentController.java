// ResidentController.java
package com.qlcc.controller;

import com.qlcc.model.Resident;
import com.qlcc.model.User;
import com.qlcc.service.ApartmentService;
import com.qlcc.service.ResidentService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.List;

@Controller
@RequestMapping("/residents")
public class ResidentController {
    
    @Autowired
    private ResidentService residentService;
    
    @Autowired
    private ApartmentService apartmentService;
    
    @GetMapping("/list")
    public String listResidents(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        List<Resident> residents;
        
        String role = user.getRole().getRoleName();
        if (role.equals("ADMIN") || role.equals("MANAGER")) {
            residents = residentService.getAllResidents();
            model.addAttribute("isAdminOrManager", true);
        } else {
            // Chủ căn hộ hoặc người thuê
            int apartmentId = residentService.getApartmentIdByUser(user.getUserId());
            residents = residentService.getResidentsByApartment(apartmentId);
            model.addAttribute("isAdminOrManager", false);
            model.addAttribute("apartment", apartmentService.getApartmentById(apartmentId));
        }
        
        model.addAttribute("residents", residents);
        return "residents/list";
    }
    
    @GetMapping("/view/{id}")
    public String viewResident(@PathVariable("id") int residentId, Model model) {
        Resident resident = residentService.getResidentById(residentId);
        if (resident == null) {
            return "redirect:/residents/list";
        }
        model.addAttribute("resident", resident);
        model.addAttribute("apartment", apartmentService.getApartmentById(resident.getApartmentId()));
        return "residents/view";
    }
    
    @GetMapping("/add")
    public String showAddResidentForm(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        String role = user.getRole().getRoleName();
        
        Resident resident = new Resident();
        
        if (role.equals("ADMIN") || role.equals("MANAGER")) {
            model.addAttribute("apartments", apartmentService.getAllApartments());
        } else {
            int apartmentId = residentService.getApartmentIdByUser(user.getUserId());
            if (apartmentId == -1) {
                return "redirect:/residents/list";
            }
            resident.setApartmentId(apartmentId);
            model.addAttribute("apartment", apartmentService.getApartmentById(apartmentId));
        }
        
        model.addAttribute("resident", resident);
        model.addAttribute("genders", new String[]{"Nam", "Nữ", "Khác"});
        model.addAttribute("relationships", new String[]{"Chủ hộ", "Vợ/Chồng", "Con", "Bố/Mẹ", "Anh/Chị/Em", "Khác"});
        return "residents/form";
    }
    
    @PostMapping("/add")
    public String addResident(@ModelAttribute Resident resident, RedirectAttributes redirectAttributes) {
        boolean result = residentService.addResident(resident);
        if (result) {
            redirectAttributes.addFlashAttribute("success", "Thêm cư dân thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Thêm cư dân thất bại!");
        }
        return "redirect:/residents/list";
    }
    
    @GetMapping("/edit/{id}")
    public String showEditResidentForm(@PathVariable("id") int residentId, HttpSession session, Model model) {
        Resident resident = residentService.getResidentById(residentId);
        if (resident == null) {
            return "redirect:/residents/list";
        }
        
        User user = (User) session.getAttribute("user");
        String role = user.getRole().getRoleName();
        
        if (role.equals("ADMIN") || role.equals("MANAGER")) {
            model.addAttribute("apartments", apartmentService.getAllApartments());
        } else {
            int apartmentId = residentService.getApartmentIdByUser(user.getUserId());
            if (apartmentId == -1 || apartmentId != resident.getApartmentId()) {
                return "redirect:/residents/list";
            }
            model.addAttribute("apartment", apartmentService.getApartmentById(apartmentId));
        }
        
        model.addAttribute("resident", resident);
        model.addAttribute("genders", new String[]{"Nam", "Nữ", "Khác"});
        model.addAttribute("relationships", new String[]{"Chủ hộ", "Vợ/Chồng", "Con", "Bố/Mẹ", "Anh/Chị/Em", "Khác"});
        return "residents/form";
    }
    
    @PostMapping("/edit/{id}")
    public String updateResident(@PathVariable("id") int residentId, @ModelAttribute Resident resident, RedirectAttributes redirectAttributes) {
        resident.setResidentId(residentId);
        boolean result = residentService.updateResident(resident);
        if (result) {
            redirectAttributes.addFlashAttribute("success", "Cập nhật cư dân thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Cập nhật cư dân thất bại!");
        }
        return "redirect:/residents/view/" + residentId;
    }
    
    @GetMapping("/delete/{id}")
    public String deleteResident(@PathVariable("id") int residentId, RedirectAttributes redirectAttributes) {
        boolean result = residentService.deleteResident(residentId);
        if (result) {
            redirectAttributes.addFlashAttribute("success", "Xóa cư dân thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Xóa cư dân thất bại!");
        }
        return "redirect:/residents/list";
    }
}