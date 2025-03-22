<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đăng ký gửi xe - Hệ thống quản lý chung cư</title>
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
                    <h1 class="h2">Chi tiết đăng ký gửi xe</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/manager/parking" class="btn btn-sm btn-outline-secondary me-2">
                            <i class="fas fa-arrow-left me-1"></i> Quay lại
                        </a>
                        <div class="btn-group">
                            <a href="${pageContext.request.contextPath}/parking/update/${registration.parkingId}" class="btn btn-sm btn-warning">
                                <i class="fas fa-edit me-1"></i> Sửa
                            </a>
                            <c:if test="${registration.status eq 'Đang hoạt động'}">
                                <a href="${pageContext.request.contextPath}/parking/cancel/${registration.parkingId}" 
                                   class="btn btn-sm btn-danger"
                                   onclick="return confirm('Bạn có chắc chắn muốn hủy đăng ký này?');">
                                    <i class="fas fa-times me-1"></i> Hủy
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
                                <h5 class="mb-0"><i class="fas fa-car me-2"></i>Thông tin đăng ký gửi xe</h5>
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered">
                                    <tr>
                                        <th width="40%">ID đăng ký:</th>
                                        <td>${registration.parkingId}</td>
                                    </tr>
                                    <tr>
                                        <th>Căn hộ:</th>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/apartments/view/${registration.apartment.apartmentId}">
                                                ${registration.apartment.apartmentNumber}
                                            </a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Người đăng ký:</th>
                                        <td>${registration.requester.fullName}</td>
                                    </tr>
                                    <tr>
                                        <th>Ngày đăng ký:</th>
                                        <td><fmt:formatDate value="${registration.registrationDate}" pattern="dd/MM/yyyy" /></td>
                                    </tr>
                                    <tr>
                                        <th>Trạng thái:</th>
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
                                    </tr>
                                </table>
                            </div>
                        </div>
                        
                        <div class="card mb-4">
                            <div class="card-header bg-info text-white">
                                <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Thông tin phương tiện</h5>
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered">
                                    <tr>
                                        <th width="40%">Loại xe:</th>
                                        <td>${registration.vehicleType}</td>
                                    </tr>
                                    <tr>
                                        <th>Biển số xe:</th>
                                        <td>${registration.licensePlate}</td>
                                    </tr>
                                    <tr>
                                        <th>Hãng xe:</th>
                                        <td>${registration.vehicleBrand}</td>
                                    </tr>
                                    <tr>
                                        <th>Model:</th>
                                        <td>${registration.vehicleModel}</td>
                                    </tr>
                                    <tr>
                                        <th>Màu sắc:</th>
                                        <td>${registration.vehicleColor}</td>
                                    </tr>
                                </table>
                                
                                <c:if test="${not empty registration.vehicleDescription}">
                                    <p class="mt-3"><strong>Mô tả thêm:</strong></p>
                                    <div class="p-3 bg-light rounded">
                                        <p class="mb-0">${registration.vehicleDescription}</p>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <div class="card mb-4">
                            <div class="card-header bg-success text-white">
                                <h5 class="mb-0"><i class="fas fa-money-bill-wave me-2"></i>Thông tin thanh toán</h5>
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered">
                                    <tr>
                                        <th width="40%">Phí hàng tháng:</th>
                                        <td><fmt:formatNumber value="${registration.monthlyFee}" type="currency" currencySymbol="₫" /></td>
                                    </tr>
                                    <tr>
                                        <th>Ngày bắt đầu tính phí:</th>
                                        <td><fmt:formatDate value="${registration.startDate}" pattern="dd/MM/yyyy" /></td>
                                    </tr>
                                    <tr>
                                        <th>Ngày hết hạn:</th>
                                        <td>
                                            <c:if test="${registration.endDate != null}">
                                                <fmt:formatDate value="${registration.endDate}" pattern="dd/MM/yyyy" />
                                            </c:if>
                                            <c:if test="${registration.endDate == null}">
                                                <span class="text-muted">Không xác định</span>
                                            </c:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Vị trí đỗ xe:</th>
                                        <td>${registration.parkingSlot}</td>
                                    </tr>
                                </table>
                                
                                <div class="card mt-3 bg-light">
                                    <div class="card-body">
                                        <h6>Lịch sử thanh toán</h6>
                                        <c:if test="${empty paymentHistory}">
                                            <p class="text-muted mb-0">Chưa có lịch sử thanh toán</p>
                                        </c:if>
                                        <c:if test="${not empty paymentHistory}">
                                            <div class="table-responsive">
                                                <table class="table table-sm table-striped">
                                                    <thead>
                                                        <tr>
                                                            <th>Kỳ thanh toán</th>
                                                            <th>Số tiền</th>
                                                            <th>Ngày thanh toán</th>
                                                            <th>Trạng thái</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="payment" items="${paymentHistory}">
                                                            <tr>
                                                                <td>${payment.month}/${payment.year}</td>
                                                                <td><fmt:formatNumber value="${payment.amount}" type="currency" currencySymbol="₫" /></td>
                                                                <td><fmt:formatDate value="${payment.paymentDate}" pattern="dd/MM/yyyy" /></td>
                                                                <td>
                                                                    <c:if test="${payment.paid}">
                                                                        <span class="badge bg-success">Đã thanh toán</span>
                                                                    </c:if>
                                                                    <c:if test="${!payment.paid}">
                                                                        <span class="badge bg-danger">Chưa thanh toán</span>
                                                                    </c:if>
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
                        
                        <div class="card mb-4">
                            <div class="card-header bg-warning text-dark">
                                <h5 class="mb-0"><i class="fas fa-user me-2"></i>Thông tin liên hệ</h5>
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered">
                                    <tr>
                                        <th width="40%">Chủ xe:</th>
                                        <td>${registration.ownerName}</td>
                                    </tr>
                                    <tr>
                                        <th>Số điện thoại:</th>
                                        <td>${registration.ownerPhone}</td>
                                    </tr>
                                    <tr>
                                        <th>Email:</th>
                                        <td>${registration.ownerEmail}</td>
                                    </tr>
                                </table>
                                
                                <c:if test="${not empty registration.emergencyContact}">
                                    <p class="mt-3"><strong>Liên hệ khẩn cấp:</strong></p>
                                    <table class="table table-bordered">
                                        <tr>
                                            <th width="40%">Tên:</th>
                                            <td>${registration.emergencyContact}</td>
                                        </tr>
                                        <tr>
                                            <th>Số điện thoại:</th>
                                            <td>${registration.emergencyPhone}</td>
                                        </tr>
                                    </table>
                                </c:if>
                                
                                <c:if test="${not empty registration.notes}">
                                    <p class="mt-3"><strong>Ghi chú:</strong></p>
                                    <div class="p-3 bg-light rounded">
                                        <p class="mb-0">${registration.notes}</p>
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