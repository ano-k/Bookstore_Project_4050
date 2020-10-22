<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <link rel="stylesheet" href="stylesheet.css">
    <title>View Cart</title>

</head>
<body>
<h1 class="page-header">View Cart</h1>
<div class="cart-information">
    <h4 id="order-sum">Order Summary (List all books being purchased)</h4>
        <ul style="list-style-type:none;">
            <li class="cart-items">
                <form>
                <div class="item">
                <button>[x]</button>
                <label>Book 1 $12.25 | Quantity:</label>
                <input type="number" id="quantity-1" name="quantity-1" min="1" max="100" placeholder="1">
                <br>
                </div>
                <div class="item">
                <button>[x]</button>
                <label>Book 2 $1.50 | Quantity:</label>
                <input type="number" id="quantity-2" name="quantity-2" min="1" max="100" placeholder="1">
                <br>
                </div>
                <div class="item">
                <button>[x]</button>
                <label>Book 3 $9.25 | Quantity:</label>
                <input type="number" id="quantity-3" name="quantity-3" min="1" max="100" placeholder="1">
                </div>
                </form>
            </li>
        <li>
            <h1>Total: $111.00</h1>
            <h4>[x] = remove from cart</h4>
        </li>
    </ul>
</div>

<nav class="nav-bar">
    <button><a>Update Order</a></button>
    <button><a>Continue to Checkout</a></button>
</nav>

<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
</body>
</html>
