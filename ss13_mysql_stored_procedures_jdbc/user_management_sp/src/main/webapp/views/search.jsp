<%--
  Created by IntelliJ IDEA.
  User: Viet
  Date: 21-Aug-23
  Time: 3:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Search User</title>
</head>
<body>
<p><a href="/home">Back to user list</a></p>
<form method="post">
  <label for="search">Search By Country</label>
  <input type="text" name="country" id="search" placeholder="Enter Country">
  <input type="submit" value="Search">
</form>
<c:if test="${user!=null}">
  <hr>
  <h2>Result: </h2>
  <p>${user.getName()}</p>
  <p>${user.getEmail()}</p>
  <p>${user.getCountry()}</p>
</c:if>
</body>
</html>
