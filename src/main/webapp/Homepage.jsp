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
    <style>
        .hp-sidebar {
            width: 25%;
            float: left;
        }

        .homepage-table {
            width: 75%;
            float: right;
        }


        .temp-information {
            margin: 20px;
            padding: 20px;
            background-color: lightblue;
            border-radius: 15px;
            display: flex;
        }


        .temp-block {
            float: left;
            margin-right: 20px;
            padding-top: 20px;
            margin-bottom: 20px;
        }

        .search-bar {
            float: left;
        }

    </style>
</head>
<body>
    <h1 class="page-header">Online Bookstore</h1>
    <nav id ="nav_menu">
        <a href="Homepage.jsp">Find Books</a>
        <a href="Login.jsp" class="current">Login/Register</a>
        <a href="ViewCart.jsp">View Cart</a>
        <a href="EditProfile.jsp">Edit Profile</a>
        <a href="OrderHistory.html">Order History</a>
    </nav>
<div class="temp-information">
    <div class="hp-sidebar">
        <div class="search-bar">
            <input id="search-bar" type="text" placeholder="Search title, author, ISBN, ..."/>
        </div>

        <div class="filters">
            <form>
                <div class="parent-filter-div">
                    <div class="temp-block">
                        <h3>Genre</h3>
                            <input type="checkbox" id="genre1" name="genre1" value="scifi">
                            <label for="genre1">Science Fiction</label><br>
                            <input type="checkbox" id="genre2" name="genre2" value="nonfiction">
                            <label for="genre2">Nonfiction</label><br>
                            <input type="checkbox" id="genre3" name="genre3" value="fiction">
                            <label for="genre3">Fiction</label><br>
                    </div>
                    <div class="temp-block">
                        <h3>Price</h3>
                        <input type="checkbox" id="price1" name="price1" value="hi2lo">
                        <label for="price1">High to low</label><br>
                        <input type="checkbox" id="price2" name="price2" value="lo2hi">
                        <label for="price2">Low to high</label><br>
                        <input type="submit" value="Submit">
                    </div>
                </div>
            </form>
        </div>
    </div>

    
    <div class="homepage-table">
    
        <h4>Featured Books</h4>
        <table>
            <tr>
                <th>Book Image</th>
                <th>Book Details</th>
                <th>Link</th>
                <th>Add to Cart</th>
            </tr>
            <tr class="homepage-book-row">
                <td><a href="BookDetails.jsp"><img src="harrypotter.jpg"/></a></td>
                <td>
                Title: Harry Potter and the Socerer's Stone <br>
                Author: JK Rowling <br>
                Rating: 3 <br>
                Price: $10
                </td>
                <td>
                    <button><a href="BookDetails.jsp">Book Page</a></button>
                </td>
                <td>
                    <button><a href="">Add to Cart</a></button>
                </td>
            </tr>
            <tr class="homepage-book-row">
                <td><img src="seuss.jpg"/></td>
                <td>
                Title: The Cat in the Hat<br>
                Author: Dr. Seuss<br>
                Rating: 4<br>
                Price: $7.50
                </td>
                <td>
                    <button><a href="BookDetails.jsp">Book Page</a></button>
                </td>
                <td>
                    <button><a href="">Add to Cart</a></button>
                </td>
            </tr>
        </table>

        <br>
        <h4>Best Sellers</h4>
        <table>
            <tr>
                <th>Book Image</th>
                <th>Book Details</th>
                <th>Link</th>
                <th>Add to Cart</th>
            </tr>
            <tr class="homepage-book-row">
                <td><img src="theory.jpg"/></td>
                <td>
                    Title:  Introduction to Theory of Computation<br>
                    Author: Michael Sipser<br>
                    Rating: 5<br>
                    Price: $20
                </td>
                <td>
                    <button><a href="BookDetails.jsp">Book Page</a></button>
                </td>
                <td>
                    <button><a href="">Add to Cart</a></button>
                </td>
            </tr>
            <tr class="homepage-book-row">
                <td><img src="ahsoka.jpg"/></td>
                <td>
                    Title:  Star Wars: Ahsoka<br>
                    Author: E.K. Johnston<br>
                    Rating: 2<br>
                    Price: $9
                </td>
                <td>
                    <button><a href="BookDetails.jsp">Book Page</a></button>
                </td>
                <td>
                    <button><a href="">Add to Cart</a></button>
                </td>
            </tr>
        </table>
    </div>
</div>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
</body>
</html>
