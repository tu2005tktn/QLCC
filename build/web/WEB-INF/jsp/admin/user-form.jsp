<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm/Sửa người dùng - Hệ thống quản lý chung cư</title>
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
                    <h1 class="h2">${user.userId != 0 ? 'Sửa' : 'Thêm'} người dùng</h1>
                </div>
                
                <div class="row">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <form:form action="${pageContext.request.contextPath}${user.userId != 0 ? '/admin/users/edit/' : '/admin/users/add'}${user.userId}" 
                                           modelAttribute="user" 
                                           method="post"
                                           id="userForm"
                                           onsubmit="return validateForm()">
                                    <div class="mb-3">
                                        <label for="username" class="form-label">Tên đăng nhập</label>
                                        <form:input path="username" cssClass="form-control" required="true" />
                                        <form:errors path="username" cssClass="text-danger" />
                                    </div>
                                    
                                    <c:if test="${user.userId == 0}">
                                        <div class="mb-3">
                                            <label for="password" class="form-label">Mật khẩu</label>
                                            <form:password path="password" cssClass="form-control" required="true" id="password" />
                                            <div class="form-text">Mật khẩu phải có ít nhất 6 ký tự</div>
                                            <form:errors path="password" cssClass="text-danger" />
                                        </div>
                                    </c:if>
                                    
                                    <c:if test="${user.userId != 0}">
                                        <div class="mb-3">
                                            <label for="newPassword" class="form-label">Mật khẩu mới (để trống nếu không đổi)</label>
                                            <input type="password" class="form-control" id="newPassword" name="newPassword" />
                                        </div>
                                    </c:if>
                                    
                                    <div class="mb-3">
                                        <label for="fullName" class="form-label">Họ tên</label>
                                        <form:input path="fullName" cssClass="form-control" required="true" />
                                        <form:errors path="fullName" cssClass="text-danger" />
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email</label>
                                        <form:input path="email" type="email" cssClass="form-control" required="true" id="email" />
                                        <form:errors path="email" cssClass="text-danger" />
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="phone" class="form-label">Số điện thoại</label>
                                        <form:input path="phone" cssClass="form-control" id="phone" />
                                        <form:errors path="phone" cssClass="text-danger" />
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="roleId" class="form-label">Vai trò</label>
                                        <form:select path="roleId" cssClass="form-select" required="true">
                                            <form:options items="${roles}" itemValue="roleId" itemLabel="roleName" />
                                        </form:select>
                                        <form:errors path="roleId" cssClass="text-danger" />
                                    </div>
                                    
                                    <div class="mb-3 form-check">
                                        <form:checkbox path="status" cssClass="form-check-input" id="status" />
                                        <label class="form-check-label" for="status">Kích hoạt</label>
                                    </div>
                                    
                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary me-md-2">Hủy</a>
                                        <button type="submit" class="btn btn-primary">Lưu</button>
                                    </div>
                                </form:form>
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
            
            // Kiểm tra email
            const email = document.getElementById('email').value;
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                alert("Email không hợp lệ");
                isValid = false;
            }
            
            // Kiểm tra số điện thoại
            const phone = document.getElementById('phone').value;
            if (phone && !/^[0-9]{10,11}$/.test(phone)) {
                alert("Số điện thoại không hợp lệ (10-11 số)");
                isValid = false;
            }
            
            // Kiểm tra mật khẩu cho người dùng mới
            const password = document.getElementById('password');
            if (password && password.value.length < 6) {
                alert("Mật khẩu phải có ít nhất 6 ký tự");
                isValid = false;
            }
            
            return isValid;
        }
    </script>
</body>
</html>