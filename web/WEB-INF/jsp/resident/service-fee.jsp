<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phí dịch vụ - Hệ thống quản lý chung cư</title>
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
                    <h1 class="h2">Phí dịch vụ</h1>
                </div>
                
                <div class="row mb-4">
                    <div class="col">
                        <div class="card">
                            <div class="card-header">
                                <ul class="nav nav-tabs card-header-tabs" id="feeTab" role="tablist">
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link active" id="unpaid-tab" data-bs-toggle="tab" data-bs-target="#unpaid" type="button" role="tab" aria-controls="unpaid" aria-selected="true">Chưa thanh toán</button>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link" id="paid-tab" data-bs-toggle="tab" data-bs-target="#paid" type="button" role="tab" aria-controls="paid" aria-selected="false">Đã thanh toán</button>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link" id="all-tab" data-bs-toggle="tab" data-bs-target="#all" type="button" role="tab" aria-controls="all" aria-selected="false">Tất cả</button>
                                    </li>
                                </ul>
                            </div>
                            <div class="card-body">
                                <div class="tab-content" id="feeTabContent">
                                    <div class="tab-pane fade show active" id="unpaid" role="tabpanel" aria-labelledby="unpaid-tab">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-hover">
                                                <thead>
                                                    <tr>
                                                        <th scope="col">ID</th>
                                                        <th scope="col">Loại phí</th>
                                                        <th scope="col">Kỳ</th>
                                                        <th scope="col">Số tiền</th>
                                                        <th scope="col">Ngày phát hành</th>
                                                        <th scope="col">Trạng thái</th>
                                                        <th scope="col">Chi tiết</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="fee" items="${serviceFees}">
                                                        <c:if test="${fee.status == 'Chưa thanh toán'}">
                                                            <tr>
                                                                <td>${fee.feeId}</td>
                                                                <td>${fee.serviceType.typeName}</td>
                                                                <td>${fee.month}/${fee.year}</td>
                                                                <td><fmt:formatNumber value="${fee.amount}" type="currency" currencySymbol="VNĐ" maxFractionDigits="0" /></td>
                                                                <td><fmt:formatDate value="${fee.issueDate}" pattern="dd/MM/yyyy" /></td>
                                                                <td><span class="badge bg-warning">${fee.status}</span></td>
                                                                <td><button class="btn btn-sm btn-primary view-details" data-id="${fee.feeId}">Chi tiết</button></td>
                                                            </tr>
                                                        </c:if>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="paid" role="tabpanel" aria-labelledby="paid-tab">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-hover">
                                                <thead>
                                                    <tr>
                                                        <th scope="col">ID</th>
                                                        <th scope="col">Loại phí</th>
                                                        <th scope="col">Kỳ</th>
                                                        <th scope="col">Số tiền</th>
                                                        <th scope="col">Ngày phát hành</th>
                                                        <th scope="col">Ngày thanh toán</th>
                                                        <th scope="col">Trạng thái</th>
                                                        <th scope="col">Chi tiết</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="fee" items="${serviceFees}">
                                                        <c:if test="${fee.status == 'Đã thanh toán'}">
                                                            <tr>
                                                                <td>${fee.feeId}</td>
                                                                <td>${fee.serviceType.typeName}</td>
                                                                <td>${fee.month}/${fee.year}</td>
                                                                <td><fmt:formatNumber value="${fee.amount}" type="currency" currencySymbol="VNĐ" maxFractionDigits="0" /></td>
                                                                <td><fmt:formatDate value="${fee.issueDate}" pattern="dd/MM/yyyy" /></td>
                                                                <td><fmt:formatDate value="${fee.paymentDate}" pattern="dd/MM/yyyy" /></td>
                                                                <td><span class="badge bg-success">${fee.status}</span></td>
                                                                <td><button class="btn btn-sm btn-primary view-details" data-id="${fee.feeId}">Chi tiết</button></td>
                                                            </tr>
                                                        </c:if>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="all" role="tabpanel" aria-labelledby="all-tab">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-hover">
                                                <thead>
                                                    <tr>
                                                        <th scope="col">ID</th>
                                                        <th scope="col">Loại phí</th>
                                                        <th scope="col">Kỳ</th>
                                                        <th scope="col">Số tiền</th>
                                                        <th scope="col">Ngày phát hành</th>
                                                        <th scope="col">Ngày thanh toán</th>
                                                        <th scope="col">Trạng thái</th>
                                                        <th scope="col">Chi tiết</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="fee" items="${serviceFees}">
                                                        <tr>
                                                            <td>${fee.feeId}</td>
                                                            <td>${fee.serviceType.typeName}</td>
                                                            <td>${fee.month}/${fee.year}</td>
                                                            <td><fmt:formatNumber value="${fee.amount}" type="currency" currencySymbol="VNĐ" maxFractionDigits="0" /></td>
                                                            <td><fmt:formatDate value="${fee.issueDate}" pattern="dd/MM/yyyy" /></td>
                                                            <td>
                                                                <c:if test="${fee.status == 'Đã thanh toán'}">
                                                                    <fmt:formatDate value="${fee.paymentDate}" pattern="dd/MM/yyyy" />
                                                                </c:if>
                                                            </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${fee.status == 'Đã thanh toán'}">
                                                                        <span class="badge bg-success">${fee.status}</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge bg-warning">${fee.status}</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td><button class="btn btn-sm btn-primary view-details" data-id="${fee.feeId}">Chi tiết</button></td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Modal chi tiết phí dịch vụ -->
                <div class="modal fade" id="feeDetailModal" tabindex="-1" aria-labelledby="feeDetailModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="feeDetailModalLabel">Chi tiết phí dịch vụ</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body" id="feeDetailContent">
                                <!-- Nội dung chi tiết sẽ được load bằng AJAX -->
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function() {
            // Xử lý sự kiện khi nhấn nút chi tiết
            $('.view-details').click(function() {
                const feeId = $(this).data('id');
                // Giả lập load dữ liệu chi tiết
                $('#feeDetailContent').html(`
                    <div class="text-center">
                        <div class="spinner-border text-primary" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                        <p class="mt-2">Đang tải dữ liệu...</p>
                    </div>
                `);
                
                // Hiển thị modal
                $('#feeDetailModal').modal('show');
                
                // Giả lập AJAX request
                setTimeout(function() {
                    $('#feeDetailContent').html(`
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">ID:</div>
                            <div class="col-md-8">${feeId}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Loại phí:</div>
                            <div class="col-md-8">Phí quản lý</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Kỳ:</div>
                            <div class="col-md-8">03/2025</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Số tiền:</div>
                            <div class="col-md-8">1.500.000 VNĐ</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Mô tả:</div>
                            <div class="col-md-8">Phí quản lý chung cư tháng 3/2025. Diện tích căn hộ: 75.5 m2, đơn giá 18.000 VNĐ/m2.</div>
                        </div>
                    `);
                }, 500);
            });
        });
    </script>
</body>
</html>