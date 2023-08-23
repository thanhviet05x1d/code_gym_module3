<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Group 3 - Store</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
</head>
<body>
<section class="vh-100 bg-light">
    <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col col-xl-10">
                <div class="card" style="border-radius: 1rem;">
                    <div class="row g-0">
                        <!-- Left Image Column -->
                        <div class="col-md-6 col-lg-5 d-none d-md-block">
                            <img src="https://i.postimg.cc/D0KLrkmJ/Gh-C-ng-Th-i-H-c-Sihoo-M90-B-M-u-x-m-C-K-Ch-n-4.jpg"
                                 alt="login form" class="img-fluid" style="border-radius: 1rem 0 0 1rem;"/>
                        </div>
                        <!-- Right Login Column -->
                        <div class="col-md-6 col-lg-7 d-flex align-items-center">
                            <div class="card-body p-4 p-lg-5 text-black">
                                <!-- Login Form -->
                                <form action="/accountServlet" method="post">
                                    <!-- Hidden action input -->
                                    <input id="action" name="action" value="login" hidden="hidden">
                                    <!-- Logo and Title -->
                                    <div class="d-flex align-items-center mb-3 pb-1">
                                        <i class="fa-solid fa-eye" style="font-size: 200%;margin-right: 20px"></i>
                                        <span class="h1 fw-bold mb-0">Login Form</span>
                                    </div>
                                    <!-- Login Fields -->
                                    <div class="form-outline mb-4">
                                        <label class="form-label" for="userName">Tên đăng nhập</label>
                                        <input type="email" id="userName" name="userName" class="form-control form-control-lg"/>
                                        <c:if test="${errMap != null}">
                                            <label class="text-danger">${errMap.errUserName}</label>
                                        </c:if>
                                    </div>
                                    <div class="form-outline mb-4">
                                        <label class="form-label" for="password">Mật khẩu</label>
                                        <input type="password" id="password" name="password" class="form-control form-control-lg"/>
                                        <c:if test="${errMap != null}">
                                            <label class="text-danger">${errMap.errPassword}</label>
                                        </c:if>
                                        <div>${msg}</div>
                                    </div>
                                    <!-- Remember Me Checkbox -->
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="rememberMe" name="rememberMe">
                                        <label class="form-check-label" for="rememberMe">Nhớ mật khẩu</label>
                                    </div>
                                    <!-- Login and Forgot Password Buttons -->
                                    <div class="pt-1 mb-4">
                                        <button class="btn btn-dark btn-lg btn-block" type="submit">Đăng nhập</button>
                                        <button class="btn btn-dark btn-lg btn-block" type="submit" formaction="ProductServlet">Quay lại</button>
                                    </div>
                                    <!-- Forgot Password Link and Registration Prompt -->
                                    <a class="small text-muted" href="/accountServlet?action=forgotPassword">Quên mật khẩu?</a>
                                    <p class="mb-5 pb-lg-2" style="color: #393f81;">Bạn chưa có tài khoản?
                                        <a href="/accountServlet?action=create" style="color: #393f81;">Đăng kí ngay!</a></p>
                                    <div>${mess}</div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<script>
    //lấy dữ liệu từ cookie
    function pushValue() {
        let cookies = document.cookie.split(';');
        for (let i = 0; i < cookies.length; i++) {
            if (cookies[i].trim() === "rememberMe=on") {
                document.getElementById("rememberMe").checked = true;
                for (let i = 0; i < cookies.length; i++) {
                    let cookie = cookies[i].trim();
                    if (cookie.startsWith("userName=")) {
                        document.getElementById("userName").value = cookie.substring("userName=".length, cookie.length);
                    }
                    if (cookie.startsWith("password=")) {
                        document.getElementById("password").value = cookie.substring("password=".length, cookie.length);
                    }
                }
            }
        }
    }
    pushValue();
</script>
</body>
</html>
