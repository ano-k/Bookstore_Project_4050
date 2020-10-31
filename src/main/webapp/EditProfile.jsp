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
        String userEmail = request.getParameter("currentUserEmail").replaceAll("/","");

        String dbURL = "jdbc:mysql://localhost:3306/bookstore?serverTimezone=EST";
        String dbUsername = "root";
        String dbPassword = "WebProg2020";
        try {
            Connection connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

            if(request.getParameter("editAddressButton") != null) {
                String updateAddressQuery = "UPDATE Address SET Street = ?, City = ?, State = ?, Zipcode = ? WHERE ID = ? ";
                PreparedStatement pstmt6 = connection.prepareStatement(updateAddressQuery);
                pstmt6.setString(1, request.getParameter("updateStreetAddress"));
                pstmt6.setString(2, request.getParameter("updateCity"));
                pstmt6.setString(3, request.getParameter("updateState"));
                pstmt6.setInt(4, (int)Integer.parseInt(request.getParameter("updateZipCode")));
                pstmt6.setInt(5, (int)Integer.parseInt(request.getParameter("addressID")));
                pstmt6.executeUpdate();
            }

            if(request.getParameter("editPaymentButton") != null) {
                String updatePaymentQuery = "UPDATE Payment SET Type = ?, Number = ?, Expiration = ?, CVV = ? WHERE ID = ? ";
                PreparedStatement pstmt6 = connection.prepareStatement(updatePaymentQuery);
                pstmt6.setString(1, request.getParameter("updateCardType"));
                pstmt6.setString(2, request.getParameter("updateCardNumber"));
                pstmt6.setString(3, request.getParameter("updateExpirationDate"));
                pstmt6.setInt(4, (int)Integer.parseInt(request.getParameter("updateCVV")));
                pstmt6.setInt(5, (int)Integer.parseInt(request.getParameter("paymentID")));
                pstmt6.executeUpdate();
            }

            if(request.getParameter("editPersonalButton") != null) {
                String updatePersonalQuery = "UPDATE Users SET FirstName = ?, LastName = ?, Phone = ? WHERE Email = ? ";
                PreparedStatement pstmt7 = connection.prepareStatement(updatePersonalQuery);
                pstmt7.setString(1, request.getParameter("updateFirstName"));
                pstmt7.setString(2, request.getParameter("updateLastName"));
                pstmt7.setString(3, request.getParameter("updatePhoneNumber"));
                pstmt7.setString(4, userEmail);
                pstmt7.executeUpdate();
            }

            if(request.getParameter("deleteAddressButton") != null) {
                String deleteAddressQuery = "DELETE FROM Address WHERE ID = ?";
                PreparedStatement pstmt8 = connection.prepareStatement(deleteAddressQuery);
                pstmt8.setInt(1, (int)Integer.parseInt(request.getParameter("addressID")));
                int row = pstmt8.executeUpdate();
            }

            if(request.getParameter("deletePaymentButton") != null) {
                String deletePaymentQuery = "DELETE FROM Payment WHERE ID = ?";
                PreparedStatement pstmt9 = connection.prepareStatement(deletePaymentQuery);
                pstmt9.setInt(1, (int)Integer.parseInt(request.getParameter("paymentID")));
                int row = pstmt9.executeUpdate();
            }

            if(request.getParameter("addAddressButton") != null) {
                String addAddressQuery = "INSERT INTO Address (User, Street, City, State, Zipcode) VALUES (?, ?, ?, ?, ?) ";
                PreparedStatement pstmt10 = connection.prepareStatement(addAddressQuery);
                pstmt10.setString(1, userEmail);
                pstmt10.setString(2, request.getParameter("addStreetAddress"));
                pstmt10.setString(3, request.getParameter("addCity"));
                pstmt10.setString(4, request.getParameter("addState"));
                pstmt10.setInt(5, (int)Integer.parseInt(request.getParameter("addZipCode")));
                pstmt10.executeUpdate();
            }

            if(request.getParameter("addPaymentButton") != null) {
                String addPaymentQuery = "INSERT INTO Payment (User, Type, Number, Expiration, CVV) VALUES (?, ?, ?, ?, ?) ";
                PreparedStatement pstmt11 = connection.prepareStatement(addPaymentQuery);
                pstmt11.setString(1, userEmail);
                pstmt11.setString(2, request.getParameter("addCardType"));
                pstmt11.setString(3, request.getParameter("addCardNumber"));
                pstmt11.setString(4, request.getParameter("addExpirationDate"));
                pstmt11.setInt(5, (int)Integer.parseInt(request.getParameter("addCVV")));
                pstmt11.executeUpdate();
            }

            if(request.getParameter("editPasswordButton") != null) {
                String updatePasswordQuery = "UPDATE Users SET Password = ? WHERE Email = ? ";
                PreparedStatement pstmt12 = connection.prepareStatement(updatePasswordQuery);
                pstmt12.setString(1, request.getParameter("confirmNewPassword"));
                pstmt12.setString(2, userEmail);
                pstmt12.executeUpdate();
            }

            //address info query
            String addressQuery = "SELECT * FROM Address WHERE User = ? "; //get a list of usernames of the logged in user
            PreparedStatement pstmt1 = connection.prepareStatement(addressQuery);
            pstmt1.setString(1, userEmail);
            ResultSet addressResults = pstmt1.executeQuery();

            //payment info query
            String paymentQuery = "SELECT * FROM Payment WHERE User = ? "; //get a list of payments of the logged in user
            PreparedStatement pstmt2 = connection.prepareStatement(paymentQuery);
            pstmt2.setString(1, userEmail);
            ResultSet paymentResults = pstmt2.executeQuery();

            //personal info query
            String personalQuery = "SELECT * FROM Users WHERE Email = ? "; //get a list of personal info of the logged in user
            PreparedStatement pstmt3 = connection.prepareStatement(personalQuery);
            pstmt3.setString(1, userEmail);
            ResultSet personalResults = pstmt3.executeQuery();

            //states table query
            String statesQuery = "SELECT * FROM States"; //get a list of states
            PreparedStatement pstmt4 = connection.prepareStatement(statesQuery);
            ResultSet statesResults = pstmt4.executeQuery();

            //card types table query
            String cardTypesQuery = "SELECT * FROM CardTypes"; //get a list of card types
            PreparedStatement pstmt5 = connection.prepareStatement(cardTypesQuery);
            ResultSet cardTypesResults = pstmt5.executeQuery();

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
                                <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/EditProfile.jsp" method="post">
                                    <div class="modal-body">
                                        <div class="container">
                                            <div class="form-row">
                                                <div class="form-group col-md-6">
                                                    <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=request.getParameter("currentUserEmail")%>/>
                                                    <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=request.getParameter("currentUserID")%>/>
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
                                                    <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=request.getParameter("currentUserEmail")%>/>
                                                    <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=request.getParameter("currentUserID")%>/>
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
                                <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/EditProfile.jsp" method="post">
                                    <div class="modal-body">
                                        <div class="container">
                                            <div class="form-row">
                                                <div class="form-group col-md">
                                                    <input type="hidden" id="addressID" name="addressID" value="<%=addressResults.getInt(1)%>"/>
                                                    <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=request.getParameter("currentUserEmail")%>/>
                                                    <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=request.getParameter("currentUserID")%>/>
                                                    <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>
                                                    <label class="form-label" for="updateStreetAddress">Address</label>
                                                    <input type="text" id="updateStreetAddress" name="updateStreetAddress" class="form-input" value="<%=addressResults.getString(3)%>"/>
                                                </div>
                                            </div>
                                            <div class="form-row">
                                                <div class="form-group col-md-5">
                                                    <label class="form-label" for="updateCity">City</label>
                                                    <input type="text" id="updateCity" name="updateCity" class="form-input" value="<%=addressResults.getString(4)%>"/>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <label class="form-label" for="updateState">State</label>
                                                    <select id="updateState" name="updateState" class="form-input">
                                                        <%
                                                            statesResults = pstmt4.executeQuery();
                                                            while(statesResults.next()){ %>
                                                            <option value = <%=statesResults.getString(2)%> <%if(statesResults.getString(2).equals(addressResults.getString(5))){%> selected <%}%> > <%=statesResults.getString(2)%> </option>
                                                        <%}%>
                                                    </select>
                                                </div>
                                                <div class="form-group col-md-3">
                                                    <label class="form-label" for="updateZipCode">Zip Code</label>
                                                    <input type="text" id="updateZipCode" name="updateZipCode" class="form-input" value="<%=addressResults.getInt(6)%>"/>
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
                                                    <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=request.getParameter("currentUserEmail")%>/>
                                                    <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=request.getParameter("currentUserID")%>/>
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
                            <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/EditProfile.jsp" method="post">
                                <div class="modal-body">
                                    <div class="container">
                                        <div class="form-row">
                                            <div class="form-group col-md">
                                                <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=request.getParameter("currentUserEmail")%>/>
                                                <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=request.getParameter("currentUserID")%>/>
                                                <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>
                                                <label class="form-label" for="addStreetAddress">Address</label>
                                                <input type="text" id="addStreetAddress" name="addStreetAddress" class="form-input"/>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-5">
                                                <label class="form-label" for="addCity">City</label>
                                                <input type="text" id="addCity" name="addCity" class="form-input"/>
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
                                                <input type="text" id="addZipCode" name="addZipCode" class="form-input"/>
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
                <button type="button" class="btn btn-success" data-toggle="modal" data-target=<%="#addAddress"%>>
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
                                                    <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=request.getParameter("currentUserEmail")%>/>
                                                    <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=request.getParameter("currentUserID")%>/>
                                                    <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>
                                                    <label class="form-label" for="updateCardType">Card Type</label>
                                                    <select id="updateCardType" name="updateCardType" class="form-input">
                                                        <%
                                                            while(cardTypesResults.next()){ %>
                                                        <option value = <%=cardTypesResults.getString(2)%> <%if(cardTypesResults.getString(2).equals(paymentResults.getString(3))){%> selected <%}%> > <%=cardTypesResults.getString(2)%> </option>
                                                        <%}%>
                                                    </select>
                                                    <%-- <script> compareValue("newCardType", "<%=paymentResults.getString(3)%>"); </script> --%>
                                                </div>
                                                <div class="form-group col-md-8">
                                                    <label class="form-label" for="updateCardNumber">Card Number</label>
                                                    <input type="text" id="updateCardNumber" name="updateCardNumber" class="form-input" value="<%=paymentResults.getString(4)%>"/>
                                                </div>
                                            </div>
                                            <div class="form-row">
                                                <div class="form-group col-md-6">
                                                    <label class="form-label" for="updateExpirationDate">Expiration Date</label>
                                                    <input type="text" id="updateExpirationDate" name="updateExpirationDate" class="form-input" value="<%=paymentResults.getString(5)%>"/>
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <label class="form-label" for="updateCVV">CVV</label>
                                                    <input type="text" id="updateCVV" name="updateCVV" class="form-input" value="<%=paymentResults.getString(6)%>"/>
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
                                                    <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=request.getParameter("currentUserEmail")%>/>
                                                    <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=request.getParameter("currentUserID")%>/>
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
                            <form class ="input-form" action="/Bookstore_Project_4050_war_exploded/EditProfile.jsp" method="post">
                                <div class="modal-body">
                                    <div class="container">
                                        <div class="form-row">
                                            <div class="form-group col-md-4">
                                                <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=request.getParameter("currentUserEmail")%>/>
                                                <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=request.getParameter("currentUserID")%>/>
                                                <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>
                                                <label class="form-label" for="addCardType">Card Type</label>
                                                <select class="form-input" id="addCardType" name="addCardType">
                                                    <option value="Visa" selected>Visa</option>
                                                    <option value="Amex">Amex</option>
                                                    <option value="MasterCard">MasterCard</option>
                                                </select>
                                            </div>
                                            <div class="form-group col-md-8">
                                                <label class="form-label" for="addCardNumber">Card Number</label>
                                                <input type="text" id="addCardNumber" name="addCardNumber" class="form-input" />
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-6">
                                                <label class="form-label" for="addExpirationDate">Expiration Date</label>
                                                <input type="text" id="addExpirationDate" name="addExpirationDate" class="form-input" />
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label class="form-label" for="addCVV">CVV</label>
                                                <input type="text" id="addCVV" name="addCVV" class="form-input" />
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
