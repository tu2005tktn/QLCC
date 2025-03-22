<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
    <div class="position-sticky pt-3">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link ${requestScope['javax.servlet.forward.servlet_path'] == '/resident/dashboard' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/resident/dashboard">
                    <i class="fas fa-home me-1"></i>
                    Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${requestScope['javax.servlet.forward.servlet_path'] == '/requests/list' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/requests/list">
                    <i class="fas fa-clipboard-list me-1"></i>
                    Yêu cầu của tôi
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${requestScope['javax.servlet.forward.servlet_path'] == '/resident/service-fees' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/resident/service-fees">
                    <i class="fas fa-file-invoice-dollar me-1"></i>
                    Phí dịch vụ
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${requestScope['javax.servlet.forward.servlet_path'] == '/moving/list' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/moving/list">
                    <i class="fas fa-dolly me-1"></i>
                    Đăng ký chuyển đồ
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${requestScope['javax.servlet.forward.servlet_path'] == '/parking/list' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/parking/list">
                    <i class="fas fa-parking me-1"></i>
                    Đăng ký gửi xe
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${requestScope['javax.servlet.forward.servlet_path'] == '/resident/profile' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/resident/profile">
                    <i class="fas fa-user me-1"></i>
                    Thông tin cá nhân
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${requestScope['javax.servlet.forward.servlet_path'] == '/resident/change-password' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/resident/change-password">
                    <i class="fas fa-key me-1"></i>
                    Đổi mật khẩu
                </a>
            </li>
        </ul>
    </div>
</nav>