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
<div class="top">
    <h1 class="page-header">Online Bookstore</h1>
    <br/>
    <div class="cart-information">
    <h2 class="page-header">Welcome Back!</h2>
    <h6 class="page-header">We've missed you! :)</h6><br>
    <form class ="input-form">
        <p class="info-wrap">
            <label class="form-label" for="useremail">Email</label>
            <input type="text" id="useremail" name="useremail" class="form-input"/>
        </p>
        <br/>
        <p class="info-wrap">
            <label class="form-label" for="userpassword">Password</label>
            <input type="password" id="userpassword" name="userpassword" class="form-input"/>
        </p>
        <br/>
        <div class="form-submit">
            <input type="submit" value="Login" onclick="location.href='Homepage.jsp';"/>
        </div>
    </form>
    </div>
</div>




<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
</body>
</html>
