<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết yêu cầu - Hệ thống quản lý chung cư</title>
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
        <c:when test="${sessionScope.user.role.roleName eq 'STAFF'}">
            <jsp:include page="../common/staff-header.jsp"/>
            <div class="container-fluid">
                <div class="row">
                    <jsp:include page="../common/staff-sidebar.jsp"/>
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
        <h1 class="h2">Chi tiết yêu cầu #${request.requestId}</h1>
        <div class="btn-toolbar mb-2 mb-md-0">
            <a href="${pageContext.request.contextPath}/requests/list" class="btn btn-sm btn-outline-secondary me-2">
                <i class="fas fa-arrow-left me-1"></i> Quay lại
            </a>
            <div class="btn-group">
                <c:if test="${(sessionScope.user.role.roleName eq 'ADMIN' || sessionScope.user.role.roleName eq 'MANAGER') && request.status eq 'Đang chờ xử lý'}">
                    <a href="${pageContext.request.contextPath}/requests/assign/${request.requestId}" class="btn btn-sm btn-success">
                        <i class="fas fa-user-plus me-1"></i> Phân công
                    </a>
                </c:if>
                
                <c:if test="${(sessionScope.user.role.roleName eq 'ADMIN' || sessionScope.user.role.roleName eq 'MANAGER' || sessionScope.user.role.roleName eq 'STAFF') && (request.status eq 'Đang chờ xử lý' || request.status eq 'Đang xử lý')}">
                    <a href="${pageContext.request.contextPath}/requests/update-progress/${request.requestId}" class="btn btn-sm btn-primary">
                        <i class="fas fa-tasks me-1"></i> Cập nhật tiến độ
                    </a>
                </c:if>
                
                <c:if test="${request.requesterId == sessionScope.user.userId && request.status eq 'Đang chờ xử lý'}">
                    <a href="${pageContext.request.contextPath}/requests/update/${request.requestId}" class="btn btn-sm btn-warning me-2">
                        <i class="fas fa-edit me-1"></i> Sửa
                    </a>
                    <a href="${pageContext.request.contextPath}/requests/cancel/${request.requestId}" 
                       class="btn btn-sm btn-danger"
                       onclick="return confirm('Bạn có chắc muốn hủy yêu cầu này?');">
                        <i class="fas fa-ban me-1"></i> Hủy
                    </a>
                </c:if>
            </div>
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
    
    <div class="row">
        <div class="col-md-6">
            <div class="card mb-4">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="fas fa-clipboard-list me-2"></i>Thông tin yêu cầu</h5>
                </div>
                <div class="card-body">
                    <table class="table table-bordered">
                        <tr>
                            <th width="40%">ID yêu cầu:</th>
                            <td>${request.requestId}</td>
                        </tr>
                        <tr>
                            <th>Tiêu đề:</th>
                            <td>${request.title}</td>
                        </tr>
                        <tr>
                            <th>Căn hộ:</th>
                            <td>${request.apartment.apartmentNumber}</td>
                        </tr>
                        <tr>
                            <th>Loại yêu cầu:</th>
                            <td>${request.requestType.typeName}</td>
                        </tr>
                        <tr>
                            <th>Người yêu cầu:</th>
                            <td>${request.requester.fullName}</td>
                        </tr>
                        <tr>
                            <th>Ngày tạo:</th>
                            <td><fmt:formatDate value="${request.requestDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                        </tr>
                        <tr>
                            <th>Trạng thái:</th>
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
                        </tr>
                        <tr>
                            <th>Mức ưu tiên:</th>
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
                        </tr>
                        <tr>
                            <th>Thời gian phù hợp:</th>
                            <td>${request.preferredTime}</td>
                        </tr>
                        <tr>
                            <th>Số liên hệ:</th>
                            <td>${request.contactPhone}</td>
                        </tr>
                    </table>
                    
                    <div class="card mt-3">
                        <div class="card-header bg-light">
                            <h6 class="mb-0">Mô tả yêu cầu</h6>
                        </div>
                        <div class="card-body">
                            <p class="mb-0">${request.description}</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <c:if test="${not empty assignment}">
                <div class="card mb-4">
                    <div class="card-header bg-success text-white">
                        <h5 class="mb-0"><i class="fas fa-user-check me-2"></i>Thông tin phân công</h5>
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered">
                            <tr>
                                <th width="40%">Nhân viên xử lý:</th>
                                <td>${assignment.staff.fullName}</td>
                            </tr>
                            <tr>
                                <th>Người phân công:</th>
                                <td>${assignment.manager.fullName}</td>
                            </tr>
                            <tr>
                                <th>Ngày phân công:</th>
                                <td><fmt:formatDate value="${assignment.assignedDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                            </tr>
                            <tr>
                                <th>Hạn xử lý:</th>
                                <td>
                                    <fmt:formatDate value="${assignment.deadline}" pattern="dd/MM/yyyy HH:mm" />
                                    <c:if test="${assignment.isOverdue}">
                                        <span class="badge bg-danger ms-2">Quá hạn</span>
                                    </c:if>
                                </td>
                            </tr>
                            <c:if test="${not empty assignment.notes}">
                                <tr>
                                    <th>Ghi chú:</th>
                                    <td>${assignment.notes}</td>
                                </tr>
                            </c:if>
                        </table>
                    </div>
                </div>
            </c:if>
        </div>
        
        <div class="col-md-6">
            <div class="card mb-4">
                <div class="card-header bg-info text-white">
                    <h5 class="mb-0"><i class="fas fa-history me-2"></i>Lịch sử xử lý</h5>
                </div>
                <div class="card-body">
                    <c:if test="${empty progressList}">
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle me-2"></i> Chưa có cập nhật tiến độ nào.
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty progressList}">
                        <div class="timeline">
                            <c:forEach var="progress" items="${progressList}" varStatus="status">
                                <div class="timeline-item">
                                    <div class="timeline-badge ${status.first ? 'bg-primary' : (progress.status eq 'Hoàn thành' ? 'bg-success' : (progress.status eq 'Từ chối' || progress.status eq 'Đã hủy' ? 'bg-danger' : 'bg-info'))}">
                                        <i class="fas ${status.first ? 'fa-clipboard-list' : (progress.status eq 'Hoàn thành' ? 'fa-check' : (progress.status eq 'Từ chối' || progress.status eq 'Đã hủy' ? 'fa-times' : 'fa-tasks'))}"></i>
                                    </div>
                                    <div class="timeline-panel card">
                                        <div class="card-header d-flex justify-content-between align-items-center">
                                            <span>
                                                <c:choose>
                                                    <c:when test="${progress.status eq 'Đang chờ xử lý'}">
                                                        <span class="badge bg-warning">Đang chờ xử lý</span>
                                                    </c:when>
                                                    <c:when test="${progress.status eq 'Đang xử lý'}">
                                                        <span class="badge bg-primary">Đang xử lý</span>
                                                    </c:when>
                                                    <c:when test="${progress.status eq 'Hoàn thành'}">
                                                        <span class="badge bg-success">Hoàn thành</span>
                                                    </c:when>
                                                    <c:when test="${progress.status eq 'Từ chối'}">
                                                        <span class="badge bg-danger">Từ chối</span>
                                                    </c:when>
                                                    <c:when test="${progress.status eq 'Đã hủy'}">
                                                        <span class="badge bg-secondary">Đã hủy</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">${progress.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                            <small class="text-muted">
                                                <fmt:formatDate value="${progress.updateTime}" pattern="dd/MM/yyyy HH:mm" />
                                            </small>
                                        </div>
                                        <div class="card-body">
                                            <p>${progress.notes}</p>
                                            <p class="text-muted mb-0">
                                                <small>Cập nhật bởi: ${progress.updatedBy.fullName}</small>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
            </div>
            
            <c:if test="${(sessionScope.user.role.roleName eq 'ADMIN' || sessionScope.user.role.roleName eq 'MANAGER' || sessionScope.user.role.roleName eq 'STAFF') && (request.status eq 'Đang chờ xử lý' || request.status eq 'Đang xử lý')}">
                <div class="card mb-4">
                    <div class="card-header bg-warning text-dark">
                        <h5 class="mb-0"><i class="fas fa-edit me-2"></i>Cập nhật tiến độ nhanh</h5>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/requests/update-progress/${request.requestId}" method="post">
                            <div class="mb-3">
                                <label for="status" class="form-label">Trạng thái mới</label>
                                <select class="form-select" id="status" name="status" required>
                                    <option value="">-- Chọn trạng thái --</option>
                                    <c:forEach var="status" items="${statusOptions}">
                                        <option value="${status}">${status}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label for="notes" class="form-label">Ghi chú</label>
                                <textarea class="form-control" id="notes" name="notes" rows="3" placeholder="Nhập ghi chú cập nhật tiến độ..." required></textarea>
                            </div>
                            
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-1"></i> Cập nhật
                                </button>
                            </div>
                        </form>
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
    
    <style>
        .timeline {
            position: relative;
            padding: 20px 0;
        }
        
        .timeline:before {
            content: '';
            position: absolute;
            top: 0;
            bottom: 0;
            left: 20px;
            width: 4px;
            background: #e9ecef;
        }
        
        .timeline-item {
            position: relative;
            margin-bottom: 30px;
        }
        
        .timeline-badge {
            position: absolute;
            top: 0;
            left: 0;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            text-align: center;
            color: white;
            line-height: 40px;
            z-index: 1;
        }
        
        .timeline-badge i {
            font-size: 1.2rem;
        }
        
        .timeline-panel {
            position: relative;
            margin-left: 60px;
        }
    </style>
</body>
</html>