<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Title</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">

</head>
<body>
<jsp:include page="/home/header.jsp"></jsp:include>

<h1 class="container" style="padding-top: 120px;text-align: center">Danh Sách Tài Khoản</h1>

<c:if test="${msg != null}">
<div class="container alert alert-success">
    <div style="text-align: center">${msg}</div>
</div>
</c:if>
<div class="container" style="width:30%;margin-top: 50px">
    <div class="row">
        <div class="col-lg-12">
            <table class="table table-striped text-center" style="width:100%">
                <thead>
                <th>Tài Khoản</th>
                <th>Vị Trí</th>
                </thead>
                <tbody>
                <c:forEach var="account" items="${accountList}">
                    <c:if test="${account.roleName != 'admin'}">
                        <tr>
                            <td>${account.userName}</td>
                            <td>${account.roleName}</td>
                            <td>
                                <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal"
                                        data-bs-target="#exampleModal"
                                        onclick="sendInfoToDelete('${account.userName}')">
                                    Xoá
                                </button>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>


<!-- Modal -->
<div style="margin-top: 200px" class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Bạn có muốn xoá tài khoản <span id="nameDelete"></span>?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
                <button class="btn btn-primary" type="button" onclick="remove()" >Xoá</button>
            </div>
        </div>
    </div>
</div>

<form id="formDelete" method="get">
    <input type="hidden" name="action" value="delete"/>
    <input type="hidden" name="userName" id="delete"/>
</form>
<jsp:include page="/home/footer.jsp"></jsp:include>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>

<script>
    function sendInfoToDelete(name) {
        document.getElementById("nameDelete").innerText = name;
        document.getElementById("delete").value = name;
       console.log(name)
    }

    function remove() {
        document.getElementById("formDelete").submit();
    }
</script>
</html>
