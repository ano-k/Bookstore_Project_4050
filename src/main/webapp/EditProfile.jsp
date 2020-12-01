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
            if(request.getParameter("verificationCode") != null){
                userID = request.getParameter("verificationCode");
            } else if(request.getParameter("currentUserID") != null){
                userID = request.getParameter("currentUserID").replaceAll("/","");
            }
        }
        String dbURL = "jdbc:mysql://localhost:3306/bookstore?serverTimezone=EST";
        String dbUsername = "root";
        String dbPassword = "Hakar123";

        try {
            Connection connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

            if(request.getParameter("editAddressButton") != null) {
                String updateAddressQuery = "UPDATE Address SET Street = ?, City = ?, State = ?, Zipcode = ? WHERE ID = ? ";
                PreparedStatement updateAddressQuery_pmst = connection.prepareStatement(updateAddressQuery);
                updateAddressQuery_pmst.setString(1, request.getParameter("updateStreetAddress"));
                updateAddressQuery_pmst.setString(2, request.getParameter("updateCity"));
                updateAddressQuery_pmst.setString(3, request.getParameter("updateState"));
                updateAddressQuery_pmst.setString(4, request.getParameter("updateZipCode"));
                updateAddressQuery_pmst.setInt(5, (int)Integer.parseInt(request.getParameter("addressID")));
                updateAddressQuery_pmst.executeUpdate();

            } else if(request.getParameter("editPaymentButton") != null) {
                String updatePaymentQuery = "UPDATE Payment SET Type = ?, Number = ?, Expiration = ?, CVV = ? WHERE ID = ? ";
                PreparedStatement updatePaymentQuery_pmst = connection.prepareStatement(updatePaymentQuery);
                updatePaymentQuery_pmst.setString(1, request.getParameter("updateCardType"));
                String cardNumber = request.getParameter("updateCardNumber");
                String first12 = cardNumber.substring(0,12);
                String last4 = cardNumber.substring(12);
                String hashedFirst12 = DigestUtils.sha256Hex(first12);
                String hashedPayment = hashedFirst12 + last4;
                updatePaymentQuery_pmst.setString(2, hashedPayment);
                updatePaymentQuery_pmst.setString(3, request.getParameter("updateExpirationDate"));
                updatePaymentQuery_pmst.setString(4, request.getParameter("updateCVV"));
                updatePaymentQuery_pmst.setInt(5, (int)Integer.parseInt(request.getParameter("paymentID")));
                updatePaymentQuery_pmst.executeUpdate();

            } else if(request.getParameter("editPersonalButton") != null) {
                String updatePersonalQuery = "UPDATE Users SET FirstName = ?, LastName = ?, Phone = ? WHERE Email = ? ";
                PreparedStatement updatePersonalQuery_pmst = connection.prepareStatement(updatePersonalQuery);
                updatePersonalQuery_pmst.setString(1, request.getParameter("updateFirstName"));
                updatePersonalQuery_pmst.setString(2, request.getParameter("updateLastName"));
                updatePersonalQuery_pmst.setString(3, request.getParameter("updatePhoneNumber"));
                updatePersonalQuery_pmst.setString(4, userEmail);
                updatePersonalQuery_pmst.executeUpdate();

            } else if(request.getParameter("notificationsButton") != null) {
                String updateNotificationsQuery = "UPDATE Users SET Notifications = ? WHERE Email = ? ";
                PreparedStatement updateNotificationsQuery_pmst = connection.prepareStatement(updateNotificationsQuery);
                updateNotificationsQuery_pmst.setInt(1, (int)Integer.parseInt(request.getParameter("notificationsSelect")));
                updateNotificationsQuery_pmst.setString(2, userEmail);
                updateNotificationsQuery_pmst.executeUpdate();

            } else if(request.getParameter("verifyButton") != null){
                String updateNotificationsQuery = "UPDATE Users SET status = ? WHERE ID = ? ";
                PreparedStatement updateNotificationsQuery_pmst = connection.prepareStatement(updateNotificationsQuery);
                updateNotificationsQuery_pmst.setInt(1, 1);
                updateNotificationsQuery_pmst.setString(2, request.getParameter("verificationCode"));
                updateNotificationsQuery_pmst.executeUpdate();

            } else if(request.getParameter("deleteAddressButton") != null) {
                String deleteAddressQuery = "DELETE FROM Address WHERE ID = ?";
                PreparedStatement deleteAddressQuery_pmst = connection.prepareStatement(deleteAddressQuery);
                deleteAddressQuery_pmst.setInt(1, (int)Integer.parseInt(request.getParameter("addressID")));
                deleteAddressQuery_pmst.executeUpdate();

            } else if(request.getParameter("deletePaymentButton") != null) {
                String deletePaymentQuery = "DELETE FROM Payment WHERE ID = ?";
                PreparedStatement deletePaymentQuery_pmst = connection.prepareStatement(deletePaymentQuery);
                deletePaymentQuery_pmst.setInt(1, (int)Integer.parseInt(request.getParameter("paymentID")));
                deletePaymentQuery_pmst.executeUpdate();

            } else if(request.getParameter("addAddressButton") != null) {
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

            } else if(request.getParameter("editPasswordButton") != null) {
                //get new pass, current pass and hash it to compare
                String newPass = request.getParameter("newPassword");
                String currentHashedPass = DigestUtils.sha256Hex(request.getParameter("currentPassword"));

                String checkPasswordQuery = "SELECT Password FROM Users WHERE Email = ? ";
                PreparedStatement checkPassword_pmst = connection.prepareStatement(checkPasswordQuery);
                checkPassword_pmst.setString(1, userEmail);
                ResultSet checkPassResults = checkPassword_pmst.executeQuery();
                checkPassResults.next();
                String dataPass = checkPassResults.getString(1);

                if(dataPass.equals(currentHashedPass)){//checks password
                    if(newPass.equals(request.getParameter("confirmNewPassword"))){
                        String hashedPass = DigestUtils.sha256Hex(request.getParameter("confirmNewPassword"));
                        String updatePasswordQuery = "UPDATE Users SET Password = ? WHERE Email = ? ";
                        PreparedStatement updatePasswordQuery_pmst = connection.prepareStatement(updatePasswordQuery);
                        updatePasswordQuery_pmst.setString(1, hashedPass);
                        updatePasswordQuery_pmst.setString(2, userEmail);
                        updatePasswordQuery_pmst.executeUpdate();

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

                        try {
                            MimeMessage context = new MimeMessage(sess);
                            InternetAddress fromIA = new InternetAddress(from);
                            context.setFrom(from);
                            if (to != null) {
                                InternetAddress toIA = new InternetAddress(to);
                                context.addRecipient(Message.RecipientType.TO, toIA);

                                context.setSubject("Password Change for Online Bookstore");
                                context.setText("The password for your account at our online bookstore has been changed");
                                System.out.println("sending email...");
                                Transport.send(context);
                                System.out.println("Message sent successfully.");
                            }
                        } catch (MessagingException mE) {
                            mE.printStackTrace();
                        }
                    } else {%>
                        <script>
                            alert("New password must match confirm password");
                        </script>
                    <%}

                }
                else { %>
                    <script>
                        alert("Incorrect current password");
                    </script>
                <%}
            }

            String address = "SELECT * FROM Address WHERE User = ? "; //get a list of usernames of the logged in user
            PreparedStatement address_pmst = connection.prepareStatement(address);
            address_pmst.setString(1, userEmail);
            ResultSet addressResults = address_pmst.executeQuery();

            String payment = "SELECT * FROM Payment WHERE User = ? "; //get a list of payments of the logged in user
            PreparedStatement payment_pmst = connection.prepareStatement(payment);
            payment_pmst.setString(1, userEmail);
            ResultSet paymentResults = payment_pmst.executeQuery();

            String personalInfo = "SELECT * FROM Users WHERE Email = ? "; //get a list of personal info of the logged in user
            PreparedStatement personalInfo_pmst = connection.prepareStatement(personalInfo);
            personalInfo_pmst.setString(1, userEmail);
            ResultSet personalResults = personalInfo_pmst.executeQuery();

            //states table query
//            String statesQuery = "SELECT * FROM States"; //get a list of states
//            PreparedStatement pstmt4 = connection.prepareStatement(statesQuery);
//            ResultSet statesResults = pstmt4.executeQuery();

            //card types table query
//            String cardTypesQuery = "SELECT * FROM CardTypes"; //get a list of card types
//            PreparedStatement pstmt5 = connection.prepareStatement(cardTypesQuery);
//            ResultSet cardTypesResults = pstmt5.executeQuery();

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
                    <li><form class= "checkout" id ="checkout" method="post" action="Checkout.jsp">
                        <a href="javascript:{}" onclick="document.getElementById('checkout').submit();">Checkout</a>
                        <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                        <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=userID%>/>
                        <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=userType%>/>
                    </form>
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
                <h2 class="page-header">Profile</h2>
                <h6 class="page-header">Personal Information</h6>
                <%-- Table for personal information --%>
                <table class="table">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col"></th>
                            <th scope="col" style="">Status</th>
                            <th scope="col">Notifications</th>
                            <th scope="col">Email</th>
                            <th scope="col">Name</th>
                            <th scope="col">Phone Number</th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                    <% while(personalResults.next()) { %>
                    <div class="modal fade" id=<%="editPersonal_" + personalResults.getInt(1)%> tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Edit Personal Information</h5>
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
                                                    <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=userType%>/>
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
                                                    <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=userType%>/>
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
                                                    <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=userID%>/>
                                                    <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=userType%>/>
                                                    <label class="form-label" for="newPassword">Would you like to receive notifications?</label>
                                                    <select id="notificationsSelect" name="notificationsSelect" class="form-input" required>
                                                        <option value=1>Yes</option>
                                                        <option value=0>No</option>
                                                    </select>
                                                    <script>
                                                        $(document).ready(function(){
                                                            $('#notificationsSelect option[value=<%=personalResults.getInt(9)%>]').attr('selected','selected');
                                                        });
                                                    </script>
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
                    <div class="modal" id="userVerification" abindex="-1" role="dialog">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">User Verification</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/EditProfile.jsp" method="post">
                                    <div class="modal-body">
                                        <p>Please enter your one-time verification code</p><br>
                                            <input type="text" id="verificationCode" name="verificationCode" class="form-input"/>
                                            <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                                            <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=userType%>/>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="submit" id="verifyButton" name="verifyButton" class="btn btn-primary">Verify</button>
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <tr>
                        <td style="padding-top: 1em; position: relative; bottom: 10px" class="listUser">
                            <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target=<%="#editPersonal_" + personalResults.getInt(1)%>>
                                Update Info
                            </button>
                        </td>
                        <%if(personalResults.getInt(2) == 0){%>
                            <td style="color:red" class="listUser"><p data-toggle="modal" data-target="#userVerification">Unverified</p></td>
                        <%}else if(personalResults.getInt(2) == 1){%>
                            <td style="color:green" class="listUser">Verified</td>
                        <%}%>
                        <%if(personalResults.getInt(2) == 0){%>
                            <td style="color:orange" class="listUser">Verification Required</td>
                        <%}else if(personalResults.getInt(2) == 1 && personalResults.getInt(9) == 0){%>
                            <td style="color:red" class="listUser"><p data-toggle="modal" data-target=<%="#notifications_" + personalResults.getInt(1)%>>Not subscribed</p></td>

                        <%}else if(personalResults.getInt(2) == 1 && personalResults.getInt(9) == 1){%>
                            <td style="color:green" class="listUser"><p data-toggle="modal" data-target=<%="#notifications_" + personalResults.getInt(1)%>>Subscribed</p></td>
                        <%}%>

                        <td class="listUser"><%=personalResults.getString(3)%></td>
                        <td class="listUser"><%=personalResults.getString(6) + " " + personalResults.getString(7)%></td>
                        <td class="listUser"><%=personalResults.getString(8)%></td>

                        <td style="padding-top: 1em; position: relative; bottom: 10px" class="listUser">
                            <button type="button" class="btn btn-outline-secondary btn-sm" data-toggle="modal" data-target=<%="#editPassword_" + personalResults.getInt(1)%>>
                                Change Password
                            </button>
                        </td>
                    </tr>
                    <%}%>
                    </tbody>
                </table>

                <h6 class="page-header">Address Information</h6>
                <%-- Table for address information --%>
                <table class="table">
                    <thead class="thead-dark">
                    <tr>
                        <th scope="col">Street Address</th>
                        <th scope="col">City</th>
                        <th scope="col">State</th>
                        <th scope="col">Zip Code</th>
                        <th scope="col"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        int countAddressRows = 0;
                        while(addressResults.next()) {
                            countAddressRows++;
                    %>
                    <div class="modal fade" id=<%="editAddress_" + addressResults.getInt(1)%> tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Edit Address Information</h5>
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
                                                    <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=userID%>/>
                                                    <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=userType%>/>
                                                    <label class="form-label" for="updateStreetAddress">Address</label>
                                                    <input type="text" id="updateStreetAddress" name="updateStreetAddress" class="form-input" pattern="\d+\s[A-z]+\s[A-z]+" title="Add a valid street address" value="<%=addressResults.getString(3)%>"/>
                                                </div>
                                            </div>
                                            <div class="form-row">
                                                <div class="form-group col-md-5">
                                                    <label class="form-label" for="updateCity">City</label>
                                                    <input type="text" id="updateCity" name="updateCity" class="form-input" pattern="[A-Za-z]{3,}" title="Enter the name of a valid city" value="<%=addressResults.getString(4)%>"/>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <label class="form-label" for="updateState">State</label>
                                                    <select id="updateState" name="updateState" class="form-input">
                                                        <option value="Alabama" <%if(addressResults.getString(5).equals("Alabama")){%>selected<%}%>>Alabama</option>
                                                        <option value="Alaska"<%if(addressResults.getString(5).equals("Alaska")){%>selected<%}%>>Alaska</option>
                                                        <option value="Arizona"<%if(addressResults.getString(5).equals("Arizona")){%>selected<%}%>>Arizona</option>
                                                        <option value="Arkansas"<%if(addressResults.getString(5).equals("Arkansas")){%>selected<%}%>>Arkansas</option>
                                                        <option value="California"<%if(addressResults.getString(5).equals("California")){%>selected<%}%>>California</option>
                                                        <option value="Colorado"<%if(addressResults.getString(5).equals("Colorado")){%>selected<%}%>>Colorado</option>
                                                        <option value="Connecticut"<%if(addressResults.getString(5).equals("Connecticut")){%>selected<%}%>>Connecticut</option>
                                                        <option value="Delaware"<%if(addressResults.getString(5).equals("Delaware")){%>selected<%}%>>Delaware</option>
                                                        <option value="District Of Columbia" <%if(addressResults.getString(5).equals("District Of Columbia")){%>selected<%}%>>District Of Columbia</option>
                                                        <option value="Florida" <%if(addressResults.getString(5).equals("Florida")){%>selected<%}%>>Florida</option>
                                                        <option value="Georgia" <%if(addressResults.getString(5).equals("Georgia")){%>selected<%}%>>Georgia</option>
                                                        <option value="Hawaii" <%if(addressResults.getString(5).equals("Hawaii")){%>selected<%}%>>Hawaii</option>
                                                        <option value="Idaho" <%if(addressResults.getString(5).equals("Idaho")){%>selected<%}%>>Idaho</option>
                                                        <option value="Illinois" <%if(addressResults.getString(5).equals("Illinois")){%>selected<%}%>>Illinois</option>
                                                        <option value="Indiana" <%if(addressResults.getString(5).equals("Indiana")){%>selected<%}%>>Indiana</option>
                                                        <option value="Iowa" <%if(addressResults.getString(5).equals("Iowa")){%>selected<%}%>>Iowa</option>
                                                        <option value="Kansas" <%if(addressResults.getString(5).equals("Kansas")){%>selected<%}%>>Kansas</option>
                                                        <option value="Kentucky" <%if(addressResults.getString(5).equals("Kentucky")){%>selected<%}%>>Kentucky</option>
                                                        <option value="Louisiana" <%if(addressResults.getString(5).equals("Louisiana")){%>selected<%}%>>Louisiana</option>
                                                        <option value="Maine" <%if(addressResults.getString(5).equals("Maine")){%>selected<%}%>>Maine</option>
                                                        <option value="Maryland" <%if(addressResults.getString(5).equals("Maryland")){%>selected<%}%>>Maryland</option>
                                                        <option value="Massachusetts" <%if(addressResults.getString(5).equals("Massachusetts")){%>selected<%}%>>Massachusetts</option>
                                                        <option value="Michigan" <%if(addressResults.getString(5).equals("Michigan")){%>selected<%}%>>Michigan</option>
                                                        <option value="Minnesota" <%if(addressResults.getString(5).equals("Minnesota")){%>selected<%}%>>Minnesota</option>
                                                        <option value="Mississippi" <%if(addressResults.getString(5).equals("Mississippi")){%>selected<%}%>>Mississippi</option>
                                                        <option value="Missouri" <%if(addressResults.getString(5).equals("Missouri")){%>selected<%}%>>Missouri</option>
                                                        <option value="Montana" <%if(addressResults.getString(5).equals("Montana")){%>selected<%}%>>Montana</option>
                                                        <option value="Nebraska" <%if(addressResults.getString(5).equals("Nebraska")){%>selected<%}%>>Nebraska</option>
                                                        <option value="Nevada" <%if(addressResults.getString(5).equals("Nevada")){%>selected<%}%>>Nevada</option>
                                                        <option value="New Hampshire" <%if(addressResults.getString(5).equals("New Hampshire")){%>selected<%}%>>New Hampshire</option>
                                                        <option value="New Jersey" <%if(addressResults.getString(5).equals("New Jersey")){%>selected<%}%>>New Jersey</option>
                                                        <option value="New Mexico" <%if(addressResults.getString(5).equals("New Mexico")){%>selected<%}%>>New Mexico</option>
                                                        <option value="New York" <%if(addressResults.getString(5).equals("New York")){%>selected<%}%>>New York</option>
                                                        <option value="North Carolina" <%if(addressResults.getString(5).equals("North Carolina")){%>selected<%}%>>North Carolina</option>
                                                        <option value="North Dakota" <%if(addressResults.getString(5).equals("North Dakota")){%>selected<%}%>>North Dakota</option>
                                                        <option value="Ohio" <%if(addressResults.getString(5).equals("Ohio")){%>selected<%}%>>Ohio</option>
                                                        <option value="Oklahoma" <%if(addressResults.getString(5).equals("Oklahoma")){%>selected<%}%>>Oklahoma</option>
                                                        <option value="Oregon" <%if(addressResults.getString(5).equals("Oregon")){%>selected<%}%>>Oregon</option>
                                                        <option value="Pennsylvania" <%if(addressResults.getString(5).equals("Pennsylvania")){%>selected<%}%>>Pennsylvania</option>
                                                        <option value="Rhode Island" <%if(addressResults.getString(5).equals("Rhode Island")){%>selected<%}%>>Rhode Island</option>
                                                        <option value="South Carolina" <%if(addressResults.getString(5).equals("South Carolina")){%>selected<%}%>>South Carolina</option>
                                                        <option value="South Dakota" <%if(addressResults.getString(5).equals("South Dakota")){%>selected<%}%>>South Dakota</option>
                                                        <option value="Tennessee" <%if(addressResults.getString(5).equals("Tennesse")){%>selected<%}%>>Tennessee</option>
                                                        <option value="Texas" <%if(addressResults.getString(5).equals("Texas")){%>selected<%}%>>Texas</option>
                                                        <option value="Utah" <%if(addressResults.getString(5).equals("Utah")){%>selected<%}%>>Utah</option>
                                                        <option value="Vermont" <%if(addressResults.getString(5).equals("Vermont")){%>selected<%}%>>Vermont</option>
                                                        <option value="Virginia" <%if(addressResults.getString(5).equals("Virginia")){%>selected<%}%>>Virginia</option>
                                                        <option value="Washington" <%if(addressResults.getString(5).equals("Washington")){%>selected<%}%>>Washington</option>
                                                        <option value="West Virginia" <%if(addressResults.getString(5).equals("West Virginia")){%>selected<%}%>>West Virginia</option>
                                                        <option value="Wisconsin" <%if(addressResults.getString(5).equals("Wisconsin")){%>selected<%}%>>Wisconsin</option>
                                                        <option value="Wyoming" <%if(addressResults.getString(5).equals("Wyoming")){%>selected<%}%>>Wyoming</option>
                                                    </select>
                                                </div>
                                                <div class="form-group col-md-3">
                                                    <label class="form-label" for="updateZipCode">Zip Code</label>
                                                    <input type="text" id="updateZipCode" name="updateZipCode" class="form-input" pattern="(\d{5}([\-]\d{4})?)" title="Enter ##### or #####-#### zip code" value="<%=addressResults.getInt(6)%>"/>
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
                                                    <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=userType%>/>
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

                    <tr>
                        <td class="listUser"><%=addressResults.getString(3)%></td>
                        <td class="listUser"><%=addressResults.getString(4)%></td>
                        <td class="listUser"><%=addressResults.getString(5)%></td>
                        <td class="listUser"><%=addressResults.getString(6)%></td>
                        <td style="padding-top: 1em; position: relative; bottom: 10px" class="listUser">
                            <button type="button" style="width: 30%" class="btn btn-warning btn-sm" data-toggle="modal" data-target=<%="#editAddress_" + addressResults.getInt(1)%>>
                                Edit
                            </button>
                            <button type="button" style="width: 35%" class="btn btn-outline-danger btn-sm" data-toggle="modal" data-target=<%="#deleteAddress_" + addressResults.getInt(1)%>>
                                Remove
                            </button>
                        </td>
                    </tr>
                    <% } %>

                    </tbody>
                </table>
                <div class="modal fade" id="addAddress" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Add Address Information</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/EditProfile.jsp" method="post">
                                <div class="modal-body">
                                    <div class="container">
                                        <div class="form-row">
                                            <div class="form-group col-md">
                                                <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                                                <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=userType%>/>
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
                <% if(countAddressRows < 3) { %>
                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addAddress">
                    Add
                </button>
                <% } %>

                <h6 class="page-header">Payment Information</h6>
                <%-- Table for payment information --%>
                <table class="table">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">Card Type</th>
                            <th scope="col">Card Number</th>
                            <th scope="col">Expiration Date</th>
                            <th scope="col">CVV</th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        int countPaymentRows = 0;
                        while(paymentResults.next()) {
                            countPaymentRows++;
                    %>
                    <div class="modal fade" id=<%="editPayment_" + paymentResults.getInt(1)%> tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Edit Payment Information</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/EditProfile.jsp" method="post">
                                    <div class="modal-body">
                                        <div class="container">
                                            <div class="form-row">
                                                <div class="form-group col-md-4">
                                                    <input type="hidden" id="paymentID" name="paymentID" value="<%=paymentResults.getInt(1)%>"/>
                                                    <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                                                    <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=userType%>/>
                                                    <label class="form-label" for="updateCardType">Card Type</label>
                                                    <select id="updateCardType" name="updateCardType" class="form-input">
                                                        <option value="Visa" <%if(paymentResults.getString(3).equals("Visa")){%>selected<%}%>>Visa</option>
                                                        <option value="Amex" <%if(paymentResults.getString(3).equals("Amex")){%>selected<%}%>>Amex</option>
                                                        <option value="MasterCard" <%if(paymentResults.getString(3).equals("MasterCard")){%>selected<%}%>>MasterCard</option>
                                                    </select>
                                                </div>
                                                <div class="form-group col-md-8">
                                                    <label class="form-label" for="updateCardNumber">Card Number</label>
                                                    <input type="text" id="updateCardNumber" name="updateCardNumber" class="form-input" pattern="[0-9]{13,16}" title="Enter the digits of a valid credit card number" value=<%="xxxxxxxxxxxx" + paymentResults.getString(4).substring(64)%>/>
                                                </div>
                                            </div>
                                            <div class="form-row">
                                                <div class="form-group col-md-6">
                                                    <label class="form-label" for="updateExpirationDate">Expiration Date</label>
                                                    <input type="text" id="updateExpirationDate" name="updateExpirationDate" class="form-input" pattern="[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])" title="Enter a date yyyy-mm-dd" placeholder="yyyy-mm-dd" value="<%=paymentResults.getString(5)%>"/>
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <label class="form-label" for="updateCVV">CVV</label>
                                                    <input type="text" id="updateCVV" name="updateCVV" class="form-input" pattern="[0-9]{3,4}" title="Enter a 3 or 4 digit CVV" value="<%=paymentResults.getString(6)%>"/>
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
                    </div>

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
                                                    <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value =<%=userType%>/>
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

                    <tr>
                        <td class="listUser"><%=paymentResults.getString(3)%></td>
                        <% String result = paymentResults.getString(4);
                            result = result.substring(64);
                            String cardNumber = "xxxxxxxxxxxx" + result;
                        %>
                        <td class="listUser"><%=cardNumber%></td>
                        <td class="listUser"><%=paymentResults.getString(5)%></td>
                        <td class="listUser"><%=paymentResults.getString(6)%></td>
                        <td style="padding-top: 1em; position: relative; bottom: 10px; right: 10px" class="listUser">
                            <button type="button" style="width: 35%" class="btn btn-warning btn-sm" data-toggle="modal" data-target=<%="#editPayment_" + paymentResults.getInt(1)%>>
                                Edit
                            </button>
                            <button type="button" style="width: 40%" class="btn btn-outline-danger btn-sm" data-toggle="modal" data-target=<%="#deletePayment_" + paymentResults.getInt(1)%>>Remove
                            </button>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>

                <div class="modal fade" id="addPayment" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Add Payment Information</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/EditProfile.jsp" method="post">
                                <div class="modal-body">
                                    <div class="container">
                                        <div class="form-row">
                                            <div class="form-group col-md-4">
                                                <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                                                <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=userType%>/>
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
                                                <input type="text" id="addExpirationDate" name="addExpirationDate" class="form-input" pattern="[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])"
                                                       placeholder="yyyy-mm-dd" title="Enter a date yyyy-mm-dd" />
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

                <% if(countPaymentRows < 3) { %>
                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addPayment">
                    Add
                </button>
                <%}%>
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
