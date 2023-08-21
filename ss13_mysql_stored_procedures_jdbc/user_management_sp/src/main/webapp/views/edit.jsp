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
  <title>Edit User</title>
  <style>
    .message {
      color: green;
    }
  </style>
</head>

<body>
<p>
  <a href="home">Back to user list</a>
</p>
<p><c:if test="${message !=null}">
  <span class="message">${message}</span>
</c:if></p>
<form method="post">
  <fieldset>
    <legend>User Information</legend>
    <table>
      <tr>
        <td><label for="name">Name: </label></td>
        <td><input type="text" name="name" id="name" value="${user.getName()}"></td>
      </tr>
      <tr>
        <td><label for="email">Email: </label></td>
        <td><input type="text" name="email" id="email" value="${user.getEmail()}"></td>
      </tr>
      <tr>
        <td><label for="country">Country: </label></td>
        <td><input type="text" name="country" id="country" value="${user.getCountry()}"></td>
      </tr>
      <tr>
        <td></td>
        <td><input type="submit" value="Update"></td>
      </tr>
    </table>
  </fieldset>
</form>
</body>
</html>
