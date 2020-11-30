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
  <title>Admin Homepage</title>
</head>
<body>
  <%
//    if(request.getParameter("currentUserEmail") == null) {
//        String redirect = new String("/Bookstore_Project_4050_war_exploded/Login.jsp");
//        response.setStatus(response.SC_MOVED_TEMPORARILY);
//       response.setHeader("Location", redirect);
//    } //checks if the user is already logged in
        String userEmail = "";
        String userType = "";
        String userID = "";
        if(request.getParameter("currentUserEmail") != null ){
            userEmail = request.getParameter("currentUserEmail").replaceAll("/","");
            userType = request.getParameter("currentUserType").replaceAll("/","");
            userID = request.getParameter("currentUserID").replaceAll("/","");
        }
        String dbURL = "jdbc:mysql://localhost:3306/bookstore?serverTimezone=EST";
        String dbUsername = "root";
        String dbPassword = "Hakar123";

        try {
            Connection connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

            if(request.getParameter("editBookButton") != null) {
                String updateBookQuery = "UPDATE Books SET Quantity = ?, Title = ?, Author = ?, Edition = ?, Publisher = ?, Year = ?, Genre = ?, Image = ?, MinThreshold = ?, BuyPrice = ?, SellPrice = ? WHERE ISBN = ? ";
                PreparedStatement updateBookQuery_pmst = connection.prepareStatement(updateBookQuery);
                updateBookQuery_pmst.setInt(1, (int)Integer.parseInt(request.getParameter("updateQuantity")));
                updateBookQuery_pmst.setString(2, request.getParameter("updateTitle"));
                updateBookQuery_pmst.setString(3, request.getParameter("updateAuthor"));
                updateBookQuery_pmst.setInt(4, (int)Integer.parseInt(request.getParameter("updateEdition")));
                updateBookQuery_pmst.setString(5, request.getParameter("updatePublisher"));
                updateBookQuery_pmst.setString(6, request.getParameter("updateYear"));
                updateBookQuery_pmst.setInt(7, (int)Integer.parseInt(request.getParameter("updateGenre")));
                updateBookQuery_pmst.setString(8, request.getParameter("updateImage"));
                updateBookQuery_pmst.setDouble(9, (double)Double.parseDouble(request.getParameter("updateMinThreshold")));
                updateBookQuery_pmst.setDouble(10, (double)Double.parseDouble(request.getParameter("updateBuyPrice")));
                updateBookQuery_pmst.setDouble(11, (double)Double.parseDouble(request.getParameter("updateSellPrice")));
                updateBookQuery_pmst.setString(12, request.getParameter("ISBN"));
                updateBookQuery_pmst.executeUpdate();

            } else if(request.getParameter("archiveBookButton") != null) {
                String archiveBookQuery = "UPDATE Books SET IsArchived = 1 WHERE ISBN = ? ";
                PreparedStatement archiveBookQuery_pmst = connection.prepareStatement(archiveBookQuery);
                archiveBookQuery_pmst.setString(1, request.getParameter("ISBN"));
                archiveBookQuery_pmst.executeUpdate();

            } else if(request.getParameter("addBookButton") != null) {
                String newBookQuery = "INSERT INTO Books (Quantity, ISBN, Title, Author, Edition, Publisher, Year, Genre, Image, MinThreshold, BuyPrice, SellPrice) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
                PreparedStatement newBookQuery_pmst = connection.prepareStatement(newBookQuery);
                newBookQuery_pmst.setInt(1, (int)Integer.parseInt(request.getParameter("updateQuantity")));
                newBookQuery_pmst.setString(2, request.getParameter("newISBN"));
                newBookQuery_pmst.setString(3, request.getParameter("updateTitle"));
                newBookQuery_pmst.setString(4, request.getParameter("updateAuthor"));
                newBookQuery_pmst.setInt(5, (int)Integer.parseInt(request.getParameter("updateEdition")));
                newBookQuery_pmst.setString(6, request.getParameter("updatePublisher"));
                newBookQuery_pmst.setString(7, request.getParameter("updateYear"));
                newBookQuery_pmst.setInt(8, (int)Integer.parseInt(request.getParameter("updateGenre")));
                newBookQuery_pmst.setString(9, request.getParameter("updateImage"));
                newBookQuery_pmst.setDouble(10, (double)Double.parseDouble(request.getParameter("updateMinThreshold")));
                newBookQuery_pmst.setDouble(11, (double)Double.parseDouble(request.getParameter("updateBuyPrice")));
                newBookQuery_pmst.setDouble(12, (double)Double.parseDouble(request.getParameter("updateSellPrice")));
                newBookQuery_pmst.executeUpdate();

            } else if(request.getParameter("editUserButton") != null) {
                String updateUserQuery = "UPDATE Users SET Type = ?, Status = ? WHERE Email = ? ";
                PreparedStatement updateUserQuery_pmst = connection.prepareStatement(updateUserQuery);
                updateUserQuery_pmst.setInt(1, (int)Integer.parseInt(request.getParameter("updateType")));
                updateUserQuery_pmst.setInt(2, (int)Integer.parseInt(request.getParameter("updateStatus")));
                updateUserQuery_pmst.setString(3, request.getParameter("email"));
                updateUserQuery_pmst.executeUpdate();

            } else if(request.getParameter("addPromotionButton") != null) {
                String addPromotionQuery = "INSERT INTO Promotions (Code, Message, Discount, Start, End) VALUES (?, ?, ?, ?, ?) ";
                PreparedStatement addPromotionQuery_pmst = connection.prepareStatement(addPromotionQuery);
                addPromotionQuery_pmst.setString(1, request.getParameter("addCode"));
                addPromotionQuery_pmst.setString(2, request.getParameter("addMessage"));
                addPromotionQuery_pmst.setInt(3, (int)Integer.parseInt(request.getParameter("addDiscount")));
                addPromotionQuery_pmst.setString(4, request.getParameter("addStart"));
                addPromotionQuery_pmst.setString(5, request.getParameter("addEnd"));
                addPromotionQuery_pmst.executeUpdate();

                String emailQuery = "SELECT Email FROM Users WHERE Status = 1 AND Notifications = 1";
                PreparedStatement email_pmst = connection.prepareStatement(emailQuery);
                ResultSet emailResults = email_pmst.executeQuery();
                while(emailResults.next()) {
                  String to = emailResults.getString(1);
                  String from = "bookstore.helper@gmail.com";

                  Properties prop = System.getProperties();
                  prop.put("mail.smtp.host", "smtp.gmail.com");
                  prop.put("mail.smtp.port", "587");
                  prop.put("mail.smtp.starttls.enable", "true");
                  prop.put("mail.smtp.auth", "true");
                  prop.put("mail.smtp.ssl.trust", "*");
                  final String emailUsername = "bookstore.helper@gmail.com";
                  final String emailPassword = "oeprimytgjyhvsbc";

                  Session sess = Session.getInstance(prop, new javax.mail.Authenticator() {
                      protected PasswordAuthentication getPasswordAuthentication() {
                          return new PasswordAuthentication(emailUsername, emailPassword);
                      }
                  });

                  try {
                      MimeMessage context = new MimeMessage(sess);
                      InternetAddress fromIA = new InternetAddress(from);
                      context.setFrom(from);
                      if (to != null) {
                          InternetAddress toIA = new InternetAddress(to);
                          context.addRecipient(Message.RecipientType.TO, toIA);

                          context.setSubject("New Bookstore Promotion!");
                          context.setText(request.getParameter("addMessage") + "\n\n Discount Percentage: " + request.getParameter("addDiscount") + "%\n Code: " + request.getParameter("addCode") + "\n Start Date: " + request.getParameter("addStart") + "\n End Date: " + request.getParameter("addEnd"));
                          System.out.println("sending email...");
                          Transport.send(context);
                          System.out.println("Message sent successfully.");
                      }
                  } catch (MessagingException mE) {
                      mE.printStackTrace();
                  }
                }

            }

            String promotionQuery = "SELECT * FROM Promotions "; //get a list of all promotions
            PreparedStatement promotion_pmst = connection.prepareStatement(promotionQuery);
            ResultSet promotionResults = promotion_pmst.executeQuery();

            String bookQuery = "SELECT * FROM Books WHERE IsArchived = 0 "; //get a list of all books
            PreparedStatement book_pmst = connection.prepareStatement(bookQuery);
            ResultSet bookResults = book_pmst.executeQuery();

            String userQuery = "SELECT * FROM Users "; //get a list of all users
            PreparedStatement user_pmst = connection.prepareStatement(userQuery);
            ResultSet userResults = user_pmst.executeQuery();

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
          <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
          <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=userType%>/>
          <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=userID%>/>
        </form></li>
        <li><form class= "view_cart" id ="view_cart" method="post" action="ViewCart.jsp">
          <a href="javascript:{}" onclick="document.getElementById('view_cart').submit();">Cart</a>
          <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=request.getParameter("currentUserEmail")%>/>
          <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=request.getParameter("currentUserID")%>/>
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
          <tr>
            <td><%=promotionResults.getString(1)%></td>
            <td><%=promotionResults.getString(2)%></td>
            <td><%=promotionResults.getString(3)%></td>
            <td><%=promotionResults.getString(4)%></td>
            <td><%=promotionResults.getString(5)%></td>
          </tr>
          <% } %>
          </tbody>
        </table>

        <div class="modal fade" id="addPromotion" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title">Add Promotion</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/AdminHomepage.jsp" method="post">
                <div class="modal-body">
                  <div class="container">
                    <div class="form-row">
                      <div class="form-group col-md-4">
                        <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=userID%>/>
                        <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                        <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=userType%>/>
                        <label class="form-label" for="addCode">Code</label>
                        <input type="text" id="addCode" name="addCode" class="form-input"/>
                      </div>
                      <div class="form-group col-md-8">
                        <label class="form-label" for="addMessage">Message</label>
                        <input type="text" id="addMessage" name="addMessage" class="form-input"/>
                      </div>
                    </div>
                    <div class="form-row">
                      <div class="form-group col-md-4">
                        <label class="form-label" for="addDiscount">Discount</label>
                        <input type="text" id="addDiscount" name="addDiscount" class="form-input"/>
                      </div>
                      <div class="form-group col-md-4">
                        <label class="form-label" for="addStart">Start Date</label>
                        <input type="text" id="addStart" name="addStart" class="form-input"/>
                      </div>
                      <div class="form-group col-md-4">
                        <label class="form-label" for="addEnd">End Date</label>
                        <input type="text" id="addEnd" name="addEnd" class="form-input"/>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                  <button type="submit" class="btn btn-primary" name="addPromotionButton">Add Promotion</button>
                </div>
              </form>
            </div>
          </div>
        </div>
        <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addPromotion">
          Add
        </button>

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
            int i = 0;
            while(userResults.next()) {
          %>
          <!-- Modal -->
          <div class="modal fade" id=<%="editUser_" + i%> tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">Edit User</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/AdminHomepage.jsp" method="post">
                  <div class="modal-body">
                    <div class="container">
                      <div class="form-row">
                        <div class="form-group col-md-6">
                          <input type="hidden" id="email" name="email" value="<%=userResults.getString(3)%>"/>
                          <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=userID%>/>
                          <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                          <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=userType%>/>
                          <label class="form-label" for="updateType">Type</label>
                          <select id="updateType" name="updateType" class="form-input" required>
                            <option value="" selected disabled hidden>Type</option>
                            <option value=0>User</option>
                            <option value=1>Employee</option>
                            <option value=2>Admin</option>
                          </select>
                        </div>
                        <div class="form-group col-md-6">
                          <label class="form-label" for="updateStatus">Status</label>
                          <select id="updateStatus" name="updateStatus" class="form-input" required>
                            <option value="" selected disabled hidden>Status</option>
                            <option value=0>Inactive</option>
                            <option value=1>Active</option>
                            <option value=2>Suspended</option>
                          </select>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary" id="editUserButton" name="editUserButton">Save changes</button>
                  </div>
                </form>
              </div>
            </div>
          </div>

          <tr>
            <td><%=userResults.getString(5)%></td>
            <td><%=userResults.getString(3)%></td>
            <td><%=userResults.getString(6)%></td>
            <td><%=userResults.getString(7)%></td>
            <td>
              <%if(userResults.getInt(1) == 0) {
              %>User<%
            } else if(userResults.getInt(1) == 1) {
            %>Employee<%
            } else if(userResults.getInt(1) == 2) {
            %>Administrator<%
            } else if(userResults.getInt(1) == 3) {
            %>System Admininistrator<%
            } else {
            %>Invalid<%
              }%>
            </td>
            <td>
              <%if(userResults.getInt(2) == 0) {
              %>Inactive<%
            } else if(userResults.getInt(2) == 1) {
            %>Active<%
            } else if(userResults.getInt(2) == 2) {
            %>Suspended<%
            } else {
            %>Invalid<%
              }%>
            </td>
            <td>
              <button type="button" class="btn btn-primary" data-toggle="modal" data-target=<%="#editUser_" + i%>>
                Edit
              </button>
            </td>
          </tr>

          <% i++;
            } %>

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
            <div class="modal-dialog modal-lg" role="document">
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
                          <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=userID%>/>
                          <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
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
                          <select id="updateGenre" name="updateGenre" class="form-input" required>
                            <option value="" selected disabled hidden>Genre</option>
                            <option value=1>Action & Adventure</option>
                            <option value=2>Children<span>&#39;</span>s</option>
                            <option value=3>Classic</option>
                            <option value=4>Drama</option>
                            <option value=5>Fantasy</option>
                            <option value=6>Graphic Novel</option>
                            <option value=7>Horror</option>
                            <option value=8>Mystery & Crime</option>
                            <option value=9>Non-Fiction</option>
                            <option value=10>Romance</option>
                            <option value=11>Science Fiction</option>
                          </select>
                        </div>
                        <div class="form-group col-md-8">
                          <label class="form-label" for="updateImage">Image</label>
                          <input type="text" id="updateImage" name="updateImage" class="form-input" value="<%=bookResults.getString(9)%>"/>
                        </div>
                      </div>
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

          <div class="modal fade" id=<%="archiveBook_" + bookResults.getString(2)%> tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title">Archive Book</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/AdminHomepage.jsp" method="post">
                  <div class="modal-body">
                    <div class="container">
                      <div class="form-row">
                        <div class="form-group col-md">
                          <input type="hidden" id="ISBN" name="ISBN" value="<%=bookResults.getString(2)%>"/>
                          <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=userID%>/>
                          <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                          <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=userType%>/>
                          <p>Are you sure you want to archive this book?</p>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-danger" name="archiveBookButton">Archive Book</button>
                  </div>
                </form>
              </div>
            </div>
          </div>

          <tr>
            <td><%=bookResults.getString(1)%></td>
            <td><%=bookResults.getString(2)%></td>
            <td><%=bookResults.getString(3)%></td>
            <td><%=bookResults.getString(4)%></td>
            <td>
              <button type="button" class="btn btn-primary" data-toggle="modal" data-target=<%="#editBook_" + bookResults.getString(2)%>>
                Edit
              </button>
              <button type="button" class="btn btn-danger" data-toggle="modal" data-target=<%="#archiveBook_" + bookResults.getString(2)%>>
                Archive
              </button>

            </td>
          </tr>

          <% } %>

          </tbody>
        </table>

        <div class="modal fade" id=<%="addBook"%> tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog  modal-lg" role="document">
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
                    <div class="form-row ">
                      <div class="form-group col-md-12">
                        <label class="form-label" for="newISBN">ISBN</label>
                        <input type="text" id="newISBN" name="newISBN" class="form-input"/>
                      </div>
                    </div>
                    <div class="form-row">
                      <div class="form-group col-md-2">
                        <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=userID%>/>
                        <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                        <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=userType%>/>
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
                          <option value=1>Action & Adventure</option>
                          <option value=2>Children<span>&#39;</span>s</option>
                          <option value=3>Classic</option>
                          <option value=4>Drama</option>
                          <option value=5>Fantasy</option>
                          <option value=6>Graphic Novel</option>
                          <option value=7>Horror</option>
                          <option value=8>Mystery & Crime</option>
                          <option value=9>Non-Fiction</option>
                          <option value=10>Romance</option>
                          <option value=11>Science Fiction</option>
                        </select>
                      </div>
                      <div class="form-group col-md-8">
                        <label class="form-label" for="updateImage">Image</label>
                        <input type="text" id="updateImage" name="updateImage" class="form-input"/>
                      </div>
                    </div>
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
                  <button type="submit" class="btn btn-primary" name="addBookButton">Save changes</button>
                </div>
              </form>
            </div>
          </div>
        </div>
        <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addBook">
          Add
        </button>

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
