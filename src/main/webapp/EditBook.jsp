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
    <button class="mng-books"><a>Back</a></button>
    <h1 class="page-header">Edit Book</h1>

    <div class="cart-information">
        <table>
            <tr>
                <th>Book Image</th>
                <th>Book Details</th>
                <th>Link</th>
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
            </tr>
        </table>    

        <table class="homepage-table">
        <tr>
            <th>Book Image Link</th>
            <th>Book Price</th>
            <th>Title</th>
            <th>Promotion</th>
        </tr>
        <tr class="homepage-book-row">
            <form>
            <td>
                <input type="text" id="link" name="link">
            </td>
            <td>
                <input type="text" id="link" name="link">
            </td>
            <td>
                <input type="text" id="link" name="link">
            </td>
            <td>
                <input type="text" id="link" name="link">
            </td>
                <br><br><br>
            <input type="submit" text="Submit">
            </form>
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
