<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Báo cáo thống kê - Hệ thống quản lý chung cư</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.css">
</head>
<body>
    <jsp:include page="../common/manager-header.jsp"/>
    
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="../common/manager-sidebar.jsp"/>
            
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Báo cáo thống kê</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="exportReport('pdf')">
                                <i class="fas fa-file-pdf me-1"></i> Xuất PDF
                            </button>
                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="exportReport('excel')">
                                <i class="fas fa-file-excel me-1"></i> Xuất Excel
                            </button>
                        </div>
                        <div class="input-group">
                            <input type="month" class="form-control form-control-sm" id="reportMonth" 
                                  value="${param.month != null ? param.month : currentMonth}">
                            <button class="btn btn-sm btn-outline-secondary" type="button" onclick="changeReportMonth()">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- Thống kê tổng quan -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="card text-white bg-primary h-100">
                            <div class="card-body">
                                <h5 class="card-title">Tổng số căn hộ</h5>
                                <p class="card-text display-6">${totalApartmentsCount}</p>
                                <p class="card-text">
                                    <span class="text-light">Đang sử dụng: ${occupiedApartmentsCount}</span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-success h-100">
                            <div class="card-body">
                                <h5 class="card-title">Tỷ lệ lấp đầy</h5>
                                <p class="card-text display-6">${occupancyRate}%</p>
                                <p class="card-text">
                                    <span class="text-light">${occupiedApartmentsCount}/${totalApartmentsCount} căn hộ</span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-info h-100">
                            <div class="card-body">
                                <h5 class="card-title">Yêu cầu trong tháng</h5>
                                <p class="card-text display-6">${monthlyRequestsCount}</p>
                                <p class="card-text">
                                    <span class="text-light">Hoàn thành: ${completedRequestsCount}/${totalRequestsCount}</span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-warning h-100">
                            <div class="card-body">
                                <h5 class="card-title">Tỷ lệ xử lý yêu cầu</h5>
                                <p class="card-text display-6">${requestCompletionRate}%</p>
                                <p class="card-text">
                                    <span class="text-light">Thời gian TB: ${avgProcessingTime} giờ</span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Biểu đồ yêu cầu -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Thống kê yêu cầu theo tháng</h5>
                            </div>
                            <div class="card-body">
                                <canvas id="requestsChart" height="300"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Thống kê yêu cầu theo loại</h5>
                            </div>
                            <div class="card-body">
                                <canvas id="requestTypeChart" height="300"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Hiệu suất nhân viên -->
                <div class="card mb-4">
                    <div class="card-header bg-white">
                        <h5 class="mb-0">Hiệu suất nhân viên</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Nhân viên</th>
                                        <th>Yêu cầu đã xử lý</th>
                                        <th>Thời gian xử lý TB (giờ)</th>
                                        <th>Đánh giá</th>
                                        <th>Hiệu suất</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="staff" items="${staffPerformance}">
                                        <tr>
                                            <td>${staff.fullName}</td>
                                            <td>${staff.completedRequestCount}</td>
                                            <td>${staff.avgProcessingTime}</td>
                                            <td>
                                                <div class="rating">
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <i class="fas fa-star ${i <= staff.rating ? 'text-warning' : 'text-secondary'}"></i>
                                                    </c:forEach>
                                                    <span class="ms-2">${staff.rating}/5</span>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="progress">
                                                    <div class="progress-bar bg-success" role="progressbar" 
                                                         style="width: ${staff.performance}%" 
                                                         aria-valuenow="${staff.performance}" 
                                                         aria-valuemin="0" 
                                                         aria-valuemax="100">${staff.performance}%</div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <!-- Thống kê căn hộ -->
                <div class="card mb-4">
                    <div class="card-header bg-white">
                        <h5 class="mb-0">Thống kê căn hộ</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <canvas id="apartmentStatusChart" height="250"></canvas>
                            </div>
                            <div class="col-md-6">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Trạng thái</th>
                                            <th>Số lượng</th>
                                            <th>Tỷ lệ</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><span class="badge bg-success">Đang sử dụng</span></td>
                                            <td>${occupiedApartmentsCount}</td>
                                            <td>${occupancyRate}%</td>
                                        </tr>
                                        <tr>
                                            <td><span class="badge bg-warning">Trống</span></td>
                                            <td>${emptyApartmentsCount}</td>
                                            <td>${emptyRate}%</td>
                                        </tr>
                                        <tr>
                                            <td><span class="badge bg-danger">Đang bảo trì</span></td>
                                            <td>${maintenanceApartmentsCount}</td>
                                            <td>${maintenanceRate}%</td>
                                        </tr>
                                        <tr class="table-active">
                                            <th>Tổng cộng</th>
                                            <th>${totalApartmentsCount}</th>
                                            <th>100%</th>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
    <script>
        // Biểu đồ yêu cầu theo tháng
        const requestsCtx = document.getElementById('requestsChart').getContext('2d');
        const requestsChart = new Chart(requestsCtx, {
            type: 'line',
            data: {
                labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'],
                datasets: [{
                    label: 'Số lượng yêu cầu',
                    data: ${requestsMonthlyData},
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 2,
                    tension: 0.1,
                    fill: true
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1
                        }
                    }
                }
            }
        });
        
        // Biểu đồ yêu cầu theo loại
        const requestTypeCtx = document.getElementById('requestTypeChart').getContext('2d');
        const requestTypeChart = new Chart(requestTypeCtx, {
            type: 'doughnut',
            data: {
                labels: ${requestTypeLabels},
                datasets: [{
                    data: ${requestTypeData},
                    backgroundColor: [
                        'rgba(54, 162, 235, 0.8)',
                        'rgba(255, 99, 132, 0.8)',
                        'rgba(255, 206, 86, 0.8)',
                        'rgba(75, 192, 192, 0.8)',
                        'rgba(153, 102, 255, 0.8)',
                        'rgba(255, 159, 64, 0.8)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'right',
                    }
                }
            }
        });
        
        // Biểu đồ trạng thái căn hộ
        const apartmentStatusCtx = document.getElementById('apartmentStatusChart').getContext('2d');
        const apartmentStatusChart = new Chart(apartmentStatusCtx, {
            type: 'pie',
            data: {
                labels: ['Đang sử dụng', 'Trống', 'Đang bảo trì'],
                datasets: [{
                    data: [${occupiedApartmentsCount}, ${emptyApartmentsCount}, ${maintenanceApartmentsCount}],
                    backgroundColor: [
                        'rgba(40, 167, 69, 0.8)',
                        'rgba(255, 193, 7, 0.8)',
                        'rgba(220, 53, 69, 0.8)'
                    ],
                    borderWidth: 1
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
        
        function changeReportMonth() {
            const monthValue = document.getElementById('reportMonth').value;
            if (monthValue) {
                window.location.href = '${pageContext.request.contextPath}/manager/reports?month=' + monthValue;
            }
        }
        
        function exportReport(type) {
            const monthValue = document.getElementById('reportMonth').value;
            window.location.href = '${pageContext.request.contextPath}/manager/reports/export?type=' + type + '&month=' + monthValue;
        }
    </script>
</body>
</html>