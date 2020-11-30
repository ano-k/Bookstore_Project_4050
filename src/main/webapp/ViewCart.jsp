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
            userID = request.getParameter("currentUserID").replaceAll("/","");
        }

        String dbURL = "jdbc:mysql://localhost:3306/bookstore?serverTimezone=EST";
        String dbUsername = "root";
        String dbPassword = "Hakar123";

        try {
            Connection connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
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
                <%if(!request.getParameter("currentUserType").equals("0")){ %>
                <li><form id ="manage_store" method="post" action="AdminHomepage.jsp">
                    <a href="javascript:{}" onclick="document.getElementById('find_books').submit();">Manage store</a>
                    <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                    <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=userType%>/>
                    <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=userID%>/>
                </form></li>
                <%}%>
                <li><form id ="find_books" method="post" action="Homepage.jsp">
                    <a href="javascript:{}" onclick="document.getElementById('find_books').submit();">Find Books</a>
                    <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=userEmail%>/>
                    <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=userID%>/>
                    <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>
                </form></li>
                <li><form id ="login_edit" method="post" action=<%if(request.getParameter("currentUserEmail") == null){%>
                        "/Bookstore_Project_4050_war_exploded/Login.jsp" <%}else {%>
                    "/Bookstore_Project_4050_war_exploded/EditProfile.jsp"
                    <%}%>>
                    <a href="javascript:{}" onclick="document.getElementById('login_edit').submit();"><%if(request.getParameter("currentUserEmail") == null){%>
                        Login<%}else {%>Profile<%}%></a>
                    <%if(request.getParameter("currentUserEmail") != null){%>
                    <input type="hidden" id="currentUserEmail" name="currentUserEmail" class="form-input" value = <%=request.getParameter("currentUserEmail")%>/>
                    <input type="hidden" id="currentUserID" name="currentUserID" class="form-input" value = <%=request.getParameter("currentUserID")%>/>
                    <input type="hidden" id="currentUserType" name="currentUserType" class="form-input" value = <%=request.getParameter("currentUserType")%>/>
                </form></li>
                <li><form class= "log_out" id ="log_out" method="post" action="Login.jsp">
                    <a href="javascript:{}" onclick="document.getElementById('log_out').submit();">Log Out</a>
                </form></li>
                <%}%>

            </ul>
        </nav>
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
