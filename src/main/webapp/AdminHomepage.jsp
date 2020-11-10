<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
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
  <title>Admin Homepage</title>
</head>
<body>
  <%
//    if(request.getParameter("currentUserEmail") == null) {
//        String redirect = new String("/Bookstore_Project_4050_war_exploded/Login.jsp");
//        response.setStatus(response.SC_MOVED_TEMPORARILY);
//        response.setHeader("Location", redirect);
//    } //checks if the user is already logged in
        String userEmail = request.getParameter("currentUserEmail").replaceAll("/","");
        String dbURL = "jdbc:mysql://localhost:3306/bookstore?serverTimezone=EST";
        String dbUsername = "root";
        String dbPassword = "WebProg2020";

        try {
            Connection connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
            String promotionQuery = "SELECT * FROM Promotions "; //get a list of all promotions
            PreparedStatement promotion_pmst = connection.prepareStatement(promotionQuery);
            ResultSet promotionResults = promotion_pmst.executeQuery();

            String bookQuery = "SELECT * FROM Books "; //get a list of all books
            PreparedStatement book_pmst = connection.prepareStatement(bookQuery);
            ResultSet bookResults = book_pmst.executeQuery();

            String userQuery = "SELECT * FROM Users "; //get a list of all users
            PreparedStatement user_pmst = connection.prepareStatement(userQuery);
            ResultSet userResults = user_pmst.executeQuery();

            if(request.getParameter("editBookButton") != null) {
                String updateBookQuery = "UPDATE Books SET Quantity = ?, Title = ?, Author = ?, Edition = ?, Publisher = ?, Year = ?, Genre = ?, Image = ?, MinThreshold = ?, BuyPrice = ?, SellPrice = ? WHERE ISBN = ? ";
                PreparedStatement updateBookQuery_pmst = connection.prepareStatement(updateBookQuery);
                updateBookQuery_pmst.setInt(1, (int)Integer.parseInt(request.getParameter("updateQuantity")));
                updateBookQuery_pmst.setString(2, request.getParameter("updateISBN"));
                updateBookQuery_pmst.setString(3, request.getParameter("updateTitle"));
                updateBookQuery_pmst.setString(4, request.getParameter("updateAuthor"));
                updateBookQuery_pmst.setInt(5, (int)Integer.parseInt(request.getParameter("updateEdition")));
                updateBookQuery_pmst.setString(6, request.getParameter("updatePublisher"));
                updateBookQuery_pmst.setInt(7, (int)Integer.parseInt(request.getParameter("updateYear")));
                updateBookQuery_pmst.setString(8, request.getParameter("updateImage"));
                updateBookQuery_pmst.setDouble(9, (double)Double.parseDouble(request.getParameter("updateMinThreshold")));
                updateBookQuery_pmst.setDouble(10, (double)Double.parseDouble(request.getParameter("updateBuyPrice")));
                updateBookQuery_pmst.setDouble(11, (double)Double.parseDouble(request.getParameter("updateSellPrice")));
                updateBookQuery_pmst.setInt(12, (int)Integer.parseInt(request.getParameter("ISBN")));
                updateBookQuery_pmst.executeUpdate();

            } else if(request.getParameter("editUserButton") != null) {
                String updateUserQuery = "UPDATE Users SET Type = ?, Status = ? WHERE Email = ? ";
                PreparedStatement updateUserQuery_pmst = connection.prepareStatement(updateUserQuery);
                updateUserQuery_pmst.setInt(1, (int)Integer.parseInt(request.getParameter("updateType")));
                updateUserQuery_pmst.setInt(2, (int)Integer.parseInt(request.getParameter("updateStatus")));
                updateUserQuery_pmst.setString(3, request.getParameter("userEmail"));
                updateUserQuery_pmst.executeUpdate();

            } //TODO: archive book query thing


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
        <li><form id ="find_books" method="post" action="Homepage.jsp">
          <a href="javascript:{}" onclick="document.getElementById('find_books').submit();">Find Books</a>
          <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=request.getParameter("currentUserEmail")%>/>
          <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>
        </form></li>
        <li><form class= "log_out" id ="log_out" method="post" action="Login.jsp">
          <a href="javascript:{}" onclick="document.getElementById('log_out').submit();">Log Out</a>
        </form></li>

        <%--            <form id ="view_cart" method="post" action="ViewCart.jsp">--%>
        <%--                <a href="javascript:{}" onclick="document.getElementById('view_cart').submit();">View Cart</a>--%>
        <%--                <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=request.getParameter("currentUserEmail")%>/>--%>
        <%--                <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=request.getParameter("currentUserID")%>/>--%>
        <%--                <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>--%>
        <%--            </form>--%>
      </ul>
    </nav>

    <div class="main content">
      <div class="cart-information">
        <h2 class="page-header">Admin Homepage</h2>
        <h6 class="page-header">Edit Promotions</h6>
        <%-- Table for personal information --%>
        <table class="table">
          <thead class="thead-dark">
          <tr>
            <th scope="col">Code</th>
            <th scope="col">Message</th>
            <th scope="col">Discount</th>
            <th scope="col">Start Date</th>
            <th scope="col">End Date</th>
          </tr>
          </thead>
          <tbody>
          <% while(promotionResults.next()) { %>
          <%--
          <div class="modal fade" id=<%="editPromotion_" + promotionResults.getInt(1)%> tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title">Edit Promotion Inform</h5>
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
                          <input type="text" id="updateFirstName" name="updateFirstName" class="form-input" value="<%=personalResults.getString(6)%>"/>
                        </div>
                        <div class="form-group col-md-6">
                          <label class="form-label" for="updateLastName">Last Name</label>
                          <input type="text" id="updateLastName" name="updateLastName" class="form-input" value="<%=personalResults.getString(7)%>"/>
                        </div>
                      </div>
                      <div class="form-row">
                        <div class="form-group col-md">
                          <label class="form-label" for="updatePhoneNumber">Phone Number</label>
                          <input type="tel" id="updatePhoneNumber" name="updatePhoneNumber" class="form-input" value="<%=personalResults.getString(8)%>"/>
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
          </div>
          --%>

          <tr>
            <td><%=promotionResults.getString(2)%></td>
            <td><%=promotionResults.getString(3)%></td>
            <td><%=promotionResults.getString(4)%></td>
            <td><%=promotionResults.getString(5)%></td>
            <td><%=promotionResults.getString(6)%></td>
            <%--
            <td>
              <button type="button" class="btn btn-primary" data-toggle="modal" data-target=<%="#editPersonal_" + personalResults.getInt(1)%>>
                Edit
              </button>
              <button type="button" class="btn btn-primary" data-toggle="modal" data-target=<%="#editPassword_" + personalResults.getInt(1)%>>
                Edit Password
              </button>
            </td>
            --%>
          </tr>
          <% } %>
          </tbody>
        </table>

        <%-- TODO:  Create add button for promotions --%>

        <h6 class="page-header">Users</h6>
        <%-- Table for address information --%>
        <table class="table">
          <thead class="thead-dark">
          <tr>
            <th scope="col">ID</th>
            <th scope="col">Email</th>
            <th scope="col">First Name</th>
            <th scope="col">Last Name</th>
            <th scope="col">Type</th>
            <th scope="col">Status</th>
            <th scope="col"></th>
          </tr>
          </thead>
          <tbody>
          <%
            while(userResults.next()) {
          %>
          <div class="modal fade" id=<%="editUser_" + userResults.getString(3)%> tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title">Edit User Details</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/AdminHomepage.jsp" method="post">
                  <div class="modal-body">
                    <div class="container">
                      <div class="form-row">
                        <div class="form-group col-md-6">
                          <input type="hidden" id="userEmail" name="userEmail" value="<%=userResults.getString(3)%>"/>
                          <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=request.getParameter("currentUserEmail")%>/>
                          <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=request.getParameter("currentUserID")%>/>
                          <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>
                          <label class="form-label" for="updateType">Type</label>
                          <select id="updateType" name="updateType" class="form-input">
                            <option value="" selected disabled hidden>Type</option>
                            <option value="User">User</option>
                            <option value="Employee">Employee</option>
                            <option value="Admin">Admin</option>
                          </select>
                        </div>
                        <div class="form-group col-md-6">
                          <label class="form-label" for="updateStatus">Status</label>
                          <select id="updateStatus" name="updateStatus" class="form-input">
                            <option value="" selected disabled hidden>Status</option>
                            <option value="Inactive">Inactive</option>
                            <option value="Active">Active</option>
                            <option value="Suspended">Suspended</option>
                          </select>
                        </div>
                      </div>

                    </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary" id="editAddressButton" name="editAddressButton">Save changes</button>
                  </div>
                </form>
              </div>
            </div>
          </div>

          <%--
          <div class="modal fade" id=<%="deleteAddress_" + addressResults.getInt(1)%> tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title">Delete Address</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/EditProfile.jsp" method="post">
                  <div class="modal-body">
                    <div class="container">
                      <div class="form-row">
                        <div class="form-group col-md">
                          <input type="hidden" id="addressID" name="addressID" value="<%=addressResults.getInt(1)%>"/>
                          <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                          <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>
                          <p>Are you sure you want to delete this address?</p>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-danger" name="deleteAddressButton">Delete Address</button>
                  </div>
                </form>
              </div>
            </div>
          </div>
          --%>
          <tr>
            <td><%=userResults.getString(5)%></td>
            <td><%=userResults.getString(3)%></td>
            <td><%=userResults.getString(6)%></td>
            <td><%=userResults.getString(7)%></td>
            <td><%=userResults.getString(1)%></td>
            <td><%=userResults.getString(2)%></td>
            <td>
              <button type="button" class="btn btn-primary" data-toggle="modal" data-target=<%="#editUser_" + userResults.getString(3)%>>
                Edit
              </button>
            </td>
          </tr>
          <% } %>

          </tbody>
        </table>


        <h6 class="page-header">Book Information</h6>
        <%-- Table for book information --%>
        <table class="table">
          <thead class="thead-dark">
          <tr>
            <th scope="col">Quantity</th>
            <th scope="col">ISBN</th>
            <th scope="col">Title</th>
            <th scope="col">Author</th>
            <th scope="col"></th>
          </tr>
          </thead>
          <tbody>
          <%
            while(bookResults.next()) {
          %>
          <div class="modal fade" id=<%="editBook_" + bookResults.getString(2)%> tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
              <div class="modal-content">
                <div class="modal-header">

                  <h5 class="modal-title">Edit Book Information</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/AdminHomepage.jsp" method="post">
                  <div class="modal-body">
                    <div class="container">
                      <div class="form-row">
                        <div class="form-group col-md-2">
                          <input type="hidden" id="ISBN" name="ISBN" value="<%=bookResults.getString(2)%>"/>
                          <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=request.getParameter("currentUserEmail")%>/>
                          <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>
                          <label class="form-label" for="updateQuantity">Quantity</label>
                          <input type="text" id="updateQuantity" name="updateQuantity" class="form-input" value="<%=bookResults.getInt(1)%>"/>
                        </div>
                        <div class="form-group col-md-5">
                          <label class="form-label" for="updateTitle">Title</label>
                          <input type="text" id="updateTitle" name="updateTitle" class="form-input" value="<%=bookResults.getString(3)%>"/>
                        </div>
                        <div class="form-group col-md-5">
                          <label class="form-label" for="updateAuthor">Author</label>
                          <input type="text" id="updateAuthor" name="updateAuthor" class="form-input" value="<%=bookResults.getString(4)%>"/>
                        </div>
                      </div>
                      <div class="form-row">
                        <div class="form-group col-md-3">
                          <label class="form-label" for="updateEdition">Edition</label>
                          <input type="text" id="updateEdition" name="updateEdition" class="form-input" value="<%=bookResults.getString(5)%>"/>
                        </div>
                        <div class="form-group col-md-7">
                          <label class="form-label" for="updatePublisher">Publisher</label>
                          <input type="text" id="updatePublisher" name="updatePublisher" class="form-input" value="<%=bookResults.getString(6)%>"/>
                        </div>
                        <div class="form-group col-md-2">
                          <label class="form-label" for="updateYear">Year</label>
                          <input type="text" id="updateYear" name="updateYear" class="form-input" value="<%=bookResults.getString(7)%>"/>
                        </div>
                      </div>
                      <div class="form-row">
                        <div class="form-group col-md-4">
                          <label class="form-label" for="updateGenre">Genre</label>
                          <select id="updateGenre" name="updateGenre" class="form-input">
                            <option value="" selected disabled hidden>Genre</option>
                            <option value="Action & Adventure">Action & Adventure</option>
                            <option value="Children\'s">Children<span>&#39;</span>s</option>
                            <option value="Classic">Classic</option>
                            <option value="Drama">Drama</option>
                            <option value="Fantasy">Fantasy</option>
                            <option value="Graphic Novel">Graphic Novel</option>
                            <option value="Horror">Horror</option>
                            <option value="Mystery & Crime">Mystery & Crime</option>
                            <option value="Non-Fiction">Non-Fiction</option>
                            <option value="Romance">Romance</option>
                            <option value="Science Fiction">Science Fiction</option>
                          </select>
                        </div>
                        <div class="form-group col-md-8">
                          <label class="form-label" for="updateImage">Image</label>
                          <input type="text" id="updateImage" name="updateImage" class="form-input" value="<%=bookResults.getString(9)%>"/>
                        </div>
                      </div
                      <div class="form-row">
                        <div class="form-group col-md-4">
                          <label class="form-label" for="updateMinThreshold">Minimum Threshold</label>
                          <input type="text" id="updateMinThreshold" name="updateMinThreshold" class="form-input" value="<%=bookResults.getString(10)%>"/>
                        </div>
                        <div class="form-group col-md-4">
                          <label class="form-label" for="updateBuyPrice">Buying Price</label>
                          <input type="text" id="updateBuyPrice" name="updateBuyPrice" class="form-input" value="<%=bookResults.getString(11)%>"/>
                        </div>
                        <div class="form-group col-md-4">
                          <label class="form-label" for="updateSellPrice">Selling Price</label>
                          <input type="text" id="updateSellPrice" name="updateSellPrice" class="form-input" value="<%=bookResults.getString(12)%>"/>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary" name="editBookButton">Save changes</button>
                  </div>
                </form>

              </div>
            </div>
          </div>

          <%-- TODO: Make this the archive book button
          <div class="modal fade" id=<%="deletePayment_" + paymentResults.getInt(1)%> tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title">Delete Payment Information</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/EditProfile.jsp" method="post">
                  <div class="modal-body">
                    <div class="container">
                      <div class="form-row">
                        <div class="form-group col-md">
                          <input type="hidden" id="paymentID" name="paymentID" value="<%=paymentResults.getInt(1)%>"/>
                          <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                          <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>
                          <p>Are you sure you want to delete this payment information?</p>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-danger" name="deletePaymentButton">Delete Payment Information</button>
                  </div>
                </form>
              </div>
            </div>
          </div>
          --%>

          <tr>
            <td><%=bookResults.getString(1)%></td>
            <td><%=bookResults.getString(2)%></td>
            <td><%=bookResults.getString(3)%></td>
            <td><%=bookResults.getString(4)%></td>
            <td>
              <button type="button" class="btn btn-primary" data-toggle="modal" data-target=<%="#editBook_" + bookResults.getString(2)%>>
                Edit
              </button>
              <%--
              <button type="button" class="btn btn-danger" data-toggle="modal" data-target=<%="#deletePayment_" + paymentResults.getInt(1)%>>
                Delete
              </button
              --%>
            </td>
          </tr>

          <% } %>

          </tbody>
        </table>

        <div class="modal fade" id=<%="addBook"%> tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">

                <h5 class="modal-title">Add Book</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/AdminHomepage.jsp" method="post">
                <div class="modal-body">
                  <div class="container">
                    <div class="form-row">
                      <div class="form-group col-md-2">
                        <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=request.getParameter("currentUserEmail")%>/>
                        <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>
                        <label class="form-label" for="updateQuantity">Quantity</label>
                        <input type="text" id="updateQuantity" name="updateQuantity" class="form-input"/>
                      </div>
                      <div class="form-group col-md-5">
                        <label class="form-label" for="updateTitle">Title</label>
                        <input type="text" id="updateTitle" name="updateTitle" class="form-input"/>
                      </div>
                      <div class="form-group col-md-5">
                        <label class="form-label" for="updateAuthor">Author</label>
                        <input type="text" id="updateAuthor" name="updateAuthor" class="form-input"/>
                      </div>
                    </div>
                    <div class="form-row">
                      <div class="form-group col-md-3">
                        <label class="form-label" for="updateEdition">Edition</label>
                        <input type="text" id="updateEdition" name="updateEdition" class="form-input""/>
                      </div>
                      <div class="form-group col-md-7">
                        <label class="form-label" for="updatePublisher">Publisher</label>
                        <input type="text" id="updatePublisher" name="updatePublisher" class="form-input"/>
                      </div>
                      <div class="form-group col-md-2">
                        <label class="form-label" for="updateYear">Year</label>
                        <input type="text" id="updateYear" name="updateYear" class="form-input"/>
                      </div>
                    </div>
                    <div class="form-row">
                      <div class="form-group col-md-4">
                        <label class="form-label" for="updateGenre">Genre</label>
                        <select id="updateGenre" name="updateGenre" class="form-input">
                          <option value="" selected disabled hidden>Genre</option>
                          <option value="Action & Adventure">Action & Adventure</option>
                          <option value="Children\'s">Children<span>&#39;</span>s</option>
                          <option value="Classic">Classic</option>
                          <option value="Drama">Drama</option>
                          <option value="Fantasy">Fantasy</option>
                          <option value="Graphic Novel">Graphic Novel</option>
                          <option value="Horror">Horror</option>
                          <option value="Mystery & Crime">Mystery & Crime</option>
                          <option value="Non-Fiction">Non-Fiction</option>
                          <option value="Romance">Romance</option>
                          <option value="Science Fiction">Science Fiction</option>
                        </select>
                      </div>
                      <div class="form-group col-md-8">
                        <label class="form-label" for="updateImage">Image</label>
                        <input type="text" id="updateImage" name="updateImage" class="form-input"/>
                      </div>
                    </div
                    <div class="form-row">
                      <div class="form-group col-md-4">
                        <label class="form-label" for="updateMinThreshold">Minimum Threshold</label>
                        <input type="text" id="updateMinThreshold" name="updateMinThreshold" class="form-input"/>
                      </div>
                      <div class="form-group col-md-4">
                        <label class="form-label" for="updateBuyPrice">Buying Price</label>
                        <input type="text" id="updateBuyPrice" name="updateBuyPrice" class="form-input"/>
                      </div>
                      <div class="form-group col-md-4">
                        <label class="form-label" for="updateSellPrice">Selling Price</label>
                        <input type="text" id="updateSellPrice" name="updateSellPrice" class="form-input"/>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                  <button type="submit" class="btn btn-primary" name="editPaymentButton">Save changes</button>
                </div>
              </form>

            </div>
          </div>
          <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addBook">
            Add
          </button>
        </div>

      </div>
    </div>
  </main>
</div>
  <%
        } catch (SQLException e){
            //out.println("<p>Unsuccessful connection to database</p>");
            e.printStackTrace();
        }
%>
</html>
