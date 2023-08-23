<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Danh sách voucher</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">


    <link rel="stylesheet" href="css/styles.css">

    <style>
        a {
            text-decoration: none;
            color: white;
        }
    </style>




    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
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
<jsp:include page="/home/header.jsp"/>
<div style="height: 150px"></div>

<div class="container" style="padding-top: 30px;">
    <div class="row text-center m-3">
        <h1><b>DANH SÁCH MÃ GIẢM GIÁ</b>
            <hr>
        </h1>
    </div>

    <center>
        <nav class="navbar bg-body-tertiary">
            <hr>
            <div class="container ">
                <button type="button" class="btn btn-primary"><a style="color: white" href="/vouchers?action=create">THÊM MÃ GIẢM GIÁ MỚI</a>
                </button>
                <button type="button" class="btn btn-primary"><a style="color: white" href="/vouchers?action=increase">TỶ LỆ TĂNG DẦN</a>
                </button>
                <button type="button" class="btn btn-primary"><a style="color: white" href="/vouchers?action=decrease">TỶ LỆ GIẢM DẦN</a>
                </button>
                <form action="/vouchers" method="get" style="margin-top: 18px">
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
                <th>TÊN MÃ GIẢM GIÁ</th>
                <th>TỶ LỆ</th>
                <th>CẬP NHẬT</th>
                <th>XÓA</th>
            </tr>
            <c:forEach var="voucher" items="${voucherList}" varStatus="loop">
                <tr>
                    <td>${loop.count}</td>
                    <td>${voucher.getName()}</td>
                    <td>${Math.round(voucher.getRate())}%</td>
                    <td>
                        <button type="button" class="btn btn-primary btn-sm"><a style="color: white" href="/vouchers?action=update&id=${voucher.getId()}">Cập
                            nhật</a></button>
                    </td>

                    <td>
                        <button type="button" class="btn btn-danger btn-sm" data-mdb-toggle="modal"
                                data-mdb-target="#exampleModal"
                                onclick="sendInfoToDelete('${voucher.id}','${voucher.name}')">
                            Xóa
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>




<!-- Modal -->
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
                <button type="button" class="btn btn-primary" data-mdb-dismiss="modal">Đóng</button>
                <button type="button" class="btn btn-danger" onclick="remove()">Có</button>
            </div>
        </div>
    </div>
</div>
<form id="formDelete" method="get">
    <input type="hidden" name="action" value="delete"/>
    <input type="hidden" name="id" id="id"/>
</form>



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
</script>




<%--<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"--%>
<%--        integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"--%>
<%--        crossorigin="anonymous"></script>--%>
<div style="height: 150px"></div>

<jsp:include page="/home/footer.jsp"></jsp:include>
</body>
</html>
