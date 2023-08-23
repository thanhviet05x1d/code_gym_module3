
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Danh Sách Người Dùng</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <link rel="stylesheet" href="home/css/styles.css">
    <script src="https://kit.fontawesome.com/7f6d2012d0.js"></script>
    <!-- Font Awesome -->
    <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
            rel="stylesheet"
    />
    <!-- Google Fonts -->
    <link
            href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap"
            rel="stylesheet"
    />
    <!-- MDB -->
    <link
            href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.0/mdb.min.css"
            rel="stylesheet"
    />
    <!-- MDB -->
    <script
            type="text/javascript"
            src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.0/mdb.min.js"
    ></script>
</head>
<body>
<jsp:include page="/home/header.jsp"></jsp:include>

<div style="padding-top: 120px;text-align: center"><H2>Danh Sách Người Dùng</H2></div>
<div class="container">
    <div class="row">
        <table class="table table-striped" style="align-content: center">
            <tr>
                <th hidden>ID</th>
                <th>Tên</th>
                <th>Ngày Sinh</th>
                <th>Giới Tính</th>
                <th>Số CMND/CCCD</th>
                <th>Số Điện Thoại</th>
                <th>Email</th>
                <th>Địa Chỉ</th>
                <%--            <th>TypeOfCustomerID</th>--%>
                <th>Tên Tài Khoản</th>
                <th></th>
            </tr>
            <c:forEach var="customer" items="${customerList}">
                <tr>
<%--                    <td hidden>${customer.id}</td>--%>
                    <td>${customer.name}</td>
                    <td>${customer.dOB}</td>
                    <c:if test="${customer.gender == true}">
                        <td>Nam</td>
                    </c:if>
                    <c:if test="${customer.gender == false}">
                        <td>Nữ</td>
                    </c:if>
                    <td>${customer.idCard}</td>
                    <td>${customer.phoneNumber}</td>
                    <td>${customer.email}</td>
                    <td>${customer.address}</td>
                        <%--                <td>${customer.typeOfCustomerID}</td>--%>
                    <td>${customer.accUserName}</td>
                    <td>
                            <%--                        <a href="CustomerServlet?action=edit&id=${customer.id}" style="text-decoration: none"><button class="btn btn-primary">Edit</button></a>--%>
                            <%--                        <a href="CustomerServlet?action=delete&id=${customer.id} " style="text-decoration: none">--%>
                            <%--                            <button class="btn btn-outline-danger">Delete</button>--%>
                            <%--                        </a>--%>
                        <button type="button" class="btn btn-danger btn-sm" data-mdb-toggle="modal"
                                data-mdb-target="#exampleModal "
                                onclick="sendInfoToDelete('${customer.id}','${customer.name}')">
                            Xóa
                        </button>

                    </td>
                </tr>
            </c:forEach>
        </table>

        <%--<div align="center">--%>
        <%--<h2>--%>
        <%--    <a href="CustomerServlet?action=create"><input type="submit" name="Add NewUser" value="Add NewUser"></a>--%>
        <%--</h2>--%>
        <%--</div>--%>
    </div>
</div>
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="padding-top: 90px;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">Hộp thoại</h5>
                <button type="button" class="btn-close" data-mdb-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <span>Bạn muốn xóa sản phẩm <span id="nameDelete"></span> ?</span>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-mdb-dismiss="modal">Hủy</button>
                <button type="button" class="btn btn-danger" onclick="remove()">Có</button>
            </div>
        </div>
    </div>
</div>
<form id="formDelete" method="post">
    <input type="hidden" name="action" value="delete"/>
    <input type="hidden" name="id" id="id"/>
</form>

<jsp:include page="/home/footer.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>
</body>
<script>
    function sendInfoToDelete(id, name) {
        document.getElementById("nameDelete").innerText = name;
        document.getElementById("id").value = id;
        console.log(id)
    }

    function remove() {
        document.getElementById("formDelete").submit();
    }
</script>
</html>
