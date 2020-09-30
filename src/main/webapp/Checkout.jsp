<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <link rel="stylesheet" href="stylesheet.css">
    <title>Checkout</title>

</head>
<body>

<div class="top">
    <h1>Online Bookstore</h1>
</div>

<h3>Checkout</h3>
<br>
<ul style="list-style-type:none;">
    <li>
        <label>Name</label>
        <p>John Doe</p>
    </li>
    <li>
        <label>Payment Info</label>
        <p>Credit Card Number: ***********4578 [Visa]</p>
        <button><a href="EditProfile.jsp">Change Credit Card</a></button>
    </li>
    <li>
        <label>Address</label>
        <p>100 Example Street</p>
        <button><a href="EditProfile.jsp">Change Address</a></button>
    </li>
    <li>
        <h4>Order Summary (List all books being purchased)</h4>

        <ul style="list-style-type:none;">
            <form>
                <button>[x]</button>
                <label>Book 1 $12.25 | Quantity:</label>
                <input type="number" id="quantity-1" name="quantity-1" min="1" max="100" placeholder="1">
                <br>
                <button>[x]</button>
                <label>Book 2 $1.50 | Quantity:</label>
                <input type="number" id="quantity-2" name="quantity-2" min="1" max="100" placeholder="1">
                <br>
                <button>[x]</button>
                <label>Book 3 $9.25 | Quantity:</label>
                <input type="number" id="quantity-3" name="quantity-3" min="1" max="100" placeholder="1">
            </form>
        </ul>
        <h1>Total: $111.00</h1>

        <h4>[x] = remove from cart</h4>
    </li>
</ul>

<nav>
    <button><a href="Homepage.jsp">Update O</a></button>
    <button><a>Confirm Order</a></button>
</nav>

<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
</body>
</html>
