<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
    <div class="position-sticky pt-3">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link ${requestScope['javax.servlet.forward.servlet_path'] == '/manager/dashboard' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/manager/dashboard">
                    <i class="fas fa-home me-1"></i>
                    Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${requestScope['javax.servlet.forward.servlet_path'] == '/manager/pending-requests' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/manager/pending-requests">
                    <i class="fas fa-clipboard-list me-1"></i>
                    Yêu cầu chờ xử lý
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${requestScope['javax.servlet.forward.servlet_path'] == '/manager/pending-movings' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/manager/pending-movings">
                    <i class="fas fa-dolly me-1"></i>
                    Đăng ký chuyển đồ
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${requestScope['javax.servlet.forward.servlet_path'] == '/manager/staff' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/manager/staff">
                    <i class="fas fa-user-tie me-1"></i>
                    Quản lý nhân viên
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${requestScope['javax.servlet.forward.servlet_path'] == '/manager/apartments' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/manager/apartments">
                    <i class="fas fa-building me-1"></i>
                    Quản lý căn hộ
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${requestScope['javax.servlet.forward.servlet_path'] == '/manager/reports' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/manager/reports">
                    <i class="fas fa-chart-bar me-1"></i>
                    Báo cáo
                </a>
            </li>
        </ul>
    </div>
</nav>