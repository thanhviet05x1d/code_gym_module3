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
    <link rel="stylesheet" href="css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
<jsp:include page="/home/header.jsp"/>
<h1 style="padding-top: 120px">Danh sách order</h1>
<table id="tableOrder" class="table table-striped table-bordered">
    <tr>
        <th>STT</th>
        <th>Tên sản phẩm</th>
        <th>Giá</th>
        <th>Số lượng</th>
        <th>Ngày đặt hàng</th>
        <th>Voucher</th>
        <th>Tên khách hàng</th>
        <th>Sô điện thoại</th>
        <th>Địa chỉ</th>
        <th></th>
    </tr>
    <c:forEach var="p" items="${list}" varStatus="loop">
        <tr>
            <td>${loop.count}</td>
            <td>${p.productName}</td>
            <td>${p.productPrice}</td>
            <td>${p.productQuantity}</td>
            <td>${p.orderDate}</td>
            <td>${p.voucherPercent}</td>
            <td>${p.customerName}</td>
            <td>${p.phoneNumber}</td>
            <td>${p.address}</td>
            <td>
                <button type="button" class="btn btn-outline-danger btn-sm" data-mdb-toggle="modal"
                        data-mdb-target="#exampleModal"
                        onclick="sendInfoToDelete('${p.id}','${p.productName}')">
                    Xoá
                </button>
            </td>
        </tr>
    </c:forEach>
</table>
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="padding-top: 90px;">
        <div class="modal-content" style="margin-top: 45px;">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">Xoá sản phẩm</h5>
                <button type="button" class="btn-close" data-mdb-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <span>Bạn có chắc chắn muốn xoá <span id="nameDelete"></span> ?</span>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-mdb-dismiss="modal">Không</button>
                <button type="button" class="btn btn-primary" onclick="remove()">Đồng ý</button>
            </div>
        </div>
    </div>
</div>
<form id="formDelete" method="get">
    <input type="hidden" name="action" value="delete"/>
    <input type="hidden" name="id" id="id"/>
</form>
<jsp:include page="/home/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function sendInfoToDelete(id, name) {
        document.getElementById("nameDelete").innerText = name;
        document.getElementById("id").value = id;
        console.log(id)
    }

    function remove() {
        document.getElementById("formDelete").submit();
    }

    <script src="js/jquery-3.5.1.min.js"></script>
<script src="js/jquery.dataTables.min.js"></script>
<script src="js/dataTables.bootstrap5.min.js"></script>
</script>
<script>
    $(document).ready(function () {
        $('#tableOrder').dataTable({
            "dom": 'lrtip',
            "lengthChange": false,
            "pageLength": 5
        });
    });
</script>
</body>
</html>
