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
<%
    String userEmail = "";
    String userType = "";
    String userID = "";
    if(request.getParameter("currentUserEmail") != null){
        userEmail = request.getParameter("currentUserEmail").replaceAll("/","");
        userType = request.getParameter("currentUserType").replaceAll("/","");
        userID = request.getParameter("currentUserID").replaceAll("/","");
    }

    String dbURL = "jdbc:mysql://localhost:3306/bookstore?serverTimezone=EST";
    String dbUsername = "root";
    String dbPassword = "WebProg2020";

    try {
        Connection connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
        if(request.getParameter("bookInfoButton") != null && userID != "") {
            String cart = "SELECT Book, Quantity FROM Cart WHERE User = ? ";
            PreparedStatement cart_pmst = connection.prepareStatement(cart, ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            cart_pmst.setInt(1, (int)Integer.parseInt(userID));
            ResultSet cartResults = cart_pmst.executeQuery();
            String cartQuery = "";
            Boolean isInCart = false;
            int quantity = 0;

            while(cartResults.next()){
                if(cartResults.getString(1).equals(request.getParameter("ISBN"))){
                    isInCart = true;
                    quantity = cartResults.getInt(2);
                }
            }

            if (!isInCart) {
                cartQuery = "INSERT INTO Cart (User, Book, Quantity) VALUES (?, ?, ?) ";
                PreparedStatement cartQuery_pmst = connection.prepareStatement(cartQuery);
                cartQuery_pmst.setInt(1, (int)Integer.parseInt(userID));
                cartQuery_pmst.setString(2, request.getParameter("ISBN").replaceAll("/",""));
                cartQuery_pmst.setInt(3, (int)Integer.parseInt(request.getParameter("quantity")));
                cartQuery_pmst.executeUpdate();

            } else {
                cartQuery = "UPDATE Cart SET Quantity = ? WHERE Book = ? AND User = ? ";
                PreparedStatement cartQuery_pmst = connection.prepareStatement(cartQuery);
                cartQuery_pmst.setInt(1, (int)Integer.parseInt(userID));
                cartQuery_pmst.setString(2, request.getParameter("ISBN").replaceAll("/",""));
                cartQuery_pmst.setInt(3, quantity +(int)Integer.parseInt(request.getParameter("quantity")));
                cartQuery_pmst.executeUpdate();
            }
        }


        String book = "SELECT * FROM Books ";
        String featured = "SELECT * FROM Books ";
        String bestSellers = "SELECT * FROM Books ";

        //loop through genre1 - genre11, to see if any selection was made
        boolean chop = false;
        for(int i = 0; i < 10; i++) {
            if(request.getParameter("genre" + i) != null) {
                chop = true;
                book += "WHERE (";
                featured += "WHERE (";
                bestSellers += "WHERE (";
                break;
            }
        } //checks if a selection was made, and if so, concat a WHERE to the string

        for(int i = 0; i < 10; i++) {
            if(request.getParameter("genre" + i) != null) {
                book += "Genre = " + request.getParameter("genre" + i) + " OR ";
                featured += "Genre = " + request.getParameter("genre" + i) + " OR ";
                bestSellers += "Genre = " + request.getParameter("genre" + i) + " OR ";
            }
        } //applies all selections made
        if(chop) {
            book = book.substring(0, (book.length()-3));
            book += ") ";
            featured = featured.substring(0, (featured.length()-3));
            featured += ") ";
            bestSellers = bestSellers.substring(0, (bestSellers.length()-3));
            bestSellers += ") ";
            featured = book + "AND isFeatured = 1 ";
            bestSellers = book + "AND isBestSeller = 1 ";
            if(request.getParameter("searchbar") != null && !request.getParameter("searchbar").trim().isEmpty()) {
                book += "AND (Title LIKE \'%" + request.getParameter("searchbar") + "%\' OR Author LIKE \'%" + request.getParameter("searchbar") + "%\' OR ISBN = \'" + request.getParameter("searchbar") + "\') ";
            }
        }
        else {
            if(request.getParameter("searchbar") != null && !request.getParameter("searchbar").trim().isEmpty()) {
                book += "WHERE (Title LIKE \'%" + request.getParameter("searchbar") + "%\' OR Author LIKE \'%" + request.getParameter("searchbar") + "%\' OR ISBN = \'" + request.getParameter("searchbar") + "\') ";
            }
            featured += "WHERE isFeatured = 1 ";
            bestSellers += "WHERE isBestSeller = 1 ";
        }
        if(request.getParameter("searchbar") != null && !request.getParameter("searchbar").trim().isEmpty()) {
            featured += "AND (Title LIKE \'%" + request.getParameter("searchbar") + "%\' OR Author LIKE \'%" + request.getParameter("searchbar") + "%\' OR ISBN = \'" + request.getParameter("searchbar") + "\') ";
            bestSellers += "AND (Title LIKE \'%" + request.getParameter("searchbar") + "%\' OR Author LIKE \'%" + request.getParameter("searchbar") + "%\' OR ISBN = \'" + request.getParameter("searchbar") + "\') ";
        }
        if(request.getParameter("price1") != null) {
            book += "ORDER BY SellPrice DESC" ;
            featured += "ORDER BY SellPrice DESC" ;
            bestSellers += "ORDER BY SellPrice DESC" ;
        }
        else if(request.getParameter("price2") != null) {
            book += "ORDER BY SellPrice ASC" ;
            featured += "ORDER BY SellPrice ASC" ;
            bestSellers += "ORDER BY SellPrice ASC" ;
        }

        PreparedStatement book_pmst = connection.prepareStatement(book, ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_UPDATABLE);
        ResultSet bookResults = book_pmst.executeQuery();

        PreparedStatement featured_pmst = connection.prepareStatement(featured, ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_UPDATABLE);
        ResultSet featuredResults = featured_pmst.executeQuery();

        PreparedStatement bestSellers_pmst = connection.prepareStatement(bestSellers, ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_UPDATABLE);
        ResultSet bestSellersResults = bestSellers_pmst.executeQuery();

%>
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
            <ul>
                <%if(userEmail != ""){%>
                    <%if(userType.equals("2") || userType.equals("1")){ %>
                        <li><form id ="manage_store" method="post" action="AdminHomepage.jsp">
                            <a href="javascript:{}" onclick="document.getElementById('manage_store').submit();">Manage store</a>
                            <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                            <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=userType%>/>
                            <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=userID%>/>
                        </form>
                        </li>
                    <%}%>
                    <li><form id ="login_edit" method="post" action="/Bookstore_Project_4050_war_exploded/EditProfile.jsp">
                        <a href="javascript:{}" onclick="document.getElementById('login_edit').submit();">Profile</a>
                        <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                        <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=userID%>/>
                        <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=userType%>/>
                        </form>
                    </li>
                    <li><form class= "view_cart" id ="view_cart" method="post" action="ViewCart.jsp">
                        <a href="javascript:{}" onclick="document.getElementById('view_cart').submit();">Cart</a>
                        <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                        <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=userID%>/>
                        <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=userType%>/>
                        </form>
                    </li>
                    <li><form class= "checkout" id ="checkout" method="post" action="Checkout.jsp">
                        <a href="javascript:{}" onclick="document.getElementById('checkout').submit();">Checkout</a>
                        <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                        <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=userID%>/>
                        <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=userType%>/>
                    </form>
                    </li>
                    <li><form class= "log_out" id ="log_out" method="post" action="Login.jsp">
                        <a href="javascript:{}" onclick="document.getElementById('log_out').submit();">Log Out</a>
                        </form>
                    </li>
                <%} else{%>
                <li><form id ="login_edit" method="post" action="/Bookstore_Project_4050_war_exploded/Login.jsp">
                    <a href="javascript:{}" onclick="document.getElementById('login_edit').submit();">Login</a>
                    </form>
                </li>
                <%}%>
            </ul>
        </nav>
    <div class="temp-information">
        <div class="hp-sidebar">
            <%--
            <div class="search-bar">
                <form>
                    <input id="searchbar" name="searchbar" type="text" placeholder="Search title, author, ISBN, ..."/>
                    <input type="submit" value="Submit">
                </form>
            </div>
            --%>

            <div class="filters">
                <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/Homepage.jsp" method="post">
                    <div class="parent-filter-div">
                        <div class="temp-block">
                            <input id="searchbar" name="searchbar" type="text" placeholder="Search title, author, ISBN, ..."/>
                            <h3>Genre</h3>
                            <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=request.getParameter("currentUserEmail")%>/>
                            <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=request.getParameter("currentUserID")%>/>
                            <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>
                            <input type="checkbox" id="genre1" name="genre1" value=1>
                            <label for="genre1">Action & Adventure</label><br>
                            <input type="checkbox" id="genre2" name="genre2" value=2>
                            <label for="genre2">Children&#39;s</label><br>
                            <input type="checkbox" id="genre3" name="genre3" value=3>
                            <label for="genre3">Classic</label><br>
                            <input type="checkbox" id="genre4" name="genre4" value=4>
                            <label for="genre4">Drama</label><br>
                            <input type="checkbox" id="genre5" name="genre5" value=5>
                            <label for="genre5">Fantasy</label><br>
                            <input type="checkbox" id="genre6" name="genre6" value=6>
                            <label for="genre6">Graphic Novel</label><br>
                            <input type="checkbox" id="genre7" name="genre7" value=7>
                            <label for="genre7">Horror</label><br>
                            <input type="checkbox" id="genre8" name="genre8" value=8>
                            <label for="genre8">Mystery & Crime</label><br>
                            <input type="checkbox" id="genre9" name="genre9" value=9>
                            <label for="genre9">Nonfiction</label><br>
                            <input type="checkbox" id="genre10" name="genre10" value=10>
                            <label for="genre10">Romance</label><br>
                            <input type="checkbox" id="genre11" name="genre11" value=11>
                            <label for="genre11">Science Fiction</label><br>

                            <h3>Price</h3>
                            <input type="radio" id="price1" name="price1" value="hi2lo">
                            <label for="price1">High to low</label><br>
                            <input type="radio" id="price2" name="price2" value="lo2hi">
                            <label for="price2">Low to high</label><br>
                            <input type="submit" value="Submit">
                        </div>
                    </div>
                </form>
            </div>
        </div>


        <div class="homepage-table">
            <% int featuredCount = 0;
                if(featuredResults.last()) {
                    featuredCount = featuredResults.getRow();
                    featuredResults.beforeFirst();
                }
                if(featuredCount != 0) { %>
                <h6 class="page-header">Featured Books</h6>
                <table class="table">
                    <tbody>
                    <% while(featuredResults.next()) { %>
                    <tr>
                        <td><img src=<%=featuredResults.getString(9)%> width="90" height="140"></td>
                        <td><%=featuredResults.getString(3)%> <br><br>by <%=featuredResults.getString(4)%></td>
                        <td>$<%=featuredResults.getDouble(12)%> <br><br> <%=featuredResults.getInt(14)%>/5</td>
                        <td>
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target=<%="#bookInfo_" + featuredResults.getString(2)%>>
                                More Information
                            </button>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
                <br><br>
            <% } %>
            <% int bestSellersCount = 0;
                if(bestSellersResults.last()) {
                    bestSellersCount = bestSellersResults.getRow();
                    bestSellersResults.beforeFirst();
                }
                if(bestSellersCount != 0) { %>
                <h6 class="page-header">Best Sellers</h6>
                <table class="table">
                    <tbody>
                    <% while(bestSellersResults.next()) { %>
                    <tr>
                        <td><img src=<%=bestSellersResults.getString(9)%> width="90" height="140"></td>
                        <td><%=bestSellersResults.getString(3)%> <br><br>by <%=bestSellersResults.getString(4)%></td>
                        <td>$<%=bestSellersResults.getDouble(12)%> <br><br> <%=bestSellersResults.getInt(14)%>/5</td>
                        <td>
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target=<%="#bookInfo_" + bestSellersResults.getString(2)%>>
                                More Information
                            </button>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
                <br><br>
            <% } %>
            <h6 class="page-header">All Books</h6>
            <table class="table">
                <tbody>
                <% while(bookResults.next()) { %>
                <div class="modal fade" id=<%="bookInfo_" + bookResults.getString(2)%> tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">

                                <h5 class="modal-title">Book Information</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/Homepage.jsp" method="post">
                                <input type="hidden" id="ISBN" name="ISBN" class="form-input" value = <%=bookResults.getString(2)%>/>
                                <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=request.getParameter("currentUserEmail")%>/>
                                <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=request.getParameter("currentUserID")%>/>
                                <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>
                                <div class="modal-body">
                                    <div class="container">
                                        <div class="form-row">
                                            <div class="form-group col-md-5">
                                                <img src=<%=bookResults.getString(9)%> width="270" height="420">
                                            </div>
                                            <div class="form-group col-md-2">
                                                <label class="form-label">Title: </label><br>

                                                <label class="form-label">Author: </label><br>

                                                <label class="form-label">Edition: </label><br>

                                                <label class="form-label">Publisher: </label><br>

                                                <label class="form-label">Genre: </label><br>

                                                <label class="form-label">Price: </label><br>

                                                <label class="form-label">Rating: </label><br>

                                                <label class="form-label">ISBN: </label><br>

                                                <label class="form-label" for="quantity">Quantity: </label>

                                            </div>
                                            <div class="form-group col-md-5">
                                                <label class="form-label"><%=bookResults.getString(3)%></label><br>
                                                <label class="form-label"><%=bookResults.getString(4)%></label><br>
                                                <label class="form-label"><%=bookResults.getInt(5)%></label><br>
                                                <label class="form-label"><%=bookResults.getString(6)%></label><br>
                                                <label class="form-label"><%=bookResults.getString(8)%></label><br>
                                                <label class="form-label">$<%=bookResults.getDouble(12)%></label><br>
                                                <label class="form-label"><%=bookResults.getInt(14)%>/5</label><br>
                                                <label class="form-label"><%=bookResults.getString(2)%></label><br>
                                                <select id="quantity" name="quantity" class="form-input" required>
                                                    <option value="" selected disabled hidden>Select One</option>
                                                    <%  String sumInCartQuery = "SELECT SUM(Quantity) FROM Cart WHERE Book = " + bookResults.getString(2) + " ";
                                                        PreparedStatement sumInCartQuery_pmst = connection.prepareStatement(sumInCartQuery);
                                                        ResultSet inCartResults = sumInCartQuery_pmst.executeQuery();
                                                        int sumInCart = 0;
                                                        if(inCartResults.next()) {
                                                            sumInCart = inCartResults.getInt(1);
                                                        }
                                                        for(int i = 1; i <= bookResults.getInt(1) - sumInCart; i++) {
                                                    %><option value=<%=i%>><%=i%></option><%
                                                    }%>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%--
                                        <div class="form-row">
                                            <div class="form-group col-md-2">
                                                <input type="hidden" id="ISBN" name="ISBN" value="<%=bookResults.getString(2)%>"/>
                                                <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                                                <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>
                                                <label class="form-label">Quantity</label>
                                                <label class="form-label"><%=bookResults.getInt(1)%></label>
                                            </div>
                                            <div class="form-group col-md-5">
                                                <label class="form-label">Title</label>
                                                <label class="form-label"><%=bookResults.getString(3)%></label>
                                            </div>
                                            <div class="form-group col-md-5">
                                                <label class="form-label">Author</label>
                                                <label class="form-label"><%=bookResults.getString(4)%></label>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-3">
                                                <label class="form-label">Edition</label>
                                                <label class="form-label"><%=bookResults.getInt(5)%></label>
                                            </div>
                                            <div class="form-group col-md-7">
                                                <label class="form-label">Publisher</label>
                                                <label class="form-label"><%=bookResults.getString(6)%></label>
                                            </div>
                                            <div class="form-group col-md-2">
                                                <label class="form-label">Year</label>
                                                <label class="form-label"><%=bookResults.getInt(7)%></label>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-4">
                                                <label class="form-label">Genre</label>
                                                <label class="form-label"><%=bookResults.getString(8)%></label>
                                            </div>
                                            <div class="form-group col-md-8">
                                                <label class="form-label">Image</label>
                                                <label class="form-label">Image</label>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-4">
                                                <label class="form-label">Price</label>
                                                <label class="form-label"><%=bookResults.getDouble(12)%></label>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-4">
                                                <label class="form-label">Rating</label>
                                                <label class="form-label"><%=bookResults.getInt(14)%></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                --%>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-primary" name="bookInfoButton">Add to Cart</button>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
                <tr>
                    <td><img src=<%=bookResults.getString(9)%> width="90" height="140"></td>
                    <td><%=bookResults.getString(3)%> <br><br>by <%=bookResults.getString(4)%></td>
                    <td>$<%=bookResults.getDouble(12)%> <br><br> <%=bookResults.getInt(14)%>/5</td>
                    <td>
                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target=<%="#bookInfo_" + bookResults.getString(2)%>>
                            More Information
                        </button>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>

        </div>
    </div>
    </main>
</div>
</body>
<%
    } catch (SQLException e){
    //out.println("<p>Unsuccessful connection to database</p>");
    e.printStackTrace();
    }
%>
</html>
