<%--
  Created by IntelliJ IDEA.
  User: Viet
  Date: 21-Aug-23
  Time: 2:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Delete User</title>
</head>
<body>
<form method="post">
  <h2>Are you sure?</h2>
  <fieldset>
    <legend>User Information</legend>
    <table>
      <tr>
        <td>Name:</td>
        <td>${user.getName()}</td>
      </tr>
      <tr>
        <td>Email:</td>
        <td>${user.getEmail()}</td>
      </tr>
      <tr>
        <td>Country:</td>
        <td>${user.getCountry()}</td>
      </tr>
      <tr>
        <td><input type="submit" value="Delete"></td>
        <td><a href="home">Back to user list</a></td>
      </tr>
    </table>
  </fieldset>
</form>
</body>
</html>
