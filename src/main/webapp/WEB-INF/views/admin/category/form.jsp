<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>${category.id == null ? 'Thêm mới' : 'Cập nhật'} Danh mục</title>
</head>
<body>
    <div class="card p-4 mx-auto shadow-sm" style="max-width: 600px;">
        <h4 class="mb-3">${category.id == null ? 'Thêm mới' : 'Cập nhật'} Danh mục</h4>
        <form action="/admin/categories/save" method="post">
            <input type="hidden" name="id" value="${category.id}"/>

            <div class="mb-3">
                <label class="form-label">Tên danh mục:</label>
                <input type="text" name="name" class="form-control" required value="${category.name}"
                       placeholder="Nhập tên danh mục..."/>
            </div>

            <div class="mb-3">
                <label class="form-label">Mô tả:</label>
                <textarea name="description" class="form-control" rows="4"
                          placeholder="Nhập mô tả chi tiết...">${category.description}</textarea>
            </div>

            <div class="mt-3">
                <button type="submit" class="btn btn-success">Lưu lại</button>
                <a href="/admin/categories" class="btn btn-secondary">Hủy</a>
            </div>
        </form>
    </div>
</body>
</html>