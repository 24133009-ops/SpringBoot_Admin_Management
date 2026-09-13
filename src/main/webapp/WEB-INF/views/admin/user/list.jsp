<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Quản lý Danh mục</title>
</head>
<body>
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>Danh mục sản phẩm</h3>
        <a href="/admin/categories/create" class="btn btn-primary">+ Thêm mới</a>
    </div>

    <!-- Form tìm kiếm -->
    <form class="row g-2 mb-3" method="get" action="/admin/categories">
        <div class="col-auto">
            <input type="text" name="keyword" class="form-control" placeholder="Nhập tên tìm kiếm..." value="${keyword}">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-secondary">Tìm kiếm</button>
            <a href="/admin/categories" class="btn btn-outline-secondary">Làm mới</a>
        </div>
    </form>

    <!-- Bảng hiển thị -->
    <table class="table table-bordered table-hover">
        <thead class="table-light">
            <tr>
                <th>ID</th>
                <th>Tên danh mục</th>
                <th>Mô tả</th>
                <th width="150px">Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="cat" items="${listCategories}">
                <tr>
                    <td>${cat.id}</td>
                    <td>${cat.name}</td>
                    <td>${cat.description}</td>
                    <td>
                        <a href="/admin/categories/edit/${cat.id}" class="btn btn-sm btn-warning">Sửa</a>
                        <a href="/admin/categories/delete/${cat.id}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- Phân trang Bootstrap -->
    <c:if test="${totalPages > 1}">
        <nav>
            <ul class="pagination">
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="/admin/categories?page=${i}&keyword=${keyword}">${i}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </c:if>
</body>
</html>