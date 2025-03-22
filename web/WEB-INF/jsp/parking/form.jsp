<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${registration.parkingId != 0 ? 'Cập nhật' : 'Đăng ký'} gửi xe - Hệ thống quản lý chung cư</title>
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
                    <h1 class="h2">${registration.parkingId != 0 ? 'Cập nhật' : 'Đăng ký'} gửi xe</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/parking/list" class="btn btn-sm btn-outline-secondary">
                            <i class="fas fa-arrow-left me-1"></i> Quay lại
                        </a>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-8">
                        <div class="card mb-4">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0"><i class="fas fa-car me-2"></i>Thông tin đăng ký</h5>
                            </div>
                            <div class="card-body">
                                <form:form action="${pageContext.request.contextPath}${registration.parkingId != 0 ? '/parking/update/' : '/parking/create'}${registration.parkingId}" 
                                           modelAttribute="registration" 
                                           method="post"
                                           id="parkingForm"
                                           onsubmit="return validateForm()">
                                    <form:hidden path="parkingId" />
                                    <form:hidden path="requesterId" />
                                    <form:hidden path="apartmentId" />
                                    
                                    <div class="mb-3 row">
                                        <label class="col-sm-3 col-form-label">Căn hộ:</label>
                                        <div class="col-sm-9">
                                            <p class="form-control-plaintext">${apartment.apartmentNumber}</p>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="vehicleType" class="col-sm-3 col-form-label">Loại xe: <span class="text-danger">*</span></label>
                                        <div class="col-sm-9">
                                            <form:select path="vehicleType" cssClass="form-select" required="true" id="vehicleType" onchange="updateFee()">
                                                <form:option value="">-- Chọn loại xe --</form:option>
                                                <c:forEach var="type" items="${vehicleTypes}">
                                                    <form:option value="${type}">${type}</form:option>
                                                </c:forEach>
                                            </form:select>
                                            <form:errors path="vehicleType" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="licensePlate" class="col-sm-3 col-form-label">Biển số xe: <span class="text-danger">*</span></label>
                                        <div class="col-sm-9">
                                            <form:input path="licensePlate" cssClass="form-control" required="true" />
                                            <form:errors path="licensePlate" cssClass="text-danger" />
                                            <div class="form-text">Nhập đúng biển số xe không có dấu cách (VD: 30A12345)</div>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="vehicleBrand" class="col-sm-3 col-form-label">Hãng xe: <span class="text-danger">*</span></label>
                                        <div class="col-sm-9">
                                            <form:input path="vehicleBrand" cssClass="form-control" required="true" />
                                            <form:errors path="vehicleBrand" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="vehicleModel" class="col-sm-3 col-form-label">Model xe:</label>
                                        <div class="col-sm-9">
                                            <form:input path="vehicleModel" cssClass="form-control" />
                                            <form:errors path="vehicleModel" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="vehicleColor" class="col-sm-3 col-form-label">Màu sắc: <span class="text-danger">*</span></label>
                                        <div class="col-sm-9">
                                            <form:input path="vehicleColor" cssClass="form-control" required="true" />
                                            <form:errors path="vehicleColor" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="vehicleDescription" class="col-sm-3 col-form-label">Mô tả thêm:</label>
                                        <div class="col-sm-9">
                                            <form:textarea path="vehicleDescription" cssClass="form-control" rows="3" 
                                                         placeholder="Mô tả thêm về xe (nếu có)" />
                                            <form:errors path="vehicleDescription" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    
                                    <hr>
                                    
                                    <div class="mb-3 row">
                                        <label for="startDate" class="col-sm-3 col-form-label">Ngày bắt đầu: <span class="text-danger">*</span></label>
                                        <div class="col-sm-9">
                                            <form:input path="startDate" type="date" cssClass="form-control" required="true" />
                                            <form:errors path="startDate" cssClass="text-danger" />
                                            <div class="form-text">Ngày bắt đầu tính phí</div>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="endDate" class="col-sm-3 col-form-label">Ngày kết thúc:</label>
                                        <div class="col-sm-9">
                                            <form:input path="endDate" type="date" cssClass="form-control" />
                                            <form:errors path="endDate" cssClass="text-danger" />
                                            <div class="form-text">Để trống nếu đăng ký không xác định thời hạn</div>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="monthlyFee" class="col-sm-3 col-form-label">Phí hàng tháng: <span class="text-danger">*</span></label>
                                        <div class="col-sm-9">
                                            <div class="input-group">
                                                <form:input path="monthlyFee" type="number" cssClass="form-control" required="true" readonly="true" />
                                                <span class="input-group-text">VNĐ</span>
                                            </div>
                                            <form:errors path="monthlyFee" cssClass="text-danger" />
                                            <div class="form-text">Phí được tính tự động theo loại xe</div>
                                        </div>
                                    </div>
                                    
                                    <hr>
                                    
                                    <h5 class="mb-3">Thông tin liên hệ</h5>
                                    
                                    <div class="mb-3 row">
                                        <label for="ownerName" class="col-sm-3 col-form-label">Chủ xe: <span class="text-danger">*</span></label>
                                        <div class="col-sm-9">
                                            <form:input path="ownerName" cssClass="form-control" required="true" />
                                            <form:errors path="ownerName" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="ownerPhone" class="col-sm-3 col-form-label">Số điện thoại: <span class="text-danger">*</span></label>
                                        <div class="col-sm-9">
                                            <form:input path="ownerPhone" cssClass="form-control" required="true" />
                                            <form:errors path="ownerPhone" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="ownerEmail" class="col-sm-3 col-form-label">Email:</label>
                                        <div class="col-sm-9">
                                            <form:input path="ownerEmail" type="email" cssClass="form-control" />
                                            <form:errors path="ownerEmail" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="emergencyContact" class="col-sm-3 col-form-label">Liên hệ khẩn cấp:</label>
                                        <div class="col-sm-9">
                                            <form:input path="emergencyContact" cssClass="form-control" />
                                            <form:errors path="emergencyContact" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="emergencyPhone" class="col-sm-3 col-form-label">SĐT khẩn cấp:</label>
                                        <div class="col-sm-9">
                                            <form:input path="emergencyPhone" cssClass="form-control" />
                                            <form:errors path="emergencyPhone" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="notes" class="col-sm-3 col-form-label">Ghi chú:</label>
                                        <div class="col-sm-9">
                                            <form:textarea path="notes" cssClass="form-control" rows="3" 
                                                         placeholder="Ghi chú thêm (nếu có)" />
                                            <form:errors path="notes" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    
                                    <div class="alert alert-info">
                                        <i class="fas fa-info-circle me-2"></i> Phí gửi xe được tính từ ngày bắt đầu và sẽ được thu hàng tháng.
                                    </div>
                                    
                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <a href="${pageContext.request.contextPath}/parking/list" class="btn btn-secondary me-md-2">Hủy</a>
                                        <button type="submit" class="btn btn-primary">${registration.parkingId != 0 ? 'Cập nhật' : 'Đăng ký'}</button>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="card mb-4">
                            <div class="card-header bg-info text-white">
                                <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Thông tin về phí gửi xe</h5>
                            </div>
                            <div class="card-body">
                                <h6>Bảng giá gửi xe</h6>
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Loại xe</th>
                                            <th>Phí hàng tháng</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>Ô tô</td>
                                            <td>1,200,000 ₫</td>
                                        </tr>
                                        <tr>
                                            <td>Xe máy</td>
                                            <td>150,000 ₫</td>
                                        </tr>
                                        <tr>
                                            <td>Xe đạp</td>
                                            <td>50,000 ₫</td>
                                        </tr>
                                    </tbody>
                                </table>
                                
                                <h6 class="mt-3">Quy định gửi xe</h6>
                                <ul>
                                    <li>Mỗi căn hộ được đăng ký tối đa 2 ô tô và 3 xe máy</li>
                                    <li>Phí gửi xe được tính vào hóa đơn chung của căn hộ</li>
                                    <li>Xe được đảm bảo vị trí đỗ cố định</li>
                                    <li>Không được tự ý thay đổi vị trí đỗ xe</li>
                                    <li>Phải thông báo khi thay đổi hoặc hủy đăng ký gửi xe</li>
                                </ul>
                                
                                <h6 class="mt-3">Thời gian hoạt động</h6>
                                <ul>
                                    <li>Bãi đỗ xe hoạt động 24/7</li>
                                    <li>Bảo vệ trực thường xuyên đảm bảo an ninh</li>
                                </ul>
                                
                                <div class="alert alert-warning mt-3">
                                    <i class="fas fa-exclamation-triangle me-2"></i> Ban quản lý không chịu trách nhiệm khi xảy ra mất cắp tài sản để trong xe.
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
            
            // Kiểm tra biển số xe
            const licensePlate = document.getElementById('licensePlate').value;
            const licensePlateRegex = /^[0-9A-Z]{2,12}$/;
            if (!licensePlateRegex.test(licensePlate)) {
                alert("Biển số xe không hợp lệ! Vui lòng nhập đúng định dạng không dấu cách.");
                isValid = false;
            }
            
            // Kiểm tra ngày 
            const startDate = new Date(document.getElementById('startDate').value);
            const endDate = document.getElementById('endDate').value;
            const today = new Date();
            today.setHours(0, 0, 0, 0);
            
            if (startDate < today) {
                alert("Ngày bắt đầu không thể trước ngày hiện tại!");
                isValid = false;
            }
            
            if (endDate) {
                const endDateObj = new Date(endDate);
                if (endDateObj <= startDate) {
                    alert("Ngày kết thúc phải sau ngày bắt đầu!");
                    isValid = false;
                }
            }
            
            // Kiểm tra số điện thoại
            const phoneRegex = /^(0|\+84)\d{9,10}$/;
            const ownerPhone = document.getElementById('ownerPhone').value;
            if (!phoneRegex.test(ownerPhone)) {
                alert("Số điện thoại không hợp lệ! Vui lòng nhập số điện thoại Việt Nam (10-11 số).");
                isValid = false;
            }
            
            // Kiểm tra email (nếu có)
            const email = document.getElementById('ownerEmail').value;
            if (email) {
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    alert("Email không hợp lệ!");
                    isValid = false;
                }
            }
            
            return isValid;
        }
        
        function updateFee() {
            const vehicleType = document.getElementById('vehicleType').value;
            let fee = 0;
            
            switch (vehicleType) {
                case 'Ô tô':
                    fee = 1200000;
                    break;
                case 'Xe máy':
                    fee = 150000;
                    break;
                case 'Xe đạp':
                    fee = 50000;
                    break;
            }
            
            document.getElementById('monthlyFee').value = fee;
        }
        
        // Set minimum date for start date
        window.onload = function() {
            const today = new Date();
            
            const yyyy = today.getFullYear();
            const mm = String(today.getMonth() + 1).padStart(2, '0');
            const dd = String(today.getDate()).padStart(2, '0');
            
            document.getElementById('startDate').min = `${yyyy}-${mm}-${dd}`;
            
            // Update fee based on selected vehicle type
            updateFee();
        };
    </script>
</body>
</html>