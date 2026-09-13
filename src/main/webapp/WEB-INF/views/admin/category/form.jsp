<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${empty category.id ? 'Thêm mới Danh mục' : 'Cập nhật Danh mục'}</title>
</head>
<body>
<div class="container mt-4" style="max-width: 600px;">
    <h2>${empty category.id ? 'Thêm mới Danh mục' : 'Cập nhật Danh mục'}</h2>

    <form action="/admin/categories/save" method="post" class="card card-body shadow-sm mt-3">
        <input type="hidden" name="id" value="${category.id}" />

        <div class="mb-3">
            <label class="form-label">Tên danh mục:</label>
            <input type="text" name="name" value="${category.name}" class="form-control" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Mô tả:</label>
            <textarea name="description" class="form-control" rows="3">${category.description}</textarea>
        </div>

        <div>
            <button type="submit" class="btn btn-success">Lưu danh mục</button>
            <a href="/admin/categories" class="btn btn-secondary">Quay lại</a>
        </div>
    </form>
</div>
</body>
</html>