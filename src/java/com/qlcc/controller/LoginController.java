// LoginController.java
package com.qlcc.controller;

import com.qlcc.model.User;
import com.qlcc.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {
    
    @Autowired
    private UserService userService;
    
    @GetMapping("/login")
    public String showLoginPage() {
        return "login";
    }
    
    @PostMapping("/login")
    public String doLogin(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            HttpSession session,
            Model model) {
        
        User user = userService.authenticate(username, password);
        
        if (user != null) {
            session.setAttribute("user", user);
            
            String role = user.getRole().getRoleName();
            if (role.equals("ADMIN")) {
                return "redirect:/admin/dashboard";
            } else if (role.equals("MANAGER")) {
                return "redirect:/manager/dashboard";
            } else if (role.equals("STAFF")) {
                return "redirect:/staff/dashboard";
            } else if (role.equals("OWNER") || role.equals("TENANT")) {
                return "redirect:/resident/dashboard";
            }
        }
        
        model.addAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
        return "login";
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
    
    @GetMapping("/access-denied")
    public String showAccessDeniedPage() {
        return "access-denied";
    }
}