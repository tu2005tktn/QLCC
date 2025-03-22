<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách căn hộ - Hệ thống quản lý chung cư</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <!-- Header và sidebar tùy theo vai trò -->
    <c:choose>
        <c:when test="${sessionScope.user.role.roleName eq 'ADMIN'}">
            <jsp:include page="../common/admin-header.jsp"/>
            <div class="container-fluid">
                <div class="row">
                    <jsp:include page="../common/admin-sidebar.jsp"/>
                    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    </c:when>
    <c:when test="${sessionScope.user.role.roleName eq 'MANAGER'}">
            <jsp:include page="../common/manager-header.jsp"/>
            <div class="container-fluid">
                <div class="row">
                    <jsp:include page="../common/manager-sidebar.jsp"/>
                    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    </c:when>
    <c:otherwise>
            <jsp:include page="../common/staff-header.jsp"/>
            <div class="container-fluid">
                <div class="row">
                    <jsp:include page="../common/staff-sidebar.jsp"/>
                    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    </c:otherwise>
    </c:choose>
        
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">Danh sách căn hộ</h1>
        <c:if test="${sessionScope.user.role.roleName eq 'ADMIN' || sessionScope.user.role.roleName eq 'MANAGER'}">
            <div class="btn-toolbar mb-2 mb-md-0">
                <a href="${pageContext.request.contextPath}/apartments/add" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Thêm căn hộ mới
                </a>
            </div>
        </c:if>
    </div>
                
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
                
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
                
    <!-- Lọc và tìm kiếm -->
    <div class="row mb-3">
        <div class="col-md-6">
            <form action="${pageContext.request.contextPath}/apartments/list" method="get" class="d-flex">
                <input type="text" name="keyword" class="form-control me-2" placeholder="Tìm kiếm căn hộ..." value="${param.keyword}">
                <button type="submit" class="btn btn-outline-primary">Tìm kiếm</button>
            </form>
        </div>
        <div class="col-md-3">
            <select name="floorFilter" id="floorFilter" class="form-select" onchange="filterByFloor()">
                <option value="">-- Tất cả tầng --</option>
                <c:forEach var="i" begin="1" end="20">
                    <option value="${i}" ${param.floor == i ? 'selected' : ''}>Tầng ${i}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-3">
            <select name="statusFilter" id="statusFilter" class="form-select" onchange="filterByStatus()">
                <option value="">-- Tất cả trạng thái --</option>
                <option value="Đang sử dụng" ${param.status == 'Đang sử dụng' ? 'selected' : ''}>Đang sử dụng</option>
                <option value="Trống" ${param.status == 'Trống' ? 'selected' : ''}>Trống</option>
                <option value="Đang bảo trì" ${param.status == 'Đang bảo trì' ? 'selected' : ''}>Đang bảo trì</option>
            </select>
        </div>
    </div>
    
    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Căn hộ</th>
                    <th>Tầng</th>
                    <th>Diện tích (m²)</th>
                    <th>Trạng thái</th>
                    <th>Chủ sở hữu</th>
                    <th>Người thuê</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="apartment" items="${apartments}">
                    <tr>
                        <td>${apartment.apartmentId}</td>
                        <td>${apartment.apartmentNumber}</td>
                        <td>${apartment.floorNumber}</td>
                        <td>${apartment.area}</td>
                        <td>
                            <c:choose>
                                <c:when test="${apartment.status eq 'Đang sử dụng'}">
                                    <span class="badge bg-success">Đang sử dụng</span>
                                </c:when>
                                <c:when test="${apartment.status eq 'Trống'}">
                                    <span class="badge bg-warning">Trống</span>
                                </c:when>
                                <c:when test="${apartment.status eq 'Đang bảo trì'}">
                                    <span class="badge bg-danger">Đang bảo trì</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">${apartment.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${apartment.owner != null ? apartment.owner.user.fullName : 'Chưa có'}</td>
                        <td>${apartment.tenant != null ? apartment.tenant.user.fullName : 'Chưa có'}</td>
                        <td>
                            <div class="btn-group">
                                <a href="${pageContext.request.contextPath}/apartments/view/${apartment.apartmentId}" class="btn btn-sm btn-primary">
                                    <i class="fas fa-eye"></i>
                                </a>
                                <c:if test="${sessionScope.user.role.roleName eq 'ADMIN' || sessionScope.user.role.roleName eq 'MANAGER'}">
                                    <a href="${pageContext.request.contextPath}/apartments/edit/${apartment.apartmentId}" class="btn btn-sm btn-warning">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/apartments/${apartment.apartmentId}/residents" class="btn btn-sm btn-info">
                                    <i class="fas fa-users"></i>
                                </a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <!-- Phân trang -->
    <c:if test="${totalPages > 1}">
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/apartments/list?page=${currentPage - 1}&keyword=${param.keyword}&floor=${param.floor}&status=${param.status}">Trước</a>
                </li>
                
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/apartments/list?page=${i}&keyword=${param.keyword}&floor=${param.floor}&status=${param.status}">${i}</a>
                    </li>
                </c:forEach>
                
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/apartments/list?page=${currentPage + 1}&keyword=${param.keyword}&floor=${param.floor}&status=${param.status}">Sau</a>
                </li>
            </ul>
        </nav>
    </c:if>
    
    </main>
    </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
    <script>
        function filterByFloor() {
            const floor = document.getElementById('floorFilter').value;
            const currentUrl = new URL(window.location.href);
            if (floor) {
                currentUrl.searchParams.set('floor', floor);
            } else {
                currentUrl.searchParams.delete('floor');
            }
            currentUrl.searchParams.set('page', 1);
            window.location.href = currentUrl.toString();
        }
        
        function filterByStatus() {
            const status = document.getElementById('statusFilter').value;
            const currentUrl = new URL(window.location.href);
            if (status) {
                currentUrl.searchParams.set('status', status);
            } else {
                currentUrl.searchParams.delete('status');
            }
            currentUrl.searchParams.set('page', 1);
            window.location.href = currentUrl.toString();
        }
    </script>
</body>
</html>