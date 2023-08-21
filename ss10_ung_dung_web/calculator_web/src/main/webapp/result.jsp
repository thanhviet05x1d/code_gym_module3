<%--
  Created by IntelliJ IDEA.
  User: Viet
  Date: 20-Aug-23
  Time: 3:40 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Calculator Result</title>
</head>
<body>
<h2>Calculator Result</h2>
<c:if test="${not empty error}">
    <p>${error}</p>
</c:if>
<c:if test="${not empty result}">
    <p>Result: ${result}</p>
</c:if>
<a href="index.jsp">Back to Calculator</a>
</body>
</html>

