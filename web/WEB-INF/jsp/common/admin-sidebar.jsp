<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse" id="sidebarMenu">
    <div class="position-sticky pt-3">
        <div class="text-center mb-4">
            <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Logo" width="100">
            <h6 class="mt-2">Hệ thống quản lý chung cư</h6>
        </div>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.servletPath.contains('/admin/dashboard') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-tachometer-alt me-2"></i>
                    Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.servletPath.contains('/admin/users') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/users">
                    <i class="fas fa-users me-2"></i>
                    Quản lý người dùng
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.servletPath.contains('/admin/apartments') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/apartments">
                    <i class="fas fa-building me-2"></i>
                    Quản lý căn hộ
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.servletPath.contains('/admin/requests') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/requests">
                    <i class="fas fa-clipboard-list me-2"></i>
                    Quản lý yêu cầu
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.servletPath.contains('/admin/service-fees') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/service-fees">
                    <i class="fas fa-file-invoice-dollar me-2"></i>
                    Quản lý phí dịch vụ
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.servletPath.contains('/admin/parking') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/parking">
                    <i class="fas fa-parking me-2"></i>
                    Quản lý bãi xe
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.servletPath.contains('/admin/reports') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/reports">
                    <i class="fas fa-chart-bar me-2"></i>
                    Báo cáo thống kê
                </a>
            </li>
        </ul>
        
        <hr>
        <div class="px-3">
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger w-100">
                <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
            </a>
        </div>
    </div>
</div>