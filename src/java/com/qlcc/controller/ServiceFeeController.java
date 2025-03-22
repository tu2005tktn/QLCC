// ServiceFeeController.java
package com.qlcc.controller;

import com.qlcc.model.Apartment;
import com.qlcc.model.ServiceFee;
import com.qlcc.model.ServiceType;
import com.qlcc.service.ApartmentService;
import com.qlcc.service.ServiceFeeService;
import com.qlcc.service.ServiceTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.List;
import java.util.Calendar;

@Controller
@RequestMapping("/service-fees")
public class ServiceFeeController {
    
    @Autowired
    private ServiceFeeService serviceFeeService;
    
    @Autowired
    private ApartmentService apartmentService;
    
    @Autowired
    private ServiceTypeService serviceTypeService;
    
    @GetMapping("/list")
    public String listServiceFees(Model model) {
        List<ServiceFee> serviceFees = serviceFeeService.getAllServiceFees();
        model.addAttribute("serviceFees", serviceFees);
        return "service-fees/list";
    }
    
    @GetMapping("/view/{id}")
    public String viewServiceFee(@PathVariable("id") int feeId, Model model) {
        ServiceFee serviceFee = serviceFeeService.getServiceFeeById(feeId);
        if (serviceFee == null) {
            return "redirect:/service-fees/list";
        }
        model.addAttribute("serviceFee", serviceFee);
        return "service-fees/view";
    }
    
    @GetMapping("/add")
    public String showAddServiceFeeForm(Model model) {
        ServiceFee serviceFee = new ServiceFee();
        
        // Thiết lập mặc định tháng và năm hiện tại
        Calendar calendar = Calendar.getInstance();
        serviceFee.setMonth(calendar.get(Calendar.MONTH) + 1); // Tháng từ 0-11
        serviceFee.setYear(calendar.get(Calendar.YEAR));
        
        model.addAttribute("serviceFee", serviceFee);
        model.addAttribute("apartments", apartmentService.getAllApartments());
        model.addAttribute("serviceTypes", serviceTypeService.getAllServiceTypes());
        return "service-fees/form";
    }
    
    @PostMapping("/add")
    public String addServiceFee(@ModelAttribute ServiceFee serviceFee, RedirectAttributes redirectAttributes) {
        boolean result = serviceFeeService.addServiceFee(serviceFee);
        if (result) {
            redirectAttributes.addFlashAttribute("success", "Thêm phí dịch vụ thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Thêm phí dịch vụ thất bại!");
        }
        return "redirect:/service-fees/list";
    }
    
    @GetMapping("/edit/{id}")
    public String showEditServiceFeeForm(@PathVariable("id") int feeId, Model model) {
        ServiceFee serviceFee = serviceFeeService.getServiceFeeById(feeId);
        if (serviceFee == null) {
            return "redirect:/service-fees/list";
        }
        model.addAttribute("serviceFee", serviceFee);
        model.addAttribute("apartments", apartmentService.getAllApartments());
        model.addAttribute("serviceTypes", serviceTypeService.getAllServiceTypes());
        return "service-fees/form";
    }
    
    @PostMapping("/edit/{id}")
    public String updateServiceFee(@PathVariable("id") int feeId, @ModelAttribute ServiceFee serviceFee, RedirectAttributes redirectAttributes) {
        serviceFee.setFeeId(feeId);
        boolean result = serviceFeeService.updateServiceFee(serviceFee);
        if (result) {
            redirectAttributes.addFlashAttribute("success", "Cập nhật phí dịch vụ thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Cập nhật phí dịch vụ thất bại!");
        }
        return "redirect:/service-fees/list";
    }
    
    @GetMapping("/mark-as-paid/{id}")
    public String markAsPaid(@PathVariable("id") int feeId, RedirectAttributes redirectAttributes) {
        boolean result = serviceFeeService.markAsPaid(feeId);
        if (result) {
            redirectAttributes.addFlashAttribute("success", "Đã đánh dấu thanh toán thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Đánh dấu thanh toán thất bại!");
        }
        return "redirect:/service-fees/view/" + feeId;
    }
    
    @GetMapping("/delete/{id}")
    public String deleteServiceFee(@PathVariable("id") int feeId, RedirectAttributes redirectAttributes) {
        boolean result = serviceFeeService.deleteServiceFee(feeId);
        if (result) {
            redirectAttributes.addFlashAttribute("success", "Xóa phí dịch vụ thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Xóa phí dịch vụ thất bại!");
        }
        return "redirect:/service-fees/list";
    }
    
    @GetMapping("/generate")
    public String showGenerateForm(Model model) {
        model.addAttribute("apartments", apartmentService.getAllApartments());
        model.addAttribute("serviceTypes", serviceTypeService.getAllServiceTypes());
        
        // Thiết lập mặc định tháng và năm hiện tại
        Calendar calendar = Calendar.getInstance();
        model.addAttribute("currentMonth", calendar.get(Calendar.MONTH) + 1);
        model.addAttribute("currentYear", calendar.get(Calendar.YEAR));
        
        return "service-fees/generate";
    }
    
    @PostMapping("/generate")
    public String generateServiceFees(
            @RequestParam("month") int month,
            @RequestParam("year") int year,
            @RequestParam("serviceTypeId") int serviceTypeId,
            RedirectAttributes redirectAttributes) {
        
        int count = serviceFeeService.generateServiceFees(month, year, serviceTypeId);
        if (count > 0) {
            redirectAttributes.addFlashAttribute("success", "Đã tạo " + count + " phí dịch vụ thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Không thể tạo phí dịch vụ. Có thể đã tồn tại!");
        }
        
        return "redirect:/service-fees/list";
    }
    
    @GetMapping("/by-month")
    public String listServiceFeesByMonth(
            @RequestParam(value = "month", required = false) Integer month,
            @RequestParam(value = "year", required = false) Integer year,
            Model model) {
        
        // Nếu không có tham số, lấy tháng và năm hiện tại
        if (month == null || year == null) {
            Calendar calendar = Calendar.getInstance();
            month = calendar.get(Calendar.MONTH) + 1;
            year = calendar.get(Calendar.YEAR);
        }
        
        List<ServiceFee> serviceFees = serviceFeeService.getServiceFeesByMonthYear(month, year);
        model.addAttribute("serviceFees", serviceFees);
        model.addAttribute("selectedMonth", month);
        model.addAttribute("selectedYear", year);
        
        // Tạo danh sách các tháng và năm để hiển thị trên dropdown
        model.addAttribute("months", java.util.Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12));
        
        Calendar calendar = Calendar.getInstance();
        int currentYear = calendar.get(Calendar.YEAR);
        List<Integer> years = new java.util.ArrayList<>();
        for (int i = currentYear - 5; i <= currentYear + 1; i++) {
            years.add(i);
        }
        model.addAttribute("years", years);
        
        return "service-fees/by-month";
    }
}