<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đăng ký chuyển đồ - Hệ thống quản lý chung cư</title>
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
        <h1 class="h2">Chi tiết đăng ký chuyển đồ</h1>
        <div class="btn-toolbar mb-2 mb-md-0">
            <a href="${pageContext.request.contextPath}/moving/list" class="btn btn-sm btn-outline-secondary me-2">
                <i class="fas fa-arrow-left me-1"></i> Quay lại
            </a>
            <div class="btn-group">
                <c:if test="${(sessionScope.user.role.roleName eq 'ADMIN' || sessionScope.user.role.roleName eq 'MANAGER') && registration.status eq 'Đang chờ phê duyệt'}">
                    <a href="${pageContext.request.contextPath}/moving/approve/${registration.movingId}" 
                       class="btn btn-sm btn-success"
                       onclick="return confirm('Bạn có chắc muốn phê duyệt đăng ký này?');">
                        <i class="fas fa-check me-1"></i> Phê duyệt
                    </a>
                    <a href="${pageContext.request.contextPath}/moving/reject/${registration.movingId}" 
                       class="btn btn-sm btn-danger"
                       onclick="return confirm('Bạn có chắc muốn từ chối đăng ký này?');">
                        <i class="fas fa-times me-1"></i> Từ chối
                    </a>
                </c:if>
                
                <c:if test="${registration.requesterId == sessionScope.user.userId && registration.status eq 'Đang chờ phê duyệt'}">
                    <a href="${pageContext.request.contextPath}/moving/update/${registration.movingId}" class="btn btn-sm btn-warning me-2">
                        <i class="fas fa-edit me-1"></i> Sửa
                    </a>
                    <a href="${pageContext.request.contextPath}/moving/cancel/${registration.movingId}" 
                       class="btn btn-sm btn-danger"
                       onclick="return confirm('Bạn có chắc muốn hủy đăng ký này?');">
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
                    <h5 class="mb-0"><i class="fas fa-dolly me-2"></i>Thông tin đăng ký chuyển đồ</h5>
                </div>
                <div class="card-body">
                    <table class="table table-bordered">
                        <tr>
                            <th width="40%">ID đăng ký:</th>
                            <td>${registration.movingId}</td>
                        </tr>
                        <tr>
                            <th>Căn hộ:</th>
                            <td>${registration.apartment.apartmentNumber}</td>
                        </tr>
                        <tr>
                            <th>Người đăng ký:</th>
                            <td>${registration.requester.fullName}</td>
                        </tr>
                        <tr>
                            <th>Loại chuyển đồ:</th>
                            <td>
                                <span class="badge ${registration.movingType eq 'Vào' ? 'bg-success' : 'bg-warning'}">
                                    ${registration.movingType}
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <th>Ngày đăng ký:</th>
                            <td><fmt:formatDate value="${registration.registrationDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                        </tr>
                        <tr>
                            <th>Ngày chuyển đồ:</th>
                            <td><fmt:formatDate value="${registration.movingDate}" pattern="dd/MM/yyyy" /></td>
                        </tr>
                        <tr>
                            <th>Thời gian:</th>
                            <td>
                                <fmt:formatDate value="${registration.startTime}" pattern="HH:mm" /> - 
                                <fmt:formatDate value="${registration.endTime}" pattern="HH:mm" />
                            </td>
                        </tr>
                        <tr>
                            <th>Trạng thái:</th>
                            <td>
                                <c:choose>
                                    <c:when test="${registration.status eq 'Đang chờ phê duyệt'}">
                                        <span class="badge bg-warning">Đang chờ phê duyệt</span>
                                    </c:when>
                                    <c:when test="${registration.status eq 'Đã phê duyệt'}">
                                        <span class="badge bg-success">Đã phê duyệt</span>
                                    </c:when>
                                    <c:when test="${registration.status eq 'Đã từ chối'}">
                                        <span class="badge bg-danger">Đã từ chối</span>
                                    </c:when>
                                    <c:when test="${registration.status eq 'Đã hủy'}">
                                        <span class="badge bg-secondary">Đã hủy</span>
                                    </c:when>
                                    <c:when test="${registration.status eq 'Đã hoàn thành'}">
                                        <span class="badge bg-info">Đã hoàn thành</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">${registration.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            
            <div class="card mb-4">
                <div class="card-header bg-info text-white">
                    <h5 class="mb-0"><i class="fas fa-box me-2"></i>Thông tin vật dụng</h5>
                </div>
                <div class="card-body">
                    <p><strong>Mô tả vật dụng:</strong></p>
                    <div class="p-3 bg-light rounded">
                        <p class="mb-0">${registration.itemsDescription}</p>
                    </div>
                    
                    <c:if test="${not empty registration.specialNotes}">
                        <p class="mt-3"><strong>Ghi chú đặc biệt:</strong></p>
                        <div class="p-3 bg-light rounded">
                            <p class="mb-0">${registration.specialNotes}</p>
                        </div>
                    </c:if>
                    
                    <c:if test="${registration.needElevatorReservation}">
                        <div class="alert alert-warning mt-3">
                            <i class="fas fa-exclamation-triangle me-2"></i> Yêu cầu đặt thang máy riêng
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
        
        <div class="col-md-6">
            <div class="card mb-4">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0"><i class="fas fa-user me-2"></i>Thông tin liên hệ</h5>
                </div>
                <div class="card-body">
                    <table class="table table-bordered">
                        <tr>
                            <th width="40%">Người liên hệ:</th>
                            <td>${registration.contactName}</td>
                        </tr>
                        <tr>
                            <th>Số điện thoại:</th>
                            <td>${registration.contactPhone}</td>
                        </tr>
                        <tr>
                            <th>Email:</th>
                            <td>${registration.contactEmail}</td>
                        </tr>
                    </table>
                    
                    <p class="mt-3"><strong>Đơn vị vận chuyển:</strong></p>
                    <table class="table table-bordered">
                        <tr>
                            <th width="40%">Tên đơn vị:</th>
                            <td>${registration.movingCompany != null ? registration.movingCompany : 'Không có'}</td>
                        </tr>
                        <tr>
                            <th>Số người:</th>
                            <td>${registration.numberOfMovers}</td>
                        </tr>
                    </table>
                </div>
            </div>
            
            <c:if test="${registration.status eq 'Đã phê duyệt' || registration.status eq 'Đã từ chối' || registration.status eq 'Đã hoàn thành'}">
                <div class="card mb-4">
                    <div class="card-header bg-warning text-dark">
                        <h5 class="mb-0"><i class="fas fa-clipboard-check me-2"></i>Thông tin phê duyệt</h5>
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered">
                            <tr>
                                <th width="40%">Người phê duyệt:</th>
                                <td>${approver.fullName}</td>
                            </tr>
                            <tr>
                                <th>Ngày phê duyệt:</th>
                                <td><fmt:formatDate value="${registration.reviewDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                            </tr>
                            <tr>
                                <th>Kết quả:</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${registration.status eq 'Đã phê duyệt'}">
                                            <span class="badge bg-success">Phê duyệt</span>
                                        </c:when>
                                        <c:when test="${registration.status eq 'Đã từ chối'}">
                                            <span class="badge bg-danger">Từ chối</span>
                                        </c:when>
                                        <c:when test="${registration.status eq 'Đã hoàn thành'}">
                                            <span class="badge bg-info">Hoàn thành</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                            </tr>
                        </table>
                        
                        <c:if test="${not empty registration.reviewNotes}">
                            <p class="mt-3"><strong>Ghi chú phê duyệt:</strong></p>
                            <div class="p-3 bg-light rounded">
                                <p class="mb-0">${registration.reviewNotes}</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:if>
            
            <c:if test="${sessionScope.user.role.roleName eq 'ADMIN' || sessionScope.user.role.roleName eq 'MANAGER'}">
                <c:if test="${registration.status eq 'Đang chờ phê duyệt'}">
                    <div class="card mb-4">
                        <div class="card-header bg-warning text-dark">
                            <h5 class="mb-0"><i class="fas fa-edit me-2"></i>Phê duyệt đăng ký</h5>
                        </div>
                        <div class="card-body">
                            <form id="reviewForm">
                                <div class="mb-3">
                                    <label for="reviewNotes" class="form-label">Ghi chú phê duyệt</label>
                                    <textarea class="form-control" id="reviewNotes" name="reviewNotes" rows="3" placeholder="Nhập ghi chú phê duyệt..."></textarea>
                                </div>
                                
                                <div class="d-grid gap-2 d-md-flex justify-content-md-between">
                                    <button type="button" class="btn btn-danger" id="btnReject" onclick="rejectRegistration()">
                                        <i class="fas fa-times me-1"></i> Từ chối
                                    </button>
                                    <button type="button" class="btn btn-success" id="btnApprove" onclick="approveRegistration()">
                                        <i class="fas fa-check me-1"></i> Phê duyệt
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </c:if>
            </c:if>
        </div>
    </div>
    
    </main>
    </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
    <script>
        function approveRegistration() {
            const notes = document.getElementById('reviewNotes').value;
            if (confirm('Bạn có chắc muốn phê duyệt đăng ký này?')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/moving/approve/${registration.movingId}',
                    type: 'POST',
                    data: {
                        reviewNotes: notes
                    },
                    success: function(response) {
                        window.location.reload();
                    },
                    error: function(xhr, status, error) {
                        alert('Đã xảy ra lỗi: ' + error);
                    }
                });
            }
        }
        
        function rejectRegistration() {
            const notes = document.getElementById('reviewNotes').value;
            if (!notes) {
                alert('Vui lòng nhập lý do từ chối!');
                return;
            }
            
            if (confirm('Bạn có chắc muốn từ chối đăng ký này?')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/moving/reject/${registration.movingId}',
                    type: 'POST',
                    data: {
                        reviewNotes: notes
                    },
                    success: function(response) {
                        window.location.reload();
                    },
                    error: function(xhr, status, error) {
                        alert('Đã xảy ra lỗi: ' + error);
                    }
                });
            }
        }
    </script>
</body>
</html>