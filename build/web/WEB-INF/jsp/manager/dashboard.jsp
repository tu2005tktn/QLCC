<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manager Dashboard - Hệ thống quản lý chung cư</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.css">
</head>
<body>
    <jsp:include page="../common/manager-header.jsp"/>
    
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="../common/manager-sidebar.jsp"/>
            
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Dashboard</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <button type="button" class="btn btn-sm btn-outline-secondary dropdown-toggle">
                            <i class="fas fa-calendar-alt me-1"></i> Hôm nay
                        </button>
                    </div>
                </div>
                
                <div class="row mb-4">
                    <div class="col-md-3 mb-4">
                        <div class="card text-white bg-primary h-100">
                            <div class="card-body d-flex align-items-center">
                                <i class="fas fa-building fa-3x me-3"></i>
                                <div>
                                    <h5 class="card-title">Tổng số căn hộ</h5>
                                    <p class="card-text display-6">${apartmentCount}</p>
                                </div>
                            </div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <a href="${pageContext.request.contextPath}/manager/apartments" class="text-white text-decoration-none">
                                    Xem chi tiết
                                </a>
                                <i class="fas fa-angle-right text-white"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-3 mb-4">
                        <div class="card text-white bg-warning h-100">
                            <div class="card-body d-flex align-items-center">
                                <i class="fas fa-clipboard-list fa-3x me-3"></i>
                                <div>
                                    <h5 class="card-title">Yêu cầu đang chờ</h5>
                                    <p class="card-text display-6">${pendingRequestCount}</p>
                                </div>
                            </div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <a href="${pageContext.request.contextPath}/manager/pending-requests" class="text-white text-decoration-none">
                                    Xem chi tiết
                                </a>
                                <i class="fas fa-angle-right text-white"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-3 mb-4">
                        <div class="card text-white bg-success h-100">
                            <div class="card-body d-flex align-items-center">
                                <i class="fas fa-dolly fa-3x me-3"></i>
                                <div>
                                    <h5 class="card-title">Đăng ký chuyển đồ</h5>
                                    <p class="card-text display-6">${pendingMovingCount}</p>
                                </div>
                            </div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <a href="${pageContext.request.contextPath}/manager/pending-movings" class="text-white text-decoration-none">
                                    Xem chi tiết
                                </a>
                                <i class="fas fa-angle-right text-white"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-3 mb-4">
                        <div class="card text-white bg-info h-100">
                            <div class="card-body d-flex align-items-center">
                                <i class="fas fa-user-tie fa-3x me-3"></i>
                                <div>
                                    <h5 class="card-title">Nhân viên</h5>
                                    <p class="card-text display-6">${staffList.size()}</p>
                                </div>
                            </div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <a href="${pageContext.request.contextPath}/manager/staff" class="text-white text-decoration-none">
                                    Xem chi tiết
                                </a>
                                <i class="fas fa-angle-right text-white"></i>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="card mb-4">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Yêu cầu gần đây</h5>
                            </div>
                            <div class="card-body">
                                <c:if test="${empty recentRequests}">
                                    <div class="alert alert-info">Không có yêu cầu nào gần đây.</div>
                                </c:if>
                                <c:if test="${not empty recentRequests}">
                                    <div class="table-responsive">
                                        <table class="table table-striped table-sm">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Căn hộ</th>
                                                    <th>Tiêu đề</th>
                                                    <th>Ngày tạo</th>
                                                    <th>Trạng thái</th>
                                                    <th>Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="request" items="${recentRequests}">
                                                    <tr>
                                                        <td>${request.requestId}</td>
                                                        <td>${request.apartment.apartmentNumber}</td>
                                                        <td>${request.title}</td>
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
                                    <div class="text-end mt-2">
                                        <a href="${pageContext.request.contextPath}/manager/pending-requests" class="btn btn-outline-primary btn-sm">
                                            Xem tất cả <i class="fas fa-arrow-right ms-1"></i>
                                        </a>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <div class="card mb-4">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Đăng ký chuyển đồ gần đây</h5>
                            </div>
                            <div class="card-body">
                                <c:if test="${empty recentMovings}">
                                    <div class="alert alert-info">Không có đăng ký chuyển đồ nào gần đây.</div>
                                </c:if>
                                <c:if test="${not empty recentMovings}">
                                    <div class="table-responsive">
                                        <table class="table table-striped table-sm">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Căn hộ</th>
                                                    <th>Loại</th>
                                                    <th>Ngày đăng ký</th>
                                                    <th>Ngày chuyển</th>
                                                    <th>Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="moving" items="${recentMovings}">
                                                    <tr>
                                                        <td>${moving.movingId}</td>
                                                        <td>${moving.apartment.apartmentNumber}</td>
                                                        <td>${moving.movingType}</td>
                                                        <td><fmt:formatDate value="${moving.registrationDate}" pattern="dd/MM/yyyy" /></td>
                                                        <td><fmt:formatDate value="${moving.movingDate}" pattern="dd/MM/yyyy" /></td>
                                                        <td>
                                                            <a href="${pageContext.request.contextPath}/moving/view/${moving.movingId}" class="btn btn-sm btn-primary">
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="text-end mt-2">
                                        <a href="${pageContext.request.contextPath}/manager/pending-movings" class="btn btn-outline-primary btn-sm">
                                            Xem tất cả <i class="fas fa-arrow-right ms-1"></i>
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
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
</body>
</html>