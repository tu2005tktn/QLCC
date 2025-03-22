<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm/Sửa chủ sở hữu - Hệ thống quản lý chung cư</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <jsp:include page="../common/admin-header.jsp"/>
    
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="../common/admin-sidebar.jsp"/>
            
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">${owner.ownerId != 0 ? 'Sửa' : 'Thêm'} chủ sở hữu</h1>
                </div>
                
                <div class="row">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <form:form action="${pageContext.request.contextPath}/apartments/${apartmentId}/owner/save" 
                                           modelAttribute="owner" 
                                           method="post">
                                    <form:hidden path="ownerId" />
                                    <form:hidden path="apartmentId" />
                                    
                                    <div class="mb-3">
                                        <label for="apartment" class="form-label">Căn hộ</label>
                                        <input type="text" class="form-control" id="apartment" value="${apartment.apartmentNumber}" readonly />
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="userId" class="form-label">Chọn người dùng</label>
                                        <form:select path="userId" cssClass="form-select" required="true">
                                            <form:option value="" label="-- Chọn người dùng --" />
                                            <form:options items="${users}" itemValue="userId" itemLabel="fullName" />
                                        </form:select>
                                        <div class="form-text">Chọn tài khoản người dùng được gán làm chủ sở hữu</div>
                                        <form:errors path="userId" cssClass="text-danger" />
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="ownershipDate" class="form-label">Ngày sở hữu</label>
                                        <form:input path="ownershipDate" type="date" cssClass="form-control" required="true" />
                                        <form:errors path="ownershipDate" cssClass="text-danger" />
                                    </div>
                                    
                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <a href="${pageContext.request.contextPath}/apartments/view/${apartmentId}" class="btn btn-secondary me-md-2">Hủy</a>
                                        <button type="submit" class="btn btn-primary">Lưu</button>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header bg-light">
                                <h5 class="mb-0">Thông tin quan trọng</h5>
                            </div>
                            <div class="card-body">
                                <div class="alert alert-warning">
                                    <i class="fas fa-exclamation-triangle me-2"></i> <strong>Lưu ý:</strong>
                                    <ul class="mb-0">
                                        <li>Mỗi căn hộ chỉ có thể có một chủ sở hữu tại một thời điểm</li>
                                        <li>Nếu căn hộ đã có chủ sở hữu, hệ thống sẽ tự động cập nhật thông tin mới</li>
                                        <li>Người dùng được chọn làm chủ sở hữu phải có tài khoản với vai trò "OWNER"</li>
                                        <li>Vui lòng kiểm tra lại thông tin trước khi lưu</li>
                                    </ul>
                                </div>
                                
                                <hr>
                                
                                <h6>Thông tin căn hộ:</h6>
                                <table class="table table-bordered">
                                    <tr>
                                        <th width="40%">Số căn hộ:</th>
                                        <td>${apartment.apartmentNumber}</td>
                                    </tr>
                                    <tr>
                                        <th>Tầng:</th>
                                        <td>${apartment.floorNumber}</td>
                                    </tr>
                                    <tr>
                                        <th>Diện tích:</th>
                                        <td>${apartment.area} m²</td>
                                    </tr>
                                    <tr>
                                        <th>Trạng thái:</th>
                                        <td>${apartment.status}</td>
                                    </tr>
                                </table>
                                
                                <c:if test="${currentOwner != null}">
                                    <h6 class="mt-3">Chủ sở hữu hiện tại:</h6>
                                    <table class="table table-bordered">
                                        <tr>
                                            <th width="40%">Họ tên:</th>
                                            <td>${currentOwner.user.fullName}</td>
                                        </tr>
                                        <tr>
                                            <th>Email:</th>
                                            <td>${currentOwner.user.email}</td>
                                        </tr>
                                        <tr>
                                            <th>Số điện thoại:</th>
                                            <td>${currentOwner.user.phone}</td>
                                        </tr>
                                        <tr>
                                            <th>Ngày sở hữu:</th>
                                            <td><fmt:formatDate value="${currentOwner.ownershipDate}" pattern="dd/MM/yyyy" /></td>
                                        </tr>
                                    </table>
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
</body>
</html>