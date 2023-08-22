    <%--@elvariable id="totalQuantity" type=""--%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <style>
        header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 9999;
        }

        .nav-a a {

            font-weight: 500;
            text-decoration: none;
            color: black;
            text-align: center;

        }
        a {
            text-decoration: none;
        }
        ul {
            list-style-type: none;
        }
    </style>
    <header>
        <div>
            <div style="position: fixed; padding-top: 0" class="col-md-12 ">
                <nav style="padding-left: 4%;" class="navbar navbar-expand-lg bg-light navbar-dark ">
                    <!--Start LOGO-->
                    <div class="row col-12">
                        <div style="padding-right: 5%" class="align-items-center col-lg-3 ">
                            <a id="logoQueen" class="navbar-brand fs-2 text-dark" href="/ProductServlet">
                                <i class="fa-solid fa-crown"></i>
                                Queen Store</a>
                        </div>
                        <!--End LOGO-->
                        <!--Start Search-->

                        <div class="col-lg-6  d-flex" style="font-size: 18px">
                            <c:if test="${sessionScope.account.roleName == 'admin'}">
                                <li class="nav-item dropdown fs-4 mt-1" style="list-style-type: none;">
                                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                                       aria-expanded="false">
                                        Quản lí
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" href="accountServlet?action=userList">Tài khoản</a>
                                        </li>
                                        <li><a class="dropdown-item" href="CustomerServlet">Người dùng</a></li>
                                        <li><a class="dropdown-item" href="/ProductServlet?action=productManagerment">Sản
                                            phẩm</a></li>
                                        <li><a class="dropdown-item" href="/vouchers">Voucher</a></li>
                                        <li><a class="dropdown-item" href="order">Đơn Hàng</a></li>
                                    </ul>
                                </li>
                            </c:if>
                            <c:if test="${name != null}">
                                <form class="d-flex justify-content-center" style="width: 100%" action="/ProductServlet"
                                      method="get">
                                    <input type="search" class="form-control bg-light" name="name" value="${name}"
                                           style="border-radius: 30px;width: 45%;border-color: black"
                                           placeholder="Tên sản phẩm">
                                    <input type="search" name="action" value="search" hidden="hidden">
                                    <select class="form-select me-2 bg-light"
                                            style="width: 100px; background-color:#f8f9fa " name="range">
                                        <option style=" background-color:#f8f9fa" value="0">Tất cả</option>
                                        <option style=" background-color:#f8f9fa" value="1">Dưới 100.000đ</option>
                                        <option style=" background-color:#f8f9fa" value="2">100000 - 500.000đ</option>
                                        <option style=" background-color:#f8f9fa" value="3">500000 - 1000.000đ</option>
                                        <option style=" background-color:#f8f9fa" value="4">Trên 1000.000đ</option>
                                    </select>
                                    <button class="btn btn-outline-dark " style="margin-left: 20px" type="submit">Tìm kiếm
                                    </button>
                                </form>
                            </c:if>
                            <c:if test="${name == null}">
                                <form class="d-flex justify-content-center" style="width: 100%" action="/ProductServlet"
                                      method="get">
                                    <input type="search" class="form-control bg-light" name="name" value="${name}"
                                           style="border-radius: 30px;width: 45%;border-color: black" placeholder="Tên sản phẩm">
                                    <input type="search" name="action" value="search" hidden="hidden">
                                    <select class="form-select me-2" style="width: 100px" name="range">
                                        <option value="0">Tất cả</option>
                                        <option value="1">Dưới 100.000đ</option>
                                        <option value="2">100000 - 500.000đ</option>
                                        <option value="3">500000 - 1000.000đ</option>
                                        <option value="4">Trên 1000.000đ</option>
                                    </select>
                                    <button class="btn btn-outline-dark " style="margin-left: 20px" type="submit">Tìm kiếm
                                    </button>
                                </form>
                            </c:if>
                        </div>

                        <!--End Search-->
                        <!--                Start cart & loin-->
                        <div class="col-lg-3 d-flex  fs-4">
                            <c:if test="${sessionScope.account.roleName != 'admin'}">
                                <div class="cart d-flex">
                                    <a href="<c:url value="/order?action=cart"/>" style="text-decoration: none; width: 50px"><i
                                            class="fa-solid fa-cart-shopping text-dark "
                                            style="margin-top: 8px">
                                    </i>
                                        <c:if test="${totalQuantity >0}">
                                <span class=" translate-middle badge rounded-pill bg-danger"
                                      style="font-size: 30%;padding-bottom: 5px">
                                    ${totalQuantity}
                                    <span class="visually-hidden">unread messages</span>
                                </span>
                                        </c:if>
                                    </a>
                                </div>
                            </c:if>
                            <!--                    Start login-->
                            <div class="nv-1 d-flex">
                                <c:if test="${sessionScope.account == null}">
                                    <a href="accountServlet?action=login" class="text-dark d-flex"
                                       style="text-decoration: none;"><i
                                            class="fa-solid fa-right-to-bracket"
                                            style="margin-left: 20px;margin-right: 5px;margin-top: 7px"></i></a>
                                </c:if>
                                <c:if test="${sessionScope.account != null}">
                                    <a href="accountServlet?action=logout" class="text-dark d-flex"
                                       style="text-decoration: none; margin-left: 20px"><i
                                            class="fa-solid fa-right-from-bracket"
                                            style="margin-right: 5px;margin-top: 7px"></i></a>
                                    <c:if test="${sessionScope.account.roleName != 'admin'}">
                                        <a href="CustomerServlet?action=customerChangeInfo&userName=${sessionScope.account.userName}">
                                            <div class="text-dark"
                                                 style="font-size: 80%;margin-top: 5px;margin-left: 20px"><i class="fa-solid fa-user"></i>${sessionScope.account.userName}</div>
                                        </a>
                                    </c:if>
                                    <c:if test="${sessionScope.account.roleName == 'admin'}">
                                        <div class="text-dark"
                                             style="font-size: 80%;margin-top: 5px;margin-left: 20px"><i class="fa-solid fa-user"></i>${sessionScope.account.userName}</div>
                                    </c:if>
                                </c:if>
                            </div>
                            <!--                    End login-->
                        </div>
                    </div>
                    <!--                End cart & login-->
                    <div class="row bg-light col-12">
                    </div>
                </nav>
            </div>
        </div>
    </header>
