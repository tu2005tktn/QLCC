<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yêu cầu đang chờ xử lý - Hệ thống quản lý chung cư</title>
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
                    <h1 class="h2">Yêu cầu đang chờ xử lý</h1>
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
                    <div class="col-md-6">
                        <form class="d-flex" action="${pageContext.request.contextPath}/manager/pending-requests" method="get">
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
                        <select id="priorityFilter" class="form-select" onchange="filterByPriority()">
                            <option value="">-- Tất cả mức ưu tiên --</option>
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
                                <th>Căn hộ</th>
                                <th>Tiêu đề</th>
                                <th>Loại yêu cầu</th>
                                <th>Người yêu cầu</th>
                                <th>Ngày tạo</th>
                                <th>Ưu tiên</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty pendingRequests}">
                                <tr>
                                    <td colspan="8" class="text-center">Không có yêu cầu nào đang chờ xử lý</td>
                                </tr>
                            </c:if>
                            <c:forEach var="request" items="${pendingRequests}">
                                <tr>
                                    <td>${request.requestId}</td>
                                    <td>${request.apartment.apartmentNumber}</td>
                                    <td>${request.title}</td>
                                    <td>${request.requestType.typeName}</td>
                                    <td>${request.requester.fullName}</td>
                                    <td><fmt:formatDate value="${request.requestDate}" pattern="dd/MM/yyyy" /></td>
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
                                            <a href="${pageContext.request.contextPath}/requests/assign/${request.requestId}" class="btn btn-sm btn-success">
                                                <i class="fas fa-user-plus"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/requests/update-progress/${request.requestId}" class="btn btn-sm btn-warning">
                                                <i class="fas fa-edit"></i>
                                            </a>
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
                                <a class="page-link" href="${pageContext.request.contextPath}/manager/pending-requests?page=${currentPage - 1}&keyword=${param.keyword}&typeId=${param.typeId}&priority=${param.priority}">Trước</a>
                            </li>
                            
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/manager/pending-requests?page=${i}&keyword=${param.keyword}&typeId=${param.typeId}&priority=${param.priority}">${i}</a>
                                </li>
                            </c:forEach>
                            
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/manager/pending-requests?page=${currentPage + 1}&keyword=${param.keyword}&typeId=${param.typeId}&priority=${param.priority}">Sau</a>
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