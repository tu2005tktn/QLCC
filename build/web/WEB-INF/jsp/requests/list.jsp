<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách yêu cầu - Hệ thống quản lý chung cư</title>
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
        <h1 class="h2">Danh sách yêu cầu</h1>
        <div class="btn-toolbar mb-2 mb-md-0">
            <c:if test="${sessionScope.user.role.roleName eq 'OWNER' || sessionScope.user.role.roleName eq 'TENANT'}">
                <a href="${pageContext.request.contextPath}/requests/create" class="btn btn-primary">
                    <i class="fas fa-plus me-1"></i> Tạo yêu cầu mới
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
            <form class="d-flex" action="${pageContext.request.contextPath}/requests/list" method="get">
                <input class="form-control me-2" type="search" placeholder="Tìm kiếm..." name="keyword" value="${param.keyword}">
                <button class="btn btn-outline-primary" type="submit">Tìm kiếm</button>
            </form>
        </div>
        <div class="col-md-3">
            <select id="typeFilter" class="form-select" onchange="filterByType()">
                <option value="">-- Tất cả loại yêu cầu --</option>
                <c:forEach var="type" items="${requestTypes}">
                    <option value="${type.requestTypeId}" ${param.typeId == type.requestTypeId ? 'selected' : ''}>${type.typeName}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-3">
            <select id="statusFilter" class="form-select" onchange="filterByStatus()">
                <option value="">-- Tất cả trạng thái --</option>
                <c:forEach var="status" items="${statusOptions}">
                    <option value="${status}" ${param.status == status ? 'selected' : ''}>${status}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-2">
            <select id="priorityFilter" class="form-select" onchange="filterByPriority()">
                <option value="">-- Mức ưu tiên --</option>
                <option value="Cao" ${param.priority == 'Cao' ? 'selected' : ''}>Cao</option>
                <option value="Bình thường" ${param.priority == 'Bình thường' ? 'selected' : ''}>Bình thường</option>
                <option value="Thấp" ${param.priority == 'Thấp' ? 'selected' : ''}>Thấp</option>
            </select>
        </div>
    </div>
    
    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tiêu đề</th>
                    <th>Căn hộ</th>
                    <th>Loại yêu cầu</th>
                    <th>Ngày tạo</th>
                    <th>Trạng thái</th>
                    <th>Ưu tiên</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty requests}">
                    <tr>
                        <td colspan="8" class="text-center">Không có yêu cầu nào</td>
                    </tr>
                </c:if>
                <c:forEach var="request" items="${requests}">
                    <tr>
                        <td>${request.requestId}</td>
                        <td>${request.title}</td>
                        <td>${request.apartment.apartmentNumber}</td>
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
                                
                                <c:if test="${(sessionScope.user.role.roleName eq 'ADMIN' || sessionScope.user.role.roleName eq 'MANAGER') && request.status eq 'Đang chờ xử lý'}">
                                    <a href="${pageContext.request.contextPath}/requests/assign/${request.requestId}" class="btn btn-sm btn-success">
                                        <i class="fas fa-user-plus"></i>
                                    </a>
                                </c:if>
                                
                                <c:if test="${(sessionScope.user.role.roleName eq 'ADMIN' || sessionScope.user.role.roleName eq 'MANAGER' || sessionScope.user.role.roleName eq 'STAFF') && (request.status eq 'Đang chờ xử lý' || request.status eq 'Đang xử lý')}">
                                    <a href="${pageContext.request.contextPath}/requests/update-progress/${request.requestId}" class="btn btn-sm btn-warning">
                                        <i class="fas fa-tasks"></i>
                                    </a>
                                </c:if>
                                
                                <c:if test="${request.requesterId == sessionScope.user.userId && request.status eq 'Đang chờ xử lý'}">
                                    <a href="${pageContext.request.contextPath}/requests/update/${request.requestId}" class="btn btn-sm btn-warning">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/requests/cancel/${request.requestId}" 
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Bạn có chắc muốn hủy yêu cầu này?')">
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
    
    <!-- Phân trang -->
    <c:if test="${totalPages > 1}">
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/requests/list?page=${currentPage - 1}&keyword=${param.keyword}&typeId=${param.typeId}&status=${param.status}&priority=${param.priority}">Trước</a>
                </li>
                
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/requests/list?page=${i}&keyword=${param.keyword}&typeId=${param.typeId}&status=${param.status}&priority=${param.priority}">${i}</a>
                    </li>
                </c:forEach>
                
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/requests/list?page=${currentPage + 1}&keyword=${param.keyword}&typeId=${param.typeId}&status=${param.status}&priority=${param.priority}">Sau</a>
                </li>
            </ul>
        </nav>
    </c:if>
    
    </main>
    </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
    <script>
        function filterByType() {
            const typeId = document.getElementById('typeFilter').value;
            const currentUrl = new URL(window.location.href);
            if (typeId) {
                currentUrl.searchParams.set('typeId', typeId);
            } else {
                currentUrl.searchParams.delete('typeId');
            }
            currentUrl.searchParams.set('page', 1);
            window.location.href = currentUrl.toString();
        }
        
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
        
        function filterByPriority() {
            const priority = document.getElementById('priorityFilter').value;
            const currentUrl = new URL(window.location.href);
            if (priority) {
                currentUrl.searchParams.set('priority', priority);
            } else {
                currentUrl.searchParams.delete('priority');
            }
            currentUrl.searchParams.set('page', 1);
            window.location.href = currentUrl.toString();
        }
    </script>
</body>
</html>