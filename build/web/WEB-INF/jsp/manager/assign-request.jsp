<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phân công yêu cầu - Hệ thống quản lý chung cư</title>
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
                    <h1 class="h2">Phân công yêu cầu</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/manager/pending-requests" class="btn btn-sm btn-outline-secondary">
                            <i class="fas fa-arrow-left me-1"></i> Quay lại
                        </a>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-5">
                        <div class="card mb-4">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0"><i class="fas fa-clipboard-list me-2"></i>Thông tin yêu cầu</h5>
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered">
                                    <tr>
                                        <th width="40%">ID yêu cầu:</th>
                                        <td>${request.requestId}</td>
                                    </tr>
                                    <tr>
                                        <th>Tiêu đề:</th>
                                        <td>${request.title}</td>
                                    </tr>
                                    <tr>
                                        <th>Căn hộ:</th>
                                        <td>${request.apartment.apartmentNumber}</td>
                                    </tr>
                                    <tr>
                                        <th>Loại yêu cầu:</th>
                                        <td>${request.requestType.typeName}</td>
                                    </tr>
                                    <tr>
                                        <th>Người yêu cầu:</th>
                                        <td>${request.requester.fullName}</td>
                                    </tr>
                                    <tr>
                                        <th>Ngày tạo:</th>
                                        <td><fmt:formatDate value="${request.requestDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                                    </tr>
                                    <tr>
                                        <th>Trạng thái:</th>
                                        <td>
                                            <span class="badge bg-warning">Đang chờ xử lý</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Mức ưu tiên:</th>
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
                                    </tr>
                                </table>
                                
                                <div class="card mt-3">
                                    <div class="card-header bg-light">
                                        <h6 class="mb-0">Mô tả yêu cầu</h6>
                                    </div>
                                    <div class="card-body">
                                        <p>${request.description}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-7">
                        <div class="card">
                            <div class="card-header bg-success text-white">
                                <h5 class="mb-0"><i class="fas fa-user-plus me-2"></i>Phân công nhân viên</h5>
                            </div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/requests/assign/${request.requestId}" method="post" id="assignForm">
                                    <div class="mb-3">
                                        <label for="staffId" class="form-label">Chọn nhân viên xử lý</label>
                                        <select class="form-select" id="staffId" name="staffId" required>
                                            <option value="">-- Chọn nhân viên --</option>
                                            <c:forEach var="staff" items="${staffList}">
                                                <option value="${staff.userId}" data-workload="${staff.processingRequestCount}">${staff.fullName} (Đang xử lý: ${staff.processingRequestCount} yêu cầu)</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="notes" class="form-label">Ghi chú</label>
                                        <textarea class="form-control" id="notes" name="notes" rows="3" placeholder="Nhập ghi chú cho nhân viên (nếu có)"></textarea>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="deadline" class="form-label">Hạn xử lý</label>
                                        <input type="datetime-local" class="form-control" id="deadline" name="deadline" required>
                                    </div>
                                    
                                    <div class="mb-3 form-check">
                                        <input type="checkbox" class="form-check-input" id="notifyStaff" name="notifyStaff" checked>
                                        <label class="form-check-label" for="notifyStaff">Gửi thông báo cho nhân viên</label>
                                    </div>
                                    
                                    <div id="staffInfoCard" class="card d-none mb-3">
                                        <div class="card-header bg-light">
                                            <h6 class="mb-0">Thông tin nhân viên</h6>
                                        </div>
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <p><strong>Tên nhân viên:</strong> <span id="staffName"></span></p>
                                                    <p><strong>Email:</strong> <span id="staffEmail"></span></p>
                                                    <p><strong>Số điện thoại:</strong> <span id="staffPhone"></span></p>
                                                </div>
                                                <div class="col-md-6">
                                                    <p><strong>Yêu cầu đang xử lý:</strong> <span id="staffWorkload"></span></p>
                                                    <p><strong>Thời gian xử lý TB:</strong> <span id="staffAvgTime"></span> giờ</p>
                                                    <p><strong>Đánh giá:</strong> <span id="staffRating"></span></p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="alert alert-warning">
                                        <i class="fas fa-exclamation-triangle me-2"></i> Lưu ý: Sau khi phân công, trạng thái yêu cầu sẽ chuyển thành "Đang xử lý" và nhân viên sẽ nhận được thông báo về yêu cầu này.
                                    </div>
                                    
                                    <div class="d-grid gap-2">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save me-2"></i> Phân công
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        
                        <div class="card mt-4">
                            <div class="card-header bg-info text-white">
                                <h5 class="mb-0"><i class="fas fa-users me-2"></i>Nhân viên có thể xử lý</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th>Nhân viên</th>
                                                <th>Đang xử lý</th>
                                                <th>Đã hoàn thành</th>
                                                <th>Thời gian TB</th>
                                                <th>Đánh giá</th>
                                                <th>Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="staff" items="${staffList}">
                                                <tr>
                                                    <td>${staff.fullName}</td>
                                                    <td><span class="badge bg-primary">${staff.processingRequestCount}</span></td>
                                                    <td>${staff.completedRequestCount}</td>
                                                    <td>${staff.avgProcessingTime} giờ</td>
                                                    <td>
                                                        <div class="rating">
                                                            <c:forEach begin="1" end="5" var="i">
                                                                <i class="fas fa-star ${i <= staff.rating ? 'text-warning' : 'text-secondary'}"></i>
                                                            </c:forEach>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <button type="button" class="btn btn-sm btn-success btn-select-staff" 
                                                                data-staff-id="${staff.userId}"
                                                                data-staff-name="${staff.fullName}"
                                                                data-staff-email="${staff.email}"
                                                                data-staff-phone="${staff.phone}"
                                                                data-staff-workload="${staff.processingRequestCount}"
                                                                data-staff-avg-time="${staff.avgProcessingTime}"
                                                                data-staff-rating="${staff.rating}">
                                                            <i class="fas fa-user-check"></i> Chọn
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
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
            // Set default deadline (tomorrow)
            const tomorrow = new Date();
            tomorrow.setDate(tomorrow.getDate() + 1);
            tomorrow.setHours(17, 0, 0, 0);
            
            const formattedDate = tomorrow.toISOString().slice(0, 16);
            $('#deadline').val(formattedDate);
            
            // Show staff info when selecting from dropdown
            $('#staffId').change(function() {
                const staffId = $(this).val();
                if (staffId) {
                    // Get staff data via AJAX or from the page if already available
                    $.ajax({
                        url: '${pageContext.request.contextPath}/api/staff/' + staffId,
                        type: 'GET',
                        success: function(staff) {
                            $('#staffName').text(staff.fullName);
                            $('#staffEmail').text(staff.email);
                            $('#staffPhone').text(staff.phone);
                            $('#staffWorkload').text(staff.processingRequestCount);
                            $('#staffAvgTime').text(staff.avgProcessingTime);
                            
                            // Display rating stars
                            let ratingHtml = '';
                            for (let i = 1; i <= 5; i++) {
                                if (i <= staff.rating) {
                                    ratingHtml += '<i class="fas fa-star text-warning"></i>';
                                } else {
                                    ratingHtml += '<i class="fas fa-star text-secondary"></i>';
                                }
                            }
                            ratingHtml += ' ' + staff.rating + '/5';
                            $('#staffRating').html(ratingHtml);
                            
                            $('#staffInfoCard').removeClass('d-none');
                        },
                        error: function() {
                            alert('Không thể lấy thông tin nhân viên!');
                        }
                    });
                } else {
                    $('#staffInfoCard').addClass('d-none');
                }
            });
            
            // Select staff from the table
            $('.btn-select-staff').click(function() {
                const staffId = $(this).data('staff-id');
                const staffName = $(this).data('staff-name');
                const staffEmail = $(this).data('staff-email');
                const staffPhone = $(this).data('staff-phone');
                const staffWorkload = $(this).data('staff-workload');
                const staffAvgTime = $(this).data('staff-avg-time');
                const staffRating = $(this).data('staff-rating');
                
                // Set the selected staff in the dropdown
                $('#staffId').val(staffId);
                
                // Display staff info
                $('#staffName').text(staffName);
                $('#staffEmail').text(staffEmail);
                $('#staffPhone').text(staffPhone);
                $('#staffWorkload').text(staffWorkload);
                $('#staffAvgTime').text(staffAvgTime);
                
                // Display rating stars
                let ratingHtml = '';
                for (let i = 1; i <= 5; i++) {
                    if (i <= staffRating) {
                        ratingHtml += '<i class="fas fa-star text-warning"></i>';
                    } else {
                        ratingHtml += '<i class="fas fa-star text-secondary"></i>';
                    }
                }
                ratingHtml += ' ' + staffRating + '/5';
                $('#staffRating').html(ratingHtml);
                
                $('#staffInfoCard').removeClass('d-none');
                
                // Scroll to the form
                $('html, body').animate({
                    scrollTop: $("#assignForm").offset().top - 100
                }, 500);
            });
            
            // Form validation
            $('#assignForm').submit(function(e) {
                const staffId = $('#staffId').val();
                const deadline = $('#deadline').val();
                
                if (!staffId) {
                    alert('Vui lòng chọn nhân viên!');
                    e.preventDefault();
                    return false;
                }
                
                if (!deadline) {
                    alert('Vui lòng nhập hạn xử lý!');
                    e.preventDefault();
                    return false;
                }
                
                return true;
            });
        });
    </script>
</body>
</html>