<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đăng ký gửi xe - Hệ thống quản lý chung cư</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <jsp:include page="../common/manager-header.jsp"/>
    
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="../common/manager-sidebar.jsp"/>
            
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Quản lý đăng ký gửi xe</h1>
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
                
                <!-- Thống kê -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="card text-white bg-primary h-100">
                            <div class="card-body">
                                <h5 class="card-title">Tổng số xe đang gửi</h5>
                                <p class="card-text display-4">${totalVehicles}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-success h-100">
                            <div class="card-body">
                                <h5 class="card-title">Ô tô</h5>
                                <p class="card-text display-4">${carCount}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-info h-100">
                            <div class="card-body">
                                <h5 class="card-title">Xe máy</h5>
                                <p class="card-text display-4">${motorbikeCount}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-warning h-100">
                            <div class="card-body">
                                <h5 class="card-title">Xe đạp</h5>
                                <p class="card-text display-4">${bicycleCount}</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Lọc và tìm kiếm -->
                <div class="row mb-3">
                    <div class="col-md-4">
                        <form action="${pageContext.request.contextPath}/manager/parking" method="get" class="d-flex">
                            <input type="text" name="keyword" class="form-control me-2" placeholder="Tìm biển số, căn hộ..." value="${param.keyword}">
                            <button type="submit" class="btn btn-outline-primary">Tìm kiếm</button>
                        </form>
                    </div>
                    <div class="col-md-3">
                        <select name="typeFilter" id="typeFilter" class="form-select" onchange="filterByVehicleType()">
                            <option value="">-- Tất cả loại xe --</option>
                            <option value="Ô tô" ${param.type == 'Ô tô' ? 'selected' : ''}>Ô tô</option>
                            <option value="Xe máy" ${param.type == 'Xe máy' ? 'selected' : ''}>Xe máy</option>
                            <option value="Xe đạp" ${param.type == 'Xe đạp' ? 'selected' : ''}>Xe đạp</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <select name="statusFilter" id="statusFilter" class="form-select" onchange="filterByStatus()">
                            <option value="">-- Tất cả trạng thái --</option>
                            <option value="Đang hoạt động" ${param.status == 'Đang hoạt động' ? 'selected' : ''}>Đang hoạt động</option>
                            <option value="Đã hủy" ${param.status == 'Đã hủy' ? 'selected' : ''}>Đã hủy</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select id="apartmentFilter" class="form-select" onchange="filterByApartment()">
                            <option value="">-- Tất cả căn hộ --</option>
                            <c:forEach var="apartment" items="${apartments}">
                                <option value="${apartment.apartmentId}" ${param.apartmentId == apartment.apartmentId ? 'selected' : ''}>
                                    ${apartment.apartmentNumber}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Căn hộ</th>
                                <th>Loại xe</th>
                                <th>Biển số</th>
                                <th>Hãng xe</th>
                                <th>Màu sắc</th>
                                <th>Ngày đăng ký</th>
                                <th>Phí hàng tháng</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty parkingRegistrations}">
                                <tr>
                                    <td colspan="10" class="text-center">Không có dữ liệu đăng ký gửi xe</td>
                                </tr>
                            </c:if>
                            <c:forEach var="registration" items="${parkingRegistrations}">
                                <tr>
                                    <td>${registration.parkingId}</td>
                                    <td>${registration.apartment.apartmentNumber}</td>
                                    <td>${registration.vehicleType}</td>
                                    <td>${registration.licensePlate}</td>
                                    <td>${registration.vehicleBrand}</td>
                                    <td>${registration.vehicleColor}</td>
                                    <td><fmt:formatDate value="${registration.registrationDate}" pattern="dd/MM/yyyy" /></td>
                                    <td><fmt:formatNumber value="${registration.monthlyFee}" type="currency" currencySymbol="₫" /></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${registration.status eq 'Đang hoạt động'}">
                                                <span class="badge bg-success">Đang hoạt động</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">Đã hủy</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="btn-group">
                                            <a href="${pageContext.request.contextPath}/parking/view/${registration.parkingId}" class="btn btn-sm btn-primary">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/parking/update/${registration.parkingId}" class="btn btn-sm btn-warning">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <c:if test="${registration.status eq 'Đang hoạt động'}">
                                                <a href="${pageContext.request.contextPath}/parking/cancel/${registration.parkingId}" 
                                                   class="btn btn-sm btn-danger"
                                                   onclick="return confirm('Bạn có chắc chắn muốn hủy đăng ký này?');">
                                                    <i class="fas fa-times"></i>
                                                </a>
                                            </c:if>
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
                                <a class="page-link" href="${pageContext.request.contextPath}/manager/parking?page=${currentPage - 1}&keyword=${param.keyword}&type=${param.type}&status=${param.status}&apartmentId=${param.apartmentId}">Trước</a>
                            </li>
                            
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/manager/parking?page=${i}&keyword=${param.keyword}&type=${param.type}&status=${param.status}&apartmentId=${param.apartmentId}">${i}</a>
                                </li>
                            </c:forEach>
                            
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/manager/parking?page=${currentPage + 1}&keyword=${param.keyword}&type=${param.type}&status=${param.status}&apartmentId=${param.apartmentId}">Sau</a>
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
        function filterByVehicleType() {
            const type = document.getElementById('typeFilter').value;
            const currentUrl = new URL(window.location.href);
            if (type) {
                currentUrl.searchParams.set('type', type);
            } else {
                currentUrl.searchParams.delete('type');
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
        
        function filterByApartment() {
            const apartmentId = document.getElementById('apartmentFilter').value;
            const currentUrl = new URL(window.location.href);
            if (apartmentId) {
                currentUrl.searchParams.set('apartmentId', apartmentId);
            } else {
                currentUrl.searchParams.delete('apartmentId');
            }
            currentUrl.searchParams.set('page', 1);
            window.location.href = currentUrl.toString();
        }
    </script>
</body>
</html>