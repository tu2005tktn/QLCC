// ApartmentController.java
package com.qlcc.controller;

import com.qlcc.model.Apartment;
import com.qlcc.service.ApartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.List;

@Controller
@RequestMapping("/apartments")
public class ApartmentController {
    
    @Autowired
    private ApartmentService apartmentService;
    
    @GetMapping("/list")
    public String listApartments(Model model) {
        List<Apartment> apartments = apartmentService.getAllApartments();
        model.addAttribute("apartments", apartments);
        return "apartments/list";
    }
    
    @GetMapping("/view/{id}")
    public String viewApartment(@PathVariable("id") int apartmentId, Model model) {
        Apartment apartment = apartmentService.getApartmentById(apartmentId);
        if (apartment == null) {
            return "redirect:/apartments/list";
        }
        model.addAttribute("apartment", apartment);
        // Thêm các thông tin liên quan đến căn hộ
        model.addAttribute("residents", apartmentService.getResidentsByApartmentId(apartmentId));
        model.addAttribute("owner", apartmentService.getOwnerByApartmentId(apartmentId));
        model.addAttribute("tenant", apartmentService.getTenantByApartmentId(apartmentId));
        return "apartments/view";
    }
    
    @GetMapping("/add")
    public String showAddApartmentForm(Model model) {
        model.addAttribute("apartment", new Apartment());
        return "apartments/form";
    }
    
    @PostMapping("/add")
    public String addApartment(@ModelAttribute Apartment apartment, RedirectAttributes redirectAttributes) {
        boolean result = apartmentService.addApartment(apartment);
        if (result) {
            redirectAttributes.addFlashAttribute("success", "Thêm căn hộ thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Thêm căn hộ thất bại!");
        }
        return "redirect:/apartments/list";
    }
    
    @GetMapping("/edit/{id}")
    public String showEditApartmentForm(@PathVariable("id") int apartmentId, Model model) {
        Apartment apartment = apartmentService.getApartmentById(apartmentId);
        if (apartment == null) {
            return "redirect:/apartments/list";
        }
        model.addAttribute("apartment", apartment);
        return "apartments/form";
    }
    
    @PostMapping("/edit/{id}")
    public String updateApartment(@PathVariable("id") int apartmentId, @ModelAttribute Apartment apartment, RedirectAttributes redirectAttributes) {
        apartment.setApartmentId(apartmentId);
        boolean result = apartmentService.updateApartment(apartment);
        if (result) {
            redirectAttributes.addFlashAttribute("success", "Cập nhật căn hộ thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Cập nhật căn hộ thất bại!");
        }
        return "redirect:/apartments/list";
    }
    
    @GetMapping("/delete/{id}")
    public String deleteApartment(@PathVariable("id") int apartmentId, RedirectAttributes redirectAttributes) {
        boolean result = apartmentService.deleteApartment(apartmentId);
        if (result) {
            redirectAttributes.addFlashAttribute("success", "Xóa căn hộ thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Xóa căn hộ thất bại! Có thể có dữ liệu liên quan.");
        }
        return "redirect:/apartments/list";
    }
    
    @GetMapping("/{id}/residents")
    public String listResidents(@PathVariable("id") int apartmentId, Model model) {
        Apartment apartment = apartmentService.getApartmentById(apartmentId);
        if (apartment == null) {
            return "redirect:/apartments/list";
        }
        model.addAttribute("apartment", apartment);
        model.addAttribute("residents", apartmentService.getResidentsByApartmentId(apartmentId));
        return "apartments/residents";
    }
    
    @GetMapping("/{id}/service-fees")
    public String listServiceFees(@PathVariable("id") int apartmentId, Model model) {
        Apartment apartment = apartmentService.getApartmentById(apartmentId);
        if (apartment == null) {
            return "redirect:/apartments/list";
        }
        model.addAttribute("apartment", apartment);
        model.addAttribute("serviceFees", apartmentService.getServiceFeesByApartmentId(apartmentId));
        return "apartments/service-fees";
    }
    
    @GetMapping("/{id}/requests")
    public String listRequests(@PathVariable("id") int apartmentId, Model model) {
        Apartment apartment = apartmentService.getApartmentById(apartmentId);
        if (apartment == null) {
            return "redirect:/apartments/list";
        }
        model.addAttribute("apartment", apartment);
        model.addAttribute("requests", apartmentService.getRequestsByApartmentId(apartmentId));
        return "apartments/requests";
    }
}