<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 7/6/2023
  Time: 10:11 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>THÊM MỚI</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        table, tr, td {
            border: 1px lightcyan;
        }

        .input {
            padding: 10px;
            border-radius: 10px;
            border-color: cadetblue;
            width: 200px;
        }

        .form {
            width: 500px;
            text-align: center;
        }
        body {
            background-image: url("https://images.unsplash.com/photo-1517646450441-a0faf4152caf?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80") ;
            background-repeat: no-repeat;
            background-size: cover;
        }
    </style>
</head>
<body>
<jsp:include page="/home/header.jsp"/>
<div style="padding-top: 112px"></div>
<div class="container">
    <div align="center">
        <form method="post" class="form">
            <legend style="text-align: center"><h1>THÔNG TIN SẢN PHẨM</h1> <hr></legend>
            <table class="table table-hover">
                <tr>
                    <td>Tên sản phẩm:</td>
                    <td>
                        <input class="input" type="text" name="name" id="name" value="${product.name}" placeholder="Nhập tên...">
                        <c:if test="${!errors.errName.isEmpty()}">
                            <small class="text-danger d-block">${errors.errName}</small>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <td>Giá:</td>
                    <td>
                        <input class="input" type="number" name="price" id="price" value="${product.price}" placeholder="Nhập giá..">
                        <c:if test="${!errors.errPrice.isEmpty()}">
                            <small class="text-danger d-block">${errors.errPrice}</small>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <td>Mô tả:</td>
                    <td><input class="input" type="text" name="description" id="description"
                               value="${product.description}" placeholder="Nhập mô tả...">
                        <c:if test="${!errors.errDes.isEmpty()}">
                            <small class="text-danger d-block">${errors.errDes}</small>
                        </c:if>
                    </td>

                </tr>
                <tr>
                    <td>Loại sản phẩm:</td>
                    <td>
                        <select class="input" name="type">
                            <c:forEach var="type" items="${productTypes}">
                                <option value="${type.name}">${type.name}</option>
                            </c:forEach>
                        </select>

                    </td>
                </tr>
                <tr>
                    <td>Số lượng:</td>
                    <td><input class="input" type="number" name="inventory" id="inventory" value="${product.inventory}" placeholder="Nhập số lượng...">
                        <c:if test="${!errors.errInven.isEmpty()}">
                            <small class="text-danger d-block">${errors.errInven}</small>
                        </c:if></td>
                </tr>
                <tr>
                    <td>Ảnh sản phẩm:</td>
                    <td><input class="input" type="text" name="imgPath" id="imgPath" value="${product.imgPath}" placeholder="Nhập đường dẫn...">
                        <c:if test="${!errors.errImg.isEmpty()}">
                            <small class="text-danger d-block">${errors.errImg}</small>
                        </c:if></td>
                </tr>
                <tr align="center">
                    <td><a class="btn btn-success" href="/ProductServlet?action=productManagerment">Quay lại
                        danh sách</a></td>
                    <td><input class="btn btn-danger" type="submit" name="submit" value="Thêm mới"></td>
                </tr>
            </table>
        </form>
    </div>
</div>
<jsp:include page="/home/footer.jsp"/>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</html>
