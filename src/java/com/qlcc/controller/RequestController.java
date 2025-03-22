// RequestController.java
package com.qlcc.controller;

import com.qlcc.model.Request;
import com.qlcc.model.RequestType;
import com.qlcc.model.User;
import com.qlcc.service.RequestService;
import com.qlcc.service.RequestTypeService;
import com.qlcc.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.List;

@Controller
@RequestMapping("/requests")
public class RequestController {
    
    @Autowired
    private RequestService requestService;
    
    @Autowired
    private RequestTypeService requestTypeService;
    
    @Autowired
    private UserService userService;
    
    @GetMapping("/list")
    public String listRequests(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        List<Request> requests;
        
        String role = user.getRole().getRoleName();
        if (role.equals("ADMIN") || role.equals("MANAGER")) {
            requests = requestService.getAllRequests();
        } else if (role.equals("STAFF")) {
            requests = requestService.getRequestsByStaff(user.getUserId());
        } else {
            // Chủ căn hộ hoặc người thuê
            int apartmentId = requestService.getApartmentIdByUser(user.getUserId());
            requests = requestService.getRequestsByApartment(apartmentId);
        }
        
        model.addAttribute("requests", requests);
        return "requests/list";
    }
    
    @GetMapping("/view/{id}")
    public String viewRequest(@PathVariable("id") int requestId, Model model) {
        Request request = requestService.getRequestById(requestId);
        if (request == null) {
            return "redirect:/requests/list";
        }
        model.addAttribute("request", request);
        model.addAttribute("progressList", requestService.getRequestProgress(requestId));
        model.addAttribute("assignment", requestService.getRequestAssignment(requestId));
        return "requests/view";
    }
    
    @GetMapping("/create")
    public String showCreateForm(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        int apartmentId = requestService.getApartmentIdByUser(user.getUserId());
        
        if (apartmentId == -1) {
            return "redirect:/requests/list";
        }
        
        Request request = new Request();
        request.setRequesterId(user.getUserId());
        request.setApartmentId(apartmentId);
        
        model.addAttribute("request", request);
        model.addAttribute("requestTypes", requestTypeService.getAllRequestTypes());
        return "requests/form";
    }
    
    @PostMapping("/create")
    public String createRequest(@ModelAttribute Request request, HttpSession session, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        request.setRequesterId(user.getUserId());
        
        boolean result = requestService.createRequest(request);
        if (result) {
            redirectAttributes.addFlashAttribute("success", "Tạo yêu cầu thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Tạo yêu cầu thất bại!");
        }
        
        return "redirect:/requests/list";
    }
    
    @GetMapping("/update/{id}")
    public String showUpdateForm(@PathVariable("id") int requestId, HttpSession session, Model model) {
        Request request = requestService.getRequestById(requestId);
        if (request == null) {
            return "redirect:/requests/list";
        }
        
        User user = (User) session.getAttribute("user");
        String role = user.getRole().getRoleName();
        
        // Chỉ admin, manager hoặc người tạo yêu cầu mới có thể cập nhật
        if (!role.equals("ADMIN") && !role.equals("MANAGER") && request.getRequesterId() != user.getUserId()) {
            return "redirect:/requests/view/" + requestId;
        }
        
        model.addAttribute("request", request);
        model.addAttribute("requestTypes", requestTypeService.getAllRequestTypes());
        return "requests/form";
    }
    
    @PostMapping("/update/{id}")
    public String updateRequest(@PathVariable("id") int requestId, @ModelAttribute Request request, RedirectAttributes redirectAttributes) {
        request.setRequestId(requestId);
        boolean result = requestService.updateRequest(request);
        if (result) {
            redirectAttributes.addFlashAttribute("success", "Cập nhật yêu cầu thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Cập nhật yêu cầu thất bại!");
        }
        
        return "redirect:/requests/view/" + requestId;
    }
    
    @GetMapping("/assign/{id}")
    public String showAssignForm(@PathVariable("id") int requestId, Model model) {
        Request request = requestService.getRequestById(requestId);
        if (request == null) {
            return "redirect:/requests/list";
        }
        
        model.addAttribute("request", request);
        model.addAttribute("staffList", userService.getUsersByRole("STAFF"));
        return "requests/assign";
    }
    
    @PostMapping("/assign/{id}")
    public String assignRequest(
            @PathVariable("id") int requestId,
            @RequestParam("staffId") int staffId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        User manager = (User) session.getAttribute("user");
        boolean result = requestService.assignRequest(requestId, staffId, manager.getUserId());
        
        if (result) {
            redirectAttributes.addFlashAttribute("success", "Phân công yêu cầu thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Phân công yêu cầu thất bại!");
        }
        
        return "redirect:/requests/view/" + requestId;
    }
    
    @GetMapping("/update-progress/{id}")
    public String showUpdateProgressForm(@PathVariable("id") int requestId, Model model) {
        Request request = requestService.getRequestById(requestId);
        if (request == null) {
            return "redirect:/requests/list";
        }
        
        model.addAttribute("request", request);
        model.addAttribute("statusOptions", requestService.getStatusOptions());
        return "requests/update-progress";
    }
    
    @PostMapping("/update-progress/{id}")
    public String updateProgress(
            @PathVariable("id") int requestId,
            @RequestParam("status") String status,
            @RequestParam("notes") String notes,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        User user = (User) session.getAttribute("user");
        boolean result = requestService.updateRequestProgress(requestId, status, notes, user.getUserId());
        
        if (result) {
            redirectAttributes.addFlashAttribute("success", "Cập nhật tiến độ thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Cập nhật tiến độ thất bại!");
        }
        
        return "redirect:/requests/view/" + requestId;
    }
    
    @GetMapping("/cancel/{id}")
    public String cancelRequest(
            @PathVariable("id") int requestId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        User user = (User) session.getAttribute("user");
        boolean result = requestService.updateRequestStatus(requestId, "Đã hủy");
        
        if (result) {
            requestService.updateRequestProgress(requestId, "Đã hủy", "Yêu cầu đã bị hủy bởi người dùng", user.getUserId());
            redirectAttributes.addFlashAttribute("success", "Hủy yêu cầu thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Hủy yêu cầu thất bại!");
        }
        
        return "redirect:/requests/list";
    }
    
    @GetMapping("/complete/{id}")
    public String completeRequest(
            @PathVariable("id") int requestId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        User user = (User) session.getAttribute("user");
        boolean result = requestService.updateRequestStatus(requestId, "Hoàn thành");
        
        if (result) {
            requestService.updateRequestProgress(requestId, "Hoàn thành", "Yêu cầu đã được hoàn thành", user.getUserId());
            redirectAttributes.addFlashAttribute("success", "Hoàn thành yêu cầu thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Hoàn thành yêu cầu thất bại!");
        }
        
        return "redirect:/requests/list";
    }
}