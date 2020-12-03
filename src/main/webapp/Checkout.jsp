<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@page import="java.util.*"%>
<%@page import="java.time.*"%>
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
    String dbPassword = "WebProg2020";
    Boolean appliedPromo = false;
    int discountedAmount = 0;
    double subtotal = 0; //for the subtotal
    double total = 0; //for the total
    int confirmationNum = 0;

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

        if(request.getParameter("addAddressButton") != null) {
            String addAddressQuery = "INSERT INTO Address (User, Street, City, State, Zipcode) VALUES (?, ?, ?, ?, ?) ";
            PreparedStatement addAddressQuery_pmst = connection.prepareStatement(addAddressQuery);
            addAddressQuery_pmst.setString(1, userEmail);
            addAddressQuery_pmst.setString(2, request.getParameter("addStreetAddress"));
            addAddressQuery_pmst.setString(3, request.getParameter("addCity"));
            addAddressQuery_pmst.setString(4, request.getParameter("addState"));
            addAddressQuery_pmst.setInt(5, (int)Integer.parseInt(request.getParameter("addZipCode")));
            addAddressQuery_pmst.executeUpdate();

        } else if(request.getParameter("addPaymentButton") != null) {
            String addPaymentQuery = "INSERT INTO Payment (User, Type, Number, Expiration, CVV) VALUES (?, ?, ?, ?, ?) ";
            PreparedStatement addPaymentQuery_pmst = connection.prepareStatement(addPaymentQuery);
            addPaymentQuery_pmst.setString(1, userEmail);
            addPaymentQuery_pmst.setString(2, request.getParameter("addCardType"));
            String cardNumber = request.getParameter("addCardNumber");
            String first12 = cardNumber.substring(0,12);
            String last4 = cardNumber.substring(12);
            String hashedFirst12 = DigestUtils.sha256Hex(first12);
            String hashedPayment = hashedFirst12 + last4;
            addPaymentQuery_pmst.setString(3, hashedPayment);
            addPaymentQuery_pmst.setString(4, request.getParameter("addExpirationDate"));
            addPaymentQuery_pmst.setInt(5, (int)Integer.parseInt(request.getParameter("addCVV")));
            addPaymentQuery_pmst.executeUpdate();

        } else if(request.getParameter("checkoutButton") != null){
            // TODO implement confirmation number
            Random random = new Random();
            confirmationNum = random.nextInt((9000000 - 1000000) + 1) + 1000000;
            String addressID = request.getParameter("selectedAddress");
            String paymentID = request.getParameter("selectedPayment");
            LocalDateTime dTholder = java.time.LocalDateTime.now();
            String dateAndTime = ""+ dTholder;
            String checkoutQuery = "INSERT INTO Orders (User, Address, Payment, Confirmation, Total, Date) VALUES (?, ?, ?, ?, ?, ?) ";
            PreparedStatement checkoutQuery_pmst = connection.prepareStatement(checkoutQuery);
            checkoutQuery_pmst.setInt(1, (int)Integer.parseInt(userID));
            checkoutQuery_pmst.setInt(2, (int)Integer.parseInt(addressID));
            checkoutQuery_pmst.setInt(3, (int)Integer.parseInt(paymentID));
            checkoutQuery_pmst.setInt(4, confirmationNum);
            checkoutQuery_pmst.setDouble(5, Double.parseDouble(request.getParameter("total").replaceAll("/","")));
            checkoutQuery_pmst.setString(6, dateAndTime);
            checkoutQuery_pmst.executeUpdate();

            String cart = "SELECT User, Book, SUM(Cart.Quantity) as Cart_Quantity, " +
                    "B.Quantity as Store_Quantity " +
                    "FROM Cart " +
                    "LEFT JOIN Books B on Cart.Book = B.ISBN " +
                    "WHERE User = ? " +
                    "GROUP BY User, Book ";
            PreparedStatement cart_pmst = connection.prepareStatement(cart, ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            cart_pmst.setInt(1, (int)Integer.parseInt(userID));
            ResultSet cartResults = cart_pmst.executeQuery();

            int orderID = 0;
            while(cartResults.next()) {
                String updateStoreQuery = "UPDATE Books SET Quantity = ? WHERE ISBN = ? ";
                PreparedStatement updateStore_pmst = connection.prepareStatement(updateStoreQuery);
                updateStore_pmst.setInt(1, cartResults.getInt(4) - cartResults.getInt(3));
                updateStore_pmst.setString(2, cartResults.getString(2));
                updateStore_pmst.executeUpdate();

                String getOrderID = "SELECT ID FROM Orders WHERE Confirmation = ? ";
                PreparedStatement orderID_pmst = connection.prepareStatement(getOrderID);
                orderID_pmst.setInt(1, confirmationNum);
                ResultSet orderIDResults = orderID_pmst.executeQuery();
                orderIDResults.next();
                orderID = orderIDResults.getInt(1);

                String addSale = " INSERT INTO Sales (OrderID, Book, Quantity) Values (?, ?, ?)";
                PreparedStatement addSale_pmst = connection.prepareStatement(addSale);
                addSale_pmst.setInt(1, orderID);
                addSale_pmst.setString(2, cartResults.getString(2));
                addSale_pmst.setInt(3, cartResults.getInt(3));
                addSale_pmst.executeUpdate();
            }
            String updateCartQuery = "DELETE FROM Cart WHERE User = ?";
            PreparedStatement updateCartQuery_pmst = connection.prepareStatement(updateCartQuery);
            updateCartQuery_pmst.setInt(1, (int)Integer.parseInt(userID));
            updateCartQuery_pmst.executeUpdate();

            String to = userEmail;
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

            String nameQuery = "SELECT FirstName FROM Users WHERE ID = ?";
            PreparedStatement name_pmst = connection.prepareStatement(nameQuery);
            name_pmst.setInt(1, (int)Integer.parseInt(userID));
            ResultSet nameResults = name_pmst.executeQuery();
            String firstname = "";
            if(nameResults.next()) {
                firstname = nameResults.getString(1);
            }

            String addressQuery = "SELECT Street FROM Address WHERE ID = ?";
            PreparedStatement address_pmst = connection.prepareStatement(addressQuery);
            address_pmst.setInt(1, (int)Integer.parseInt(addressID));
            ResultSet addressResults2 = address_pmst.executeQuery();
            String street = "";
            if(addressResults2.next()) {
                street = addressResults2.getString(1);
            }

            String books = "SELECT B.Title FROM Sales LEFT JOIN Books B on Sales.Book = B.ISBN LEFT JOIN Orders O on Sales.OrderID = O.ID WHERE OrderID = ? ";
            PreparedStatement books_pmst = connection.prepareStatement(books);
            books_pmst.setInt(1, orderID);
            ResultSet titleResults = books_pmst.executeQuery();
            String contents = "";
            while(titleResults.next()) {
                contents += titleResults.getString(1) + ", ";
            }
            contents = contents.substring(0, contents.length() - 2);

            try {
                MimeMessage context = new MimeMessage(sess);
                InternetAddress fromIA = new InternetAddress(from);
                context.setFrom(from);
                if(to != null){
                    String content = "Hi " + firstname + ", \n\n";
                    content += "Thanks for shopping at our online bookstore!  The following are your order details: \n\n";
                    content += "Confirmation number: " + confirmationNum + "\n";
                    content += "Order ID: " + orderID + "\n";
                    content += "Order Date: " + dateAndTime.substring(0,10) + "\n";
                    content += "Order Time: " + dateAndTime.substring(11,16) + "\n";
                    content += "Price: $" + Double.parseDouble(request.getParameter("total").replaceAll("/","")) + "\n";
                    content += "Contents: " + contents + "\n";
                    content += "Shipping to: " + street + "\n";
                    InternetAddress toIA = new InternetAddress(to);
                    context.addRecipient(Message.RecipientType.TO, toIA);
                    context.setSubject("Thanks for your order!");
                    context.setText(content);
                    System.out.println("sending email...");
                    Transport.send(context);
                    System.out.println("Message sent successfully.");
                }
            } catch (MessagingException mE) {
                mE.printStackTrace();
            }

        } else if(request.getParameter("applyPromoButton") != null){
            String userPromo = request.getParameter("promotion").replaceAll("/","");
            String promoCheckQuery = "SELECT * FROM Promotions "; //get a list of usernames of the logged in user
            PreparedStatement promoCheck_pmst = connection.prepareStatement(promoCheckQuery);
            ResultSet promoResults = promoCheck_pmst.executeQuery();

            while(promoResults.next()){
                String promo = promoResults.getString(1);
                if(userPromo.equals(promo)){
                    appliedPromo = true;
                    discountedAmount = promoResults.getInt(3);
                }
            }
        }

        String cart = "SELECT User, Book, SUM(Cart.Quantity) as Cart_Quantity, B.Quantity as Store_Quantity, Title, Author, Edition, Publisher, Year, Genre, Image, SellPrice, Rating FROM cart LEFT JOIN Books B on Cart.Book = B.ISBN WHERE user = ? GROUP BY User, Book ";
        PreparedStatement cart_pmst = connection.prepareStatement(cart, ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_UPDATABLE);
        cart_pmst.setInt(1, (int)Integer.parseInt(userID));
        System.out.println(userID);
        ResultSet cartResults = cart_pmst.executeQuery();

        String address = "SELECT * FROM Address WHERE User = ? and IsArchived = 0 "; //get a list of usernames of the logged in user
        PreparedStatement address_pmst = connection.prepareStatement(address);
        address_pmst.setString(1, userEmail);
        ResultSet addressResults = address_pmst.executeQuery();

        String payment = "SELECT * FROM Payment WHERE User = ? and IsArchived = 0 "; //get a list of payments of the logged in user
        PreparedStatement payment_pmst = connection.prepareStatement(payment);
        payment_pmst.setString(1, userEmail);
        ResultSet paymentResults = payment_pmst.executeQuery();


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
                        <li><form class= "view_cart" id ="view_cart" method="post" action="ViewCart.jsp">
                            <a href="javascript:{}" onclick="document.getElementById('view_cart').submit();">Cart</a>
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
                <h1 class="page-header">Checkout</h1>
                <%if(cartResults.next()){
                    cartResults.beforeFirst();
                %>
                <table class="table">
                    <tbody>
                    <h4 style="text-align: center">Cart</h4>
                    <%while(cartResults.next()) {
                               subtotal+= cartResults.getInt(3)*cartResults.getDouble(12);%>
                            <tr>
                                <td class="listUser">Quantity: <%=cartResults.getInt(3)%></td>
                                <td class="listUser"><img src=<%=cartResults.getString(11)%> width="90" height="140"></td>
                                <td class="listUser"><%=cartResults.getString(5)%> <br><br>by <%=cartResults.getString(6)%></td>
                                <td class="listUser">$<%=cartResults.getDouble(12)%> <br><br> <%=cartResults.getInt(13)%>/5</td>
                            </tr>
                        <%}%>
                    </tbody>
                </table>
                <h4 style="text-align: center">Address Information</h4>
                <%-- Table for address information --%>
                <form method="post" action="Checkout.jsp">
                    <table class="table">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col" class="listUser">Street Address</th>
                                <th scope="col" class="listUser">City</th>
                                <th scope="col" class="listUser">State</th>
                                <th scope="col" class="listUser">Zip Code</th>
                                <th scope="col" class="listUser"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <%int countAddressRows = 0;
                            while(addressResults.next()) {
                                countAddressRows++;%>
                                <tr>
                                    <td class="listUser"><%=addressResults.getString(3)%></td>
                                    <td class="listUser"><%=addressResults.getString(4)%></td>
                                    <td class="listUser"><%=addressResults.getString(5)%></td>
                                    <td class="listUser"><%=addressResults.getString(6)%></td>
                                    <td class="listUser">
                                          <input type="radio" id="selectedAddress" name="selectedAddress" value=<%=addressResults.getInt(1)%>>
                                    </td>
                                </tr>
                            <%}%>
                        </tbody>
                    </table>
                    <% if(countAddressRows < 3) { %>
                        <button type="button" style="display: block; margin: auto;" class="btn btn-success" data-toggle="modal" data-target="#addAddress">
                            Add
                        </button>
                    <%}%>
                    <br>
                    <br>
                    <h4 style="text-align: center">Payment Information</h4>
                    <%-- Table for payment information --%>
                    <table class="table">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col" class="listUser">Card Type</th>
                                <th scope="col" class="listUser">Card Number</th>
                                <th scope="col" class="listUser">Expiration Date</th>
                                <th scope="col" class="listUser">CVV</th>
                                <th scope="col" class="listUser"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <%int countPaymentRows = 0;
                            while(paymentResults.next()) {
                                countPaymentRows++;%>
                                <tr>
                                    <td class="listUser"><%=paymentResults.getString(3)%></td>
                                    <%String result = paymentResults.getString(4);
                                        result = result.substring(64);
                                        String cardNumber = "xxxxxxxxxxxx" + result;%>
                                    <td class="listUser"><%=cardNumber%></td>
                                    <td class="listUser"><%=paymentResults.getString(5)%></td>
                                    <td class="listUser"><%=paymentResults.getString(6)%></td>
                                    <td class="listUser">
                                        <input type="radio" id="selectedPayment" name="selectedPayment" value=<%=paymentResults.getInt(1)%>>
                                    </td>
                                </tr>
                            <%}%>
                        </tbody>
                    </table>

                    <% if(countPaymentRows < 3) { %>
                        <button type="button" style="display: block; margin: auto;" class="btn btn-success" data-toggle="modal" data-target="#addPayment" >
                            Add
                        </button>
                    <%}%>
                    <br>
                    <br>
                <%-- end of payment--%>

                    <div style="margin-top: 5%;">
                        Promotions:<input type="text" id="promotion" name="promotion" class="form-input" style="width:25%"<%if(appliedPromo){%> disabled <%}%>/>
                        <button type="submit" class="btn btn-outline-secondary btn-sm" name="applyPromoButton" id="applyPromoButton" <%if(appliedPromo){%> disabled <%}%>
                        formaction="">
                            Apply
                        </button>
                        <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                        <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=userType%>/>
                        <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=userID%>/>
                        <br>
                        Subtotal: $<%=subtotal%>
                        <%if(appliedPromo){ total = subtotal - (subtotal * discountedAmount)/100;%>
                        <p style="color:red">Discount: $<%=subtotal * discountedAmount/100%></p>
                        Total: $<%=total%><br>
                        <%} else {
                            total = subtotal;
                        }%>
                    </div>
                    <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                    <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>
                    <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=userID%>/>
                    <input type="hidden" id="total" name="total" class="form-input" value = <%=total%>/>

                    <button type="submit" id="checkoutButton" name="checkoutButton" class="btn btn-success" onclick="check()">
                    Check Out
                    </button>
                    <script>
                        function check(){
                            document.getElementById("selectedAddress").required = true;
                            document.getElementById("selectedPayment").required = true;
                        }
                    </script>
                </form>


                <div class="modal fade" id="addAddress" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Add Address Information</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/Checkout.jsp" method="post">
                                <div class="modal-body">
                                    <div class="container">
                                        <div class="form-row">
                                            <div class="form-group col-md">
                                                <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                                                <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=userType%>/>
                                                <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=userID%>/>
                                                <label class="form-label" for="addStreetAddress">Address</label>
                                                <input type="text" id="addStreetAddress" name="addStreetAddress" class="form-input" pattern="\d+\s[A-z]+\s[A-z]+" title="Add a valid street address"/>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-5">
                                                <label class="form-label" for="addCity">City</label>
                                                <input type="text" id="addCity" name="addCity" class="form-input" pattern="[A-Za-z]{2,}" title="Enter the name of a valid city"/>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label class="form-label" for="addState">State</label>
                                                <select id="addState" name="addState" class="form-input">
                                                    <option value="Alabama">Alabama</option>
                                                    <option value="Alaska">Alaska</option>
                                                    <option value="Arizona">Arizona</option>
                                                    <option value="Arkansas">Arkansas</option>
                                                    <option value="California">California</option>
                                                    <option value="Colorado">Colorado</option>
                                                    <option value="Connecticut">Connecticut</option>
                                                    <option value="Delaware">Delaware</option>
                                                    <option value="District Of Columbia">District Of Columbia</option>
                                                    <option value="Florida">Florida</option>
                                                    <option value="Georgia">Georgia</option>
                                                    <option value="Hawaii">Hawaii</option>
                                                    <option value="Idaho">Idaho</option>
                                                    <option value="Illinois">Illinois</option>
                                                    <option value="Indiana">Indiana</option>
                                                    <option value="Iowa">Iowa</option>
                                                    <option value="Kansas">Kansas</option>
                                                    <option value="Kentucky">Kentucky</option>
                                                    <option value="Louisiana">Louisiana</option>
                                                    <option value="Maine">Maine</option>
                                                    <option value="Maryland">Maryland</option>
                                                    <option value="Massachusetts">Massachusetts</option>
                                                    <option value="Michigan">Michigan</option>
                                                    <option value="Minnesota">Minnesota</option>
                                                    <option value="Mississippi">Mississippi</option>
                                                    <option value="Missouri">Missouri</option>
                                                    <option value="Montana">Montana</option>
                                                    <option value="Nebraska">Nebraska</option>
                                                    <option value="Nevada">Nevada</option>
                                                    <option value="New Hampshire">New Hampshire</option>
                                                    <option value="New Jersey">New Jersey</option>
                                                    <option value="New Mexico">New Mexico</option>
                                                    <option value="New York">New York</option>
                                                    <option value="North Carolina">North Carolina</option>
                                                    <option value="North Dakota">North Dakota</option>
                                                    <option value="Ohio">Ohio</option>
                                                    <option value="Oklahoma">Oklahoma</option>
                                                    <option value="Oregon">Oregon</option>
                                                    <option value="Pennsylvania">Pennsylvania</option>
                                                    <option value="Rhode Island">Rhode Island</option>
                                                    <option value="South Carolina">South Carolina</option>
                                                    <option value="South Dakota">South Dakota</option>
                                                    <option value="Tennessee">Tennessee</option>
                                                    <option value="Texas">Texas</option>
                                                    <option value="Utah">Utah</option>
                                                    <option value="Vermont">Vermont</option>
                                                    <option value="Virginia">Virginia</option>
                                                    <option value="Washington">Washington</option>
                                                    <option value="West Virginia">West Virginia</option>
                                                    <option value="Wisconsin">Wisconsin</option>
                                                    <option value="Wyoming">Wyoming</option>
                                                </select>
                                            </div>
                                            <div class="form-group col-md-3">
                                                <label class="form-label" for="addZipCode">Zip Code</label>
                                                <input type="text" id="addZipCode" name="addZipCode" class="form-input" pattern="(\d{5}([\-]\d{4})?)" title="Enter ##### or #####-#### zip code"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-primary" name="addAddressButton">Add Address</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="addPayment" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Add Payment Information</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/Checkout.jsp" method="post">
                                <div class="modal-body">
                                    <div class="container">
                                        <div class="form-row">
                                            <div class="form-group col-md-4">
                                                <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=request.getParameter("currentUserEmail")%>/>
                                                <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>
                                                <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=userID%>/>
                                                <label class="form-label" for="addCardType">Card Type</label>
                                                <select class="form-input" id="addCardType" name="addCardType">
                                                    <option value="Visa" selected>Visa</option>
                                                    <option value="Amex">Amex</option>
                                                    <option value="MasterCard">MasterCard</option>
                                                </select>
                                            </div>
                                            <div class="form-group col-md-8">
                                                <label class="form-label" for="addCardNumber">Card Number</label>
                                                <input type="text" id="addCardNumber" name="addCardNumber" class="form-input" pattern="[0-9]{13,16}" title="Enter the digits of a valid credit card number"/>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-6">
                                                <label class="form-label" for="addExpirationDate">Expiration Date</label>
                                                <input type="text" id="addExpirationDate" name="addExpirationDate" class="form-input" pattern="[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])" title="Enter a date yyyy-mm-dd" />
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label class="form-label" for="addCVV">CVV</label>
                                                <input type="text" id="addCVV" name="addCVV" class="form-input" pattern="[0-9]{3,4}" title="Enter a 3 or 4 digit CVV"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-primary" name="addPaymentButton">Save changes</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <%} else if(request.getParameter("checkoutButton") != null){%>
                    <h6 class="page-header">Thank you for your order!</h6><br>
                    <h5 class="page-header">Confirmation #: <%=confirmationNum%></h5><br>
                <%} else{%>
                    <h6 class="page-header">Your cart is empty!</h6><br>
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
