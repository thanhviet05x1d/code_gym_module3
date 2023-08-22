<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 7/7/2023
  Time: 8:28 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>CHI TIẾT SẢN PHẨM</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">

    <link rel="stylesheet" href="css/styles.css">
    <style>
        .input {
            border: 0px;
        }

        th {
            width: 200px;
        }

        td {
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
<div class="container" style="padding-top: 120px">
    <div class="row">
        <div class="col-12 mg-2" style="text-align: center"><h1>CHI TIẾT SẢN PHẨM</h1><hr></div>
        <form action="/order" method="get">
            <input hidden="hidden" name="action" value="addToCart">
            <input hidden="hidden" name="id" value="${product.id}">
            <div class="d-flex mx-2 justify-content-center">
                <img style=" width: 27rem;margin-right: 40px;margin-left: -12px;" src="${product.imgPath}" alt="">
                <table class="table table-hover ms-3">
                    <tr>
                        <th>Tên sản phẩm</th>
                        <td><c:out value="${product.name}"/></td>
                    </tr>
                    <tr>
                        <th>Giá</th>
                        <td><fmt:setLocale value="vi_VN"/>
                            <fmt:formatNumber value="${product.price}" type="currency"/></td>
                    </tr>
                    <tr>
                        <th>Mô tả</th>
                        <td><c:out value="${product.description}"/></td>
                    </tr>
                    <tr>
                        <th>Loại sản phẩm</th>
                        <td><c:out value="${product.type}"/></td>
                    </tr>
                    <tr>
                        <th>Số lượng</th>
                        <td><input class="input" min="1" max="${product.inventory}" name="quantity" type="number"
                                   value="1"></td>
                    </tr>
                </table>
            </div>
            <div style="text-align: center">
                <c:if test="${sessionScope.account.roleName != 'admin'}">
                    <input type="submit" value="Thêm vào giỏ hàng" class="btn btn-primary">
                </c:if>
                <c:if test="${sessionScope.account.roleName == 'admin'}">
                    <a class="btn btn-primary"
                    href="/ProductServlet?action=save&id=${product.id}">Chỉnh sửa</a>
                </c:if>
            </div>
        </form>
    </div>
</div>
<jsp:include page="/home/footer.jsp"/>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</html>
