<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết căn hộ - Hệ thống quản lý chung cư</title>
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
            <jsp:include page="../common/staff-header.jsp"/>
            <div class="container-fluid">
                <div class="row">
                    <jsp:include page="../common/staff-sidebar.jsp"/>
                    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
        </c:otherwise>
    </c:choose>
    
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">Chi tiết căn hộ: ${apartment.apartmentNumber}</h1>
        <div class="btn-toolbar mb-2 mb-md-0">
            <a href="${pageContext.request.contextPath}/apartments/list" class="btn btn-sm btn-outline-secondary">
                <i class="fas fa-arrow-left me-1"></i> Quay lại danh sách
            </a>
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
    
    <!-- Tab navigation -->
    <ul class="nav nav-tabs mb-4" id="apartmentTab" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="info-tab" data-bs-toggle="tab" data-bs-target="#info" type="button" role="tab" aria-controls="info" aria-selected="true">
                <i class="fas fa-info-circle me-1"></i> Thông tin căn hộ
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="residents-tab" data-bs-toggle="tab" data-bs-target="#residents" type="button" role="tab" aria-controls="residents" aria-selected="false">
                <i class="fas fa-users me-1"></i> Cư dân
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="fees-tab" data-bs-toggle="tab" data-bs-target="#fees" type="button" role="tab" aria-controls="fees" aria-selected="false">
                <i class="fas fa-file-invoice-dollar me-1"></i> Phí dịch vụ
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="requests-tab" data-bs-toggle="tab" data-bs-target="#requests" type="button" role="tab" aria-controls="requests" aria-selected="false">
                <i class="fas fa-clipboard-list me-1"></i> Yêu cầu
            </button>
        </li>
    </ul>
    
    <!-- Tab content -->
    <div class="tab-content" id="apartmentTabContent">
        <!-- Thông tin căn hộ -->
        <div class="tab-pane fade show active" id="info" role="tabpanel" aria-labelledby="info-tab">
            <div class="row">
                <div class="col-md-6">
                    <div class="card mb-4">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0"><i class="fas fa-building me-2"></i>Thông tin cơ bản</h5>
                        </div>
                        <div class="card-body">
                            <table class="table table-bordered">
                                <tr>
                                    <th width="40%">ID căn hộ:</th>
                                    <td>${apartment.apartmentId}</td>
                                </tr>
                                <tr>
                                    <th>Số căn hộ:</th>
                                    <td>${apartment.apartmentNumber}</td>
                                </tr>
                                <tr>
                                    <th>Tầng:</th>
                                    <td>${apartment.floorNumber}</td>
                                </tr>
                                <tr>
                                    <th>Diện tích:</th>
                                    <td>${apartment.area} m²</td>
                                </tr>
                                <tr>
                                    <th>Trạng thái:</th>
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
                                </tr>
                            </table>
                            
                            <c:if test="${sessionScope.user.role.roleName eq 'ADMIN' || sessionScope.user.role.roleName eq 'MANAGER'}">
                                <div class="mt-3">
                                    <a href="${pageContext.request.contextPath}/apartments/edit/${apartment.apartmentId}" class="btn btn-warning">
                                        <i class="fas fa-edit me-1"></i> Sửa thông tin
                                    </a>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="card mb-4">
                        <div class="card-header bg-success text-white">
                            <h5 class="mb-0"><i class="fas fa-user me-2"></i>Thông tin chủ sở hữu</h5>
                        </div>
                        <div class="card-body">
                            <c:if test="${owner != null}">
                                <table class="table table-bordered">
                                    <tr>
                                        <th width="40%">Họ tên:</th>
                                        <td>${owner.user.fullName}</td>
                                    </tr>
                                    <tr>
                                        <th>Email:</th>
                                        <td>${owner.user.email}</td>
                                    </tr>
                                    <tr>
                                        <th>Số điện thoại:</th>
                                        <td>${owner.user.phone}</td>
                                    </tr>
                                    <tr>
                                        <th>Ngày sở hữu:</th>
                                        <td><fmt:formatDate value="${owner.ownershipDate}" pattern="dd/MM/yyyy" /></td>
                                    </tr>
                                </table>
                                
                                <c:if test="${sessionScope.user.role.roleName eq 'ADMIN' || sessionScope.user.role.roleName eq 'MANAGER'}">
                                    <div class="mt-3">
                                        <a href="${pageContext.request.contextPath}/apartments/${apartment.apartmentId}/owner/edit" class="btn btn-outline-success">
                                            <i class="fas fa-user-edit me-1"></i> Thay đổi chủ sở hữu
                                        </a>
                                    </div>
                                </c:if>
                            </c:if>
                            
                            <c:if test="${owner == null}">
                                <div class="alert alert-warning">
                                    <i class="fas fa-exclamation-triangle me-2"></i> Căn hộ chưa có chủ sở hữu.
                                </div>
                                
                                <c:if test="${sessionScope.user.role.roleName eq 'ADMIN' || sessionScope.user.role.roleName eq 'MANAGER'}">
                                    <div class="mt-3">
                                        <a href="${pageContext.request.contextPath}/apartments/${apartment.apartmentId}/owner/add" class="btn btn-success">
                                            <i class="fas fa-user-plus me-1"></i> Thêm chủ sở hữu
                                        </a>
                                    </div>
                                </c:if>
                            </c:if>
                        </div>
                    </div>
                    
                    <div class="card mb-4">
                        <div class="card-header bg-info text-white">
                            <h5 class="mb-0"><i class="fas fa-address-card me-2"></i>Thông tin người thuê</h5>
                        </div>
                        <div class="card-body">
                            <c:if test="${tenant != null}">
                                <table class="table table-bordered">
                                    <tr>
                                        <th width="40%">Họ tên:</th>
                                        <td>${tenant.user.fullName}</td>
                                    </tr>
                                    <tr>
                                        <th>Email:</th>
                                        <td>${tenant.user.email}</td>
                                    </tr>
                                    <tr>
                                        <th>Số điện thoại:</th>
                                        <td>${tenant.user.phone}</td>
                                    </tr>
                                    <tr>
                                        <th>Ngày bắt đầu thuê:</th>
                                        <td><fmt:formatDate value="${tenant.rentalStartDate}" pattern="dd/MM/yyyy" /></td>
                                    </tr>
                                    <tr>
                                        <th>Ngày kết thúc thuê:</th>
                                        <td>
                                            <c:if test="${tenant.rentalEndDate != null}">
                                                <fmt:formatDate value="${tenant.rentalEndDate}" pattern="dd/MM/yyyy" />
                                            </c:if>
                                            <c:if test="${tenant.rentalEndDate == null}">
                                                Chưa xác định
                                            </c:if>
                                        </td>
                                    </tr>
                                </table>
                                
                                <c:if test="${sessionScope.user.role.roleName eq 'ADMIN' || sessionScope.user.role.roleName eq 'MANAGER'}">
                                    <div class="mt-3">
                                        <a href="${pageContext.request.contextPath}/apartments/${apartment.apartmentId}/tenant/edit" class="btn btn-outline-info">
                                            <i class="fas fa-user-edit me-1"></i> Thay đổi người thuê
                                        </a>
                                    </div>
                                </c:if>
                            </c:if>
                            
                            <c:if test="${tenant == null}">
                                <div class="alert alert-warning">
                                    <i class="fas fa-exclamation-triangle me-2"></i> Căn hộ chưa có người thuê.
                                </div>
                                
                                <c:if test="${sessionScope.user.role.roleName eq 'ADMIN' || sessionScope.user.role.roleName eq 'MANAGER'}">
                                    <div class="mt-3">
                                        <a href="${pageContext.request.contextPath}/apartments/${apartment.apartmentId}/tenant/add" class="btn btn-info">
                                            <i class="fas fa-user-plus me-1"></i> Thêm người thuê
                                        </a>
                                    </div>
                                </c:if>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Cư dân -->
        <div class="tab-pane fade" id="residents" role="tabpanel" aria-labelledby="residents-tab">
            <div class="card">
                <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="fas fa-users me-2"></i>Danh sách cư dân</h5>
                    <c:if test="${sessionScope.user.role.roleName eq 'ADMIN' || sessionScope.user.role.roleName eq 'MANAGER' || (sessionScope.user.role.roleName eq 'OWNER' && owner.userId == sessionScope.user.userId)}">
                        <a href="${pageContext.request.contextPath}/apartments/${apartment.apartmentId}/residents/add" class="btn btn-light btn-sm">
                            <i class="fas fa-plus me-1"></i> Thêm cư dân
                        </a>
                    </c:if>
                </div>
                <div class="card-body">
                    <c:if test="${empty residents}">
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle me-2"></i> Căn hộ này chưa có thông tin cư dân.
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty residents}">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Họ tên</th>
                                        <th>Giới tính</th>
                                        <th>Ngày sinh</th>
                                        <th>CMND/CCCD</th>
                                        <th>Quan hệ</th>
                                        <th>Số điện thoại</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="resident" items="${residents}">
                                        <tr>
                                            <td>${resident.residentId}</td>
                                            <td>${resident.fullName}</td>
                                            <td>${resident.gender}</td>
                                            <td><fmt:formatDate value="${resident.dob}" pattern="dd/MM/yyyy" /></td>
                                            <td>${resident.idCard}</td>
                                            <td>${resident.relationship}</td>
                                            <td>${resident.phone}</td>
                                            <td>
                                                <div class="btn-group">
                                                    <a href="${pageContext.request.contextPath}/residents/view/${resident.residentId}" class="btn btn-sm btn-primary">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <c:if test="${sessionScope.user.role.roleName eq 'ADMIN' || sessionScope.user.role.roleName eq 'MANAGER' || (sessionScope.user.role.roleName eq 'OWNER' && owner.userId == sessionScope.user.userId)}">
                                                        <a href="${pageContext.request.contextPath}/residents/edit/${resident.residentId}" class="btn btn-sm btn-warning">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/residents/delete/${resident.residentId}" 
                                                           class="btn btn-sm btn-danger"
                                                           onclick="return confirm('Bạn có chắc chắn muốn xóa cư dân này?');">
                                                            <i class="fas fa-trash"></i>
                                                        </a>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
        
        <!-- Phí dịch vụ -->
        <div class="tab-pane fade" id="fees" role="tabpanel" aria-labelledby="fees-tab">
            <div class="card">
                <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="fas fa-file-invoice-dollar me-2"></i>Phí dịch vụ</h5>
                    <c:if test="${sessionScope.user.role.roleName eq 'ADMIN' || sessionScope.user.role.roleName eq 'MANAGER'}">
                        <a href="${pageContext.request.contextPath}/service-fees/add?apartmentId=${apartment.apartmentId}" class="btn btn-light btn-sm">
                            <i class="fas fa-plus me-1"></i> Thêm phí dịch vụ
                        </a>
                    </c:if>
                </div>
                <div class="card-body">
                    <c:if test="${empty serviceFees}">
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle me-2"></i> Căn hộ này chưa có thông tin phí dịch vụ.
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
                    </c:if>
                </div>
            </div>
        </div>
        
        <!-- Yêu cầu -->
        <div class="tab-pane fade" id="requests" role="tabpanel" aria-labelledby="requests-tab">
            <div class="card">
                <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="fas fa-clipboard-list me-2"></i>Yêu cầu</h5>
                    <c:if test="${sessionScope.user.role.roleName eq 'OWNER' || sessionScope.user.role.roleName eq 'TENANT'}">
                        <a href="${pageContext.request.contextPath}/requests/create" class="btn btn-light btn-sm">
                            <i class="fas fa-plus me-1"></i> Tạo yêu cầu
                        </a>
                    </c:if>
                </div>
                <div class="card-body">
                    <c:if test="${empty requests}">
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle me-2"></i> Căn hộ này chưa có yêu cầu nào.
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty requests}">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Tiêu đề</th>
                                        <th>Loại yêu cầu</th>
                                        <th>Người yêu cầu</th>
                                        <th>Ngày tạo</th>
                                        <th>Trạng thái</th>
                                        <th>Ưu tiên</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="request" items="${requests}">
                                        <tr>
                                            <td>${request.requestId}</td>
                                            <td>${request.title}</td>
                                            <td>${request.requestType.typeName}</td>
                                            <td>${request.requester.fullName}</td>
                                            <td><fmt:formatDate value="${request.requestDate}" pattern="dd/MM/yyyy" /></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${request.status eq 'Đang chờ xử lý'}">
                                                        <span class="badge bg-warning">Đang chờ xử lý</span>
                                                    </c:when>
                                                    <c:when test="${request.status eq 'Đang xử lý'}">
                                                        <span class="badge bg-primary">Đang xử lý</span>
                                                    </c:when>
                                                    <c:when test="${request.status eq 'Hoàn thành'}">
                                                        <span class="badge bg-success">Hoàn thành</span>
                                                    </c:when>
                                                    <c:when test="${request.status eq 'Từ chối'}">
                                                        <span class="badge bg-danger">Từ chối</span>
                                                    </c:when>
                                                    <c:when test="${request.status eq 'Đã hủy'}">
                                                        <span class="badge bg-secondary">Đã hủy</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">${request.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${request.priority eq 'Cao'}">
                                                        <span class="badge bg-danger">Cao</span>
                                                    </c:when>
                                                    <c:when test="${request.priority eq 'Bình thường'}">
                                                        <span class="badge bg-info">Bình thường</span>
                                                    </c:when>
                                                    <c:when test="${request.priority eq 'Thấp'}">
                                                        <span class="badge bg-success">Thấp</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">${request.priority}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/requests/view/${request.requestId}" class="btn btn-sm btn-primary">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    
    </main>
    </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>