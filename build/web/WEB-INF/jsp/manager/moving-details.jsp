<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đăng ký chuyển đồ - Hệ thống quản lý chung cư</title>
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
                    <h1 class="h2">Chi tiết đăng ký chuyển đồ</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/manager/pending-movings" class="btn btn-sm btn-outline-secondary me-2">
                            <i class="fas fa-arrow-left me-1"></i> Quay lại
                        </a>
                        <c:if test="${moving.status eq 'Đang chờ phê duyệt'}">
                            <div class="btn-group">
                                <a href="${pageContext.request.contextPath}/moving/approve/${moving.movingId}" 
                                   class="btn btn-sm btn-success"
                                   onclick="return confirm('Bạn có chắc muốn phê duyệt đăng ký này?');">
                                    <i class="fas fa-check me-1"></i> Phê duyệt
                                </a>
                                <a href="${pageContext.request.contextPath}/moving/reject/${moving.movingId}" 
                                   class="btn btn-sm btn-danger"
                                   onclick="return confirm('Bạn có chắc muốn từ chối đăng ký này?');">
                                    <i class="fas fa-times me-1"></i> Từ chối
                                </a>
                            </div>
                        </c:if>
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
                
                <div class="row">
                    <div class="col-md-6">
                        <div class="card mb-4">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0"><i class="fas fa-dolly me-2"></i>Thông tin đăng ký chuyển đồ</h5>
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered">
                                    <tr>
                                        <th width="40%">ID đăng ký:</th>
                                        <td>${moving.movingId}</td>
                                    </tr>
                                    <tr>
                                        <th>Căn hộ:</th>
                                        <td>${moving.apartment.apartmentNumber}</td>
                                    </tr>
                                    <tr>
                                        <th>Người đăng ký:</th>
                                        <td>${moving.requester.fullName}</td>
                                    </tr>
                                    <tr>
                                        <th>Loại chuyển đồ:</th>
                                        <td>
                                            <span class="badge ${moving.movingType eq 'Vào' ? 'bg-success' : 'bg-warning'}">
                                                ${moving.movingType}
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Ngày đăng ký:</th>
                                        <td><fmt:formatDate value="${moving.registrationDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                                    </tr>
                                    <tr>
                                        <th>Ngày chuyển đồ:</th>
                                        <td><fmt:formatDate value="${moving.movingDate}" pattern="dd/MM/yyyy" /></td>
                                    </tr>
                                    <tr>
                                        <th>Thời gian bắt đầu:</th>
                                        <td><fmt:formatDate value="${moving.startTime}" pattern="HH:mm" /></td>
                                    </tr>
                                    <tr>
                                        <th>Thời gian kết thúc:</th>
                                        <td><fmt:formatDate value="${moving.endTime}" pattern="HH:mm" /></td>
                                    </tr>
                                    <tr>
                                        <th>Trạng thái:</th>
                                        <td>
                                            <c:choose>
                                                <c:when test="${moving.status eq 'Đang chờ phê duyệt'}">
                                                    <span class="badge bg-warning">Đang chờ phê duyệt</span>
                                                </c:when>
                                                <c:when test="${moving.status eq 'Đã phê duyệt'}">
                                                    <span class="badge bg-success">Đã phê duyệt</span>
                                                </c:when>
                                                <c:when test="${moving.status eq 'Đã từ chối'}">
                                                    <span class="badge bg-danger">Đã từ chối</span>
                                                </c:when>
                                                <c:when test="${moving.status eq 'Đã hủy'}">
                                                    <span class="badge bg-secondary">Đã hủy</span>
                                                </c:when>
                                                <c:when test="${moving.status eq 'Đã hoàn thành'}">
                                                    <span class="badge bg-info">Đã hoàn thành</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">${moving.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        
                        <div class="card mb-4">
                            <div class="card-header bg-info text-white">
                                <h5 class="mb-0"><i class="fas fa-box me-2"></i>Thông tin vật dụng</h5>
                            </div>
                            <div class="card-body">
                                <p><strong>Mô tả vật dụng:</strong></p>
                                <div class="p-3 bg-light rounded">
                                    <p class="mb-0">${moving.itemsDescription}</p>
                                </div>
                                
                                <c:if test="${not empty moving.specialNotes}">
                                    <p class="mt-3"><strong>Ghi chú đặc biệt:</strong></p>
                                    <div class="p-3 bg-light rounded">
                                        <p class="mb-0">${moving.specialNotes}</p>
                                    </div>
                                </c:if>
                                
                                <c:if test="${moving.needElevatorReservation}">
                                    <div class="alert alert-warning mt-3">
                                        <i class="fas fa-exclamation-triangle me-2"></i> Yêu cầu đặt thang máy riêng
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <div class="card mb-4">
                            <div class="card-header bg-success text-white">
                                <h5 class="mb-0"><i class="fas fa-user me-2"></i>Thông tin liên hệ</h5>
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered">
                                    <tr>
                                        <th width="40%">Người liên hệ:</th>
                                        <td>${moving.contactName}</td>
                                    </tr>
                                    <tr>
                                        <th>Số điện thoại:</th>
                                        <td>${moving.contactPhone}</td>
                                    </tr>
                                    <tr>
                                        <th>Email:</th>
                                        <td>${moving.contactEmail}</td>
                                    </tr>
                                </table>
                                
                                <p class="mt-3"><strong>Đơn vị vận chuyển:</strong></p>
                                <table class="table table-bordered">
                                    <tr>
                                        <th width="40%">Tên đơn vị:</th>
                                        <td>${moving.movingCompany != null ? moving.movingCompany : 'Không có'}</td>
                                    </tr>
                                    <tr>
                                        <th>Số người:</th>
                                        <td>${moving.numberOfMovers}</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        
                        <c:if test="${moving.status eq 'Đã phê duyệt' || moving.status eq 'Đã từ chối' || moving.status eq 'Đã hoàn thành'}">
                            <div class="card mb-4">
                                <div class="card-header bg-warning text-dark">
                                    <h5 class="mb-0"><i class="fas fa-clipboard-check me-2"></i>Thông tin phê duyệt</h5>
                                </div>
                                <div class="card-body">
                                    <table class="table table-bordered">
                                        <tr>
                                            <th width="40%">Người phê duyệt:</th>
                                            <td>${approver.fullName}</td>
                                        </tr>
                                        <tr>
                                            <th>Ngày phê duyệt:</th>
                                            <td><fmt:formatDate value="${moving.reviewDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                                        </tr>
                                        <tr>
                                            <th>Kết quả:</th>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${moving.status eq 'Đã phê duyệt'}">
                                                        <span class="badge bg-success">Phê duyệt</span>
                                                    </c:when>
                                                    <c:when test="${moving.status eq 'Đã từ chối'}">
                                                        <span class="badge bg-danger">Từ chối</span>
                                                    </c:when>
                                                    <c:when test="${moving.status eq 'Đã hoàn thành'}">
                                                        <span class="badge bg-info">Hoàn thành</span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </table>
                                    
                                    <c:if test="${not empty moving.reviewNotes}">
                                        <p class="mt-3"><strong>Ghi chú phê duyệt:</strong></p>
                                        <div class="p-3 bg-light rounded">
                                            <p class="mb-0">${moving.reviewNotes}</p>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:if>
                        
                        <c:if test="${moving.status eq 'Đang chờ phê duyệt'}">
                            <div class="card mb-4">
                                <div class="card-header bg-warning text-dark">
                                    <h5 class="mb-0"><i class="fas fa-edit me-2"></i>Phê duyệt đăng ký</h5>
                                </div>
                                <div class="card-body">
                                    <div class="mb-3">
                                        <label for="reviewNotes" class="form-label">Ghi chú phê duyệt</label>
                                        <textarea class="form-control" id="reviewNotes" rows="3" placeholder="Nhập ghi chú phê duyệt..."></textarea>
                                    </div>
                                    
                                    <div class="alert alert-info">
                                        <i class="fas fa-info-circle me-2"></i> Nhập ghi chú phê duyệt trước khi nhấn nút phê duyệt hoặc từ chối.
                                    </div>
                                    
                                    <div class="d-flex justify-content-between">
                                        <button type="button" class="btn btn-danger" id="btnReject">
                                            <i class="fas fa-times me-1"></i> Từ chối
                                        </button>
                                        <button type="button" class="btn btn-success" id="btnApprove">
                                            <i class="fas fa-check me-1"></i> Phê duyệt
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function() {
            // Handle approve button
            $('#btnApprove').click(function() {
                const notes = $('#reviewNotes').val();
                if (confirm('Bạn có chắc muốn phê duyệt đăng ký này?')) {
                    // Send approval with notes
                    $.ajax({
                        url: '${pageContext.request.contextPath}/moving/approve/${moving.movingId}',
                        type: 'POST',
                        data: { reviewNotes: notes },
                        success: function() {
                            window.location.reload();
                        },
                        error: function() {
                            alert('Có lỗi xảy ra khi phê duyệt đăng ký!');
                        }
                    });
                }
            });
            
            // Handle reject button
            $('#btnReject').click(function() {
                const notes = $('#reviewNotes').val();
                if (notes.trim() === '') {
                    alert('Vui lòng nhập lý do từ chối!');
                    return;
                }
                
                if (confirm('Bạn có chắc muốn từ chối đăng ký này?')) {
                    // Send rejection with notes
                    $.ajax({
                        url: '${pageContext.request.contextPath}/moving/reject/${moving.movingId}',
                        type: 'POST',
                        data: { reviewNotes: notes },
                        success: function() {
                            window.location.reload();
                        },
                        error: function() {
                            alert('Có lỗi xảy ra khi từ chối đăng ký!');
                        }
                    });
                }
            });
        });
    </script>
</body>
</html>