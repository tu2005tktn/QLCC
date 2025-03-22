<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết nhân viên - Hệ thống quản lý chung cư</title>
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
                    <h1 class="h2">Chi tiết nhân viên</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/manager/staff" class="btn btn-sm btn-outline-secondary">
                            <i class="fas fa-arrow-left me-1"></i> Quay lại
                        </a>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-4">
                        <div class="card mb-4">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0"><i class="fas fa-user-tie me-2"></i>Thông tin nhân viên</h5>
                            </div>
                            <div class="card-body">
                                <div class="text-center mb-4">
                                    <div class="avatar-circle mx-auto mb-3">
                                        <span class="initials">${staff.fullName.charAt(0)}</span>
                                    </div>
                                    <h4>${staff.fullName}</h4>
                                    <p class="text-muted">
                                        <c:if test="${staff.status}">
                                            <span class="badge bg-success">Đang hoạt động</span>
                                        </c:if>
                                        <c:if test="${!staff.status}">
                                            <span class="badge bg-danger">Đã khóa</span>
                                        </c:if>
                                    </p>
                                </div>
                                
                                <table class="table table-bordered">
                                    <tr>
                                        <th width="40%">ID:</th>
                                        <td>${staff.userId}</td>
                                    </tr>
                                    <tr>
                                        <th>Tên đăng nhập:</th>
                                        <td>${staff.username}</td>
                                    </tr>
                                    <tr>
                                        <th>Email:</th>
                                        <td>${staff.email}</td>
                                    </tr>
                                    <tr>
                                        <th>Số điện thoại:</th>
                                        <td>${staff.phone}</td>
                                    </tr>
                                    <tr>
                                        <th>Ngày tạo:</th>
                                        <td><fmt:formatDate value="${staff.createdDate}" pattern="dd/MM/yyyy" /></td>
                                    </tr>
                                </table>
                                
                                <div class="d-grid gap-2 mt-3">
                                    <c:if test="${staff.status}">
                                        <button type="button" class="btn btn-danger" 
                                                onclick="if(confirm('Bạn có chắc muốn khóa tài khoản nhân viên này?')) 
                                                        window.location.href='${pageContext.request.contextPath}/manager/staff/${staff.userId}/toggle-status'">
                                            <i class="fas fa-lock me-2"></i> Khóa tài khoản
                                        </button>
                                    </c:if>
                                    <c:if test="${!staff.status}">
                                        <button type="button" class="btn btn-success" 
                                                onclick="if(confirm('Bạn có chắc muốn kích hoạt tài khoản nhân viên này?')) 
                                                        window.location.href='${pageContext.request.contextPath}/manager/staff/${staff.userId}/toggle-status'">
                                            <i class="fas fa-unlock me-2"></i> Kích hoạt tài khoản
                                        </button>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-8">
                        <div class="card mb-4">
                            <div class="card-header bg-info text-white">
                                <h5 class="mb-0"><i class="fas fa-chart-line me-2"></i>Thống kê hoạt động</h5>
                            </div>
                            <div class="card-body">
                                <div class="row mb-4">
                                    <div class="col-md-4">
                                        <div class="card bg-light">
                                            <div class="card-body text-center">
                                                <h1 class="display-4">${processingRequestCount}</h1>
                                                <p class="mb-0">Đang xử lý</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="card bg-light">
                                            <div class="card-body text-center">
                                                <h1 class="display-4">${completedRequestCount}</h1>
                                                <p class="mb-0">Đã hoàn thành</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="card bg-light">
                                            <div class="card-body text-center">
                                                <h1 class="display-4">${avgHandlingTime}</h1>
                                                <p class="mb-0">Thời gian TB (giờ)</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="mb-4">
                                    <h5>Đánh giá</h5>
                                    <div class="rating">
                                        <c:forEach begin="1" end="5" var="i">
                                            <i class="fas fa-star fa-2x ${i <= avgRating ? 'text-warning' : 'text-secondary'}"></i>
                                        </c:forEach>
                                        <span class="ms-3 fs-4">${avgRating}/5</span>
                                    </div>
                                </div>
                                
                                <canvas id="performanceChart" height="200"></canvas>
                            </div>
                        </div>
                        
                        <div class="card mb-4">
                            <div class="card-header bg-success text-white">
                                <h5 class="mb-0"><i class="fas fa-clipboard-list me-2"></i>Yêu cầu đang xử lý</h5>
                            </div>
                            <div class="card-body">
                                <c:if test="${empty processingRequests}">
                                    <div class="alert alert-info">
                                        Nhân viên này hiện không có yêu cầu nào đang xử lý.
                                    </div>
                                </c:if>
                                
                                <c:if test="${not empty processingRequests}">
                                    <div class="table-responsive">
                                        <table class="table table-striped table-hover">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Căn hộ</th>
                                                    <th>Tiêu đề</th>
                                                    <th>Loại yêu cầu</th>
                                                    <th>Ngày giao</th>
                                                    <th>Ưu tiên</th>
                                                    <th>Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="request" items="${processingRequests}">
                                                    <tr>
                                                        <td>${request.requestId}</td>
                                                        <td>${request.apartment.apartmentNumber}</td>
                                                        <td>${request.title}</td>
                                                        <td>${request.requestType.typeName}</td>
                                                        <td><fmt:formatDate value="${request.assignedDate}" pattern="dd/MM/yyyy" /></td>
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
                                </c:if>
                            </div>
                        </div>
                        
                        <div class="card mb-4">
                            <div class="card-header bg-warning text-dark">
                                <h5 class="mb-0"><i class="fas fa-history me-2"></i>Yêu cầu gần đây đã hoàn thành</h5>
                            </div>
                            <div class="card-body">
                                <c:if test="${empty recentCompletedRequests}">
                                    <div class="alert alert-info">
                                        Không có yêu cầu nào hoàn thành gần đây.
                                    </div>
                                </c:if>
                                
                                <c:if test="${not empty recentCompletedRequests}">
                                    <div class="table-responsive">
                                        <table class="table table-striped table-hover">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Căn hộ</th>
                                                    <th>Tiêu đề</th>
                                                    <th>Ngày giao</th>
                                                    <th>Ngày hoàn thành</th>
                                                    <th>Thời gian xử lý</th>
                                                    <th>Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="request" items="${recentCompletedRequests}">
                                                    <tr>
                                                        <td>${request.requestId}</td>
                                                        <td>${request.apartment.apartmentNumber}</td>
                                                        <td>${request.title}</td>
                                                        <td><fmt:formatDate value="${request.assignedDate}" pattern="dd/MM/yyyy" /></td>
                                                        <td><fmt:formatDate value="${request.completedDate}" pattern="dd/MM/yyyy" /></td>
                                                        <td>${request.processingTime} giờ</td>
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
                                </c:if>
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
    
    <style>
        .avatar-circle {
            width: 100px;
            height: 100px;
            background-color: #007bff;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .initials {
            font-size: 42px;
            color: #fff;
            font-weight: bold;
        }
    </style>
    
    <script>
        // Biểu đồ hiệu suất nhân viên theo tháng
        const ctx = document.getElementById('performanceChart').getContext('2d');
        const performanceChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'],
                datasets: [
                    {
                        label: 'Số yêu cầu hoàn thành',
                        data: ${monthlyCompletedData},
                        borderColor: 'rgb(75, 192, 192)',
                        tension: 0.1,
                        fill: false
                    },
                    {
                        label: 'Thời gian xử lý trung bình (giờ)',
                        data: ${monthlyTimeData},
                        borderColor: 'rgb(255, 99, 132)',
                        tension: 0.1,
                        fill: false,
                        yAxisID: 'y1'
                    }
                ]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: 'Số yêu cầu'
                        }
                    },
                    y1: {
                        beginAtZero: true,
                        position: 'right',
                        title: {
                            display: true,
                            text: 'Thời gian (giờ)'
                        },
                        grid: {
                            drawOnChartArea: false
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>