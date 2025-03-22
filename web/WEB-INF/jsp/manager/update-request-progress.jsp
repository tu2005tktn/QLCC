<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập nhật tiến độ - Hệ thống quản lý chung cư</title>
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
                    <h1 class="h2">Cập nhật tiến độ yêu cầu #${request.requestId}</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/requests/view/${request.requestId}" class="btn btn-sm btn-outline-secondary">
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
                                        <th>Trạng thái hiện tại:</th>
                                        <td>
                                            <c:choose>
                                                <c:when test="${request.status eq 'Đang chờ xử lý'}">
                                                    <span class="badge bg-warning">Đang chờ xử lý</span>
                                                </c:when>
                                                <c:when test="${request.status eq 'Đang xử lý'}">
                                                    <span class="badge bg-primary">Đang xử lý</span>
                                                </c:when>
                                                <c:when test="${request.status eq 'Hoàn thành'}">
                                                    <span class="badge bg-success">Hoàn thành</span>
                                                </c:when>
                                                <c:when test="${request.status eq 'Từ chối'}">
                                                    <span class="badge bg-danger">Từ chối</span>
                                                </c:when>
                                                <c:when test="${request.status eq 'Đã hủy'}">
                                                    <span class="badge bg-secondary">Đã hủy</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">${request.status}</span>
                                                </c:otherwise>
                                            </c:choose>
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
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">${request.priority}</span>
                                                </c:otherwise>
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
                        <div class="card mb-4">
                            <div class="card-header bg-success text-white">
                                <h5 class="mb-0"><i class="fas fa-tasks me-2"></i>Cập nhật tiến độ</h5>
                            </div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/requests/update-progress/${request.requestId}" method="post">
                                    <div class="mb-3">
                                        <label for="status" class="form-label">Trạng thái mới <span class="text-danger">*</span></label>
                                        <select class="form-select" id="status" name="status" required>
                                            <option value="">-- Chọn trạng thái --</option>
                                            <c:forEach var="status" items="${statusOptions}">
                                                <option value="${status}">${status}</option>
                                            </c:forEach>
                                        </select>
                                        <div class="form-text">Chọn trạng thái mới cho yêu cầu.</div>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="notes" class="form-label">Ghi chú <span class="text-danger">*</span></label>
                                        <textarea class="form-control" id="notes" name="notes" rows="5" placeholder="Nhập nội dung cập nhật tiến độ..." required></textarea>
                                        <div class="form-text">Mô tả chi tiết về tiến độ xử lý hoặc lý do từ chối/hủy.</div>
                                    </div>
                                    
                                    <div class="mb-3 form-check">
                                        <input type="checkbox" class="form-check-input" id="notifyRequester" name="notifyRequester" checked>
                                        <label class="form-check-label" for="notifyRequester">Gửi thông báo cho người yêu cầu</label>
                                    </div>
                                    
                                    <div class="card mb-3 border-warning">
                                        <div class="card-header bg-warning bg-opacity-25">
                                            <h6 class="mb-0"><i class="fas fa-exclamation-triangle me-2"></i>Hướng dẫn cập nhật trạng thái</h6>
                                        </div>
                                        <div class="card-body">
                                            <ul class="mb-0">
                                                <li><strong>Đang xử lý:</strong> Yêu cầu đã được tiếp nhận và đang được xử lý</li>
                                                <li><strong>Hoàn thành:</strong> Yêu cầu đã được giải quyết hoàn toàn</li>
                                                <li><strong>Từ chối:</strong> Yêu cầu bị từ chối vì lý do nào đó (cần ghi rõ)</li>
                                                <li><strong>Đã hủy:</strong> Yêu cầu bị hủy theo yêu cầu của người yêu cầu hoặc vì lý do khác</li>
                                            </ul>
                                        </div>
                                    </div>
                                    
                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <a href="${pageContext.request.contextPath}/requests/view/${request.requestId}" class="btn btn-secondary me-md-2">Hủy</a>
                                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        
                        <div class="card mb-4">
                            <div class="card-header bg-info text-white">
                                <h5 class="mb-0"><i class="fas fa-history me-2"></i>Lịch sử cập nhật</h5>
                            </div>
                            <div class="card-body">
                                <c:if test="${empty progressList}">
                                    <div class="alert alert-info">
                                        Chưa có cập nhật tiến độ nào.
                                    </div>
                                </c:if>
                                
                                <c:if test="${not empty progressList}">
                                    <div class="table-responsive">
                                        <table class="table table-striped table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Thời gian</th>
                                                    <th>Trạng thái</th>
                                                    <th>Người cập nhật</th>
                                                    <th>Ghi chú</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="progress" items="${progressList}">
                                                    <tr>
                                                        <td><fmt:formatDate value="${progress.updateTime}" pattern="dd/MM/yyyy HH:mm" /></td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${progress.status eq 'Đang chờ xử lý'}">
                                                                    <span class="badge bg-warning">Đang chờ xử lý</span>
                                                                </c:when>
                                                                <c:when test="${progress.status eq 'Đang xử lý'}">
                                                                    <span class="badge bg-primary">Đang xử lý</span>
                                                                </c:when>
                                                                <c:when test="${progress.status eq 'Hoàn thành'}">
                                                                    <span class="badge bg-success">Hoàn thành</span>
                                                                </c:when>
                                                                <c:when test="${progress.status eq 'Từ chối'}">
                                                                    <span class="badge bg-danger">Từ chối</span>
                                                                </c:when>
                                                                <c:when test="${progress.status eq 'Đã hủy'}">
                                                                    <span class="badge bg-secondary">Đã hủy</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-secondary">${progress.status}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>${progress.updatedBy.fullName}</td>
                                                        <td>${progress.notes}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
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