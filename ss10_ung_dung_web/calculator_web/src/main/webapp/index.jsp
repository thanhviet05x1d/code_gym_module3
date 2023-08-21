<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Calculator App</title>
</head>
<body>
<h2>Calculator</h2>
<form action="calculator" method="post">
    Operand 1: <input type="text" name="operand1"><br>
    Operand 2: <input type="text" name="operand2"><br>
    Operator:
    <select name="operator">
        <option value="add">+</option>
        <option value="subtract">-</option>
        <option value="multiply">*</option>
        <option value="divide">/</option>
    </select><br>
    <input type="submit" value="Calculate">
</form>
</body>
</html>
