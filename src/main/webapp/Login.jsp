<%@page import="java.sql.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.mail.*"%>
<%@page import="java.net.InterfaceAddress" %>
<%@page import="javax.mail.internet.*" %>
<%@page import="java.util.Random"%>
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
        <title>Login</title>
    </head>
    <%
    String dbURL = "jdbc:mysql://localhost:3306/bookstore?serverTimezone=EST";
    String dbUsername = "root";
    String dbPassword = "WebProg2020";
    Connection connection = null;
    try {
        connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
        String emailQuery = "SELECT Email, ID, Password, type, Status FROM Users "; //get a list of usernames of every user
        PreparedStatement pstmt1 = connection.prepareStatement(emailQuery);
        ResultSet userResults = pstmt1.executeQuery(emailQuery);
        if (request.getParameter("sendTempPass") != null) {
            Random rand = new Random();
            int capLetters = rand.nextInt((90-65)+1) + 65;
            int lowerLetters = rand.nextInt((122-97)+1) + 97;
            int numbers = rand.nextInt((57-48)+1) + 65;
            String password = "";
            char cL = 'a';
            char sL = 'a';
            char nL = 'a';
            int count = 0;
            int options = rand.nextInt(3);

            while (count <8) {
                if ((count == 0) || (count == 4) || (count == 7)) {//this is for the first letter
                    if (options == 0) {
                        cL = (char) capLetters;
                        password += cL;
                        capLetters = rand.nextInt((90 - 65) + 1) + 65;
                        ++count;
                    } else if (options == 1) {
                        nL = (char) numbers;
                        password += nL;
                        numbers = rand.nextInt((57 - 48) + 1) + 65;
                        ++count;
                    } else {
                        sL = (char) lowerLetters;
                        password += sL;
                        lowerLetters = rand.nextInt((122 - 97) + 1) + 97;
                        ++count;
                    }
                }//rando options

                if ((count == 2) || (count == 5)) {
                    //second letter
                    cL = (char) capLetters;
                    password += cL;
                    capLetters = rand.nextInt((90 - 65) + 1) + 65;
                    ++count;
                }//cap letters

                if ((count == 3)) {
                    sL = (char) lowerLetters;
                    password += sL;
                    lowerLetters = rand.nextInt((122 - 97) + 1) + 97;
                    ++count;
                }//third letter

                nL = (char) numbers;
                numbers = rand.nextInt((57 - 48) + 1) + 65;
                password += nL;
                ++count;
            }

            String to = request.getParameter("EmailPassword");
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

                    context.setSubject("Testing out my mail sending code!");
                    context.setText("Here is your temporary password: " + password);
                    System.out.println("sending email...");
                    Transport.send(context);
                    System.out.println("Message sent successfully.");
                }
            } catch (MessagingException mE) {
                mE.printStackTrace();
            }
            String updateUserPassQuery = "UPDATE Users SET Password = ? where Email = ? ";
            PreparedStatement pstmt = connection.prepareStatement(updateUserPassQuery);
            String hashedPass = DigestUtils.sha256Hex(password);
            pstmt.setString(1, hashedPass);
            pstmt.setString(2, request.getParameter("EmailPassword"));
            pstmt.executeUpdate();
        } else if (request.getParameter("registerButton") != null) {
            String hashedPass = DigestUtils.sha256Hex(request.getParameter("newPassword"));
            String addUserQuery = "INSERT INTO Users (Email, Password, FirstName, LastName, phone) VALUES (?, ?, ?, ?, ?) ";
            PreparedStatement addUserQuery_pmst = connection.prepareStatement(addUserQuery);
            addUserQuery_pmst.setString(1, request.getParameter("newEmail"));
            addUserQuery_pmst.setString(2, hashedPass);
            addUserQuery_pmst.setString(3, request.getParameter("newFirstName"));
            addUserQuery_pmst.setString(4, request.getParameter("newLastName"));
            addUserQuery_pmst.setString(5, request.getParameter("newPhoneNumber"));
            addUserQuery_pmst.executeUpdate();

            String street = request.getParameter("newStreetAddress");
            String city = request.getParameter("newCity");
            String state = request.getParameter("newState");
            String zip = request.getParameter("newZipCode");
            String addAddressQuery = "INSERT INTO Address (User, Street, City, State, Zipcode) VALUES (?, ?, ?, ?, ?) ";
            PreparedStatement addAddressQuery_pmst = connection.prepareStatement(addAddressQuery);
            addAddressQuery_pmst.setString(1, request.getParameter("newEmail"));
            if(street != null && street != ""){
                addAddressQuery_pmst.setString(2, street);
            } else {
                addAddressQuery_pmst.setString(2, "");
            }

            if(city != null && city != ""){
                addAddressQuery_pmst.setString(3, city);
            } else {
                addAddressQuery_pmst.setString(3, "");
            }

            if(state != null && state != ""){
                addAddressQuery_pmst.setString(4, state);
            } else {
                addAddressQuery_pmst.setString(4, "");
            }

            if(zip != null && zip != ""){
                addAddressQuery_pmst.setString(5, zip);
            } else {
                addAddressQuery_pmst.setString(5, "");
            }
            addAddressQuery_pmst.executeUpdate();

            String type = request.getParameter("newCardType");
            String cardNumber = request.getParameter("newCardNumber");
            String expiration = request.getParameter("newExpirationDate");
            String cvv = request.getParameter("newCVV");
            String addPaymentQuery = "INSERT INTO Payment (User, Type, Number, Expiration, CVV) VALUES (?, ?, ?, ?, ?) ";
            PreparedStatement addPaymentQuery_pmst = connection.prepareStatement(addPaymentQuery);
            addPaymentQuery_pmst.setString(1, request.getParameter("newEmail"));
            if(type != null && type != "") {
                addPaymentQuery_pmst.setString(2, type);
            } else {
                addPaymentQuery_pmst.setString(2, "");
            }

            if(cardNumber != null && cardNumber != "") {
                //addPaymentQuery_pmst.setString(3, number); //right here
                String first12 = cardNumber.substring(0,12);
                String last4 = cardNumber.substring(12);
                String hashedFirst12 = DigestUtils.sha256Hex(first12);
                String hashedPayment = hashedFirst12 + last4;
                addPaymentQuery_pmst.setString(3, hashedPayment);
            } else {
                addPaymentQuery_pmst.setString(3, "");
            }

            if(expiration != null && expiration != "") {
                addPaymentQuery_pmst.setString(4, expiration);
            } else {
                addPaymentQuery_pmst.setString(4, "");
            }
            if(cvv != null && cvv != "") {
                addPaymentQuery_pmst.setString(5, cvv);
            } else {
                addPaymentQuery_pmst.setString(5, "");
            }
            addPaymentQuery_pmst.executeUpdate();
            %>
            <form class ="input-form" id="userInfoForm" action="/Bookstore_Project_4050_war_exploded/Homepage.jsp" method="post">
                <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=request.getParameter("newEmail").replaceAll("/","")%>/>
                <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=0%>/>
                <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=0%>/>
            </form>
            <script>
                document.getElementById("userInfoForm").submit();
            </script>
        <% } else if(request.getParameter("user") != null) {
            boolean userFound = false;
            while(userResults.next()) {
                if(request.getParameter("user").equals(userResults.getString(1)) || request.getParameter("user").equals(userResults.getString(2))){
                    if(DigestUtils.sha256Hex(request.getParameter("password")).equals(userResults.getString(3))){
                        userFound = true;
                        if((userResults.getInt(5) == 2)) { %>
                            <script>
                                    alert("This user is suspended.");
                            </script>
                        <%} else {
                                String currentUserEmail = "";
                                if(userResults.getString(1) != null){
                                    currentUserEmail = userResults.getString(1).replaceAll("/","");
                                }
                        %>
                            <form class ="input-form" id="userInfoForm"  method="post" action="Homepage.jsp">
                                <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=currentUserEmail%>/>
                                <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=userResults.getString(4)%>/>
                                <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=userResults.getInt(5)%>/>
                            </form>
                            <script>
                                var type = document.getElementById("currentUserType").value;
                                if(type == "0/") {
                                    document.getElementById("userInfoForm").action = "/Bookstore_Project_4050_war_exploded/Homepage.jsp";
                                }
                                else {
                                    document.getElementById("userInfoForm").action = "/Bookstore_Project_4050_war_exploded/AdminHomepage.jsp";
                                }
                                document.getElementById("userInfoForm").submit();
                            </script>
                        <%}
                    }
                }
            }
            if(!userFound) {%>
                <script>
                    alert("Incorrect login information, please try again.");
                </script>
            <%}
        }

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
        <nav id ="nav_menu">
            <ul>
            <li><form id ="find_books" method="post" action="Homepage.jsp">
                <a href="javascript:{}" onclick="document.getElementById('find_books').submit();">Find Books</a>
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
                <h2 class="page-header">Welcome to your favorite Bookstore!</h2>
                <h6 class="page-header">We've missed you! :)</h6>
                <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/Login.jsp" method="post">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">
                                <span class="fa fa-user"></span>
                            </span>
                        </div>
                        <input type="text" id="user" name="user" class="form-input" placeholder="ID/Email" style="margin-bottom: 1%" required/>
                    </div>
                    <div class="input-group">
                        <div class="input-group-prepend">
								<span class="input-group-text">
									<i class="fa fa-lock"></i>
								</span>
                        </div>
                        <input style="margin-bottom: 0ex" type="password" id="password" name="password" class="form-input" placeholder="Password"  required/>
                    </div>
                    <div style="display:block;">
                        <button type="button" class="forgotPassword" data-toggle="modal" data-target="#forgotModal">
                            Forgot Your Password?
                        </button>
                        <button type="button" class="forgotPassword" data-toggle="modal" data-target="#registerModal">
                            Don't Have Account?
                        </button>
                    </div>
                    <button type="submit" class="btn btn-primary" style="display: block; width: 100%; margin-top: 1ex;">
                        Login
                    </button>
                </form>
                <div class="modal fade" id="forgotModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Enter your email to receive a temporary password</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/Login.jsp" method="post">
                                <div class="modal-body">
                                    <label class="form-label" for="EmailPassword">Email</label>
                                    <input type="text" id="EmailPassword" name="EmailPassword" class="form-input"/>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button type="submit" name="sendTempPass" class="btn btn-primary">Send temporary password</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-md" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title">User Registration</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <form class ="needs-validation input-form " action="/Bookstore_Project_4050_war_exploded/Login.jsp" method="post" novalidate>
                                <div class="modal-body">
                                    <div class="container">
                                        <div class="form-row">
                                            <div class="form-group col-md-6 md-form">
                                                <label class="form-label" for="newFirstName"><b>First Name</b></label>
                                                <input type="text" id="newFirstName" name="newFirstName" class="form-control" pattern="[A-Za-z]{1,}" required/>
                                                <div class="valid-feedback">Looks good!</div>
                                                <div class="invalid-feedback">Please provide a valid name</div>
                                            </div>
                                            <div class="form-group col-md-6 md-form">
                                                <label class="form-label" for="newLastName"><b>Last Name</b></label>
                                                <input type="text" id="newLastName" name="newLastName" class="form-control" pattern="[A-Za-z]{1,}" required/>
                                                <div class="valid-feedback">Looks good!</div>
                                                <div class="invalid-feedback">Please provide a valid name</div>
                                            </div>
                                        </div>
                                        <div class="form-row ">
                                            <div class="form-group col-md-6 md-form">
                                                <label class="form-label" for="newEmail"><b>Email</b></label>
                                                <input type="email" id="newEmail" name="newEmail" class="form-control" required/>
                                                <div class="valid-feedback">Looks good!</div>
                                                <div class="invalid-feedback">Please provide a valid email </div>
                                            </div>
                                            <div class="form-group col-md-6 md-form">
                                                <label class="form-label" for="newPhoneNumber"><b>Phone Number</b></label>
                                                <input type="tel" id="newPhoneNumber" name="newPhoneNumber" class="form-control"
                                                       pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}" required/>
                                                <div class="valid-feedback">Looks good!</div>
                                                <div class="invalid-feedback">Invalid format, please use "xxx-xxx-xxxx" </div>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-6 md-form" style="alignment: left">
                                                <label class="form-label" for="newPassword"><b>Password</b></label>
                                                <input type="password" id="newPassword" name="newPassword" class="form-control" pattern=".{8,}" required/>
                                                <div class="valid-feedback">Looks good!</div>
                                                <div class="invalid-feedback">Please provide a valid password </div>
                                            </div>
                                            <div class="form-group col-md-6 md-form" style="alignment: right">
                                                <label class="form-label" for="confirmPassword"><b>Confirm Password</b></label>
                                                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" pattern=".{8,}" required/>
                                                <div class="valid-feedback">Looks good!</div>
                                                <div class="invalid-feedback">Please provide a valid password</div>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md md-form">
                                                <label class="form-label" for="newStreetAddress"><b>Address</b></label>
                                                <input type="text" id="newStreetAddress" name="newStreetAddress" class="form-control"
                                                       pattern="[a-zA-Z0-9\s]{1,}" />
                                                <div class="invalid-feedback">Please provide a valid street address</div>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-4 md-form">
                                                <label class="form-label" for="newCity"><b>City</b></label>
                                                <input type="text" id="newCity" name="newCity" class="form-control" pattern="[a-zA-Z\s]{1,}"/>
                                                <div class="invalid-feedback">Please provide a valid city </div>
                                            </div>
                                            <div class="form-group col-md-5 md-form">
                                                <select class= "form-control" id="newState" name="newState" data-width="100%">
                                                    <option value="" selected disabled hidden>State</option>
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
                                            <div class="form-group col-md-3 md-form">
                                                <label class="form-label" for="newZipCode"><b>Zip Code</b></label>
                                                <input type="text" id="newZipCode" name="newZipCode" class="form-control" pattern="[0-9]{5}"
                                                    style="height: 38px"/>
                                                <div class="invalid-feedback">Please provide a valid zipcode</div>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md md-form">
                                                <label class="form-label" for="newCardNumber"><b>Card Number</b></label>
                                                <input type="text" id="newCardNumber" name="newCardNumber" class="form-control" pattern="[0-9]{16}"/>
                                                <div class = "invalid-feedback">Please provide a valid card</div>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-5 md-form">
                                                <label class="form-label" for="newExpirationDate"><b>Expiration Date</b></label>
                                                <input type="text" id="newExpirationDate" name="newExpirationDate" class="form-control"/>
                                            </div>
                                            <div class="form-group col-md-5 md-form">
                                                <select id = "newCardType" name="newCardType" data-width="100%">
                                                    <option value="" selected disabled hidden>Card Type</option>
                                                    <option value="Visa">Visa</option>
                                                    <option value="Amex">Amex</option>
                                                    <option value="MasterCard">MasterCard</option>
                                                </select>
                                            </div>
                                            <div class="form-group col-md-2 md-form">
                                                <label class="form-label" for="newCVV"><b>CVV</b></label>
                                                <input type="text" id="newCVV" name="newCVV" class="form-control" pattern="[0-9]{3,4}" />
                                                <div class = "invalid-feedback">Please provide a valid CVV</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-primary" name="registerButton">Register</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <script type="text/javascript">
                    (function() {
                        'use strict';
                        window.addEventListener('load', function() {
                            var forms = document.getElementsByClassName('needs-validation');
                            var validation = Array.prototype.filter.call(forms, function(form) {
                                form.addEventListener('submit', function(event) {
                                    if (form.checkValidity() === false) {
                                        event.preventDefault();
                                        event.stopPropagation();
                                    }
                                    form.classList.add('was-validated');
                                }, false);
                            });
                        }, false);
                    })();
                </script>
            </div>
        </div>
    </main>
</div>
    <div class="column right"></div>
<%
    } catch (SQLException e){
        e.printStackTrace();
    }
%>

    </body>
</html>
