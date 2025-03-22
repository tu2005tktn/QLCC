<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${registration.movingId != 0 ? 'Cập nhật' : 'Đăng ký'} chuyển đồ - Hệ thống quản lý chung cư</title>
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
                    <h1 class="h2">${registration.movingId != 0 ? 'Cập nhật' : 'Đăng ký'} chuyển đồ</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/moving/list" class="btn btn-sm btn-outline-secondary">
                            <i class="fas fa-arrow-left me-1"></i> Quay lại
                        </a>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-8">
                        <div class="card mb-4">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0"><i class="fas fa-dolly me-2"></i>Thông tin đăng ký</h5>
                            </div>
                            <div class="card-body">
                                <form:form action="${pageContext.request.contextPath}${registration.movingId != 0 ? '/moving/update/' : '/moving/create'}${registration.movingId}" 
                                           modelAttribute="registration" 
                                           method="post"
                                           id="movingForm"
                                           onsubmit="return validateForm()">
                                    <form:hidden path="movingId" />
                                    <form:hidden path="requesterId" />
                                    <form:hidden path="apartmentId" />
                                    
                                    <div class="mb-3 row">
                                        <label class="col-sm-3 col-form-label">Căn hộ:</label>
                                        <div class="col-sm-9">
                                            <p class="form-control-plaintext">${apartment.apartmentNumber}</p>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="movingType" class="col-sm-3 col-form-label">Loại chuyển đồ: <span class="text-danger">*</span></label>
                                        <div class="col-sm-9">
                                            <form:select path="movingType" cssClass="form-select" required="true">
                                                <form:option value="">-- Chọn loại chuyển đồ --</form:option>
                                                <c:forEach var="type" items="${movingTypes}">
                                                    <form:option value="${type}">${type}</form:option>
                                                </c:forEach>
                                            </form:select>
                                            <form:errors path="movingType" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="movingDate" class="col-sm-3 col-form-label">Ngày chuyển đồ: <span class="text-danger">*</span></label>
                                        <div class="col-sm-9">
                                            <form:input path="movingDate" type="date" cssClass="form-control" required="true" />
                                            <form:errors path="movingDate" cssClass="text-danger" />
                                            <div class="form-text">Chọn ngày dự kiến chuyển đồ (phải cách ngày đăng ký ít nhất 1 ngày)</div>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="startTime" class="col-sm-3 col-form-label">Thời gian bắt đầu: <span class="text-danger">*</span></label>
                                        <div class="col-sm-9">
                                            <form:input path="startTime" type="time" cssClass="form-control" required="true" />
                                            <form:errors path="startTime" cssClass="text-danger" />
                                            <div class="form-text">Giờ bắt đầu chuyển đồ (từ 8:00 đến 17:00)</div>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="endTime" class="col-sm-3 col-form-label">Thời gian kết thúc: <span class="text-danger">*</span></label>
                                        <div class="col-sm-9">
                                            <form:input path="endTime" type="time" cssClass="form-control" required="true" />
                                            <form:errors path="endTime" cssClass="text-danger" />
                                            <div class="form-text">Giờ kết thúc chuyển đồ (tối đa 3 giờ từ giờ bắt đầu)</div>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="itemsDescription" class="col-sm-3 col-form-label">Mô tả vật dụng: <span class="text-danger">*</span></label>
                                        <div class="col-sm-9">
                                            <form:textarea path="itemsDescription" cssClass="form-control" rows="4" required="true" 
                                                            placeholder="Mô tả chi tiết các vật dụng sẽ được chuyển (loại, kích thước, số lượng...)" />
                                            <form:errors path="itemsDescription" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="specialNotes" class="col-sm-3 col-form-label">Ghi chú đặc biệt:</label>
                                        <div class="col-sm-9">
                                            <form:textarea path="specialNotes" cssClass="form-control" rows="3" 
                                                          placeholder="Các yêu cầu đặc biệt hoặc lưu ý khi chuyển đồ (nếu có)" />
                                            <form:errors path="specialNotes" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <div class="col-sm-3">Đặt thang máy riêng:</div>
                                        <div class="col-sm-9">
                                            <div class="form-check form-switch">
                                                <form:checkbox path="needElevatorReservation" cssClass="form-check-input" id="needElevatorReservation" />
                                                <label class="form-check-label" for="needElevatorReservation">Yêu cầu đặt thang máy riêng</label>
                                            </div>
                                            <div class="form-text">Chọn nếu bạn cần sử dụng thang máy riêng khi chuyển đồ</div>
                                        </div>
                                    </div>
                                    
                                    <hr>
                                    
                                    <h5 class="mb-3">Thông tin liên hệ</h5>
                                    
                                    <div class="mb-3 row">
                                        <label for="contactName" class="col-sm-3 col-form-label">Người liên hệ: <span class="text-danger">*</span></label>
                                        <div class="col-sm-9">
                                            <form:input path="contactName" cssClass="form-control" required="true" />
                                            <form:errors path="contactName" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="contactPhone" class="col-sm-3 col-form-label">Số điện thoại: <span class="text-danger">*</span></label>
                                        <div class="col-sm-9">
                                            <form:input path="contactPhone" cssClass="form-control" required="true" />
                                            <form:errors path="contactPhone" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="contactEmail" class="col-sm-3 col-form-label">Email:</label>
                                        <div class="col-sm-9">
                                            <form:input path="contactEmail" type="email" cssClass="form-control" />
                                            <form:errors path="contactEmail" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    
                                    <hr>
                                    
                                    <h5 class="mb-3">Thông tin đơn vị vận chuyển</h5>
                                    
                                    <div class="mb-3 row">
                                        <label for="movingCompany" class="col-sm-3 col-form-label">Tên đơn vị:</label>
                                        <div class="col-sm-9">
                                            <form:input path="movingCompany" cssClass="form-control" placeholder="Tên công ty vận chuyển (nếu có)" />
                                            <form:errors path="movingCompany" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="numberOfMovers" class="col-sm-3 col-form-label">Số người tham gia: <span class="text-danger">*</span></label>
                                        <div class="col-sm-9">
                                            <form:input path="numberOfMovers" type="number" cssClass="form-control" min="1" max="10" required="true" />
                                            <form:errors path="numberOfMovers" cssClass="text-danger" />
                                            <div class="form-text">Số lượng người tham gia quá trình chuyển đồ (bao gồm cả nhân viên vận chuyển)</div>
                                        </div>
                                    </div>
                                    
                                    <div class="alert alert-warning">
                                        <i class="fas fa-exclamation-triangle me-2"></i> Lưu ý: Đăng ký chuyển đồ sẽ được duyệt trong vòng 24 giờ. Vui lòng đăng ký trước ít nhất 2 ngày trước ngày dự kiến chuyển đồ.
                                    </div>
                                    
                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <a href="${pageContext.request.contextPath}/moving/list" class="btn btn-secondary me-md-2">Hủy</a>
                                        <button type="submit" class="btn btn-primary">${registration.movingId != 0 ? 'Cập nhật' : 'Đăng ký'}</button>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="card mb-4">
                            <div class="card-header bg-info text-white">
                                <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Hướng dẫn</h5>
                            </div>
                            <div class="card-body">
                                <h6>Quy định chuyển đồ</h6>
                                <ul>
                                    <li>Thời gian chuyển đồ: 8:00 - 17:00 các ngày trong tuần</li>
                                    <li>Thời gian chuyển tối đa: 3 giờ</li>
                                    <li>Đăng ký trước ít nhất 2 ngày</li>
                                    <li>Chỉ được chuyển đồ sau khi đăng ký được phê duyệt</li>
                                </ul>
                                
                                <h6>Các vật dụng cấm chuyển</h6>
                                <ul>
                                    <li>Vật liệu dễ cháy nổ, độc hại</li>
                                    <li>Vật dụng quá khổ không phù hợp với kích thước thang máy</li>
                                    <li>Các vật phẩm bị pháp luật cấm</li>
                                </ul>
                                
                                <h6>Trạng thái đăng ký</h6>
                                <ul>
                                    <li><span class="badge bg-warning">Đang chờ phê duyệt</span>: Đang chờ ban quản lý xét duyệt</li>
                                    <li><span class="badge bg-success">Đã phê duyệt</span>: Đã được phê duyệt, có thể thực hiện chuyển đồ</li>
                                    <li><span class="badge bg-danger">Đã từ chối</span>: Bị từ chối, cần liên hệ ban quản lý để biết lý do</li>
                                    <li><span class="badge bg-secondary">Đã hủy</span>: Đã bị hủy bởi người đăng ký</li>
                                </ul>
                                
                                <div class="alert alert-primary mt-3">
                                    <i class="fas fa-phone-alt me-2"></i> Mọi thắc mắc vui lòng liên hệ ban quản lý: <strong>0123 456 789</strong>
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
            
            // Kiểm tra ngày chuyển đồ
            const movingDate = new Date(document.getElementById('movingDate').value);
            const today = new Date();
            today.setHours(0, 0, 0, 0);
            
            const minDate = new Date();
            minDate.setDate(today.getDate() + 1);
            minDate.setHours(0, 0, 0, 0);
            
            if (movingDate < minDate) {
                alert("Ngày chuyển đồ phải cách ngày đăng ký ít nhất 1 ngày!");
                isValid = false;
            }
            
            // Kiểm tra thời gian
            const startTime = document.getElementById('startTime').value;
            const endTime = document.getElementById('endTime').value;
            
            if (startTime && endTime) {
                const start = new Date(`2000-01-01T${startTime}`);
                const end = new Date(`2000-01-01T${endTime}`);
                const minStart = new Date(`2000-01-01T08:00`);
                const maxEnd = new Date(`2000-01-01T17:00`);
                
                if (start < minStart || end > maxEnd) {
                    alert("Thời gian chuyển đồ phải trong khoảng 8:00 - 17:00!");
                    isValid = false;
                }
                
                const diffHours = (end - start) / 1000 / 60 / 60;
                if (diffHours > 3) {
                    alert("Thời gian chuyển đồ tối đa là 3 giờ!");
                    isValid = false;
                }
                
                if (start >= end) {
                    alert("Thời gian kết thúc phải sau thời gian bắt đầu!");
                    isValid = false;
                }
            }
            
            // Kiểm tra số điện thoại
            const phoneRegex = /^(0|\+84)\d{9,10}$/;
            const phone = document.getElementById('contactPhone').value;
            if (!phoneRegex.test(phone)) {
                alert("Số điện thoại không hợp lệ! Vui lòng nhập số điện thoại Việt Nam (10-11 số).");
                isValid = false;
            }
            
            // Kiểm tra email (nếu có)
            const email = document.getElementById('contactEmail').value;
            if (email) {
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    alert("Email không hợp lệ!");
                    isValid = false;
                }
            }
            
            return isValid;
        }
        
        // Set minimum date for moving date
        window.onload = function() {
            const tomorrow = new Date();
            tomorrow.setDate(tomorrow.getDate() + 1);
            
            const yyyy = tomorrow.getFullYear();
            const mm = String(tomorrow.getMonth() + 1).padStart(2, '0');
            const dd = String(tomorrow.getDate()).padStart(2, '0');
            
            document.getElementById('movingDate').min = `${yyyy}-${mm}-${dd}`;
            
            // Set default start and end time if empty
            if (!document.getElementById('startTime').value) {
                document.getElementById('startTime').value = '09:00';
            }
            
            if (!document.getElementById('endTime').value) {
                document.getElementById('endTime').value = '11:00';
            }
        };
    </script>
</body>
</html>