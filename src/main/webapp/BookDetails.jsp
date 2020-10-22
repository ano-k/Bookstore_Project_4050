<%--
  Created by IntelliJ IDEA.
  User: mpcer
  Date: 9/29/2020
  Time: 10:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <link rel="stylesheet" href="stylesheet.css">
    <title>Book Details</title>
</head>
<body>
    <h1 class="page-header">Book Details</h1>
    <table id="book-details">
        <tr>
            <th>Book Image</th>
            <th>Book Details</th>
            <th></th>
        </tr>
        <tr>
            <td><img src="harrypotter.jpg"/></td>
            <td>
                Title: Harry Potter and the Socerer's Stone <br>
                Author: JK Rowling <br>
                Rating: 3 <br>
                Price: $10
            </td>
            <td>
                <button><a href="">Add to Cart</a></button>
            </td>
        </tr>
    </table>


    <nav class="nav-bar">
        <button><a>Update Order</a></button>
        <button><a>Continue to Checkout</a></button>
    </nav>
</body>
</html>
