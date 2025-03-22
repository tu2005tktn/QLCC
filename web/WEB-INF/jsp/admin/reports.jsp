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
    <jsp:include page="../common/admin-header.jsp"/>
    
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="../common/admin-sidebar.jsp"/>
            
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
                                <h5 class="card-title">Tổng doanh thu</h5>
                                <p class="card-text display-6"><fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="₫" /></p>
                                <p class="card-text">
                                    <c:if test="${revenueGrowth > 0}">
                                        <span class="text-light"><i class="fas fa-arrow-up"></i> ${revenueGrowth}%</span>
                                    </c:if>
                                    <c:if test="${revenueGrowth < 0}">
                                        <span class="text-light"><i class="fas fa-arrow-down"></i> ${Math.abs(revenueGrowth)}%</span>
                                    </c:if>
                                    <c:if test="${revenueGrowth == 0}">
                                        <span class="text-light"><i class="fas fa-equals"></i> 0%</span>
                                    </c:if>
                                    <span class="text-light"> so với tháng trước</span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-success h-100">
                            <div class="card-body">
                                <h5 class="card-title">Tỷ lệ thu phí</h5>
                                <p class="card-text display-6">${feeCollectionRate}%</p>
                                <p class="card-text">
                                    <span class="text-light">${paidFeesCount}/${totalFeesCount} khoản phí đã thu</span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-info h-100">
                            <div class="card-body">
                                <h5 class="card-title">Xử lý yêu cầu</h5>
                                <p class="card-text display-6">${requestCompletionRate}%</p>
                                <p class="card-text">
                                    <span class="text-light">${completedRequestsCount}/${totalRequestsCount} yêu cầu hoàn thành</span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-warning h-100">
                            <div class="card-body">
                                <h5 class="card-title">Tỷ lệ lấp đầy</h5>
                                <p class="card-text display-6">${occupancyRate}%</p>
                                <p class="card-text">
                                    <span class="text-light">${occupiedApartmentsCount}/${totalApartmentsCount} căn hộ đang sử dụng</span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Biểu đồ doanh thu -->
                <div class="row mb-4">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Báo cáo doanh thu theo tháng</h5>
                            </div>
                            <div class="card-body">
                                <canvas id="revenueChart" height="300"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Cơ cấu doanh thu</h5>
                            </div>
                            <div class="card-body">
                                <canvas id="revenueStructureChart" height="300"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Phân tích yêu cầu và phí dịch vụ -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Thống kê yêu cầu theo loại</h5>
                            </div>
                            <div class="card-body">
                                <canvas id="requestTypeChart" height="250"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Thời gian xử lý yêu cầu</h5>
                            </div>
                            <div class="card-body">
                                <canvas id="requestTimeChart" height="250"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Bảng thống kê chi tiết -->
                <div class="card mb-4">
                    <div class="card-header bg-white">
                        <h5 class="mb-0">Chi tiết doanh thu theo loại phí</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Loại phí</th>
                                        <th>Số lượng</th>
                                        <th>Đã thu</th>
                                        <th>Chưa thu</th>
                                        <th>Tổng tiền</th>
                                        <th>Tỷ lệ thu</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="stat" items="${feeTypeStats}">
                                        <tr>
                                            <td>${stat.typeName}</td>
                                            <td>${stat.totalCount}</td>
                                            <td>${stat.paidCount}</td>
                                            <td>${stat.unpaidCount}</td>
                                            <td><fmt:formatNumber value="${stat.totalAmount}" type="currency" currencySymbol="₫" /></td>
                                            <td>
                                                <div class="progress">
                                                    <div class="progress-bar bg-success" role="progressbar" 
                                                         style="width: ${stat.collectionRate}%" 
                                                         aria-valuenow="${stat.collectionRate}" 
                                                         aria-valuemin="0" 
                                                         aria-valuemax="100">${stat.collectionRate}%</div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <tr class="table-active fw-bold">
                                        <td>Tổng cộng</td>
                                        <td>${totalFeesCount}</td>
                                        <td>${paidFeesCount}</td>
                                        <td>${unpaidFeesCount}</td>
                                        <td><fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="₫" /></td>
                                        <td>
                                            <div class="progress">
                                                <div class="progress-bar bg-success" role="progressbar" 
                                                     style="width: ${feeCollectionRate}%" 
                                                     aria-valuenow="${feeCollectionRate}" 
                                                     aria-valuemin="0" 
                                                     aria-valuemax="100">${feeCollectionRate}%</div>
                                            </div>
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>
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
        // Biểu đồ doanh thu
        const revenueCtx = document.getElementById('revenueChart').getContext('2d');
        const revenueChart = new Chart(revenueCtx, {
            type: 'line',
            data: {
                labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'],
                datasets: [{
                    label: 'Doanh thu theo tháng',
                    data: ${revenueMonthlyData},
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
                            callback: function(value) {
                                return value.toLocaleString('vi-VN') + ' ₫';
                            }
                        }
                    }
                },
                plugins: {
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return context.dataset.label + ': ' + context.raw.toLocaleString('vi-VN') + ' ₫';
                            }
                        }
                    }
                }
            }
        });
        
        // Biểu đồ cơ cấu doanh thu
        const structureCtx = document.getElementById('revenueStructureChart').getContext('2d');
        const structureChart = new Chart(structureCtx, {
            type: 'pie',
            data: {
                labels: ${revenueStructureLabels},
                datasets: [{
                    data: ${revenueStructureData},
                    backgroundColor: [
                        'rgba(54, 162, 235, 0.8)',
                        'rgba(255, 99, 132, 0.8)',
                        'rgba(255, 206, 86, 0.8)',
                        'rgba(75, 192, 192, 0.8)',
                        'rgba(153, 102, 255, 0.8)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'bottom',
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                const value = context.raw;
                                const total = context.dataset.data.reduce((a, b) => a + b, 0);
                                const percentage = Math.round((value / total) * 100);
                                return context.label + ': ' + value.toLocaleString('vi-VN') + ' ₫ (' + percentage + '%)';
                            }
                        }
                    }
                }
            }
        });
        
        // Biểu đồ yêu cầu theo loại
        const requestTypeCtx = document.getElementById('requestTypeChart').getContext('2d');
        const requestTypeChart = new Chart(requestTypeCtx, {
            type: 'bar',
            data: {
                labels: ${requestTypeLabels},
                datasets: [{
                    label: 'Số lượng yêu cầu',
                    data: ${requestTypeData},
                    backgroundColor: 'rgba(75, 192, 192, 0.8)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
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
        
        // Biểu đồ thời gian xử lý yêu cầu
        const requestTimeCtx = document.getElementById('requestTimeChart').getContext('2d');
        const requestTimeChart = new Chart(requestTimeCtx, {
            type: 'bar',
            data: {
                labels: ${requestTypeLabels},
                datasets: [{
                    label: 'Thời gian xử lý trung bình (giờ)',
                    data: ${requestProcessingTimeData},
                    backgroundColor: 'rgba(255, 159, 64, 0.8)',
                    borderColor: 'rgba(255, 159, 64, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
        
        function changeReportMonth() {
            const monthValue = document.getElementById('reportMonth').value;
            if (monthValue) {
                window.location.href = '${pageContext.request.contextPath}/admin/reports?month=' + monthValue;
            }
        }
        
        function exportReport(type) {
            const monthValue = document.getElementById('reportMonth').value;
            window.location.href = '${pageContext.request.contextPath}/admin/reports/export?type=' + type + '&month=' + monthValue;
        }
    </script>
</body>
</html>