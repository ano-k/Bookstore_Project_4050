<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <link rel="stylesheet" href="stylesheet.css">
    <title>Homepage</title>

</head>
<body>
<div class="top">
    <h1>Online Bookstore</h1>
    <nav class="buttons">
        <button><a href="Profile.jsp">Profile</a></button>
        <button><a href="Login.jsp">Login</a></button>
        <button><a href="Signup.jsp">Signup</a></button>
        <button><a href="ViewCart.jsp">Cart</a></button>
    </nav>
</div>

<div class="search">
    <input type="text" placeholder="Search title, author, ISBN, ..."/>
</div>

<div class="filters">
    <form>
        <h3>Genre</h3>
        <input type="checkbox" id="genre1" name="genre1" value="scifi">
        <label for="genre1">Science Fiction</label><br>
        <input type="checkbox" id="genre2" name="genre2" value="nonfiction">
        <label for="genre2">Nonfiction</label><br>
        <input type="checkbox" id="genre3" name="genre3" value="fiction">
        <label for="genre3">Fiction</label><br>
        <br/>
        <h3>Price</h3>
        <input type="checkbox" id="price1" name="price1" value="hi2lo">
        <label for="price1">High to low</label><br>
        <input type="checkbox" id="price2" name="price2" value="lo2hi">
        <label for="price2">Low to high</label><br>
        <input type="submit" value="Submit">
    </form>
</div>

<div class="books">
    <table style="width:100%">
        <tr>
            <th>Book Image</th>
            <th>Book Details</th>
        </tr>
        <tr>
            <td><img src="harrypotter.jpg"/></td>
            <td>
                Title: Harry Potter and the Socerer's Stone <br>
                Author: JK Rowling <br>
                Rating: 3 <br>
                Price: $10
            </td>
        </tr>
        <tr>
            <td><img src="seuss.jpg"/></td>
            <td>
                Title: The Cat in the Hat<br>
                Author: Dr. Seuss<br>
                Rating: 4<br>
                Price: $7.50
            </td>
        </tr>
        <tr>
            <td><img src="theory.jpg"/></td>
            <td>
                Title:  Introduction to Theory of Computation<br>
                Author: Michael Sipser<br>
                Rating: 5<br>
                Price: $20
            </td>
        </tr>
        <tr>
            <td><img src="ahsoka.jpg"/></td>
            <td>
                Title:  Star Wars: Ahsoka<br>
                Author: E.K. Johnston<br>
                Rating: 2<br>
                Price: $9
            </td>
        </tr>
    </table>
</div>

<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
</body>
</html>
