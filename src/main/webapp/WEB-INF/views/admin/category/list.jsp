<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Quản lý Danh mục</title>
</head>
<body>
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>Danh mục sản phẩm (Category)</h3>
        <a href="/admin/categories/create" class="btn btn-primary">+ Thêm mới danh mục</a>
    </div>

    <!-- Form tìm kiếm -->
    <form class="row g-2 mb-3" method="get" action="/admin/categories">
        <div class="col-md-4">
            <input type="text" name="keyword" class="form-control"
                   placeholder="Nhập tên danh mục cần tìm..." value="${keyword}">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-secondary">Tìm kiếm</button>
            <a href="/admin/categories" class="btn btn-outline-secondary">Làm mới</a>
        </div>
    </form>

    <!-- Bảng hiển thị danh mục -->
    <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle">
            <thead class="table-light">
                <tr>
                    <th width="80px">ID</th>
                    <th>Tên danh mục</th>
                    <th>Mô tả</th>
                    <th width="150px">Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty listCategories}">
                        <c:forEach var="cat" items="${listCategories}">
                            <tr>
                                <td>${cat.id}</td>
                                <td><strong>${cat.name}</strong></td>
                                <td>${cat.description}</td>
                                <td>
                                    <a href="/admin/categories/edit/${cat.id}" class="btn btn-sm btn-warning">Sửa</a>
                                    <a href="/admin/categories/delete/${cat.id}" class="btn btn-sm btn-danger"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?')">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="4" class="text-center text-muted">Không tìm thấy danh mục nào</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <!-- Phân trang Bootstrap -->
    <c:if test="${totalPages > 1}">
        <nav aria-label="Page navigation" class="mt-3">
            <ul class="pagination justify-content-center">
                <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                    <a class="page-link" href="/admin/categories?page=${currentPage - 1}&keyword=${keyword}">Trước</a>
                </li>
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="/admin/categories?page=${i}&keyword=${keyword}">${i}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="/admin/categories?page=${currentPage + 1}&keyword=${keyword}">Sau</a>
                </li>
            </ul>
        </nav>
    </c:if>
</body>
</html>