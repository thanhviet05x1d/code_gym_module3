<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Thêm voucher mới</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">


    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">


    <link rel="stylesheet" href="css/styles.css">
    <style>
        a {
            text-decoration: none;
            color: white;
        }
        .form {
            width: 40%;
        }
    </style>
</head>
<body>
<div style="height: 150px"></div>

<jsp:include page="/home/header.jsp"/>

<div class="container" style="padding-top: 30px;">
    <center>
        <h1>THÊM MÃ GIẢM GIÁ MỚI</h1>
        <p1>
            <c:if test='${requestScope["message"] !=null}'>
                <span>${requestScope["message"]}</span>
            </c:if>
        </p1>
        <form method="post" class="form">
            <table border="1" cellpadding="5" class="table table-hover" >
                <tr>
                    <th>Tên mã giảm giá</th>
                    <td>
                        <input type="text" name="name" id="name" required>
                    </td>
                </tr>
                <tr>
                    <th>Tỷ lệ</th>
                    <td>
                        <input type="number" name="rate" id="rate" required>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" width="200px">
                        <button type="button" class="btn btn-primary" id="back">
                            <a href="/vouchers?action=vouchers">Quay lại</a>
                        </button>
                        <button type="submit" class="btn btn-primary" id="deleteButton" >Lưu
                        </button>
                    </td>
                </tr>
            </table>
            <c:if test='${requestScope["mess"] !=null}'>
                <span>${requestScope["mess"]}</span>
            </c:if>
        </form>
    </center>
</div>

<div style="height: 150px"></div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<jsp:include page="/home/footer.jsp"></jsp:include>
</body>
</html>
