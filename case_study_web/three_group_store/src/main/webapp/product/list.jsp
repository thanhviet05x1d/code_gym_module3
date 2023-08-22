<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 7/6/2023
  Time: 3:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>DANH SÁCH SẢN PHẨM</title>
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
    <style>
        /*body {*/
        /*    font-size: x-large;*/
        /*    margin-left: 20px;*/
        /*    font-weight: bolder;*/
        /*}*/

        /*table {*/
        /*    margin: 20px;*/
        /*}*/

        /*table, tr, td, th {*/
        /*    border: 2px solid gray;*/
        /*    padding: 5px;*/
        /*    text-align: center;*/
        /*    border-collapse: collapse;*/
        /*}*/

        /*h1 {*/
        /*    text-align: center;*/
        /*    color: black;*/
        /*}*/

        /*h2 {*/
        /*    text-align: left;*/
        /*    margin-left: 20px;*/
        /*}*/
    </style>
</head>
<body>
<%--<jsp:include page="/home/header.jsp"/>--%>
<div class="container" style="padding-top: 30px;">
    <div class="row text-center m-3">
        <h1><b>DANH SÁCH SẢN PHẨM</b>
            <hr>
        </h1>
    </div>
    <%--Thanh chức năng--%>
    <div class="row container-fluid justify-content-center mb-2 mt-2">
        <div class="float-start d-inline-block w-50">
            <div class="col-md-auto d-inline-block float-start me-2"><h2><a class="btn btn-primary"
                                                                            href="/ProductServlet">Quay lại menu
                chính</a></h2>
            </div>
            <div class="col-md-auto d-inline-block float-start"><h2><a class="btn btn-primary"
                                                                       href="/ProductServlet?action=create">Thêm sản
                phẩm
                mới</a></h2></div>
        </div>

        <div class="w-50 float-end d-inline-block">
            <form class="d-flex mt-0">
                <input type="hidden" name="action" value="search" >
                <input class="form-control me-2" type="text" placeholder="Nhập tên sản phẩm..." id="searchProductId"
                       name="name"
                       value="${name}" style="width: auto">
                <select class="form-select me-2" name="range">
                    <option value="0">Tất cả</option>
                    <option value="1">Dưới 100.000đ</option>
                    <option value="2">100.000đ - 500.000đ</option>
                    <option value="3">500.000đ - 1000.000đ</option>
                    <option value="4">Trên 1000.000đ</option>
                </select>
                <div class="col-md-auto d-inline-block float-end me-2">
                    <button class="btn btn-primary" style="width: auto" type="submit">Tìm kiếm</button>
                </div >
                <div class="col-md-auto d-inline-block float-end me-2" style="width: auto">
                    <a href="/ProductServlet?action=productManagerment" class="btn btn-primary">Hủy</a>
                </div>
            </form>
        </div>
    </div>
    <div class="row justify-content-center" style="align-content: center">
        <p>
            <c:if test="${message !=null}">
        <div class="text-danger " style="text-align: center">
            <span class="message">${message}</span>
        </div>
        </c:if>
        </p>
        <c:if test="${productList.size() > 0}">
            <table class="table table-striped text-center">
                <thead>
                <tr>
                    <th>STT</th>
                    <th>TÊN SẢN PHẨM</th>
                    <th>GIÁ</th>
                    <th>LOẠI SẢN PHẨM</th>
                    <th>SỐ LƯỢNG</th>
                    <th colspan="2">THAO TÁC</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="product" items="${productList}" varStatus="loop">
                    <tr>
                        <td><c:out value="${loop.count}"/></td>
                        <td><c:out value="${product.name}"/></td>
                        <td>
                            <fmt:setLocale value="vi_VN"/>
                            <fmt:formatNumber value="${product.price}" type="currency"/></td>
                        <td><c:out value="${product.type}"/></td>
                        <td><c:out value="${product.inventory}"/></td>
                        <td>
                            <a class="btn btn-primary btn-sm"
                               href="/ProductServlet?action=view&id=${product.id}">Chi tiết</a>
                        </td>
                        <td>
                                <%-- <a class="btn btn-outline-danger btn-sm" href="/ProductServlet?action=delete&id=${product.id}">Delete</a>--%>
                            <!-- Button trigger modal -->
                            <button type="button" class="btn btn-danger btn-sm" data-mdb-toggle="modal"
                                    data-mdb-target="#exampleModal"
                                    onclick="sendInfoToDelete('${product.id}','${product.name}')">
                                Xóa
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>
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
                    <span>Bạn muốn xóa sản phẩm <span id="nameDelete"></span>?</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-mdb-dismiss="modal">Đóng</button>
                    <button type="button" class="btn btn-primary" onclick="remove()">Có</button>
                </div>
            </div>
        </div>
    </div>
    <form id="formDelete" method="get">
        <input type="hidden" name="action" value="delete"/>
        <input type="hidden" name="id" id="id"/>
    </form>
</div>
</div>

<jsp:include page="/home/footer.jsp"/>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function sendInfoToDelete(id, name) {
        document.getElementById("nameDelete").innerText = name;
        document.getElementById("id").value = id;
    }

    function remove() {
        document.getElementById("formDelete").submit();
    }

    function backToMenu() {
        if (document.getElementById("searchProductId").value == "") {

        }
        ;
    }
</script>
</html>
<%--<div class="row d-flex container-fluid  ">--%>
<%--    <div class="col-lg-3 col-md-6 col-sm-12 align-content-center">--%>
<%--        <div class="card shadow p-3 mb-5 bg-body-tertiary rounded " style="width: 18rem;">--%>
<%--            <img src="<c:out value="${product.imgPath}"/>" class="card-img-top" alt="...">--%>
<%--            <div class="card-body">--%>
<%--                <h5 class="card-title"><c:out value="${product.name}"/></h5>--%>
<%--                <p class="card-text"><c:out value="${product.description}"/></p>--%>
<%--                <p class="card-text"><c:out value="${product.price}"/></p>--%>
<%--                <a href="#" class="btn btn-primary">Add to cart</a>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>