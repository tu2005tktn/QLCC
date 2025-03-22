// AuthorizationFilter.java
package com.qlcc.filter;

import com.qlcc.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AuthorizationFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String uri = httpRequest.getRequestURI();
        
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            String role = user.getRole().getRoleName();
            
            // Kiểm tra quyền truy cập
            if (uri.contains("/admin/") && !role.equals("ADMIN")) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/access-denied");
                return;
            }
            
            if (uri.contains("/manager/") && !role.equals("MANAGER") && !role.equals("ADMIN")) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/access-denied");
                return;
            }
            
            if (uri.contains("/staff/") && !role.equals("STAFF") && !role.equals("MANAGER") && !role.equals("ADMIN")) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/access-denied");
                return;
            }
        }
        
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
    }
}