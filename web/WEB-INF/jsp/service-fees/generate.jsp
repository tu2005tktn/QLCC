<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo phí dịch vụ hàng loạt - Hệ thống quản lý chung cư</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <c:choose>
        <c:when test="${sessionScope.user.role.roleName == 'ADMIN'}">
            <jsp:include page="../common/admin-header.jsp"/>
        </c:when>
        <c:otherwise>
            <jsp:include page="../common/manager-header.jsp"/>
        </c:otherwise>
    </c:choose>
    
    <div class="container-fluid">
        <div class="row">
            <c:choose>
                <c:when test="${sessionScope.user.role.roleName == 'ADMIN'}">
                    <jsp:include page="../common/admin-sidebar.jsp"/>
                </c:when>
                <c:otherwise>
                    <jsp:include page="../common/manager-sidebar.jsp"/>
                </c:otherwise>
            </c:choose>
            
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Tạo phí dịch vụ hàng loạt</h1>
                </div>
                
                <div class="row">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/service-fees/generate" method="post">
                                    <div class="mb-3">
                                        <label for="month" class="form-label">Tháng</label>
                                        <select class="form-select" id="month" name="month" required>
                                            <c:forEach var="i" begin="1" end="12">
                                                <option value="${i}" ${i == currentMonth ? 'selected' : ''}>${i}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="year" class="form-label">Năm</label>
                                        <select class="form-select" id="year" name="year" required>
                                            <c:forEach var="year" items="${years}">
                                                <option value="${year}" ${year == currentYear ? 'selected' : ''}>${year}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="serviceTypeId" class="form-label">Loại phí dịch vụ</label>
                                        <select class="form-select" id="serviceTypeId" name="serviceTypeId" required>
                                            <c:forEach var="serviceType" items="${serviceTypes}">
                                                <option value="${serviceType.serviceTypeId}">${serviceType.typeName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    
                                    <div class="alert alert-info">
                                        <i class="fas fa-info-circle me-2"></i> Lưu ý: Hệ thống sẽ tự động tính toán phí dịch vụ dựa trên diện tích căn hộ và loại dịch vụ. Các phí đã tồn tại sẽ không được tạo lại.
                                    </div>
                                    
                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <a href="${pageContext.request.contextPath}/service-fees/list" class="btn btn-secondary me-md-2">Hủy</a>
                                        <button type="submit" class="btn btn-primary">Tạo phí dịch vụ</button>
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
</body>
</html>