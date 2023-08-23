<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Chỉnh Sửa Thông Tin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <link rel="stylesheet" href="home/css/styles.css">
    <style>
        .input {
            padding: 10px;
            border-radius: 10px;
            width: 200px;
            border-color: darkseagreen;
        }
    </style>
</head>

<body>
<jsp:include page="/home/header.jsp"></jsp:include>
<form action="/CustomerServlet?action=update" style="padding-top: 120px" method="post">
    <input hidden="hidden" name="user_id" value="${customer.id}">
    <input hidden="hidden" name="account_user_name" value="${customer.accUserName}">
    <div style="text-align: center" class="container ">
        <h2>Chỉnh Sửa Thông Tin</h2>
        <div hidden>${customer.accUserName}</div>
    </div>
    <div class="container ">
        <table class="table table-striped mx-auto" style="width: 30%;margin: 0" >
            <tr>
                <th>Tên</th>
                <td>
                    <input class="input"  type="text" name="user_name" value="<c:out value='${customer.name}'/>"/>
                    <div class="text">${error.errName}</div>
                </td>
            </tr>
            <tr>
                <th>Ngày Sinh</th>
                <td>
                    <input class="input" type="date" name="user_dob" value="${customer.dob}">
                    <div class="text-danger">${error.errDate}</div>
                </td>

            </tr>
            <tr>
                <th>Giới Tính</th>
                <c:if test="${customer.gender == true}">
                    <td>
                        <input type="radio" checked="checked" name="user_gender" value="${customer.gender}">Nam
                        <input type="radio" name="user_gender" value="${customer.gender}">Nữ
                    </td>
                </c:if>
                <c:if test="${customer.gender == false}">
                    <td>
                        <input type="radio" name="user_gender" value="${customer.gender}">Nam
                        <input type="radio" checked="checked" name="user_gender" value="${customer.gender}">Nữ
                    </td>
                </c:if>

            </tr>
            <tr>
                <th>Số CMND/CCCD</th>
                <td><input class="input" type="text" name="user_id_card" value="${customer.idCard}">
                    <div class="text">${error.errIdCard}</div>
                </td>
            </tr>
            <tr>
                <th>Số Điện Thoại</th>
                <td>
                    <input class="input" type="text" name="user_phone_number" value="${customer.phoneNumber}">
                    <div class="text">${error.errPhoneNumber}</div>
                </td>

            </tr>
            <tr>
                <th>Email</th>
                <td>
                    <input class="input" type="text" name="user_mail" value="${customer.email}">
                    <div class="text">${error.errEmail}</div>
                </td>

            </tr>
            <tr>
                <th>Địa Chỉ</th>
                <td>
                    <input class="input" type="text" name="user_address" value="${customer.address}">
                    <div class="text">${error.errAddress}</div>
                </td>

            </tr>
            <tr>
                <td align="center" colspan="2">
                   <button class="btn btn-primary" type="submit" name="save">Xác Nhận</button>
                </td>
                <%--            <td align="center">--%>
                <%--               <button><a href="/ProductServlet" style="text-decoration: none">Back</a></button>--%>
                <%--            </td>--%>
            </tr>
        </table>
    </div>
</form>
<jsp:include page="/home/footer.jsp"></jsp:include>
</body>
</html>
