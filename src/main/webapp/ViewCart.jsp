<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.mail.*"%>
<%@page import="java.net.InterfaceAddress" %>
<%@page import="javax.mail.internet.*" %>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
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
    <title>Edit Profile</title>
</head>
<body>
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
        String dbPassword = "Hakar123";

        try {
            Connection connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

            if(request.getParameter("editQuantityButton") != null) {
                if(request.getParameter("quantity").equals("0")) {
                    String deleteCartItemQuery = "DELETE FROM Cart WHERE Book = ? AND User = ?";
                    PreparedStatement deleteCartItemQuery_pmst = connection.prepareStatement(deleteCartItemQuery);
                    deleteCartItemQuery_pmst.setString(1, request.getParameter("ISBN").replaceAll("/",""));
                    deleteCartItemQuery_pmst.setInt(2, (int)Integer.parseInt(userID));
                    deleteCartItemQuery_pmst.executeUpdate();
                }
                else {
                    String editQuantityQuery = "UPDATE Cart SET Quantity = ? WHERE Book = ? AND User = ?";
                    PreparedStatement editQuantityQuery_pmst = connection.prepareStatement(editQuantityQuery);
                    editQuantityQuery_pmst.setInt(1, (int)Integer.parseInt(request.getParameter("quantity")));
                    editQuantityQuery_pmst.setString(2, request.getParameter("ISBN").replaceAll("/",""));
                    editQuantityQuery_pmst.setInt(3, (int)Integer.parseInt(userID));
                    editQuantityQuery_pmst.executeUpdate();
                }
            } else if(request.getParameter("removeButton") != null) {
                String deleteCartItemQuery = "DELETE FROM Cart WHERE Book = ? AND User = ?";
                PreparedStatement deleteCartItemQuery_pmst = connection.prepareStatement(deleteCartItemQuery);
                deleteCartItemQuery_pmst.setString(1, request.getParameter("ISBN").replaceAll("/",""));
                deleteCartItemQuery_pmst.setInt(2, (int)Integer.parseInt(userID));
                deleteCartItemQuery_pmst.executeUpdate();
            }

                String cart = "select * from bookstore.cart left join bookstore.books B on bookstore.Cart.Book = B.ISBN WHERE User = ?";
            PreparedStatement cart_pmst = connection.prepareStatement(cart);
            cart_pmst.setInt(1, (int)Integer.parseInt(userID));
            ResultSet cartResults = cart_pmst.executeQuery();

    %>
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
        <nav id ="nav_menu">
            <ul>
                <%if(userEmail != ""){ %>
                    <%if(!userType.equals("0")){ %>
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

                    <li><form id ="find_books" method="post" action="Homepage.jsp">
                        <a href="javascript:{}" onclick="document.getElementById('find_books').submit();">Find Books</a>
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
        <div class="main content">
            <div class="cart-information">
                <h2 class="page-header">Cart</h2>
                <%
                    if(!cartResults.next()) {
                %>
                <h6 class="page-header">Your cart is empty</h6>
                <%
                }
                else {
                    cartResults.beforeFirst();%>
                    <table class="table">
                    <tbody>
                    <%
                        while(cartResults.next()) { %>
                        <div class="modal fade" id=<%="editQuantity_" + cartResults.getString(2)%> tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">

                                        <h5 class="modal-title">Book Information</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/ViewCart.jsp" method="post">
                                        <input type="hidden" id="ISBN" name="ISBN" class="form-input" value = <%=cartResults.getString(2)%>/>
                                        <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=request.getParameter("currentUserEmail")%>/>
                                        <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=request.getParameter("currentUserID")%>/>
                                        <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>
                                        <div class="modal-body">
                                            <div class="container">
                                                <div class="form-row">
                                                    <div class="form-group col-md-5">
                                                        <img src=<%=cartResults.getString(12)%> width="270" height="420">
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
                                                        <label class="form-label"><%=cartResults.getString(6)%></label><br>
                                                        <label class="form-label"><%=cartResults.getString(7)%></label><br>
                                                        <label class="form-label"><%=cartResults.getInt(8)%></label><br>
                                                        <label class="form-label"><%=cartResults.getString(9)%></label><br>
                                                        <label class="form-label"><%=cartResults.getString(11)%></label><br>
                                                        <label class="form-label">$<%=cartResults.getDouble(15)%></label><br>
                                                        <label class="form-label"><%=cartResults.getInt(17)%>/5</label><br>
                                                        <label class="form-label"><%=cartResults.getString(2)%></label><br>
                                                        <select id="quantity" name="quantity" class="form-input" required>
                                                            <option value="" selected disabled hidden>Select One</option>
                                                            <%  String sumInCartQuery = "SELECT SUM(Quantity) FROM Cart WHERE Book = " + cartResults.getString(2) + " AND NOT USER = ?";
                                                                PreparedStatement sumInCartQuery_pmst = connection.prepareStatement(sumInCartQuery);
                                                                sumInCartQuery_pmst.setInt(1, (int)Integer.parseInt(userID));
                                                                ResultSet inCartResults = sumInCartQuery_pmst.executeQuery();
                                                                int sumInCart = 0;
                                                                if(inCartResults.next()) {
                                                                    sumInCart = inCartResults.getInt(1);
                                                                }
                                                                for(int i = 0; i <= cartResults.getInt(4) - sumInCart; i++) {
                                                            %><option value=<%=i%>><%=i%></option><%
                                                            }%>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                            <button type="submit" class="btn btn-primary" name="editQuantityButton">Update Quantity</button>
                                        </div>
                                    </form>

                                </div>
                            </div>
                        </div>
                        <div class="modal fade" id=<%="remove_" + cartResults.getString(2)%> tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Delete Address</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/ViewCart.jsp" method="post">
                                        <div class="modal-body">
                                            <div class="container">
                                                <div class="form-row">
                                                    <div class="form-group col-md">
                                                        <input type="hidden" id="ISBN" name="ISBN" value="<%=cartResults.getString(2)%>"/>
                                                        <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                                                        <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=userID%>/>
                                                        <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>
                                                        <p>Are you sure you want to remove this item from your cart?</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                            <button type="submit" class="btn btn-danger" name="removeButton">Remove Item</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <tr>
                            <td>Quantity: <%=cartResults.getInt(3)%></td>
                            <td><img src=<%=cartResults.getString(12)%> width="90" height="140"></td>
                            <td><%=cartResults.getString(6)%> <br><br>by <%=cartResults.getString(7)%></td>
                            <td>$<%=cartResults.getDouble(15)%> <br><br> <%=cartResults.getInt(17)%>/5</td>
                            <td>
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target=<%="#editQuantity_" + cartResults.getString(2)%>>
                                    Edit Quantity
                                </button>
                                <button type="button" class="btn btn-danger" data-toggle="modal" data-target=<%="#remove_" + cartResults.getString(2)%>>
                                    Remove
                                </button>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <button type="button" class="btn btn-success" data-toggle="modal" data-target=<%="#checkout"%>>
                    Check Out
                </button>
                <%}%>
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
