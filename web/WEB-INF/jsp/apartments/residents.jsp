<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách cư dân - Hệ thống quản lý chung cư</title>
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
        <h1 class="h2">Danh sách cư dân - Căn hộ ${apartment.apartmentNumber}</h1>
        <div class="btn-toolbar mb-2 mb-md-0">
            <a href="${pageContext.request.contextPath}/apartments/view/${apartment.apartmentId}" class="btn btn-sm btn-outline-secondary me-2">
                <i class="fas fa-arrow-left me-1"></i> Quay lại
            </a>
            <c:if test="${sessionScope.user.role.roleName eq 'ADMIN' || sessionScope.user.role.roleName eq 'MANAGER' || (sessionScope.user.role.roleName eq 'OWNER' && owner.userId == sessionScope.user.userId)}">
                <a href="${pageContext.request.contextPath}/apartments/${apartment.apartmentId}/residents/add" class="btn btn-sm btn-primary">
                    <i class="fas fa-plus me-1"></i> Thêm cư dân
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
    
    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0"><i class="fas fa-users me-2"></i>Danh sách cư dân</h5>
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
    
    </main>
    </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>