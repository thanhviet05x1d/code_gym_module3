<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Xóa</title>
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

        .form {
            width: 40%;
        }

    </style>
</head>
<body>
<jsp:include page="/home/header.jsp"/>
<div style="height: 150px"></div>

<div class="container" style="padding-top: 30px;">

    <center>
        <h1>Xóa voucher</h1>
        <c:if test='${requestScope["message"] != null}'>
            <span>${requestScope["message"]}</span>
        </c:if>
        <form method="post" class="form">
            <table border="1" cellpadding="5" width="350px" class="table table-hover" >
                <tr>
                    <th>Tên Voucher:</th>
                    <td>
                        ${voucher.getName()}
                    </td>
                </tr>
                <tr>
                    <th>Giá trị Voucher:</th>
                    <td>
                        ${Math.round(voucher.getRate()*100)}
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <button type="button" class="btn btn-primary" id="back" >
                            <a href="/vouchers?action=vouchers">Quay lại</a>
                        </button>
                        <button type="submit" class="btn btn-danger" id="deleteButton" >Xóa
                        </button>
                    </td>
                </tr>
            </table>
        </form>
    </center>
    <div style="height: 150px"></div>
</div>
<jsp:include page="/home/footer.jsp"></jsp:include>
</body>
</html>