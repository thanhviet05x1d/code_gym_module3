
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Group 3 - Store</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <link rel="stylesheet" href="home/css/styles.css">

</head>
<body>
<div>

</div>
<!--Start Header-->
<jsp:include page="home/header.jsp"/>
<!--End Header-->
<c:if test="${msg != null}">
    <h1>${msg}</h1>
</c:if>
<!--Start Carousel-->
<div style="height: 100%; padding-top: 62px;">

    <div id="carouselExampleRide" class="carousel slide" data-bs-ride="true" data-interval="2000">
        <div class="carousel-inner">
            <div class="carousel-item active ">
                <img height="500px"
                     src="https://i.postimg.cc/dVWWr3vZ/p1.png"
                     class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
                <img height="500px"
                     src="https://i.postimg.cc/2Sjc1hpf/p2.png"
                     class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
                <img height="500px"
                     src="https://i.postimg.cc/44tFqXvj/p3.png"
                     class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
                <img height="500px"
                     src="https://i.postimg.cc/xT2FSBt8/p4.png"
                     class="d-block w-100" alt="...">
            </div>

            <div class="carousel-item">
                <img height="500px"
                     src="https://i.postimg.cc/pdpsZvXG/p5.png"
                     class="d-block w-100" alt="...">
            </div>


        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleRide" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleRide" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</div>
<!--End Carousel-->
<main style="margin-top: 20px" class="container">
    <div class="my-2">
        <span>Sắp xếp theo:</span>
        <a href="/ProductServlet?action=sortAsc" class="btn btn-outline-dark">Giá thấp đến cao</a>
        <a href="/ProductServlet?action=sortDesc" class="btn btn-outline-dark">Giá cao đến thấp</a>
    </div>
    <c:if test="${!message.isEmpty()}">
        <div class="text-danger " style="text-align: center">
            <c:out value="${message}"/>
        </div>
    </c:if>
    <div class="row d-flex  justify-align-center">
        <%--@elvariable id="productList" type="java.util.List"--%>
        <c:forEach var="product" items="${productList}" varStatus="loop">
            <div class="col-lg-3 col-md-6 col-sm-12 align-content-center">
                <div class="card shadow p-3 mb-5 bg-body-tertiary rounded " style="width: 18rem;height: 34rem;">
                    <a href="<c:url value="/ProductServlet?action=view&id=${product.id}"/>">
                        <img src="<c:out value="${product.imgPath}"/>" class="card-img-top" alt="...">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title"><c:out value="${product.name}"/></h5>
                        <p class="card-text"><c:out value="${product.type}"/></p>
                        <p class="card-text"><fmt:setLocale value="vi_VN"/>
                            <fmt:formatNumber value="${product.price}" type="currency"/></p>
                    </div>
                </div>
            </div>
        </c:forEach>
        <div class="pagination container d-flex justify-content-center align-items-center">
            <c:if test="${currentPage > 1}">
                <a class="fs-5" href="?page=${currentPage-1}">&laquo; Previous</a>
            </c:if>
            &nbsp;
            <c:forEach var="i" begin="1" end="${noOfPages}">
                <c:choose>
                    <c:when test="${currentPage eq i}">
                        <span class="fs-5" class="current">${i}</span>
                        &nbsp;
                    </c:when>
                    <c:otherwise>
                        <a class="fs-5" href="?page=${i}">${i}</a>
                        &nbsp;
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            &nbsp;
            <c:if test="${currentPage < noOfPages}">
                <a class="fs-5" href="?page=${currentPage+1}">Next &raquo;</a>
            </c:if>
        </div>
    </div>
</main>
<!--Start footer-->
<jsp:include page="home/footer.jsp"/>
<!--End footer-->
<a href="/ProductServlet?action=listAdmin">admin</a>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>
</body>
</html>
