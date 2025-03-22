<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phê duyệt đăng ký chuyển đồ - Hệ thống quản lý chung cư</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <c:choose>
        <c:when test="${sessionScope.user.role.roleName eq 'ADMIN'}">
            <jsp:include page="../common/admin-header.jsp"/>
            <div class="container-fluid">
                <div class="row">
                    <jsp:include page="../common/admin-sidebar.jsp"/>
                    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
        </c:when>
        <c:otherwise>
            <jsp:include page="../common/manager-header.jsp"/>
            <div class="container-fluid">
                <div class="row">
                    <jsp:include page="../common/manager-sidebar.jsp"/>
                    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
        </c:otherwise>
    </c:choose>
    
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">${action eq 'approve' ? 'Phê duyệt' : 'Từ chối'} đăng ký chuyển đồ</h1>
        <div class="btn-toolbar mb-2 mb-md-0">
            <a href="${pageContext.request.contextPath}/moving/view/${registration.movingId}" class="btn btn-sm btn-outline-secondary">
                <i class="fas fa-arrow-left me-1"></i> Quay lại
            </a>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-6">
            <div class="card mb-4">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="fas fa-dolly me-2"></i>Thông tin đăng ký</h5>
                </div>
                <div class="card-body">
                    <table class="table table-bordered">
                        <tr>
                            <th width="40%">ID đăng ký:</th>
                            <td>${registration.movingId}</td>
                        </tr>
                        <tr>
                            <th>Căn hộ:</th>
                            <td>${registration.apartment.apartmentNumber}</td>
                        </tr>
                        <tr>
                            <th>Người đăng ký:</th>
                            <td>${registration.requester.fullName}</td>
                        </tr>
                        <tr>
                            <th>Loại chuyển đồ:</th>
                            <td>
                                <span class="badge ${registration.movingType eq 'Vào' ? 'bg-success' : 'bg-warning'}">
                                    ${registration.movingType}
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <th>Ngày chuyển đồ:</th>
                            <td><fmt:formatDate value="${registration.movingDate}" pattern="dd/MM/yyyy" /></td>
                        </tr>
                        <tr>
                            <th>Thời gian:</th>
                            <td>
                                <fmt:formatDate value="${registration.startTime}" pattern="HH:mm" /> - 
                                <fmt:formatDate value="${registration.endTime}" pattern="HH:mm" />
                            </td>
                        </tr>
                    </table>
                    
                    <p class="mt-3"><strong>Mô tả vật dụng:</strong></p>
                    <div class="p-3 bg-light rounded">
                        <p class="mb-0">${registration.itemsDescription}</p>
                    </div>
                    
                    <c:if test="${not empty registration.specialNotes}">
                        <p class="mt-3"><strong>Ghi chú đặc biệt:</strong></p>
                        <div class="p-3 bg-light rounded">
                            <p class="mb-0">${registration.specialNotes}</p>
                        </div>
                    </c:if>
                    
                    <c:if test="${registration.needElevatorReservation}">
                        <div class="alert alert-warning mt-3">
                            <i class="fas fa-exclamation-triangle me-2"></i> Yêu cầu đặt thang máy riêng
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
        
        <div class="col-md-6">
            <div class="card mb-4">
                <div class="card-header ${action eq 'approve' ? 'bg-success' : 'bg-danger'} text-white">
                    <h5 class="mb-0">
                        <i class="fas ${action eq 'approve' ? 'fa-check-circle' : 'fa-times-circle'} me-2"></i>
                        ${action eq 'approve' ? 'Phê duyệt' : 'Từ chối'} đăng ký
                    </h5>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/moving/${action}/${registration.movingId}" method="post">
                        <div class="mb-3">
                            <label for="reviewNotes" class="form-label">Ghi chú ${action eq 'approve' ? 'phê duyệt' : 'từ chối'} <span class="text-danger">*</span></label>
                            <textarea class="form-control" id="reviewNotes" name="reviewNotes" rows="5" 
                                      placeholder="Nhập ghi chú ${action eq 'approve' ? 'phê duyệt' : 'lý do từ chối'}..." 
                                      ${action eq 'reject' ? 'required' : ''}></textarea>
                            <div class="form-text">
                                <c:choose>
                                    <c:when test="${action eq 'approve'}">
                                        Nhập hướng dẫn hoặc lưu ý khi thực hiện chuyển đồ (nếu có).
                                    </c:when>
                                    <c:otherwise>
                                        Vui lòng nhập lý do từ chối để người đăng ký có thể hiểu và điều chỉnh.
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <c:if test="${action eq 'approve'}">
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="elevatorReserved" name="elevatorReserved" ${registration.needElevatorReservation ? 'checked' : ''}>
                                <label class="form-check-label" for="elevatorReserved">Xác nhận đã đặt thang máy riêng</label>
                            </div>
                            
                            <div class="mb-3">
                                <label for="securityNotes" class="form-label">Hướng dẫn an ninh</label>
                                <textarea class="form-control" id="securityNotes" name="securityNotes" rows="3" 
                                        placeholder="Nhập các hướng dẫn về an ninh, ra vào..."></textarea>
                            </div>
                        </c:if>
                        
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="notifyResident" name="notifyResident" checked>
                            <label class="form-check-label" for="notifyResident">Gửi thông báo cho cư dân</label>
                        </div>
                        
                        <div class="alert ${action eq 'approve' ? 'alert-info' : 'alert-warning'}">
                            <i class="fas ${action eq 'approve' ? 'fa-info-circle' : 'fa-exclamation-triangle'} me-2"></i>
                            <c:choose>
                                <c:when test="${action eq 'approve'}">
                                    Khi phê duyệt, cư dân sẽ được phép thực hiện chuyển đồ theo thời gian đã đăng ký.
                                </c:when>
                                <c:otherwise>
                                    Khi từ chối, cư dân sẽ phải tạo đăng ký mới nếu vẫn muốn thực hiện chuyển đồ.
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="${pageContext.request.contextPath}/moving/view/${registration.movingId}" class="btn btn-secondary me-md-2">Hủy</a>
                            <button type="submit" class="btn ${action eq 'approve' ? 'btn-success' : 'btn-danger'}">
                                <i class="fas ${action eq 'approve' ? 'fa-check' : 'fa-times'} me-1"></i>
                                ${action eq 'approve' ? 'Phê duyệt' : 'Từ chối'}
                            </button>
                        </div>
                    </form>
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
        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const reviewNotes = document.getElementById('reviewNotes').value;
            
            if ('${action}' === 'reject' && !reviewNotes.trim()) {
                e.preventDefault();
                alert('Vui lòng nhập lý do từ chối!');
                return false;
            }
            
            return true;
        });
    </script>
</body>
</html>