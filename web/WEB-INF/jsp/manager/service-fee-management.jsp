<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý phí dịch vụ - Hệ thống quản lý chung cư</title>
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
                    <h1 class="h2">Quản lý phí dịch vụ</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="${pageContext.request.contextPath}/service-fees/add" class="btn btn-sm btn-outline-secondary">
                                <i class="fas fa-plus"></i> Thêm phí
                            </a>
                            <a href="${pageContext.request.contextPath}/service-fees/generate" class="btn btn-sm btn-outline-primary">
                                <i class="fas fa-cogs"></i> Tạo phí tự động
                            </a>
                        </div>
                        <a href="${pageContext.request.contextPath}/service-fees/by-month" class="btn btn-sm btn-outline-success">
                            <i class="fas fa-calendar-alt"></i> Xem theo tháng
                        </a>
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
                
                <!-- Thống kê -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="card text-white bg-primary h-100">
                            <div class="card-body">
                                <h5 class="card-title">Tổng số phí</h5>
                                <p class="card-text display-4">${totalCount}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-success h-100">
                            <div class="card-body">
                                <h5 class="card-title">Đã thanh toán</h5>
                                <p class="card-text display-4">${paidCount}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-danger h-100">
                            <div class="card-body">
                                <h5 class="card-title">Chưa thanh toán</h5>
                                <p class="card-text display-4">${unpaidCount}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-info h-100">
                            <div class="card-body">
                                <h5 class="card-title">Tổng tiền</h5>
                                <p class="card-text fs-4"><fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="₫" /></p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Lọc và tìm kiếm -->
                <div class="row mb-3">
                    <div class="col-md-3">
                        <input type="text" id="apartmentFilter" class="form-control" placeholder="Tìm căn hộ..." onkeyup="filterTable()">
                    </div>
                    <div class="col-md-3">
                        <select id="monthFilter" class="form-select" onchange="filterTable()">
                            <option value="">-- Tất cả tháng --</option>
                            <c:forEach var="i" begin="1" end="12">
                                <option value="${i}">Tháng ${i}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select id="yearFilter" class="form-select" onchange="filterTable()">
                            <option value="">-- Tất cả năm --</option>
                            <c:forEach var="i" begin="2020" end="2025">
                                <option value="${i}">${i}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select id="statusFilter" class="form-select" onchange="filterTable()">
                            <option value="">-- Tất cả trạng thái --</option>
                            <option value="Đã thanh toán">Đã thanh toán</option>
                            <option value="Chưa thanh toán">Chưa thanh toán</option>
                        </select>
                    </div>
                </div>
                
                <div class="table-responsive">
                    <table class="table table-striped table-hover" id="feesTable">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Căn hộ</th>
                                <th>Loại phí</th>
                                <th>Thời gian</th>
                                <th>Số tiền</th>
                                <th>Ngày phát hành</th>
                                <th>Ngày thanh toán</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty serviceFees}">
                                <tr>
                                    <td colspan="9" class="text-center">Không có dữ liệu phí dịch vụ</td>
                                </tr>
                            </c:if>
                            <c:forEach var="fee" items="${serviceFees}">
                                <tr>
                                    <td>${fee.feeId}</td>
                                    <td>${fee.apartment.apartmentNumber}</td>
                                    <td>${fee.serviceType.typeName}</td>
                                    <td>${fee.month}/${fee.year}</td>
                                    <td><fmt:formatNumber value="${fee.amount}" type="currency" currencySymbol="₫" /></td>
                                    <td><fmt:formatDate value="${fee.issueDate}" pattern="dd/MM/yyyy" /></td>
                                    <td><fmt:formatDate value="${fee.paymentDate}" pattern="dd/MM/yyyy" /></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${fee.status eq 'Đã thanh toán'}">
                                                <span class="badge bg-success">Đã thanh toán</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger">Chưa thanh toán</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="btn-group">
                                            <a href="${pageContext.request.contextPath}/service-fees/view/${fee.feeId}" class="btn btn-sm btn-primary">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/service-fees/edit/${fee.feeId}" class="btn btn-sm btn-warning">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <c:if test="${fee.status ne 'Đã thanh toán'}">
                                                <a href="${pageContext.request.contextPath}/service-fees/mark-as-paid/${fee.feeId}" 
                                                   class="btn btn-sm btn-success"
                                                   onclick="return confirm('Bạn có chắc chắn muốn đánh dấu đã thanh toán?');">
                                                    <i class="fas fa-check"></i>
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
                                <a class="page-link" href="${pageContext.request.contextPath}/manager/service-fees?page=${currentPage - 1}">Trước</a>
                            </li>
                            
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/manager/service-fees?page=${i}">${i}</a>
                                </li>
                            </c:forEach>
                            
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/manager/service-fees?page=${currentPage + 1}">Sau</a>
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
        function filterTable() {
            const apartmentInput = document.getElementById('apartmentFilter').value.toLowerCase();
            const monthSelect = document.getElementById('monthFilter').value;
            const yearSelect = document.getElementById('yearFilter').value;
            const statusSelect = document.getElementById('statusFilter').value;
            
            const table = document.getElementById('feesTable');
            const rows = table.getElementsByTagName('tr');
            
            for (let i = 1; i < rows.length; i++) {
                const apartment = rows[i].cells[1] ? rows[i].cells[1].textContent.toLowerCase() : '';
                const monthYear = rows[i].cells[3] ? rows[i].cells[3].textContent : ''; // Format: "MM/YYYY"
                let month = '';
                let year = '';
                
                if (monthYear) {
                    const parts = monthYear.split('/');
                    if (parts.length == 2) {
                        month = parts[0];
                        year = parts[1];
                    }
                }
                
                const status = rows[i].cells[7] ? rows[i].cells[7].textContent.trim() : '';
                
                let showRow = true;
                
                if (apartmentInput && !apartment.includes(apartmentInput)) {
                    showRow = false;
                }
                
                if (monthSelect && month !== monthSelect) {
                    showRow = false;
                }
                
                if (yearSelect && year !== yearSelect) {
                    showRow = false;
                }
                
                if (statusSelect && !status.includes(statusSelect)) {
                    showRow = false;
                }
                
                rows[i].style.display = showRow ? '' : 'none';
            }
        }
    </script>
</body>
</html>