<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
    <div class="position-sticky pt-3">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link ${requestScope['javax.servlet.forward.servlet_path'] == '/staff/dashboard' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/staff/dashboard">
                    <i class="fas fa-home me-1"></i>
                    Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${requestScope['javax.servlet.forward.servlet_path'] == '/staff/requests' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/staff/requests">
                    <i class="fas fa-clipboard-list me-1"></i>
                    Yêu cầu được giao
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${requestScope['javax.servlet.forward.servlet_path'] == '/staff/profile' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/staff/profile">
                    <i class="fas fa-user me-1"></i>
                    Thông tin cá nhân
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${requestScope['javax.servlet.forward.servlet_path'] == '/staff/change-password' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/staff/change-password">
                    <i class="fas fa-key me-1"></i>
                    Đổi mật khẩu
                </a>
            </li>
        </ul>
    </div>
</nav>