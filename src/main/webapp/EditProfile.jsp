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
        String redirect = new String("/Bookstore_Project_4050_war_exploded/Login.jsp");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", redirect);
    } //checks if the user is already logged in
    else {
        String dbURL = "jdbc:mysql://localhost:3306/bookstore?serverTimezone=EST";
        String dbUsername = "root";
        String dbPassword = "WebProg2020";
        try {
            //address info query
            Connection connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
            String addressQuery = "SELECT * FROM Address WHERE User = ? "; //get a list of usernames of the logged in user
            PreparedStatement pstmt1 = connection.prepareStatement(addressQuery);
            pstmt1.setString(1, request.getParameter("currentUserEmail").substring(0, request.getParameter("currentUserEmail").length()-1));
            ResultSet addressResults = pstmt1.executeQuery();

            //payment info query
            String paymentQuery = "SELECT * FROM Payment WHERE User = ? "; //get a list of payments of the logged in user
            PreparedStatement pstmt2 = connection.prepareStatement(paymentQuery);
            pstmt2.setString(1, request.getParameter("currentUserEmail").substring(0, request.getParameter("currentUserEmail").length()-1));
            ResultSet paymentResults = pstmt2.executeQuery();

            //personal info query
            String personalQuery = "SELECT * FROM Users WHERE Email = ? "; //get a list of personal info of the logged in user
            PreparedStatement pstmt3 = connection.prepareStatement(personalQuery);
            pstmt3.setString(1, request.getParameter("currentUserEmail").substring(0, request.getParameter("currentUserEmail").length()-1));
            ResultSet personalResults = pstmt3.executeQuery();

            //states table query
            String statesQuery = "SELECT * FROM States"; //get a list of states
            PreparedStatement pstmt4 = connection.prepareStatement(statesQuery);
            ResultSet statesResults = pstmt4.executeQuery();

            //card types table query
            String cardTypesQuery = "SELECT * FROM CardTypes"; //get a list of card types
            PreparedStatement pstmt5 = connection.prepareStatement(cardTypesQuery);
            ResultSet cardTypesResults = pstmt5.executeQuery();

            //update address query
            //String updateAddressQuery = "UPDATE Address SET Street = ?, City = ?, State = ?, Zipcode = ? WHERE ID = ?";
            //PreparedStatement pstmt6 = connection.prepareStatement(updateAddressQuery);
            //pstmt6.executeUpdate(updateAddressQuery);

%>

<script>
    function compareValue(id, dbValue) {

        var select = document.getElementById(id);
        var x = select.options.length;

        for (var i = 0; i < x; i++) {
            if (dbValue === select.options[i].value) {
                select.options[i].selected = true;
            }
        }
    }
</script>

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

                <h6 class="page-header">Personal Information</h6>
                <%-- Table for personal information --%>
                <table class="table">
                    <thead class="thead-dark">
                    <tr>
                        <th scope="col">First Name</th>
                        <th scope="col">Last Name</th>
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
                                <div class="modal-body">
                                    <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/EditProfile.jsp" method="post">
                                        <div class="container">
                                            <div class="form-row">
                                                <div class="form-group col-md-6">
                                                    <label class="form-label" for="newFirstName">First Name</label>
                                                    <input type="text" id="newFirstName" name="newFirstName" class="form-input" value="<%=personalResults.getString(6)%>"/>
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <label class="form-label" for="newLastName">Last Name</label>
                                                    <input type="text" id="newLastName" name="newLastName" class="form-input" value="<%=personalResults.getString(7)%>"/>
                                                </div>
                                            </div>
                                            <div class="form-row">
                                                <div class="form-group col-md">
                                                    <label class="form-label" for="newPhoneNumber">Phone Number</label>
                                                    <input type="text" id="newPhoneNumber" name="newPhoneNumber" class="form-input" value="<%=personalResults.getString(8)%>"/>
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

                    <div class="modal fade" id=<%="editPassword_" + personalResults.getInt(1)%> tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Edit Password</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/EditProfile.jsp" method="post">
                                        <div class="container">
                                            <div class="form-row">
                                                <div class="form-group col-md-6">
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

                        <td><%=personalResults.getString(6)%></td>
                        <td><%=personalResults.getString(7)%></td>
                        <td><%=personalResults.getString(8)%></td>
                        <td>
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target=<%="#editPersonal_" + personalResults.getInt(1)%>>
                                Edit
                            </button>
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target=<%="#editPassword_" + personalResults.getInt(1)%>>
                                Edit Password
                            </button>
                        </td>
                    </tr>

                    <% } %>

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
                                <div class="modal-body">
                                    <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/EditProfile.jsp" method="post">
                                        <div class="container">
                                            <div class="form-row">
                                                <div class="form-group col-md">
                                                    <label class="form-label" for="newStreetAddress">Address</label>
                                                    <input type="text" id="newStreetAddress" name="newStreetAddress" class="form-input" value="<%=addressResults.getString(3)%>"/>
                                                </div>
                                            </div>
                                            <div class="form-row">
                                                <div class="form-group col-md-5">
                                                    <label class="form-label" for="newCity">City</label>
                                                    <input type="text" id="newCity" name="newCity" class="form-input" value="<%=addressResults.getString(4)%>"/>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <label class="form-label" for="newState">State</label>
                                                    <select id="newState" name="newState" class="form-input">
                                                        <%
                                                            statesResults = pstmt4.executeQuery();
                                                            while(statesResults.next()){ %>
                                                            <option value = <%=statesResults.getString(2)%> <%if(statesResults.getString(2).equals(addressResults.getString(5))){%> selected <%}%> > <%=statesResults.getString(2)%> </option>
                                                        <%}%>
                                                    </select>
                                                </div>
                                                <div class="form-group col-md-3">
                                                    <label class="form-label" for="newZipCode">Zip Code</label>
                                                    <input type="text" id="newZipCode" name="newZipCode" class="form-input" value="<%=addressResults.getString(6)%>"/>
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

                    <div class="modal fade" id=<%="deleteAddress_" + addressResults.getInt(1)%> tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Delete Address</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/EditProfile.jsp" method="post">
                                        <div class="container">
                                            <div class="form-row">
                                                <div class="form-group col-md">
                                                    <p>Are you sure you want to delete this address?</p>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                    <button type="button" class="btn btn-danger">Delete Address</button>
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
                            <button type="button" class="btn btn-danger" data-toggle="modal" data-target=<%="#deleteAddress_" + addressResults.getInt(1)%>>
                                Delete
                            </button>
                        </td>
                    </tr>

                    <% } %>

                    </tbody>
                </table>
                <div class="modal fade" id=<%="addAddress"%> tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Add Address Information</h5>
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
                                                <input type="text" id="newStreetAddress" name="newStreetAddress" class="form-input"/>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-5">
                                                <label class="form-label" for="newCity">City</label>
                                                <input type="text" id="newCity" name="newCity" class="form-input"/>
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
                                                <input type="text" id="newZipCode" name="newZipCode" class="form-input"/>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button type="button" class="btn btn-primary">Add Address</button>
                            </div>
                        </div>
                    </div>
                </div>
                <% if(countAddressRows < 3) { %>
                <button type="button" class="btn btn-success" data-toggle="modal" data-target=<%="#addPayment"%>>
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
                                <div class="modal-body">
                                    <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/EditProfile.jsp" method="post">
                                        <div class="container">
                                            <div class="form-row">
                                                <div class="form-group col-md-4">
                                                    <label class="form-label" for="newCardType">Card Type</label>
                                                    <select id="newState" name="newState" class="form-input">
                                                        <%
                                                            cardTypesResults = pstmt5.executeQuery();
                                                            while(cardTypesResults.next()){ %>
                                                        <option value = <%=cardTypesResults.getString(2)%> <%if(cardTypesResults.getString(2).equals(paymentResults.getString(3))){%> selected <%}%> > <%=cardTypesResults.getString(2)%> </option>
                                                        <%}%>
                                                    </select>
                                                    <%-- <script> compareValue("newCardType", "<%=paymentResults.getString(3)%>"); </script> --%>
                                                </div>
                                                <div class="form-group col-md-8">
                                                    <label class="form-label" for="newCardNumber">Card Number</label>
                                                    <input type="text" id="newCardNumber" name="newCardNumber" class="form-input" value="<%=paymentResults.getString(4)%>"/>
                                                </div>
                                            </div>
                                            <div class="form-row">
                                                <div class="form-group col-md-6">
                                                    <label class="form-label" for="newExpirationDate">Expiration Date</label>
                                                    <input type="month" id="newExpirationDate" name="newExpirationDate" class="form-input" value="<%=paymentResults.getString(5)%>"/>
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <label class="form-label" for="newCVV">CVV</label>
                                                    <input type="text" id="newCVV" name="newCVV" class="form-input" value="<%=paymentResults.getString(6)%>"/>
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

                    <div class="modal fade" id=<%="deletePayment_" + paymentResults.getInt(1)%> tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Delete Payment Information</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/EditProfile.jsp" method="post">
                                        <div class="container">
                                            <div class="form-row">
                                                <div class="form-group col-md">
                                                    <p>Are you sure you want to delete this payment information?</p>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                    <button type="button" class="btn btn-danger">Delete Payment Information</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <tr>

                        <td><%=paymentResults.getString(3)%></td>
                        <td><%=paymentResults.getString(4)%></td>
                        <td><%=paymentResults.getString(5)%></td>
                        <td><%=paymentResults.getString(6)%></td>
                        <td>
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target=<%="#editPayment_" + paymentResults.getInt(1)%>>
                                Edit
                            </button>
                            <button type="button" class="btn btn-danger" data-toggle="modal" data-target=<%="#deletePayment_" + paymentResults.getInt(1)%>>
                                Delete
                            </button
                        </td>
                    </tr>

                    <% } %>

                    </tbody>
                </table>
                <div class="modal fade" id=<%="addPayment"%> tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Add Payment Information</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/EditProfile.jsp" method="post">
                                    <div class="container">
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
                                <button type="button" class="btn btn-primary">Save changes</button>
                            </div>
                        </div>
                    </div>
                </div>
                <% if(countPaymentRows < 3) { %>
                <button type="button" class="btn btn-success" data-toggle="modal" data-target=<%="#addPayment"%>>
                    Add
                </button>
                <% } %>
            </div>
        </div>
    </main>
</div>

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
