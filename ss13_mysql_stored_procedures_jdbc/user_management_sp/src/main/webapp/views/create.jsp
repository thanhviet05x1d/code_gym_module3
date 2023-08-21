<%--
  Created by IntelliJ IDEA.
  User: Viet
  Date: 21-Aug-23
  Time: 2:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Create User</title>
  <style>
    .message {
      color: green;
    }
  </style>
  <link rel="stylesheet" href="/bootstrap-5.2.3-dist/css/bootstrap.css">
</head>
<body>
<p>
  <a href="home">Back to User List</a>
</p>
<p>
  <c:if test="${message != null}">
    <span class="message">${message}</span>
  </c:if>
</p>
<form method="post">
  <fieldset>
    <legend>User Information</legend>
    <table>
      <tr>
        <td><label for="name">Name: </label></td>
        <td><input type="text" name="name" id="name"></td>
      </tr>
      <tr>
        <td><label for="email">Email: </label></td>
        <td><input type="text" name="email" id="email"></td>
      </tr>
      <tr>
        <td><label for="country">Country: </label></td>
        <td><input type="text" name="country" id="country"></td>
      </tr>
      <tr>
        <td></td>
        <td><input type="submit" value="Create"></td>
      </tr>
    </table>
  </fieldset>
</form>
<script src="/bootstrap-5.2.3-dist/js/bootstrap.bundle.js"></script>
</body>
</html>
