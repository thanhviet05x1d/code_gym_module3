<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Giỏ hàng</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">

    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<jsp:include page="/home/header.jsp"/>
<div class="justify-align-center container" style="padding-top: 66px; height: 400px">
    <h1>Giỏ hàng</h1>
    <form action="/order" method="get">

        <input name="action" value="findVoucherByName" hidden="hidden"/>
        <table class="table">
            <tr>
                <th>Tên </th>
                <th>Giá</th>
                <th>Số lượng</th>
            </tr>
            <c:forEach var="product" items="${list}">
                <tr>
                    <td>${product.key.getName()}</td>
                    <td><fmt:setLocale value="vi_VN"/>
                        <fmt:formatNumber value="${product.key.getPrice()}" type="currency"/></td>
                    <td>${product.value}</td>

                    <c:set var="sum" value="${sum + product.key.getPrice() * product.value}"/>
                </tr>
            </c:forEach>
            <tr>
                <td>Tổng</td>
                <td colspan="2"><fmt:setLocale value="vi_VN"/>
                    <fmt:formatNumber value="${sum}" type="currency"/></td>
            </tr>
            <input name="price" value="${product.key.getPrice()}" hidden="hidden"/>
            <input name="productId" value="${product.key.getId()}" hidden="hidden"/>
            <input name="voucherId" value="${voucher.getId()}" hidden="hidden"/>
            <input name="useName" value="${account.getUserName()}" hidden="hidden"/>
        </table>
        <label for="voucher">Nhập voucher(nếu có): </label>
        <input type="text" id="voucher" name="voucherName" value="${voucherName}">
        <c:if test="${msg!=null}">
            <div class="text-danger">${msg}</div>
        </c:if>
        <c:if test="${!list.isEmpty()}">
        <div class="mx-2">
        <input type="submit" value="Đặt hàng" class="btn btn-outline-primary">
        </div>
        </c:if>
    </form>

</div>
<jsp:include page="/home/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>

</body>
</html>
