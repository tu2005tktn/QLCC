<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${request.requestId != 0 ? 'Cập nhật' : 'Tạo'} yêu cầu - Hệ thống quản lý chung cư</title>
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
                    <h1 class="h2">${request.requestId != 0 ? 'Cập nhật' : 'Tạo'} yêu cầu</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/requests/list" class="btn btn-sm btn-outline-secondary">
                            <i class="fas fa-arrow-left me-1"></i> Quay lại
                        </a>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-8">
                        <div class="card mb-4">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0"><i class="fas fa-clipboard-list me-2"></i>Thông tin yêu cầu</h5>
                            </div>
                            <div class="card-body">
                                <form:form action="${pageContext.request.contextPath}${request.requestId != 0 ? '/requests/update/' : '/requests/create'}${request.requestId}" 
                                           modelAttribute="request" 
                                           method="post"
                                           id="requestForm"
                                           onsubmit="return validateForm()">
                                    <form:hidden path="requestId" />
                                    <form:hidden path="requesterId" />
                                    <form:hidden path="apartmentId" />
                                    
                                    <div class="mb-3 row">
                                        <label class="col-sm-3 col-form-label">Căn hộ:</label>
                                        <div class="col-sm-9">
                                            <p class="form-control-plaintext">${apartment.apartmentNumber}</p>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="title" class="col-sm-3 col-form-label">Tiêu đề: <span class="text-danger">*</span></label>
                                        <div class="col-sm-9">
                                            <form:input path="title" cssClass="form-control" required="true" 
                                                      placeholder="Nhập tiêu đề ngắn gọn của yêu cầu" />
                                            <form:errors path="title" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="requestTypeId" class="col-sm-3 col-form-label">Loại yêu cầu: <span class="text-danger">*</span></label>
                                        <div class="col-sm-9">
                                            <form:select path="requestTypeId" cssClass="form-select" required="true">
                                                <form:option value="">-- Chọn loại yêu cầu --</form:option>
                                                <c:forEach var="type" items="${requestTypes}">
                                                    <form:option value="${type.requestTypeId}">${type.typeName}</form:option>
                                                </c:forEach>
                                            </form:select>
                                            <form:errors path="requestTypeId" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="description" class="col-sm-3 col-form-label">Mô tả: <span class="text-danger">*</span></label>
                                        <div class="col-sm-9">
                                            <form:textarea path="description" cssClass="form-control" rows="5" required="true" 
                                                         placeholder="Mô tả chi tiết về yêu cầu của bạn..." />
                                            <form:errors path="description" cssClass="text-danger" />
                                            <div class="form-text">Chi tiết vấn đề, địa điểm, thời gian phát hiện, v.v.</div>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="priority" class="col-sm-3 col-form-label">Mức ưu tiên:</label>
                                        <div class="col-sm-9">
                                            <form:select path="priority" cssClass="form-select">
                                                <form:option value="Bình thường">Bình thường</form:option>
                                                <form:option value="Cao">Cao</form:option>
                                                <form:option value="Thấp">Thấp</form:option>
                                            </form:select>
                                            <form:errors path="priority" cssClass="text-danger" />
                                            <div class="form-text">Chọn "Cao" cho các vấn đề cần giải quyết gấp</div>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="preferredTime" class="col-sm-3 col-form-label">Thời gian phù hợp:</label>
                                        <div class="col-sm-9">
                                            <form:input path="preferredTime" cssClass="form-control" 
                                                      placeholder="VD: Buổi sáng 8-11h, Chiều từ 2-5h..." />
                                            <form:errors path="preferredTime" cssClass="text-danger" />
                                            <div class="form-text">Thời gian thuận tiện để nhân viên đến kiểm tra/xử lý</div>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3 row">
                                        <label for="contactPhone" class="col-sm-3 col-form-label">Số liên hệ: <span class="text-danger">*</span></label>
                                        <div class="col-sm-9">
                                            <form:input path="contactPhone" cssClass="form-control" required="true" 
                                                      placeholder="Số điện thoại liên hệ" />
                                            <form:errors path="contactPhone" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    
                                    <div class="alert alert-info">
                                        <i class="fas fa-info-circle me-2"></i> Yêu cầu của bạn sẽ được tiếp nhận và xử lý trong thời gian sớm nhất. Ban quản lý sẽ liên hệ theo số điện thoại bạn cung cấp.
                                    </div>
                                    
                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <a href="${pageContext.request.contextPath}/requests/list" class="btn btn-secondary me-md-2">Hủy</a>
                                        <button type="submit" class="btn btn-primary">${request.requestId != 0 ? 'Cập nhật' : 'Gửi yêu cầu'}</button>
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
                                <h6>Các loại yêu cầu</h6>
                                <ul>
                                    <li><strong>Sửa chữa:</strong> Hỏng hóc, rò rỉ nước, điện, v.v.</li>
                                    <li><strong>Bảo trì:</strong> Bảo dưỡng định kỳ các thiết bị</li>
                                    <li><strong>An ninh:</strong> Vấn đề về camera, cửa, khóa an toàn</li>
                                    <li><strong>Vệ sinh:</strong> Khu vực công cộng, thu gom rác</li>
                                    <li><strong>Khiếu nại:</strong> Tiếng ồn, mùi hôi, vi phạm nội quy</li>
                                    <li><strong>Đề xuất:</strong> Cải thiện dịch vụ, tiện ích chung</li>
                                </ul>
                                
                                <h6 class="mt-3">Mức độ ưu tiên</h6>
                                <ul>
                                    <li><span class="badge bg-danger">Cao</span>: Ảnh hưởng nghiêm trọng, cần giải quyết ngay</li>
                                    <li><span class="badge bg-info">Bình thường</span>: Cần giải quyết trong vòng 24-48 giờ</li>
                                    <li><span class="badge bg-success">Thấp</span>: Có thể xử lý sau, không gấp</li>
                                </ul>
                                
                                <h6 class="mt-3">Quy trình xử lý</h6>
                                <ol>
                                    <li>Tiếp nhận yêu cầu</li>
                                    <li>Phân công nhân viên xử lý</li>
                                    <li>Liên hệ và thực hiện</li>
                                    <li>Hoàn thành yêu cầu</li>
                                </ol>
                                
                                <div class="alert alert-warning mt-3">
                                    <i class="fas fa-phone-alt me-2"></i> Trường hợp khẩn cấp vui lòng gọi số hotline: <strong>0123 456 789</strong>
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
            
            // Kiểm tra tiêu đề
            const title = document.getElementById('title').value;
            if (title.length < 5 || title.length > 100) {
                alert("Tiêu đề phải từ 5 đến 100 ký tự!");
                isValid = false;
            }
            
            // Kiểm tra loại yêu cầu
            const requestTypeId = document.getElementById('requestTypeId').value;
            if (!requestTypeId) {
                alert("Vui lòng chọn loại yêu cầu!");
                isValid = false;
            }
            
            // Kiểm tra mô tả
            const description = document.getElementById('description').value;
            if (description.length < 10) {
                alert("Mô tả phải có ít nhất 10 ký tự!");
                isValid = false;
            }
            
            // Kiểm tra số điện thoại
            const phoneRegex = /^(0|\+84)\d{9,10}$/;
            const phone = document.getElementById('contactPhone').value;
            if (!phoneRegex.test(phone)) {
                alert("Số điện thoại không hợp lệ! Vui lòng nhập số điện thoại Việt Nam (10-11 số).");
                isValid = false;
            }
            
            return isValid;
        }
    </script>
</body>
</html>