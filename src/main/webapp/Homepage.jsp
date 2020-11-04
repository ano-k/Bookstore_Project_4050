<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
<link rel="stylesheet" href="https://www.tutorialrepublic.com/lib/styles/snippets-2.2.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="stylesheet.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" rel="stylesheet">
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Homepage</title>
    <style>
        .hp-sidebar {
            width: 25%;
            float: left;
        }

        .homepage-table {
            width: 75%;
            float: right;
        }


        .temp-information {
            margin: 20px;
            padding: 20px;
            background-color: lightblue;
            border-radius: 15px;
            display: flex;
        }


        .temp-block {
            float: left;
            margin-right: 20px;
            padding-top: 20px;
            margin-bottom: 20px;
        }

        .search-bar {
            float: left;
        }

    </style>
</head>
<body>
<div class="column left"></div>
<div class="column middle">
    <header>
            <h1 class="page-header">
            <span style="color: red" class="logo">B</span>
            <span style="color: orange" class="logo">OO</span>
            <span style="color: limegreen" class="logo">K</span>
            <span style="color: red" class="logo">S </span>
            <backward><span style="color: royalblue" class="logo"> R </span></backward>
            <span style="color: limegreen" class="logo"> U</span>
            <span style="color: red" class="logo">S</span>
            </h1>
    </header>
    <main>
        <nav id ="nav_menu" style="align-content: center">
            <form id ="login_edit" method="post" action=<%if(request.getParameter("currentUserEmail") == null){%>
                    "/Bookstore_Project_4050_war_exploded/Login.jsp" <%}else {%>
                     "/Bookstore_Project_4050_war_exploded/EditProfile.jsp"
            <%}%>>
                <a href="javascript:{}" onclick="document.getElementById('login_edit').submit();"><%if(request.getParameter("currentUserEmail") == null){%>
                    Login<%}else {%>Profile<%}%></a>
                <%if(request.getParameter("currentUserEmail") != null){%>
                <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=request.getParameter("currentUserEmail")%>/>
                <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=request.getParameter("currentUserID")%>/>
                <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>
                <%}%>
            </form>
    <%--        <form id ="view_cart" method="post" action="ViewCart.jsp">--%>
    <%--            <a href="javascript:{}" onclick="document.getElementById('view_cart').submit();">View Cart</a>--%>
    <%--            <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=request.getParameter("currentUserEmail")%>/>--%>
    <%--            <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=request.getParameter("currentUserID")%>/>--%>
    <%--            <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>--%>
    <%--        </form>--%>
        </nav>
    <div class="temp-information">
        <div class="hp-sidebar">
            <div class="search-bar">
                <form>
                    <input id="searchbar" name="searchbar" type="text" placeholder="Search title, author, ISBN, ..."/>
                    <input type="submit" value="Submit">
                </form>
            </div>

            <div class="filters">
                <form>
                    <div class="parent-filter-div">
                        <div class="temp-block">
                            <h3>Genre</h3>
                            <input type="checkbox" id="genre1" name="genre1" value="scifi">
                            <label for="genre1">Science Fiction</label><br>
                            <input type="checkbox" id="genre2" name="genre2" value="nonfiction">
                            <label for="genre2">Nonfiction</label><br>
                            <input type="checkbox" id="genre3" name="genre3" value="fiction">
                            <label for="genre3">Fiction</label><br>

                            <h3>Price</h3>
                            <input type="checkbox" id="price1" name="price1" value="hi2lo">
                            <label for="price1">High to low</label><br>
                            <input type="checkbox" id="price2" name="price2" value="lo2hi">
                            <label for="price2">Low to high</label><br>
                            <input type="submit" value="Submit">
                        </div>
                    </div>
                </form>
            </div>
        </div>


        <div class="homepage-table">

            <h4>Featured Books</h4>
            <table>
                <tr>
                    <th>Book Image</th>
                    <th>Book Details</th>
                    <th>Link</th>
                    <th>Add to Cart</th>
                </tr>
                <tr class="homepage-book-row">
                    <td><a href="BookDetails.jsp"><img src="harrypotter.jpg"/></a></td>
                    <td>
                        Title: Harry Potter and the Socerer's Stone <br>
                        Author: JK Rowling <br>
                        Rating: 3 <br>
                        Price: $10
                    </td>
                    <td>
                        <button><a href="BookDetails.jsp">Book Page</a></button>
                    </td>
                    <td>
                        <button><a href="">Add to Cart</a></button>
                    </td>
                </tr>
                <tr class="homepage-book-row">
                    <td><img src="seuss.jpg"/></td>
                    <td>
                        Title: The Cat in the Hat<br>
                        Author: Dr. Seuss<br>
                        Rating: 4<br>
                        Price: $7.50
                    </td>
                    <td>
                        <button><a href="BookDetails.jsp">Book Page</a></button>
                    </td>
                    <td>
                        <button><a href="">Add to Cart</a></button>
                    </td>
                </tr>
            </table>

            <br>
            <h4>Best Sellers</h4>
            <table>
                <tr>
                    <th>Book Image</th>
                    <th>Book Details</th>
                    <th>Link</th>
                    <th>Add to Cart</th>
                </tr>
                <tr class="homepage-book-row">
                    <td><img src="theory.jpg"/></td>
                    <td>
                        Title:  Introduction to Theory of Computation<br>
                        Author: Michael Sipser<br>
                        Rating: 5<br>
                        Price: $20
                    </td>
                    <td>
                        <button><a href="BookDetails.jsp">Book Page</a></button>
                    </td>
                    <td>
                        <button><a href="">Add to Cart</a></button>
                    </td>
                </tr>
                <tr class="homepage-book-row">
                    <td><img src="ahsoka.jpg"/></td>
                    <td>
                        Title:  Star Wars: Ahsoka<br>
                        Author: E.K. Johnston<br>
                        Rating: 2<br>
                        Price: $9
                    </td>
                    <td>
                        <button><a href="BookDetails.jsp">Book Page</a></button>
                    </td>
                    <td>
                        <button><a href="">Add to Cart</a></button>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </main>
</div>
</body>
</html>
