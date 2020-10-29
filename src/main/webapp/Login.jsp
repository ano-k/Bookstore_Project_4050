<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.mail.*"%>
<%@ page import="java.net.InterfaceAddress" %>
<%@ page import="javax.mail.internet.*" %>

<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <link rel="stylesheet" href="stylesheet.css">
    <title>Login</title>

</head>

<body>

<%
    String dbURL = "jdbc:mysql://localhost:3306/bookstore?serverTimezone=EST";
    String dbUsername = "root";
    String dbPassword = "WebProg2020";
    try {
        Connection connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
        String emailQuery = "SELECT Email, ID, Password, type FROM Users"; //get a list of usernames of every user
        PreparedStatement pstmt1 = connection.prepareStatement(emailQuery);
        ResultSet userResults = pstmt1.executeQuery(emailQuery);
        if(request.getParameter("EmailPassword") != null){
            String to = request.getParameter("EmailPassword");
            String from = "bookstore.helper@gmail.com";

            Properties prop = System.getProperties();
            prop.put("mail.smtp.host", "smtp.gmail.com");
            prop.put("mail.smtp.port", "587");
            prop.put("mail.smtp.starttls.enable", "true");
            prop.put("mail.smtp.auth", "true");
            prop.put("mail.smtp.ssl.trust", "*");

            final String username = "bookstore.helper@gmail.com";
            final String password = "oeprimytgjyhvsbc";

            Session sess = Session.getInstance(prop, new javax.mail.Authenticator(){
                protected PasswordAuthentication getPasswordAuthentication(){
                    return new PasswordAuthentication(username, password);
                }
            });
            try{
                MimeMessage context = new MimeMessage(sess);
                InternetAddress fromIA = new InternetAddress(from);
                context.setFrom(from);
                if(to != null) {
                    InternetAddress toIA = new InternetAddress(to);
                    context.addRecipient(Message.RecipientType.TO, toIA);

                    context.setSubject("Bookstore Temporary Password");
                    context.setText("The following is your temporary password for your bookstore account");
                    System.out.println("sending email...");
                    Transport.send(context);
                    System.out.println("Message sent successfully.");
                }
            }catch(MessagingException mE){
                mE.printStackTrace();
            }
        }
        if(request.getParameter("user") != null) {
            while(userResults.next()) {
                if(request.getParameter("user").equals(userResults.getString(1)) || request.getParameter("user").equals(userResults.getString(2))) {
                    if(request.getParameter("password").equals(userResults.getString(3))) {
                        %>

                        <form class ="input-form" id="userInfoForm"  method="post">
                            <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userResults.getString(1)%>/>
                            <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=userResults.getString(2)%>/>
                            <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=userResults.getString(4)%>/>
                        </form>
                        <script>
                            var type = document.getElementById("currentUserType").value;
                            console.log(type);
                            if(type == "0/") {
                                document.getElementById("userInfoForm").action = "/Bookstore_Project_4050_war_exploded/EditProfile.jsp"; //change this to go to Homepage.jsp
                            }
                            else {
                                document.getElementById("userInfoForm").action = "/Bookstore_Project_4050_war_exploded/EditProfile.jsp"; //change this to go to AdminHomePage.jsp
                            }
                            document.getElementById("userInfoForm").submit();
                        </script>
                        <%
                    }
                }
            }
        }
%>
<div class="column left"></div>

<div class="column middle">
    <header>
        <h1 class="page-header">Online Bookstore</h1>
    </header>
    <main>
        <nav id ="nav_menu">
            <a href="Homepage.jsp">Find Books</a>
            <a href="Login.jsp" class="current">Login/Register</a>
            <a href="ViewCart.jsp">View Cart</a>
            <a href="EditProfile.jsp">Edit Profile</a>
            <a href="OrderHistory.html">Order History</a>
        </nav>

        <div class="main content">
            <div class="cart-information">
                <h2 class="page-header">Welcome Back!</h2>
                <h6 class="page-header">We've missed you! :)</h6><br>
                <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/Login.jsp" method="post">
                    <p class="info-wrap">
                        <label class="form-label" for="user">Email</label>
                        <input type="text" id="user" name="user" class="form-input" />
                    </p>
                    <br/>
                    <p class="info-wrap">
                        <label class="form-label" for="password">Password</label>
                        <input type="password" id="password" name="password" class="form-input"/>
                    </p>
                    <br/>
                    <p class="info-wrap">
                        <input type="checkbox" class="form-input" id="rmbr" name="rmbr" value="RM">
                        <label for="rmbr" class="form-label"> Remember Me</label>
                    </p>
                    <br/>
                    <input type="submit" class="btn btn-danger" value="Login" /> <!-- onclick, code should check role and redirect to the correct webpage -->
                </form>

                <br/>
                <br>
                <p> Forgot Password
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#forgotModal">
                        Forgot Password
                    </button>
                </p>
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
                                <button type="submit" class="btn btn-primary">Send temporary password</button>
                            </div>
                            </form>
                        </div>
                    </div>
                </div>
                <p>
                    Don't have an account yet?
                    <!-- Button trigger modal -->
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#registerModal">
                        Register Now!
                    </button>
                </p>
                <!-- Modal -->
                <div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Please enter your information</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/Login.jsp" method="post">
                                    <div class="container">
                                        <div class="form-row">
                                            <div class="form-group col-md-6">
                                                <label class="form-label" for="newEmail">Email</label>
                                                <input type="text" id="newEmail" name="newEmail" class="form-input"/>
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label class="form-label" for="newPhoneNumber">Phone Number</label>
                                                <input type="text" id="newPhoneNumber" name="newPhoneNumber" class="form-input" />
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-6">
                                                <label class="form-label" for="newPassword">Password</label>
                                                <input type="text" id="newPassword" name="newPassword" class="form-input" />
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label class="form-label" for="confirmPassword">Confirm Password</label>
                                                <input type="text" id="confirmPassword" name="confirmPassword" class="form-input" />
                                            </div>
                                        </div>

                                        <div class="form-row">
                                            <div class="form-group col-md-6">
                                                <label class="form-label" for="newFirstName">First Name</label>
                                                <input type="text" id="newFirstName" name="newFirstName" class="form-input" />
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label class="form-label" for="newLastName">Last Name</label>
                                                <input type="text" id="newLastName" name="newLastName" class="form-input" />
                                            </div>
                                        </div>
                                        <br><hr><br>

                                        <div class="form-row">
                                            <div class="form-group col-md">
                                                <label class="form-label" for="newStreetAddress">Address</label>
                                                <input type="text" id="newStreetAddress" name="newStreetAddress" class="form-input" />
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-5">
                                                <label class="form-label" for="newCity">City</label>
                                                <input type="text" id="newCity" name="newCity" class="form-input" />
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label class="form-label" for="newState">State</label>
                                                <select id="newState" name="newState" class="form-input">
                                                    <option value="AL">Alabama</option>
                                                    <option value="AK">Alaska</option>
                                                    <option value="AZ">Arizona</option>
                                                    <option value="AR">Arkansas</option>
                                                    <option value="CA">California</option>
                                                    <option value="CO">Colorado</option>
                                                    <option value="CT">Connecticut</option>
                                                    <option value="DE">Delaware</option>
                                                    <option value="DC">District Of Columbia</option>
                                                    <option value="FL">Florida</option>
                                                    <option value="GA">Georgia</option>
                                                    <option value="HI">Hawaii</option>
                                                    <option value="ID">Idaho</option>
                                                    <option value="IL">Illinois</option>
                                                    <option value="IN">Indiana</option>
                                                    <option value="IA">Iowa</option>
                                                    <option value="KS">Kansas</option>
                                                    <option value="KY">Kentucky</option>
                                                    <option value="LA">Louisiana</option>
                                                    <option value="ME">Maine</option>
                                                    <option value="MD">Maryland</option>
                                                    <option value="MA">Massachusetts</option>
                                                    <option value="MI">Michigan</option>
                                                    <option value="MN">Minnesota</option>
                                                    <option value="MS">Mississippi</option>
                                                    <option value="MO">Missouri</option>
                                                    <option value="MT">Montana</option>
                                                    <option value="NE">Nebraska</option>
                                                    <option value="NV">Nevada</option>
                                                    <option value="NH">New Hampshire</option>
                                                    <option value="NJ">New Jersey</option>
                                                    <option value="NM">New Mexico</option>
                                                    <option value="NY">New York</option>
                                                    <option value="NC">North Carolina</option>
                                                    <option value="ND">North Dakota</option>
                                                    <option value="OH">Ohio</option>
                                                    <option value="OK">Oklahoma</option>
                                                    <option value="OR">Oregon</option>
                                                    <option value="PA">Pennsylvania</option>
                                                    <option value="RI">Rhode Island</option>
                                                    <option value="SC">South Carolina</option>
                                                    <option value="SD">South Dakota</option>
                                                    <option value="TN">Tennessee</option>
                                                    <option value="TX">Texas</option>
                                                    <option value="UT">Utah</option>
                                                    <option value="VT">Vermont</option>
                                                    <option value="VA">Virginia</option>
                                                    <option value="WA">Washington</option>
                                                    <option value="WV">West Virginia</option>
                                                    <option value="WI">Wisconsin</option>
                                                    <option value="WY">Wyoming</option>
                                                </select>
                                            </div>
                                            <div class="form-group col-md-3">
                                                <label class="form-label" for="newZipCode">Zip Code</label>
                                                <input type="text" id="newZipCode" name="newZipCode" class="form-input" />
                                            </div>
                                        </div>
                                        <br><hr><br>

                                        <div class="form-row">
                                            <div class="form-group col-md-4">
                                                <label class="form-label" for="newCardType">Card Type</label>
                                                <select class="form-input" id="newCardType">
                                                    <option value="Visa">Visa</option>
                                                    <option value="Amex">Amex</option>
                                                    <option value="MasterCard">MasterCard</option>
                                                </select>
                                            </div>
                                            <div class="form-group col-md-8">
                                                <label class="form-label" for="newCardNumber">Card Number</label>
                                                <input type="text" id="newCardNumber" name="newCardNumber" class="form-input" />
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-6">
                                                <label class="form-label" for="newExpirationDate">Expiration Date</label>
                                                <input type="month" id="newExpirationDate" name="newExpirationDate" class="form-input" />
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label class="form-label" for="newCVV">CVV</label>
                                                <input type="text" id="newCVV" name="newCVV" class="form-input" />
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">Register</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<div class="column right"></div>


<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
</body>
<%
    }
    catch (SQLException e){
        //out.println("<p>Unsuccessful connection to database</p>");
        e.printStackTrace();
    }
%>
</html>