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
    String userEmail = request.getParameter("currentUserEmail").replaceAll("/","");
    String dbURL = "jdbc:mysql://localhost:3306/bookstore?serverTimezone=EST";
    String dbUsername = "root";
    String dbPassword = "WebProg2020";

    try {
        Connection connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

        String book = "SELECT * FROM Books "; //get a list of usernames of the logged in user
        PreparedStatement book_pmst = connection.prepareStatement(book);
        ResultSet bookResults = book_pmst.executeQuery();
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
            <li><form id ="login_edit" method="post" action=<%if(request.getParameter("currentUserEmail") == null){%>
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
                </form></li>
                <li><form class= "log_out" id ="log_out" method="post" action="Login.jsp">
                    <a href="javascript:{}" onclick="document.getElementById('log_out').submit();">Log Out</a>
                </form></li>
    <%--        <form id ="view_cart" method="post" action="ViewCart.jsp">--%>
    <%--            <a href="javascript:{}" onclick="document.getElementById('view_cart').submit();">View Cart</a>--%>
    <%--            <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=request.getParameter("currentUserEmail")%>/>--%>
    <%--            <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=request.getParameter("currentUserID")%>/>--%>
    <%--            <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>--%>
    <%--        </form>--%>
            </ul>
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

            <h6 class="page-header">All Books</h6>
            <%-- Table for personal information --%>
            <table class="table">
                <%--
                <thead class="thead-dark">
                <tr>
                    <th scope="col">Image</th>
                    <th scope="col">Title</th>
                    <th scope="col">Author</th>
                    <th scope="col">Price</th>
                    <th scope="col">Rating</th>
                    <th scope="col">Details</th>
                </tr>
                </thead>
                --%>
                <tbody>
                <% while(bookResults.next()) { %>
                <%--
                <div class="modal fade" id=<%="bookInfo_" + bookResults.getString(2)%> tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Book Information</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/EditProfile.jsp" method="post">
                                <div class="modal-body">
                                    <div class="container">
                                        <div class="form-row">
                                            <div class="form-group col-md-6">
                                                <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                                                <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>
                                                <label class="form-label" for="updateFirstName">First Name</label>
                                                <input type="text" id="updateFirstName" name="updateFirstName" class="form-input" pattern="[A-Za-z]{2,}" title="Enter the letters of your first name" value="<%=personalResults.getString(6)%>"/>
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label class="form-label" for="updateLastName">Last Name</label>
                                                <input type="text" id="updateLastName" name="updateLastName" class="form-input" pattern="[A-Za-z]{2,}" title="Enter the letters of your last name" value="<%=personalResults.getString(7)%>"/>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md">
                                                <label class="form-label" for="updatePhoneNumber">Phone Number</label>
                                                <input type="tel" id="updatePhoneNumber" name="updatePhoneNumber" class="form-input" pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}" title="Please enter a phone number -> ###-###-####" value="<%=personalResults.getString(8)%>"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-primary" name="editPersonalButton">Save changes</button>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
                --%>
                <%--
                <div class="modal fade" id=<%="editPassword_" + personalResults.getInt(1)%> tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Edit Password</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/EditProfile.jsp" method="post">
                                <div class="modal-body">
                                    <div class="container">
                                        <div class="form-row">
                                            <div class="form-group col-md-6">
                                                <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                                                <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>
                                                <label class="form-label" for="newPassword">New Password</label>
                                                <input type="text" id="newPassword" name="newPassword" class="form-input" />
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label class="form-label" for="confirmNewPassword">Confirm New Password</label>
                                                <input type="text" id="confirmNewPassword" name="confirmNewPassword" class="form-input" />
                                            </div>
                                        </div>

                                        <div class="form-row">
                                            <div class="form-group col-md">
                                                <label class="form-label" for="currentPassword">Current Password</label>
                                                <input type="text" id="currentPassword" name="currentPassword" class="form-input" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-primary" name="editPasswordButton">Save changes</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div> --%>
                <%--
                <div class="modal fade" id=<%="notifications_" + personalResults.getInt(1)%> tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Notifications?</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/EditProfile.jsp" method="post">
                                <div class="modal-body">
                                    <div class="container">
                                        <div class="form-row">
                                            <div class="form-group col-md-12">
                                                <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                                                <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>
                                                <label class="form-label" for="newPassword">Would you like to receive notifications?</label>
                                                <select id="notifications" name="notifications" class="form-input" required>
                                                    <option value="" selected disabled hidden>Select One</option>
                                                    <option value=1>Yes</option>
                                                    <option value=0>No</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-primary" name="notificationsButton">Save changes</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                --%>

                <tr>
                    <td><img src=<%=bookResults.getString(9)%> width="90" height="140"></td>
                    <td><%=bookResults.getString(3)%> <br><br>by <%=bookResults.getString(4)%></td>
                    <td>$<%=bookResults.getDouble(11)%> <br><br> <%="x"%>/5</td> <%-- TODO: WE NEED TO ADD RATINGS TO BOOK TABLE --%>
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
