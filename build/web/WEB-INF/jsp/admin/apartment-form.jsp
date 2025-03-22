<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm/Sửa căn hộ - Hệ thống quản lý chung cư</title>
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
                    <h1 class="h2">${apartment.apartmentId != 0 ? 'Sửa' : 'Thêm'} căn hộ</h1>
                </div>
                
                <div class="row">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <form:form action="${pageContext.request.contextPath}${apartment.apartmentId != 0 ? '/apartments/edit/' : '/apartments/add'}${apartment.apartmentId}" 
                                           modelAttribute="apartment" 
                                           method="post"
                                           id="apartmentForm"
                                           onsubmit="return validateForm()">
                                    <div class="mb-3">
                                        <label for="apartmentNumber" class="form-label">Số căn hộ</label>
                                        <form:input path="apartmentNumber" cssClass="form-control" required="true" />
                                        <form:errors path="apartmentNumber" cssClass="text-danger" />
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="floorNumber" class="form-label">Tầng</label>
                                        <form:input path="floorNumber" type="number" min="1" cssClass="form-control" required="true" />
                                        <form:errors path="floorNumber" cssClass="text-danger" />
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="area" class="form-label">Diện tích (m²)</label>
                                        <form:input path="area" type="number" step="0.01" min="0" cssClass="form-control" required="true" />
                                        <form:errors path="area" cssClass="text-danger" />
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="status" class="form-label">Trạng thái</label>
                                        <form:select path="status" cssClass="form-select" required="true">
                                            <form:option value="Đang sử dụng">Đang sử dụng</form:option>
                                            <form:option value="Trống">Trống</form:option>
                                            <form:option value="Đang bảo trì">Đang bảo trì</form:option>
                                        </form:select>
                                        <form:errors path="status" cssClass="text-danger" />
                                    </div>
                                    
                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <a href="${pageContext.request.contextPath}/admin/apartments" class="btn btn-secondary me-md-2">Hủy</a>
                                        <button type="submit" class="btn btn-primary">Lưu</button>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header bg-light">
                                <h5 class="mb-0">Hướng dẫn</h5>
                            </div>
                            <div class="card-body">
                                <p><strong>Số căn hộ:</strong> Nhập số căn hộ theo định dạng (VD: A101, B205,...)</p>
                                <p><strong>Tầng:</strong> Nhập số tầng (số nguyên dương)</p>
                                <p><strong>Diện tích:</strong> Nhập diện tích căn hộ (m²)</p>
                                <p><strong>Trạng thái:</strong> Chọn trạng thái hiện tại của căn hộ</p>
                                <ul>
                                    <li><strong>Đang sử dụng:</strong> Căn hộ đang có người ở</li>
                                    <li><strong>Trống:</strong> Căn hộ chưa có người ở</li>
                                    <li><strong>Đang bảo trì:</strong> Căn hộ đang được sửa chữa, bảo trì</li>
                                </ul>
                                <div class="alert alert-info mt-3">
                                    <i class="fas fa-info-circle me-2"></i> Sau khi thêm căn hộ, bạn có thể gán chủ sở hữu và người thuê trong phần quản lý chi tiết căn hộ.
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
        function validateForm() {
            let isValid = true;
            
            // Kiểm tra số căn hộ
            const apartmentNumber = document.getElementById('apartmentNumber').value;
            const apartmentNumberRegex = /^[A-Z][0-9]{3,4}$/;
            if (!apartmentNumberRegex.test(apartmentNumber)) {
                alert("Số căn hộ không hợp lệ. Định dạng đúng: 1 chữ cái in hoa + 3-4 chữ số (VD: A101, B2345)");
                isValid = false;
            }
            
            // Kiểm tra tầng
            const floorNumber = document.getElementById('floorNumber').value;
            if (floorNumber < 1 || floorNumber > 50) {
                alert("Số tầng không hợp lệ (từ 1-50)");
                isValid = false;
            }
            
            // Kiểm tra diện tích
            const area = document.getElementById('area').value;
            if (area <= 0 || area > 500) {
                alert("Diện tích không hợp lệ (0-500 m²)");
                isValid = false;
            }
            
            return isValid;
        }
    </script>
</body>
</html>