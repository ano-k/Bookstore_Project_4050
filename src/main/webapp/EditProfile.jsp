<%--
  Created by IntelliJ IDEA.
  User: mpcer
  Date: 9/29/2020
  Time: 10:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                <form class ="input-form">
                    <h4>Personal Info</h4>
                    <br>
                    <p class="info-wrap">
                        <label class="form-label" for="changefirstname">Change First Name</label>
                        <input type="text" id="changefirstname" name="changefirstname" class="form-input" value="John"/>
                    </p>
                    <br/>
                    <p class="info-wrap">
                        <label class="form-label" for="changelastname">Change Last Name</label>
                        <input type="text" id="changelastname" name="changelastname" class="form-input" value="Doe"/>
                    </p>
                    <hr>
                    <br/>
                    <h4>Password</h4>
                    <br>
                    <p class="info-wrap">
                        <label class="form-label" for="changepassword">Change Password</label>
                        <input type="password" id="changepassword" name="changepassword" class="form-input" value="current password"/>
                    </p>
                    <br/>
                    <p class="info-wrap">
                        <label class="form-label" for="confchangepassword">Confirm Changed Password</label>
                        <input type="password" id="confchangepassword" name="confchangepassword" class="form-input" value="currentpass"/>
                    </p>
                    <hr>
                    <br>
                    <h4>Payment Info</h4>
                    <br>
                    <p class="info-wrap">
                        <label class="form-label" for="changecreditnum">Change Credit Card Number</label>
                        <input type="text" id="changecreditnum" name="changecreditnum" class="form-input" value="123456789"/>
                    </p>
                    <br>
                    <p class="info-wrap">
                        <label class="form-label" for="changeexpdate">Change Expiration</label>
                        <input type="month" id="changeexpdate" name="changeexpdate" min="2020-09" value="2020-10" class="form-input"/>
                    </p>
                    <br>
                    <p class="info-wrap">
                        <label class="form-label" for="changecvv">Change CVV</label>
                        <input type="text" id="changecvv" name="changecvv" class="form-input" value="1234"/>
                    </p>
                    <hr>
                    <br>
                    <h4>Address Info</h4>
                    <br>
                    <p class="info-wrap">
                        <label class="form-label" for="changestreetandnum">Change Address Line</label>
                        <input type="text" id="changestreetandnum" name="changestreetandnum" class="form-input" value="100 Example Street"/>
                    </p>
                    <br/>
                    <p class="info-wrap">
                        <label class="form-label" for="changecity">Change City</label>
                        <input type="text" id="changecity" name="changecity" class="form-input" value="Athens"/>
                    </p>
                    <br/>
                    <p class="info-wrap">
                        <label class="form-label" for="changestate">Change State</label>
                        <select id="changestate" name="changestate" class="form-input">
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
                            <option value="GA" selected>Georgia</option>
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
                    </p>
                    <br/>
                    <p class="info-wrap">
                        <label class="form-label" for="changezip">Change Zip Code</label>
                        <input type="text" id="changezip" name="changezip" class="form-input" value="30605"/>
                    </p>
                    <hr>
                    <br>
                    <div class="form-submit">
                        <input type="submit" value="Submit Changes" onclick="location.href='Homepage.jsp';"/>
                    </div>
                </form>
            </div>
        </div>
        <br>
    </main>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
</body>
</html>
