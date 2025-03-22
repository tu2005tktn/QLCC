<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký chuyển đồ - Hệ thống quản lý chung cư</title>
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
        <h1 class="h2">Đăng ký chuyển đồ</h1>
        <div class="btn-toolbar mb-2 mb-md-0">
            <c:if test="${sessionScope.user.role.roleName eq 'OWNER' || sessionScope.user.role.roleName eq 'TENANT'}">
                <a href="${pageContext.request.contextPath}/moving/create" class="btn btn-primary">
                    <i class="fas fa-plus me-1"></i> Tạo đăng ký mới
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
    
    <!-- Lọc và tìm kiếm -->
    <div class="row mb-3">
        <div class="col-md-4">
            <form class="d-flex" action="${pageContext.request.contextPath}/moving/list" method="get">
                <input class="form-control me-2" type="search" placeholder="Tìm kiếm..." name="keyword" value="${param.keyword}">
                <button class="btn btn-outline-primary" type="submit">Tìm kiếm</button>
            </form>
        </div>
        <div class="col-md-3">
            <select id="statusFilter" class="form-select" onchange="filterByStatus()">
                <option value="">-- Tất cả trạng thái --</option>
                <option value="Đang chờ phê duyệt" ${param.status == 'Đang chờ phê duyệt' ? 'selected' : ''}>Đang chờ phê duyệt</option>
                <option value="Đã phê duyệt" ${param.status == 'Đã phê duyệt' ? 'selected' : ''}>Đã phê duyệt</option>
                <option value="Đã từ chối" ${param.status == 'Đã từ chối' ? 'selected' : ''}>Đã từ chối</option>
                <option value="Đã hủy" ${param.status == 'Đã hủy' ? 'selected' : ''}>Đã hủy</option>
                <option value="Đã hoàn thành" ${param.status == 'Đã hoàn thành' ? 'selected' : ''}>Đã hoàn thành</option>
            </select>
        </div>
        <div class="col-md-3">
            <select id="typeFilter" class="form-select" onchange="filterByType()">
                <option value="">-- Tất cả loại chuyển đồ --</option>
                <option value="Vào" ${param.type == 'Vào' ? 'selected' : ''}>Vào</option>
                <option value="Ra" ${param.type == 'Ra' ? 'selected' : ''}>Ra</option>
            </select>
        </div>
        <div class="col-md-2">
            <input type="date" id="dateFilter" class="form-control" onchange="filterByDate()" value="${param.date}">
        </div>
    </div>
    
    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0"><i class="fas fa-dolly me-2"></i>Danh sách đăng ký chuyển đồ</h5>
        </div>
        <div class="card-body">
            <c:if test="${empty registrations}">
                <div class="alert alert-info">
                    <i class="fas fa-info-circle me-2"></i> Không có đăng ký chuyển đồ nào.
                </div>
            </c:if>
            
            <c:if test="${not empty registrations}">
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Căn hộ</th>
                                <th>Loại</th>
                                <th>Ngày chuyển</th>
                                <th>Thời gian</th>
                                <th>Người đăng ký</th>
                                <th>Ngày đăng ký</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="registration" items="${registrations}">
                                <tr>
                                    <td>${registration.movingId}</td>
                                    <td>${registration.apartment.apartmentNumber}</td>
                                    <td>
                                        <span class="badge ${registration.movingType eq 'Vào' ? 'bg-success' : 'bg-warning'}">
                                            ${registration.movingType}
                                        </span>
                                    </td>
                                    <td><fmt:formatDate value="${registration.movingDate}" pattern="dd/MM/yyyy" /></td>
                                    <td>
                                        <fmt:formatDate value="${registration.startTime}" pattern="HH:mm" /> - 
                                        <fmt:formatDate value="${registration.endTime}" pattern="HH:mm" />
                                    </td>
                                    <td>${registration.requester.fullName}</td>
                                    <td><fmt:formatDate value="${registration.registrationDate}" pattern="dd/MM/yyyy" /></td>
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
                                    <td>
                                        <div class="btn-group">
                                            <a href="${pageContext.request.contextPath}/moving/view/${registration.movingId}" class="btn btn-sm btn-primary">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            
                                            <c:if test="${(sessionScope.user.role.roleName eq 'ADMIN' || sessionScope.user.role.roleName eq 'MANAGER') && registration.status eq 'Đang chờ phê duyệt'}">
                                                <a href="${pageContext.request.contextPath}/moving/approve/${registration.movingId}" 
                                                   class="btn btn-sm btn-success"
                                                   onclick="return confirm('Bạn có chắc muốn phê duyệt đơn này?')">
                                                    <i class="fas fa-check"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/moving/reject/${registration.movingId}" 
                                                   class="btn btn-sm btn-danger"
                                                   onclick="return confirm('Bạn có chắc muốn từ chối đơn này?')">
                                                    <i class="fas fa-times"></i>
                                                </a>
                                            </c:if>
                                            
                                            <c:if test="${registration.requesterId == sessionScope.user.userId && registration.status eq 'Đang chờ phê duyệt'}">
                                                <a href="${pageContext.request.contextPath}/moving/update/${registration.movingId}" class="btn btn-sm btn-warning">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/moving/cancel/${registration.movingId}" 
                                                   class="btn btn-sm btn-danger"
                                                   onclick="return confirm('Bạn có chắc muốn hủy đơn này?')">
                                                    <i class="fas fa-ban"></i>
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
                                <a class="page-link" href="${pageContext.request.contextPath}/moving/list?page=${currentPage - 1}&keyword=${param.keyword}&status=${param.status}&type=${param.type}&date=${param.date}">Trước</a>
                            </li>
                            
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/moving/list?page=${i}&keyword=${param.keyword}&status=${param.status}&type=${param.type}&date=${param.date}">${i}</a>
                                </li>
                            </c:forEach>
                            
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/moving/list?page=${currentPage + 1}&keyword=${param.keyword}&status=${param.status}&type=${param.type}&date=${param.date}">Sau</a>
                            </li>
                        </ul>
                    </nav>
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
        
        function filterByType() {
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
        
        function filterByDate() {
            const date = document.getElementById('dateFilter').value;
            const currentUrl = new URL(window.location.href);
            if (date) {
                currentUrl.searchParams.set('date', date);
            } else {
                currentUrl.searchParams.delete('date');
            }
            currentUrl.searchParams.set('page', 1);
            window.location.href = currentUrl.toString();
        }
    </script>
</body>
</html>