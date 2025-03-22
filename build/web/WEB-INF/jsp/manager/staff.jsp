<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý nhân viên - Hệ thống quản lý chung cư</title>
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
                    <h1 class="h2">Quản lý nhân viên</h1>
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
                
                <!-- Tìm kiếm nhân viên -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <form action="${pageContext.request.contextPath}/manager/staff" method="get" class="d-flex">
                            <input type="text" name="keyword" class="form-control me-2" placeholder="Tìm kiếm tên, email..." value="${param.keyword}">
                            <button type="submit" class="btn btn-outline-primary">Tìm kiếm</button>
                        </form>
                    </div>
                    <div class="col-md-6">
                        <div class="d-flex justify-content-end">
                            <div class="btn-group">
                                <a href="${pageContext.request.contextPath}/manager/staff?status=active" class="btn ${param.status == 'active' || param.status == null ? 'btn-primary' : 'btn-outline-primary'}">
                                    <i class="fas fa-user-check me-1"></i> Đang hoạt động
                                </a>
                                <a href="${pageContext.request.contextPath}/manager/staff?status=inactive" class="btn ${param.status == 'inactive' ? 'btn-primary' : 'btn-outline-primary'}">
                                    <i class="fas fa-user-times me-1"></i> Bị khóa
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0"><i class="fas fa-user-tie me-2"></i>Danh sách nhân viên</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Họ tên</th>
                                        <th>Email</th>
                                        <th>Số điện thoại</th>
                                        <th>Trạng thái</th>
                                        <th>Yêu cầu đang xử lý</th>
                                        <th>Tổng số yêu cầu đã hoàn thành</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:if test="${empty staffList}">
                                        <tr>
                                            <td colspan="8" class="text-center">Không có nhân viên nào</td>
                                        </tr>
                                    </c:if>
                                    <c:forEach var="staff" items="${staffList}">
                                        <tr>
                                            <td>${staff.userId}</td>
                                            <td>${staff.fullName}</td>
                                            <td>${staff.email}</td>
                                            <td>${staff.phone}</td>
                                            <td>
                                                <c:if test="${staff.status}">
                                                    <span class="badge bg-success">Hoạt động</span>
                                                </c:if>
                                                <c:if test="${!staff.status}">
                                                    <span class="badge bg-danger">Khóa</span>
                                                </c:if>
                                            </td>
                                            <td>
                                                <span class="badge bg-info">${staff.processingRequestCount}</span>
                                            </td>
                                            <td>
                                                <span class="badge bg-secondary">${staff.completedRequestCount}</span>
                                            </td>
                                            <td>
                                                <div class="btn-group">
                                                    <a href="${pageContext.request.contextPath}/manager/staff/${staff.userId}/view" class="btn btn-sm btn-primary">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <c:if test="${staff.status}">
                                                        <button type="button" class="btn btn-sm btn-danger" 
                                                                onclick="if(confirm('Bạn có chắc muốn khóa tài khoản nhân viên này?')) 
                                                                        window.location.href='${pageContext.request.contextPath}/manager/staff/${staff.userId}/toggle-status'">
                                                            <i class="fas fa-lock"></i>
                                                        </button>
                                                    </c:if>
                                                    <c:if test="${!staff.status}">
                                                        <button type="button" class="btn btn-sm btn-success" 
                                                                onclick="if(confirm('Bạn có chắc muốn kích hoạt tài khoản nhân viên này?')) 
                                                                        window.location.href='${pageContext.request.contextPath}/manager/staff/${staff.userId}/toggle-status'">
                                                            <i class="fas fa-unlock"></i>
                                                        </button>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <!-- Phân trang -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/manager/staff?page=${currentPage - 1}&keyword=${param.keyword}&status=${param.status}">Trước</a>
                            </li>
                            
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/manager/staff?page=${i}&keyword=${param.keyword}&status=${param.status}">${i}</a>
                                </li>
                            </c:forEach>
                            
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/manager/staff?page=${currentPage + 1}&keyword=${param.keyword}&status=${param.status}">Sau</a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </main>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>