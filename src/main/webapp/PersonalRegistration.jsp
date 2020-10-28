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
    <title>Personal Registration</title>

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
                <a href="Login.jsp" class="current">Login/Register</a>
                <a href="ViewCart.jsp">View Cart</a>
                <a href="EditProfile.jsp">Edit Profile</a>
                <a href="OrderHistory.html">Order History</a>
            </nav>

            <div class="main_content">
                <div class="cart-information">
                    <h2 class="registration-header">Enter your personal information:</h2>
                    <h5>* - indicates required field</h5>
                    <br>
                    <form class="input-form" method="post" action="PersonalRegistration.jsp">
                        <p class="info-wrap">
                            <label class="form-label" for="firstname"> * First Name</label>
                            <input type="text" id="firstname" name="firstname" class="form-input"/>
                        </p>
                        <br/>
                        <p class="info-wrap">
                            <label class="form-label" for="lastname">* Last Name</label>
                            <input type="text" id="lastname" name="lastname" class="form-input"/>
                        </p>
                        <br/>
                        <p class="info-wrap">
                            <label class="form-label" for="email">* Email</label>
                            <input type="text" id="email" name="email" class="form-input"/>
                        </p>
                        <br/>
                        <p class="info-wrap">
                            <label class="form-label" for="password">* Password</label>
                            <input type="password" id="password" name="password" class="form-input"/>
                        </p>
                        <br/>
                        <p class="info-wrap">
                            <label class="form-label" for="confirmpassword">* Confirm Password</label>
                            <input type="password" id="confirmpassword" name="confirmpassword" class="form-input"/>
                        </p>
                        <br/>
                        <p class="form-submit">
                            <input type="submit" value="Submit" onclick="location.href='PaymentRegistration.jsp';"/>
                        </p>
                        <br>
                        <br>
                    </form>
                </div>
            </div>
            <%
                String to = request.getParameter("email");
                System.out.println(to);//DELETE LATER
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

                        context.setSubject("Testing out my mail sending code!");
                        context.setText("Thanks for signing up for our Bookstore!");
                        System.out.println("sending email...");
                        Transport.send(context);
                        System.out.println("Message sent successfully.");
                    }
                }catch(MessagingException mE){
                    mE.printStackTrace();
                }
            %>
        </main>
    </div>

    <div class="column right"></div>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
</body>
</html>
