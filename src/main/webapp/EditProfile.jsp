<%--
  Created by IntelliJ IDEA.
  User: mpcer
  Date: 9/29/2020
  Time: 10:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <link rel="stylesheet" href="stylesheet.css">
    <title>Edit Profile</title>
</head>
<body>
<%
    if(request.getParameter("currentUserEmail") == null) {
        out.println("redirect to login");
    } //checks if the user is already logged in
    else {
        String dbURL = "jdbc:mysql://localhost:3306/bookstore?serverTimezone=EST";
        String dbUsername = "root";
        String dbPassword = "WebProg2020";
        try {
            Connection connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
            String addressQuery = "SELECT * FROM Address WHERE User = ? "; //get a list of usernames of every user
            PreparedStatement pstmt1 = connection.prepareStatement(addressQuery);
            pstmt1.setString(1, request.getParameter("currentUserEmail").substring(0, request.getParameter("currentUserEmail").length()-1));
            ResultSet addressResults = pstmt1.executeQuery();
%>
<div class="column left"></div>

<div class="column middle">
    <header>
        <h1 class="page-header">Online Bookstore</h1>
    </header>

    <main>
        <nav id ="nav_menu">
            <a href="Homepage.jsp">Find Books</a>
            <a href="Login.jsp">Login/Register</a>
            <a href="ViewCart.jsp">View Cart</a>
            <a href="EditProfile.jsp" class="current">Edit Profile</a>
            <a href="OrderHistory.html">Order History</a>
        </nav>

        <div class="main content">
            <div class="cart-information">
                <h2 class="page-header">Edit Profile</h2>
                <br>

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
                    <% while(addressResults.next()) { %>
                    <div class="modal fade" id=<%="editAddress_" + addressResults.getInt(1)%> tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Modal title</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/EditProfile.jsp" method="post">
                                        <div class="container">
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
                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button type="button" class="btn btn-primary">Save changes</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <tr>

                        <td><%=addressResults.getString(3)%></td>
                        <td><%=addressResults.getString(4)%></td>
                        <td><%=addressResults.getString(5)%></td>
                        <td><%=addressResults.getString(6)%></td>
                        <td>
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target=<%="#editAddress_" + addressResults.getInt(1)%>>
                            Edit
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
//<body>
//<div class="column left"></div>
//
//<div class="column middle">
//    <header>
//        <h1 class="page-header">Online Bookstore</h1>
//    </header>
//
//    <main>
//        <nav id ="nav_menu">
//            <a href="Homepage.jsp">Find Books</a>
//            <a href="Login.jsp">Login/Register</a>
//            <a href="ViewCart.jsp">View Cart</a>
//            <a href="EditProfile.jsp" class="current">Edit Profile</a>
//            <a href="OrderHistory.html">Order History</a>
//        </nav>
//
//        <div class="main content">
//            <div class="cart-information">
//                <h2 class="page-header">Edit Profile</h2>
//                <br>
//                <form class ="input-form" action="PasswordEmail.jsp">
//
//                    <h4>Personal Info</h4>
//                    <br>
//                    <p class="info-wrap">
//                        <label class="form-label" for="changefirstname">Change First Name</label>
//                        <input type="text" id="changefirstname" name="changefirstname" class="form-input" value="John"/>
//                    </p>
//                    <br/>
//                    <p class="info-wrap">
//                        <label class="form-label" for="changelastname">Change Last Name</label>
//                        <input type="text" id="changelastname" name="changelastname" class="form-input" value="Doe"/>
//                    </p>
//                    <hr>
//                    <br/>
//                    <h4>Password</h4>
//                    <br>
//                    <p class="info-wrap">
//                        <label class="form-label" for="currentpassword"> Current Password</label>
//                        <input type="password" id="currentpassword" name="currentpassword" class="form-input" value="old password"/>
//                    </p>
//                    <br>
//                    <p class="info-wrap">
//                        <label class="form-label" for="changepassword">Change Password</label>
//                        <input type="password" id="changepassword" name="changepassword" class="form-input" value="current password"/>
//                    </p>
//                    <br/>
//                    <p class="info-wrap">
//                        <label class="form-label" for="confchangepassword">Confirm Changed Password</label>
//                        <input type="password" id="confchangepassword" name="confchangepassword" class="form-input" value="currentpass"/>
//                    </p>
//                    <hr>
//                    <br>
//                    <h4>Payment Info</h4>
//                    <br>
//                    <p class="info-wrap">
//                        <label class="form-label" for="changecreditnum">Change Credit Card Number</label>
//                        <input type="text" id="changecreditnum" name="changecreditnum" class="form-input" value="123456789"/>
//                    </p>
//                    <br>
//                    <p class="info-wrap">
//                        <label class="form-label" for="changeexpdate">Change Expiration</label>
//                        <input type="month" id="changeexpdate" name="changeexpdate" min="2020-09" value="2020-10" class="form-input"/>
//                    </p>
//                    <br>
//                    <p class="info-wrap">
//                        <label class="form-label" for="changecvv">Change CVV</label>
//                        <input type="text" id="changecvv" name="changecvv" class="form-input" value="1234"/>
//                    </p>
//                    <!--Optional Credit Information for CC #2-->
//                    <br>
//                    <h6>(Optional)</h6>
//                    <p class="info-wrap">
//                        <label class="form-label" for="changecreditnum2">Change Credit Card Number</label>
//                        <input type="text" id="changecreditnum2" name="changecreditnum2" class="form-input" value="123456789"/>
//                    </p>
//                    <br>
//                    <p class="info-wrap">
//                        <label class="form-label" for="changeexpdate2">Change Expiration</label>
//                        <input type="month" id="changeexpdate2" name="changeexpdate2" min="2020-09" value="2020-10" class="form-input"/>
//                    </p>
//                    <br>
//                    <p class="info-wrap">
//                        <label class="form-label" for="changecvv2">Change CVV</label>
//                        <input type="text" id="changecvv2" name="changecvv2" class="form-input" value="1234"/>
//                    </p>
//                    <!--Optional Credit Information for CC #3-->
//                    <br>
//                    <h6>(Optional)</h6>
//                    <p class="info-wrap">
//                        <label class="form-label" for="changecreditnum3">Change Credit Card Number</label>
//                        <input type="text" id="changecreditnum3" name="changecreditnum3" class="form-input" value="123456789"/>
//                    </p>
//                    <br>
//                    <p class="info-wrap">
//                        <label class="form-label" for="changeexpdate3">Change Expiration</label>
//                        <input type="month" id="changeexpdate3" name="changeexpdate3" min="2020-09" value="2020-10" class="form-input"/>
//                    </p>
//                    <br>
//                    <p class="info-wrap">
//                        <label class="form-label" for="changecvv3">Change CVV</label>
//                        <input type="text" id="changecvv3" name="changecvv3" class="form-input" value="1234"/>
//                    </p>
//                    <hr>
//                    <br>
//                    <!--Address information starts here-->
//                    <h4>Address Info</h4>
//                    <br>
//                    <p class="info-wrap">
//                        <label class="form-label" for="changestreetandnum">Change Address Line</label>
//                        <input type="text" id="changestreetandnum" name="changestreetandnum" class="form-input" value="100 Example Street"/>
//                    </p>
//                    <br>
//                    <p class="info-wrap">
//                        <label class="form-label" for="changecity">Change City</label>
//                        <input type="text" id="changecity" name="changecity" class="form-input" value="Athens"/>
//                    </p>
//                    <br/>
//                    <p class="info-wrap">
//                        <label class="form-label" for="changestate">Change State</label>
//                        <select id="changestate" name="changestate" class="form-input">
//                            <option value="AL">Alabama</option>
//                            <option value="AK">Alaska</option>
//                            <option value="AZ">Arizona</option>
//                            <option value="AR">Arkansas</option>
//                            <option value="CA">California</option>
//                            <option value="CO">Colorado</option>
//                            <option value="CT">Connecticut</option>
//                            <option value="DE">Delaware</option>
//                            <option value="DC">District Of Columbia</option>
//                            <option value="FL">Florida</option>
//                            <option value="GA" selected>Georgia</option>
//                            <option value="HI">Hawaii</option>
//                            <option value="ID">Idaho</option>
//                            <option value="IL">Illinois</option>
//                            <option value="IN">Indiana</option>
//                            <option value="IA">Iowa</option>
//                            <option value="KS">Kansas</option>
//                            <option value="KY">Kentucky</option>
//                            <option value="LA">Louisiana</option>
//                            <option value="ME">Maine</option>
//                            <option value="MD">Maryland</option>
//                            <option value="MA">Massachusetts</option>
//                            <option value="MI">Michigan</option>
//                            <option value="MN">Minnesota</option>
//                            <option value="MS">Mississippi</option>
//                            <option value="MO">Missouri</option>
//                            <option value="MT">Montana</option>
//                            <option value="NE">Nebraska</option>
//                            <option value="NV">Nevada</option>
//                            <option value="NH">New Hampshire</option>
//                            <option value="NJ">New Jersey</option>
//                            <option value="NM">New Mexico</option>
//                            <option value="NY">New York</option>
//                            <option value="NC">North Carolina</option>
//                            <option value="ND">North Dakota</option>
//                            <option value="OH">Ohio</option>
//                            <option value="OK">Oklahoma</option>
//                            <option value="OR">Oregon</option>
//                            <option value="PA">Pennsylvania</option>
//                            <option value="RI">Rhode Island</option>
//                            <option value="SC">South Carolina</option>
//                            <option value="SD">South Dakota</option>
//                            <option value="TN">Tennessee</option>
//                            <option value="TX">Texas</option>
//                            <option value="UT">Utah</option>
//                            <option value="VT">Vermont</option>
//                            <option value="VA">Virginia</option>
//                            <option value="WA">Washington</option>
//                            <option value="WV">West Virginia</option>
//                            <option value="WI">Wisconsin</option>
//                            <option value="WY">Wyoming</option>
//                        </select>
//                    </p>
//                    <br/>
//                    <p class="info-wrap">
//                        <label class="form-label" for="changezip">Change Zip Code</label>
//                        <input type="text" id="changezip" name="changezip" class="form-input" value="30605" pattern="[0-9]{5}"/>
//                        <!-- Added a pattern to recognize ZIPs as five digit codes, I assume that's what needed changing?1-->
//                    </p>
//                    <!--Address info block ends here-->
//                    <br>
//                    <br>
//                    <h6>(Optional)</h6>
//                    <p class="info-wrap">
//                        <label class="form-label" for="changestreetandnum2">Change Address Line</label>
//                        <input type="text" id="changestreetandnum2" name="changestreetandnum2" class="form-input" value="100 Example Street"/>
//                    </p>
//                    <br>
//                    <p class="info-wrap">
//                        <label class="form-label" for="changecity2">Change City</label>
//                        <input type="text" id="changecity2" name="changecity2" class="form-input" value="Athens"/>
//                    </p>
//                    <br/>
//                    <p class="info-wrap">
//                        <label class="form-label" for="changestate2">Change State</label>
//                        <select id="changestate2" name="changestate2" class="form-input">
//                            <option value="AL">Alabama</option>
//                            <option value="AK">Alaska</option>
//                            <option value="AZ">Arizona</option>
//                            <option value="AR">Arkansas</option>
//                            <option value="CA">California</option>
//                            <option value="CO">Colorado</option>
//                            <option value="CT">Connecticut</option>
//                            <option value="DE">Delaware</option>
//                            <option value="DC">District Of Columbia</option>
//                            <option value="FL">Florida</option>
//                            <option value="GA" selected>Georgia</option>
//                            <option value="HI">Hawaii</option>
//                            <option value="ID">Idaho</option>
//                            <option value="IL">Illinois</option>
//                            <option value="IN">Indiana</option>
//                            <option value="IA">Iowa</option>
//                            <option value="KS">Kansas</option>
//                            <option value="KY">Kentucky</option>
//                            <option value="LA">Louisiana</option>
//                            <option value="ME">Maine</option>
//                            <option value="MD">Maryland</option>
//                            <option value="MA">Massachusetts</option>
//                            <option value="MI">Michigan</option>
//                            <option value="MN">Minnesota</option>
//                            <option value="MS">Mississippi</option>
//                            <option value="MO">Missouri</option>
//                            <option value="MT">Montana</option>
//                            <option value="NE">Nebraska</option>
//                            <option value="NV">Nevada</option>
//                            <option value="NH">New Hampshire</option>
//                            <option value="NJ">New Jersey</option>
//                            <option value="NM">New Mexico</option>
//                            <option value="NY">New York</option>
//                            <option value="NC">North Carolina</option>
//                            <option value="ND">North Dakota</option>
//                            <option value="OH">Ohio</option>
//                            <option value="OK">Oklahoma</option>
//                            <option value="OR">Oregon</option>
//                            <option value="PA">Pennsylvania</option>
//                            <option value="RI">Rhode Island</option>
//                            <option value="SC">South Carolina</option>
//                            <option value="SD">South Dakota</option>
//                            <option value="TN">Tennessee</option>
//                            <option value="TX">Texas</option>
//                            <option value="UT">Utah</option>
//                            <option value="VT">Vermont</option>
//                            <option value="VA">Virginia</option>
//                            <option value="WA">Washington</option>
//                            <option value="WV">West Virginia</option>
//                            <option value="WI">Wisconsin</option>
//                            <option value="WY">Wyoming</option>
//                        </select>
//                    </p>
//                    <br/>
//                    <p class="info-wrap">
//                        <label class="form-label" for="changezip2">Change Zip Code</label>
//                        <input type="text" id="changezip2" name="changezip2" class="form-input" value="30605" pattern="[0-9]{5}"/>
//                        <!-- Added a pattern to recognize ZIPs as five digit codes, I assume that's what needed changing?1-->
//                    <!--Address info block ends here-->
//                    </p>
//                    <br>
//                    <h6>(Optional)</h6>
//                    <p class="info-wrap">
//                        <label class="form-label" for="changestreetandnum3">Change Address Line</label>
//                        <input type="text" id="changestreetandnum3" name="changestreetandnum3" class="form-input" value="100 Example Street"/>
//                    </p>
//                    <br>
//                    <p class="info-wrap">
//                        <label class="form-label" for="changecity3">Change City</label>
//                        <input type="text" id="changecity3" name="changecity3" class="form-input" value="Athens"/>
//                    </p>
//                    <br/>
//                    <p class="info-wrap">
//                        <label class="form-label" for="changestate3">Change State</label>
//                        <select id="changestate3" name="changestate3" class="form-input">
//                            <option value="AL">Alabama</option>
//                            <option value="AK">Alaska</option>
//                            <option value="AZ">Arizona</option>
//                            <option value="AR">Arkansas</option>
//                            <option value="CA">California</option>
//                            <option value="CO">Colorado</option>
//                            <option value="CT">Connecticut</option>
//                            <option value="DE">Delaware</option>
//                            <option value="DC">District Of Columbia</option>
//                            <option value="FL">Florida</option>
//                            <option value="GA" selected>Georgia</option>
//                            <option value="HI">Hawaii</option>
//                            <option value="ID">Idaho</option>
//                            <option value="IL">Illinois</option>
//                            <option value="IN">Indiana</option>
//                            <option value="IA">Iowa</option>
//                            <option value="KS">Kansas</option>
//                            <option value="KY">Kentucky</option>
//                            <option value="LA">Louisiana</option>
//                            <option value="ME">Maine</option>
//                            <option value="MD">Maryland</option>
//                            <option value="MA">Massachusetts</option>
//                            <option value="MI">Michigan</option>
//                            <option value="MN">Minnesota</option>
//                            <option value="MS">Mississippi</option>
//                            <option value="MO">Missouri</option>
//                            <option value="MT">Montana</option>
//                            <option value="NE">Nebraska</option>
//                            <option value="NV">Nevada</option>
//                            <option value="NH">New Hampshire</option>
//                            <option value="NJ">New Jersey</option>
//                            <option value="NM">New Mexico</option>
//                            <option value="NY">New York</option>
//                            <option value="NC">North Carolina</option>
//                            <option value="ND">North Dakota</option>
//                            <option value="OH">Ohio</option>
//                            <option value="OK">Oklahoma</option>
//                            <option value="OR">Oregon</option>
//                            <option value="PA">Pennsylvania</option>
//                            <option value="RI">Rhode Island</option>
//                            <option value="SC">South Carolina</option>
//                            <option value="SD">South Dakota</option>
//                            <option value="TN">Tennessee</option>
//                            <option value="TX">Texas</option>
//                            <option value="UT">Utah</option>
//                            <option value="VT">Vermont</option>
//                            <option value="VA">Virginia</option>
//                            <option value="WA">Washington</option>
//                            <option value="WV">West Virginia</option>
//                            <option value="WI">Wisconsin</option>
//                            <option value="WY">Wyoming</option>
//                        </select>
//                    </p>
//                    <br/>
//                    <p class="info-wrap">
//                        <label class="form-label" for="changezip3">Change Zip Code</label>
//                        <input type="text" id="changezip3" name="changezip3" class="form-input" value="30605" pattern="[0-9]{5}"/>
//                        <!-- Added a pattern to recognize ZIPs as five digit codes, I assume that's what needed changing?1-->
//                    </p>
//                    <hr>
//                    <div class="form-submit">
//                        <input type="submit" value="Submit Changes"/>
//                        <!-- Wouldn't recommend using js redirect function to redirect a form, it does not store in the url I think onclick="location.href='Homepage.jsp';"-->
//                    </div>

                    <%--
                    For this one, all the relevant information is stored in the request.getParameters, so we can use an email verfication
                    with this request stored so the user will have to input code before we make changes to the database.
                    --%>
                    <%--

                        String dbURL = "jdbc:mysql://localhost:3306/bookstore?serverTimezone=EST";
                        String username = "root";
                        String password = "WebProg2020";
                        //try {
                            Connection connection = DriverManager.getConnection(dbURL, username, password);
                            String selectUserQuery = "SELECT firstName, lastName FROM User WHERE userID = ???"; //userID needs to be the userID of the currently logged in user
                            String selectPaymentQuery = "SELECT cardNumber, cardExpirationDate, cvv FROM PaymentMethod WHERE userID = ???";
                            String selectAddressQuery = "SELECT streetAddress, city, state, zipCode, country FROM Address WHERE userID = ???";
                            PreparedStatement pstmt1 = connection.prepareStatement(selectUserQuery);
                            PreparedStatement pstmt2 = connection.prepareStatement(selectPaymentQuery);
                            PreparedStatement pstmt3 = connection.prepareStatement(selectAddressQuery);
                            ResultSet userResults = pstmt1.executeQuery(selectUserQuery);
                            ResultSet paymentResults = pstmt2.executeQuery(selectPaymentQuery);
                            ResultSet addressResults = pstmt3.executeQuery(selectAddressQuery);

                            /*
                            //here, update the html elements here with the values of the database in the textfields
                            document.getElementById("changefirstname").value = ;
                            document.getElementById("changelastname").value = ;
                            document.getElementById("changecreditnum").value = ;
                            document.getElementById("changeexpdate").value = ;
                            document.getElementById("changecvv").value = ;
                            document.getElementById("changestreetandnum").value = ;
                            document.getElementById("changecity").value = ;
                            document.getElementById("changestate").value = ;


                            //then, when submit button is pressed:
                            //use several if statements to check if new information has been added:

                            String queryContent = "";

                            if(!firstName.equals(newFirstName)){
                                queryContent += "firstName = " + newFirstName + ", ";
                            }

                            String updateQuery = "UPDATE User SET " + queryContent + " Where User = userID";
                            PreparedStatement pstmt4 = connection.prepareStatement(updateQuery);
                            //and then execute update query here
                            */

                        //}
                        //catch (SQLException e){
                            //e.printStackTrace();
                        //}
                    --%>
//                </form>
//            </div>
//        </div>
//        <br>
//    </main>
//</div>

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
    }
%>
</html>
