<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
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
    <h1>Thanh toán</h1>
    <form action="/order" method="get">
        <input name="action" value="checkOut" hidden="hidden">
        <table class="table">
            <tr>
                <th>Name</th>
                <th>Price</th>
                <th>Quantity</th>
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
            <c:if test="${rate !=0}">
                <tr>
                    <td>Voucher</td>
                    <td colspan="2">${voucher.getRate()}%</td>
                </tr>
                <tr>
                    <td>Tổng tiền sau khi trừ voucher</td>
                    <td colspan="2"><fmt:setLocale value="vi_VN"/>
                        <fmt:formatNumber value="${sum - sum*voucher.getRate()/100}" type="currency"/></td>
                </tr>
            </c:if>
            <input name="price" value="${product.key.getPrice()}" hidden="hidden"/>
            <input name="productId" value="${product.key.getId()}" hidden="hidden"/>
            <input name="voucherId" value="${voucher.getId()}" hidden="hidden"/>
            <input name="userName" value="${sessionScope.account.userName}" hidden="hidden"/>
        </table>
        <input type="submit" value="Thanh toán" class="btn btn-outline-dark">
    </form>
</div>

<jsp:include page="/home/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>

</body>
</html>
