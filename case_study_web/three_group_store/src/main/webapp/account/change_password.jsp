<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Queen Store</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">

</head>
<body>
<div>

</div>

<section class="vh-100 bg-light">
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col col-xl-10">
        <div class="card" style="border-radius: 1rem;">
          <div class="row g-0">
            <div class="col-md-6 col-lg-5 d-none d-md-block">
              <img height="100px" src="https://bachma.vn/wp-content/uploads/2022/01/ghe-cong-thai-hoc-gia-re.jpg"
                   alt="login form" class="img-fluid" style="border-radius: 1rem 0 0 1rem;"/>
            </div>
            <div class="col-md-6 col-lg-7 d-flex align-items-center">
              <div class="card-body p-4 p-lg-5 text-black">

                <%--                                Thẻ Form--%>
                <form action="/accountServlet" method="post">
                    <input id="action" name="action" value="checkForgotPassword" hidden="hidden">
                  <div class="d-flex align-items-center mb-3 pb-1">
                    <i class="fa-solid fa-crown" style="font-size: 300%;margin-right: 20px"></i>
                    <span class="h1 fw-bold mb-0">Group 3 Store</span>
                  </div>

                  <h5 class="fw-normal mb-3 pb-3" style="letter-spacing: 1px;">Đổi Mật Khẩu</h5>

                  <div class="form-outline mb-4">
                    <label class="fw-normal mb-3 pb-3" for="userName">Tên Đăng Nhập:&nbsp;</label>
                    <label class="fw-normal mb-3 pb-3">${userName}</label>
                    <input type="email" id="userName" name="userName" hidden="hidden" value="${userName}"
                           class="form-control form-control-lg"/>

                  </div>

                  <div class="form-outline mb-4">
                    <label class="form-label" for="password">Mật Khẩu</label>
                    <input type="password" id="password" name="password" value="${password}"
                           class="form-control form-control-lg"/>
                    <c:if test="${errMap != null}">
                      <label class="text-danger">${errMap.errPassword}</label>
                    </c:if>
                  </div>
                  <div class="form-outline mb-4">
                    <label class="form-label" for="confirmPassword">Xác Nhận Mật Khẩu</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" value="${confirmPassword}"
                           class="form-control form-control-lg"/>
                    <c:if test="${msg != null}">
                      <label class="text-danger">${msg}</label>
                    </c:if>
                    <c:if test="${errMap != null}">
                      <label class="text-danger">${errMap.errConfirmPassword}</label>
                    </c:if>
                  </div>

                  <div class="form-outline mb-4">
                    <input hidden="hidden" id="code" name="code" value="${code}">
                    <label class="form-label" for="inputCode">Mã Đã Được Gửi Về Mail</label>
                    <input type="text" id="inputCode" name="inputCode"
                           class="form-control form-control-lg" value="${inputCode}"/>
                      <label class="text-danger">${mess}</label>


                  </div>
                  <div class="pt-1 mb-4">
                    <button class="btn btn-dark btn-lg btn-block" type="submit">Đổi Mật Khẩu</button>
                    <a href="/accountServlet?action=login"><button class="btn btn-dark btn-lg btn-block"
                                                                   type="button" style="margin-left: 10px">Quay Lại
                    </button></a>
                  </div>
                </form>
                <div class="text-danger">${msgSigin}</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
</div>
<!--Start footer-->


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>

</body>
</html>