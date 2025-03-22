<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký chuyển đồ đang chờ - Hệ thống quản lý chung cư</title>
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
                    <h1 class="h2">Đăng ký chuyển đồ đang chờ phê duyệt</h1>
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
                        <form class="d-flex" action="${pageContext.request.contextPath}/manager/pending-movings" method="get">
                            <input class="form-control me-2" type="search" placeholder="Tìm kiếm căn hộ..." name="keyword" value="${param.keyword}">
                            <button class="btn btn-outline-primary" type="submit">Tìm kiếm</button>
                        </form>
                    </div>
                    <div class="col-md-3">
                        <select id="typeFilter" class="form-select" onchange="filterByType()">
                            <option value="">-- Tất cả loại chuyển đồ --</option>
                            <option value="Vào" ${param.type == 'Vào' ? 'selected' : ''}>Vào</option>
                            <option value="Ra" ${param.type == 'Ra' ? 'selected' : ''}>Ra</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <input type="date" id="dateFilter" class="form-control" onchange="filterByDate()" value="${param.date}">
                    </div>
                </div>
                
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Căn hộ</th>
                                <th>Người đăng ký</th>
                                <th>Loại chuyển đồ</th>
                                <th>Ngày đăng ký</th>
                                <th>Ngày chuyển đồ</th>
                                <th>Thông tin vật dụng</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty pendingMovings}">
                                <tr>
                                    <td colspan="8" class="text-center">Không có đăng ký chuyển đồ nào đang chờ phê duyệt</td>
                                </tr>
                            </c:if>
                            <c:forEach var="moving" items="${pendingMovings}">
                                <tr>
                                    <td>${moving.movingId}</td>
                                    <td>${moving.apartment.apartmentNumber}</td>
                                    <td>${moving.requester.fullName}</td>
                                    <td>
                                        <span class="badge ${moving.movingType eq 'Vào' ? 'bg-success' : 'bg-warning'}">
                                            ${moving.movingType}
                                        </span>
                                    </td>
                                    <td><fmt:formatDate value="${moving.registrationDate}" pattern="dd/MM/yyyy" /></td>
                                    <td><fmt:formatDate value="${moving.movingDate}" pattern="dd/MM/yyyy" /></td>
                                    <td>
                                        <button type="button" class="btn btn-sm btn-info" data-bs-toggle="modal" data-bs-target="#itemsModal${moving.movingId}">
                                            <i class="fas fa-box"></i> Chi tiết
                                        </button>
                                        
                                        <!-- Modal hiển thị danh sách vật dụng -->
                                        <div class="modal fade" id="itemsModal${moving.movingId}" tabindex="-1" aria-labelledby="itemsModalLabel${moving.movingId}" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="itemsModalLabel${moving.movingId}">Danh sách vật dụng</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <p><strong>Mô tả:</strong> ${moving.itemsDescription}</p>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="btn-group">
                                            <a href="${pageContext.request.contextPath}/moving/view/${moving.movingId}" class="btn btn-sm btn-primary">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/moving/approve/${moving.movingId}" class="btn btn-sm btn-success"
                                               onclick="return confirm('Bạn có chắc muốn phê duyệt đăng ký chuyển đồ này?');">
                                                <i class="fas fa-check"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/moving/reject/${moving.movingId}" class="btn btn-sm btn-danger"
                                               onclick="return confirm('Bạn có chắc muốn từ chối đăng ký chuyển đồ này?');">
                                                <i class="fas fa-times"></i>
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
                                <a class="page-link" href="${pageContext.request.contextPath}/manager/pending-movings?page=${currentPage - 1}&keyword=${param.keyword}&type=${param.type}&date=${param.date}">Trước</a>
                            </li>
                            
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/manager/pending-movings?page=${i}&keyword=${param.keyword}&type=${param.type}&date=${param.date}">${i}</a>
                                </li>
                            </c:forEach>
                            
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/manager/pending-movings?page=${currentPage + 1}&keyword=${param.keyword}&type=${param.type}&date=${param.date}">Sau</a>
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