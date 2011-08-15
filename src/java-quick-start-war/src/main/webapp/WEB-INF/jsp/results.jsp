<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
  "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
<head>
<link rel="stylesheet" type="text/css" href="stylesheets/style.css" />
<title>Tomcat MySQL Demo</title>
</head>
<h2>Tomcat MySQL Demo</h2>
<table>
  <tr>
    <th>ID</th>
    <th>Description</th>
    <th>MSRP</th>
  </tr>
  <c:forEach var="product" items="${results}">
    <tr>
    <td><c:out value="${product.code}" /></td>
    <td><c:out value="${product.name}" /></td>
    <td><c:out value="${product.msrp}" /></td>
    </tr>
  </c:forEach>
</table>
</body>
</html>
