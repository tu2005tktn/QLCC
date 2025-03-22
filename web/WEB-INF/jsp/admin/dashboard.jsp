<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Hệ thống quản lý chung cư</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.css">
</head>
<body>
    <jsp:include page="../common/admin-header.jsp"/>
    
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="../common/admin-sidebar.jsp"/>
            
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Dashboard</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <button type="button" class="btn btn-sm btn-outline-secondary">Chia sẻ</button>
                            <button type="button" class="btn btn-sm btn-outline-secondary">Xuất báo cáo</button>
                        </div>
                        <button type="button" class="btn btn-sm btn-outline-secondary dropdown-toggle">
                            <i class="fas fa-calendar-alt me-1"></i> Thời gian
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
                                <a href="${pageContext.request.contextPath}/admin/apartments" class="text-white text-decoration-none">
                                    Xem chi tiết
                                </a>
                                <i class="fas fa-angle-right text-white"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-3 mb-4">
                        <div class="card text-white bg-success h-100">
                            <div class="card-body d-flex align-items-center">
                                <i class="fas fa-clipboard-list fa-3x me-3"></i>
                                <div>
                                    <h5 class="card-title">Yêu cầu đang chờ</h5>
                                    <p class="card-text display-6">${pendingRequestCount}</p>
                                </div>
                            </div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <a href="${pageContext.request.contextPath}/admin/requests?status=pending" class="text-white text-decoration-none">
                                    Xem chi tiết
                                </a>
                                <i class="fas fa-angle-right text-white"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-3 mb-4">
                        <div class="card text-white bg-info h-100">
                            <div class="card-body d-flex align-items-center">
                                <i class="fas fa-users fa-3x me-3"></i>
                                <div>
                                    <h5 class="card-title">Tổng số người dùng</h5>
                                    <p class="card-text display-6">${userCount}</p>
                                </div>
                            </div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <a href="${pageContext.request.contextPath}/admin/users" class="text-white text-decoration-none">
                                    Xem chi tiết
                                </a>
                                <i class="fas fa-angle-right text-white"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-3 mb-4">
                        <div class="card text-white bg-warning h-100">
                            <div class="card-body d-flex align-items-center">
                                <i class="fas fa-file-invoice-dollar fa-3x me-3"></i>
                                <div>
                                    <h5 class="card-title">Phí dịch vụ chưa thu</h5>
                                    <p class="card-text display-6">${unpaidFeeCount}</p>
                                </div>
                            </div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <a href="${pageContext.request.contextPath}/admin/service-fees?status=unpaid" class="text-white text-decoration-none">
                                    Xem chi tiết
                                </a>
                                <i class="fas fa-angle-right text-white"></i>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="row mb-4">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Biểu đồ hoạt động</h5>
                            </div>
                            <div class="card-body">
                                <canvas id="activityChart" height="250"></canvas>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Thống kê căn hộ</h5>
                            </div>
                            <div class="card-body">
                                <canvas id="apartmentChart" height="250"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                
                <h2 class="mt-4">Yêu cầu gần đây</h2>
                <div class="table-responsive">
                    <table class="table table-striped table-sm table-hover">
                        <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Căn hộ</th>
                                <th scope="col">Tiêu đề</th>
                                <th scope="col">Loại yêu cầu</th>
                                <th scope="col">Ngày tạo</th>
                                <th scope="col">Trạng thái</th>
                                <th scope="col">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="request" items="${recentRequests}">
                                <tr>
                                    <td>${request.requestId}</td>
                                    <td>${request.apartment.apartmentNumber}</td>
                                    <td>${request.title}</td>
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
                    <a href="${pageContext.request.contextPath}/admin/requests" class="btn btn-outline-primary">
                        Xem tất cả yêu cầu <i class="fas fa-arrow-right ms-1"></i>
                    </a>
                </div>
            </main>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
    <script>
        // Biểu đồ hoạt động
        const activityCtx = document.getElementById('activityChart').getContext('2d');
        const activityChart = new Chart(activityCtx, {
            type: 'line',
            data: {
                labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'],
                datasets: [
                    {
                        label: 'Yêu cầu',
                        data: [65, 59, 80, 81, 56, 55, 40, 30, 45, 55, 60, 70],
                        borderColor: 'rgb(75, 192, 192)',
                        tension: 0.1,
                        fill: false
                    },
                    {
                        label: 'Phí dịch vụ',
                        data: [28, 48, 40, 19, 86, 27, 90, 85, 80, 70, 60, 50],
                        borderColor: 'rgb(255, 99, 132)',
                        tension: 0.1,
                        fill: false
                    }
                ]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
        
        // Biểu đồ căn hộ
        const apartmentCtx = document.getElementById('apartmentChart').getContext('2d');
        const apartmentChart = new Chart(apartmentCtx, {
            type: 'doughnut',
            data: {
                labels: ['Đang sử dụng', 'Trống', 'Đang bảo trì'],
                datasets: [{
                    data: [${occupiedCount}, ${emptyCount}, ${maintenanceCount}],
                    backgroundColor: [
                        'rgb(54, 162, 235)',
                        'rgb(255, 205, 86)',
                        'rgb(255, 99, 132)'
                    ]
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'bottom',
                    }
                }
            }
        });
    </script>
</body>
</html>