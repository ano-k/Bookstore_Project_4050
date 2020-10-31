<%--
  Created by IntelliJ IDEA.
  User: mpcer
  Date: 9/29/2020
  Time: 10:36 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
  <link rel="stylesheet" href="stylesheet.css">
  <title>Admin Homepage</title>
</head>
<body>
  <h1 class="page-header">Admin Homepage</h1>
  <div class="cart-information">
  <nav class="admin-nav"> 
    <button><a>Manage Employees</a></button>
    <button><a>Manage Users</a></button>
    <button><a>Manage Promotions</a></button>
    <button><a>Manage Books</a></button>
    <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/EditProfile.jsp" method="post">
        <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=request.getParameter("currentUserEmail")%>/>
        <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=request.getParameter("currentUserID")%>/>
        <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>
        <button type="submit" ><a>Edit Profile</a></button>
    </form>
    <form style="float : right;">
          <input id="searchbar" name="searchbar" type="text" placeholder="Search Employee, Roles, Status, ETC"/>
          <input type="submit" value="Submit">
      </form>
  </nav>
  <table class="admin-table">
    <tr>
      <th id="test">Employee ID Number</th>
      <th>Role/Status</th>
      <th>Last Name</th>
      <th>First Name</th>
      <th>Edit Rolex</th>
    </tr>
    <tr>
      <td>12345</td>
      <td>Book Finder</td>
      <td>Smith</td>
      <td>Joe</td>
      <td>IDK</td>
    </tr>
    <tr>
      <td>12344</td>
      <td>Book Placer</td>
      <td>Cercone</td>
      <td>Michael</td>
      <td>IDK</td>
    </tr>
    <tr>
      <td>12346</td>
      <td>Book Reader</td>
      <td>Desiderio</td>
      <td>John</td>
      <td>IDK</td>
    </tr>
  </table>
  </div>

</body>
</html>
