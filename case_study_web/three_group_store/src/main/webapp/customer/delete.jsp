
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <link rel="stylesheet" href="home/css/styles.css">
</head>
<body>

<jsp:include page="/home/header.jsp"></jsp:include>
<form method="post">
    <h3>Do You Want Delete ?</h3>
    <fieldset>
        <legend>Customer User Information</legend>
        <table border="1">
            <tr>
                <th>Name: </th>
                <td>${customerList.getName()}</td>
            </tr>
            <tr>
                <th>Date_Of_Birth: </th>
                <td>${customerList.getDob()}</td>
            </tr>
            <tr>
                <th>Gender: </th>
                <c:if test="${customerList.isGender() == true}">
                    <td>Nam</td>
                </c:if>
                <c:if test="${customerList.isGender() == false}">
                    <td>Nữ</td>
                </c:if>
            </tr>
           <tr>
               <th>ID_Card: </th>
               <td>${customerList.getIdCard()}</td>
           </tr>
            <tr>
                <th>Phone_Number: </th>
                <td>${customerList.getPhoneNumber()}</td>
            </tr>
            <tr>
                <th>Email: </th>
                <td>${customerList.getEmail()}</td>
            </tr>
            <tr>
                <th>Address: </th>
                <td>${customerList.getAddress()}</td>
            </tr>

            <tr>
                <td align="center"><input type="submit" value="Delete" align="center" ></td>
                <td align="center"><button><a href="/CustomerServlet" style="text-decoration: none">Back</a></button></td>
            </tr>
        </table>
    </fieldset>
</form>
<jsp:include page="/home/footer.jsp"></jsp:include>
</body>
</html>
