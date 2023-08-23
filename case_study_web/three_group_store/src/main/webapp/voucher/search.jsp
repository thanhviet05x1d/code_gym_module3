
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Tìm kiếm</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">

    <link rel="stylesheet" href="css/styles.css">

    <style>
        a {
            text-decoration: none;
            color: white;
        }
    </style>
</head>
<body>
<jsp:include page="/home/header.jsp"/>

<div style="height: 150px"></div>

<div class="container" style="padding-top: 30px;">
    <center>
        <h1>Tìm kiếm Voucher</h1>
        <nav class="navbar bg-body-tertiary" style="width: 70%">
            <div class="container justify-content-center">
                <button type="button" class="btn btn-primary" style="height: 30px">
                    <a href="/vouchers?action=vouchers">Quay lại</a>
                </button>
                <form action="/vouchers" method="get" style="margin-top: 18px;width: auto">
                    <input id="action" name="action" value="search" hidden="hidden">
                    <input type="text" name="searchName" id="searchName" placeholder="Tìm kiếm theo tên">
                    <input type="submit" value="Tìm kiếm theo tên">
                </form>
            </div>
        </nav>
    </center>
    <div style="height: 10px"></div>
    <div align="center">
        <table class="table table-hover" width="80%">
            <tr>
                <th>STT</th>
                <th>Tên mã khuyến mãi</th>
                <th>Tỷ lệ</th>
            </tr>
            <c:forEach var="voucher" items="${voucherList}" varStatus="loop">
                <tr>
                    <td>${loop.count}</td>
                    <td>${voucher.getName()}</td>
                    <td>${Math.round(voucher.getRate()*100)}</td>
                </tr>
            </c:forEach>
        </table>
        <c:if test="${msg != null}">
            <div>${msg}</div>
        </c:if>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
        crossorigin="anonymous"></script>
<div style="height: 150px"></div>

<jsp:include page="/home/footer.jsp"></jsp:include>
</body>
</html>
