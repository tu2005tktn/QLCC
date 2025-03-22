<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yêu cầu - Căn hộ ${apartment.apartmentNumber} - Hệ thống quản lý chung cư</title>
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
        <h1 class="h2">Yêu cầu - Căn hộ ${apartment.apartmentNumber}</h1>
        <div class="btn-toolbar mb-2 mb-md-0">
            <a href="${pageContext.request.contextPath}/apartments/view/${apartment.apartmentId}" class="btn btn-sm btn-outline-secondary me-2">
                <i class="fas fa-arrow-left me-1"></i> Quay lại
            </a>
            <c:if test="${sessionScope.user.role.roleName eq 'OWNER' || sessionScope.user.role.roleName eq 'TENANT'}">
                <a href="${pageContext.request.contextPath}/requests/create" class="btn btn-sm btn-primary">
                    <i class="fas fa-plus me-1"></i> Tạo yêu cầu
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
    
    <!-- Lọc theo trạng thái -->
    <div class="row mb-3">
        <div class="col-md-6">
            <form action="${pageContext.request.contextPath}/apartments/${apartment.apartmentId}/requests" method="get" class="d-flex">
                <select name="status" class="form-select me-2">
                    <option value="">-- Tất cả trạng thái --</option>
                    <option value="Đang chờ xử lý" ${param.status == 'Đang chờ xử lý' ? 'selected' : ''}>Đang chờ xử lý</option>
                    <option value="Đang xử lý" ${param.status == 'Đang xử lý' ? 'selected' : ''}>Đang xử lý</option>
                    <option value="Hoàn thành" ${param.status == 'Hoàn thành' ? 'selected' : ''}>Hoàn thành</option>
                    <option value="Từ chối" ${param.status == 'Từ chối' ? 'selected' : ''}>Từ chối</option>
                    <option value="Đã hủy" ${param.status == 'Đã hủy' ? 'selected' : ''}>Đã hủy</option>
                </select>
                <button type="submit" class="btn btn-outline-primary">Lọc</button>
            </form>
        </div>
        <div class="col-md-6">
            <form action="${pageContext.request.contextPath}/apartments/${apartment.apartmentId}/requests" method="get" class="d-flex">
                <input type="text" name="keyword" class="form-control me-2" placeholder="Tìm kiếm tiêu đề..." value="${param.keyword}">
                <button type="submit" class="btn btn-outline-primary">Tìm kiếm</button>
            </form>
        </div>
    </div>
    
    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0"><i class="fas fa-clipboard-list me-2"></i>Danh sách yêu cầu</h5>
        </div>
        <div class="card-body">
            <c:if test="${empty requests}">
                <div class="alert alert-info">
                    <i class="fas fa-info-circle me-2"></i> Không có yêu cầu nào với điều kiện tìm kiếm hiện tại.
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
                                        <div class="btn-group">
                                            <a href="${pageContext.request.contextPath}/requests/view/${request.requestId}" class="btn btn-sm btn-primary">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <c:if test="${request.status eq 'Đang chờ xử lý' && request.requesterId == sessionScope.user.userId}">
                                                <a href="${pageContext.request.contextPath}/requests/update/${request.requestId}" class="btn btn-sm btn-warning">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/requests/cancel/${request.requestId}" 
                                                   class="btn btn-sm btn-danger"
                                                   onclick="return confirm('Bạn có chắc chắn muốn hủy yêu cầu này?');">
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