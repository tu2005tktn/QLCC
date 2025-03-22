<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Hệ thống quản lý chung cư</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <jsp:include page="../common/resident-header.jsp"/>
    
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="../common/resident-sidebar.jsp"/>
            
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Trang chủ</h1>
                </div>
                
                <div class="alert alert-info" role="alert">
                    <h4 class="alert-heading"><i class="fas fa-info-circle me-2"></i>Xin chào, ${sessionScope.user.fullName}!</h4>
                    <p>Chào mừng bạn đến với hệ thống quản lý chung cư. Đây là trang chủ của bạn, nơi bạn có thể xem các thông tin quan trọng về căn hộ và các dịch vụ.</p>
                </div>
                
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="card h-100">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0"><i class="fas fa-building me-2"></i>Thông tin căn hộ</h5>
                            </div>
                            <div class="card-body">
                                <c:if test="${not empty apartment}">
                                    <table class="table table-borderless">
                                        <tr>
                                            <th width="40%">Căn hộ:</th>
                                            <td><strong>${apartment.apartmentNumber}</strong></td>
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
                                            <td>${apartment.status}</td>
                                        </tr>
                                        <tr>
                                            <th>Số thành viên:</th>
                                            <td>${residentCount} người</td>
                                        </tr>
                                    </table>
                                    <a href="${pageContext.request.contextPath}/residents/list" class="btn btn-outline-primary">
                                        <i class="fas fa-users me-2"></i>Xem danh sách thành viên
                                    </a>
                                </c:if>
                                <c:if test="${empty apartment}">
                                    <div class="alert alert-warning">
                                        Bạn chưa được gán với căn hộ nào. Vui lòng liên hệ ban quản lý!
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <div class="card h-100">
                            <div class="card-header bg-danger text-white">
                                <h5 class="mb-0"><i class="fas fa-file-invoice-dollar me-2"></i>Phí dịch vụ chưa thanh toán</h5>
                            </div>
                            <div class="card-body">
                                <c:if test="${empty unpaidFees}">
                                    <div class="alert alert-success">
                                        <i class="fas fa-check-circle me-2"></i>Bạn không có khoản phí nào chưa thanh toán!
                                    </div>
                                </c:if>
                                <c:if test="${not empty unpaidFees}">
                                    <div class="table-responsive">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Loại phí</th>
                                                    <th>Thời gian</th>
                                                    <th>Số tiền</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="fee" items="${unpaidFees}" varStatus="status">
                                                    <c:if test="${status.index < 3}">
                                                        <tr>
                                                            <td>${fee.serviceType.typeName}</td>
                                                            <td>${fee.month}/${fee.year}</td>
                                                            <td class="text-end"><fmt:formatNumber value="${fee.amount}" type="currency" currencySymbol="₫" /></td>
                                                        </tr>
                                                    </c:if>
                                                </c:forEach>
                                            </tbody>
                                            <tfoot>
                                                <tr class="fw-bold">
                                                    <td colspan="2">Tổng cộng:</td>
                                                    <td class="text-end"><fmt:formatNumber value="${totalUnpaid}" type="currency" currencySymbol="₫" /></td>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/resident/service-fees" class="btn btn-danger">
                                        <i class="fas fa-credit-card me-2"></i>Thanh toán ngay
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="row mb-4">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header bg-success text-white">
                                <h5 class="mb-0"><i class="fas fa-clipboard-list me-2"></i>Yêu cầu gần đây</h5>
                            </div>
                            <div class="card-body">
                                <c:if test="${empty recentRequests}">
                                    <div class="alert alert-info">
                                        Bạn chưa có yêu cầu nào. <a href="${pageContext.request.contextPath}/requests/create" class="alert-link">Tạo yêu cầu mới</a>
                                    </div>
                                </c:if>
                                <c:if test="${not empty recentRequests}">
                                    <div class="table-responsive">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Tiêu đề</th>
                                                    <th>Loại yêu cầu</th>
                                                    <th>Ngày tạo</th>
                                                    <th>Trạng thái</th>
                                                    <th>Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="request" items="${recentRequests}">
                                                    <tr>
                                                        <td>${request.title}</td>
                                                        <td>${request.requestType.typeName}</td>
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
                                                                <c:otherwise>
                                                                    <span class="badge bg-secondary">${request.status}</span>
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
                                    <div class="d-flex justify-content-between align-items-center">
                                        <a href="${pageContext.request.contextPath}/requests/create" class="btn btn-success">
                                            <i class="fas fa-plus me-2"></i>Tạo yêu cầu mới
                                        </a>
                                        <a href="${pageContext.request.contextPath}/resident/requests" class="btn btn-outline-secondary">
                                            Xem tất cả yêu cầu <i class="fas fa-arrow-right ms-1"></i>
                                        </a>
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