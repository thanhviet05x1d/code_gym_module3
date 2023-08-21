<%--
  Created by IntelliJ IDEA.
  User: Viet
  Date: 21-Aug-23
  Time: 2:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>List Users</title>
  <link rel="stylesheet" href="/bootstrap-5.2.3-dist/css/bootstrap.css">
</head>
<body>
<p>
  <a href="/home?action=create">Create Users</a>
</p>
<p>
  <a href="/home?action=search">Search Users</a>
</p>
<p>
  <a href="/home?action=sort">Sort By Name</a>
</p>
<table class="table table-responsive table-hover table-bordered">
  <tr>
    <td>Name</td>
    <td>Email</td>
    <td>Country</td>
    <td>Edit</td>
    <td>Delete</td>
  </tr>
  <c:forEach var="user" items="${user}">
    <tr>
      <td><a href="home?action=view&id=${user.getId()}">${user.getName()}</a></td>
      <td>${user.getEmail()}</td>
      <td>${user.getCountry()}</td>
      <td><a href="home?action=edit&id=${user.getId()}">Edit</a></td>
      <td><a href="home?action=delete&id=${user.getId()}">Delete</a></td>
    </tr>
  </c:forEach>
</table>


<script src="/bootstrap-5.2.3-dist/js/bootstrap.bundle.js"></script>
</body>
</html>
