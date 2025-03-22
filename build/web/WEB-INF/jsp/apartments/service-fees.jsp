<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phí dịch vụ - Căn hộ ${apartment.apartmentNumber} - Hệ thống quản lý chung cư</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
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
            <jsp:include page="../common/resident-header.jsp"/>
            <div class="container-fluid">
                <div class="row">
                    <jsp:include page="../common/resident-sidebar.jsp"/>
                    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
        </c:otherwise>
    </c:choose>
    
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">Phí dịch vụ - Căn hộ ${apartment.apartmentNumber}</h1>
        <div class="btn-toolbar mb-2 mb-md-0">
            <a href="${pageContext.request.contextPath}/apartments/view/${apartment.apartmentId}" class="btn btn-sm btn-outline-secondary me-2">
                <i class="fas fa-arrow-left me-1"></i> Quay lại
            </a>
            <c:if test="${sessionScope.user.role.roleName eq 'ADMIN' || sessionScope.user.role.roleName eq 'MANAGER'}">
                <a href="${pageContext.request.contextPath}/service-fees/add?apartmentId=${apartment.apartmentId}" class="btn btn-sm btn-primary">
                    <i class="fas fa-plus me-1"></i> Thêm phí dịch vụ
                </a>
            </c:if>
        </div>
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
    
    <!-- Lọc theo tháng/năm -->
    <div class="row mb-3">
        <div class="col-md-6">
            <form action="${pageContext.request.contextPath}/apartments/${apartment.apartmentId}/service-fees" method="get" class="d-flex">
                <select name="month" class="form-select me-2">
                    <option value="">-- Tất cả tháng --</option>
                    <c:forEach var="i" begin="1" end="12">
                        <option value="${i}" ${param.month == i ? 'selected' : ''}>Tháng ${i}</option>
                    </c:forEach>
                </select>
                <select name="year" class="form-select me-2">
                    <option value="">-- Tất cả năm --</option>
                    <c:forEach var="i" begin="2020" end="2025">
                        <option value="${i}" ${param.year == i ? 'selected' : ''}>${i}</option>
                    </c:forEach>
                </select>
                <button type="submit" class="btn btn-outline-primary">Lọc</button>
            </form>
        </div>
        <div class="col-md-6">
            <select name="statusFilter" id="statusFilter" class="form-select" onchange="filterByStatus()">
                <option value="">-- Tất cả trạng thái --</option>
                <option value="Đã thanh toán" ${param.status == 'Đã thanh toán' ? 'selected' : ''}>Đã thanh toán</option>
                <option value="Chưa thanh toán" ${param.status == 'Chưa thanh toán' ? 'selected' : ''}>Chưa thanh toán</option>
            </select>
        </div>
    </div>
    
    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0"><i class="fas fa-file-invoice-dollar me-2"></i>Danh sách phí dịch vụ</h5>
        </div>
        <div class="card-body">
            <c:if test="${empty serviceFees}">
                <div class="alert alert-info">
                    <i class="fas fa-info-circle me-2"></i> Không có phí dịch vụ nào với điều kiện tìm kiếm hiện tại.
                </div>
            </c:if>
            
            <c:if test="${not empty serviceFees}">
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Loại phí</th>
                                <th>Thời gian</th>
                                <th>Số tiền</th>
                                <th>Ngày phát hành</th>
                                <th>Ngày thanh toán</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="fee" items="${serviceFees}">
                                <tr>
                                    <td>${fee.feeId}</td>
                                    <td>${fee.serviceType.typeName}</td>
                                    <td>${fee.month}/${fee.year}</td>
                                    <td><fmt:formatNumber value="${fee.amount}" type="currency" currencySymbol="₫" /></td>
                                    <td><fmt:formatDate value="${fee.issueDate}" pattern="dd/MM/yyyy" /></td>
                                    <td><fmt:formatDate value="${fee.paymentDate}" pattern="dd/MM/yyyy" /></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${fee.status eq 'Đã thanh toán'}">
                                                <span class="badge bg-success">Đã thanh toán</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger">Chưa thanh toán</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="btn-group">
                                            <a href="${pageContext.request.contextPath}/service-fees/view/${fee.feeId}" class="btn btn-sm btn-primary">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <c:if test="${sessionScope.user.role.roleName eq 'ADMIN' || sessionScope.user.role.roleName eq 'MANAGER'}">
                                                <a href="${pageContext.request.contextPath}/service-fees/edit/${fee.feeId}" class="btn btn-sm btn-warning">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <c:if test="${fee.status ne 'Đã thanh toán'}">
                                                    <a href="${pageContext.request.contextPath}/service-fees/mark-as-paid/${fee.feeId}" 
                                                       class="btn btn-sm btn-success"
                                                       onclick="return confirm('Bạn có chắc chắn muốn đánh dấu đã thanh toán?');">
                                                        <i class="fas fa-check"></i>
                                                    </a>
                                                </c:if>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <!-- Tổng kết -->
                <div class="card mt-3 bg-light">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4">
                                <h5>Tổng số phí: ${serviceFees.size()}</h5>
                            </div>
                            <div class="col-md-4">
                                <h5>Đã thanh toán: ${paidCount} / ${serviceFees.size()}</h5>
                            </div>
                            <div class="col-md-4">
                                <h5>Tổng tiền: <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="₫" /></h5>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
    
    </main>
    </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
    <script>
        function filterByStatus() {
            const status = document.getElementById('statusFilter').value;
            const currentUrl = new URL(window.location.href);
            if (status) {
                currentUrl.searchParams.set('status', status);
            } else {
                currentUrl.searchParams.delete('status');
            }
            window.location.href = currentUrl.toString();
        }
    </script>
</body>
</html>