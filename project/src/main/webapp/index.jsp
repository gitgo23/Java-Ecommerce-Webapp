<%@page import="com.learn.helper.FactoryProvider"%>
<%@page import="com.learn.entities.*"%>
<%@page import="com.learn.Dao.ProductDao"%>
<%@page import="com.learn.Dao.CategoryDao"%>
<%@page import="com.learn.entities.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.helper.Helper"%>
<%@page import="java.lang.Integer"%>
<%@page import="java.lang.String"%>

<html>

<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

</head>
<style>
body{
overflow-x: hidden;
}
#cart:hover{
background-color: red;
color: white;
}
#categories:hover{
color: red;
}
#navigation{
background-color: red;
color: white;
}
#books{
font-family: Fantasy, Copperplate; 
color: white; 
font-size: 44px;
}
 .nav-item{
 font-family: Fantasy, Copperplate; 
color: white;
font-size: 27px;
}
.nav-link{

}


</style>
<body>
<nav class="navbar navbar-expand-lg navbar-light" style="background-color: red;">
  <div class="container-fluid">
    <a class="navbar-brand" href="#" id="books">MyBooks</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="index.jsp" style="color: white;">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="login.jsp">Login</a>
        </li>
         <li class="nav-item">
          <a class="nav-link" href="commonfile.jsp">Register</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" onclick="gotocheckout()" href="#" style="color:white;">Check Out</a>
        </li>
      </ul>
      <form class="d-flex">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit" style="color:white;font-family: Fantasy, Copperplate; border-color: white;">Search</button>
      </form>
    </div>
  </div>
</nav>


<div class="row">
<%
          String cat= request.getParameter("index.jsp?category=");
 ProductDao dao= new ProductDao(FactoryProvider.getFactory());
   List <Product>list= dao.getAllProducts();
   CategoryDao cdao= new CategoryDao(FactoryProvider.getFactory());
   List <Category> clist= cdao.getCategories();
   %>
  </div>
</div>
<br>
<h2 style="text-align: center;font-family: Fantasy, Copperplate;">Our Products</h2> 
 <br>        
<div class="card" style="margin-right:0px; padding-right:0px; padding-left:50px; margin-left:10px; " >
<div class="row"style="margin-top:14px;">
  <% for (int i = 0; i < list.size(); i++) { %>
    <% if (i % 4 == 0 && i != 0) { %>
      </div><div class="row">
    <% } %>
    <div class="col-md-3">
      <div class="card" style="width: 18rem;"> 
        <img src="image/<%=list.get(i).getpPhoto()%>" class="card-img-top" alt="...">
        <div class="card-body">
          <h5 class="card-title"><%= list.get(i).getpName() %></h5>
          <p class="card-text"><%=Helper.get10Words(list.get(i).getpDesc())%></p>
          <a id="cart" href="#" onclick="addToCart('<%= list.get(i).getpName() %>', '<%=list.get(i).getpPrice()%>')" class="btn btn-primary">Add to Cart</a>
         <a id="cart" href="#" onclick="removeFromCart('<%= list.get(i).getpName() %>')" class="btn btn-primary" style="margin-top:5px;">Remove from Cart</a>
          <a id="price"  class="btn btn-primary" style="background-color: red; color: white; border-color: red;">Rs.<%=list.get(i).getpPrice()%>/-</a>

          <a id="categories" class="btn btn-primary" style="background-color: white; color: blue; margin-top:5px;"><%=list.get(i).getCategory().getCategoryTitle()%></a>
        
        </div>
      </div>
    </div>

  <% 
  } 
  if (list.size()==0){
  out.println("No Items Found");
  }
  
  %>
</div>
    </div>

<script>

var cartItems = [];
var totalPrice = 0;

function addToCart(title, price) {
    var quantity = prompt("Enter the quantity for " + title + ":");

    if (quantity !== null && quantity !== "") {
        console.log("Title: " + title);
        console.log("Price: " + price);
        console.log("Quantity: " + quantity);

        // Create a new object to represent the added product
        var product = {
            title: title,
            price: price,
            quantity: quantity
        };

        // Add the product to the cartItems array
        cartItems.push(product);

        // Calculate the total price
        calculateTotalPrice();
        displayCartItems();
        sessionStorage.setItem("cartItems", JSON.stringify(cartItems));
    sessionStorage.setItem("totalPrice", totalPrice.toFixed(2));

    } else {
        console.log("Quantity not provided.");
    }
}

function calculateTotalPrice() {
    totalPrice = 0;

    for (var i = 0; i < cartItems.length; i++) {
        var item = cartItems[i];
        var itemPrice = parseFloat(item.price);
        var itemQuantity = parseInt(item.quantity);
        var itemTotalPrice = itemPrice * itemQuantity;

        totalPrice += itemTotalPrice;
    }
}
function removeFromCart(title) {
  // Find the index of the product in the cartItems array
  var index = -1;
  for (var i = 0; i < cartItems.length; i++) {
    if (cartItems[i].title === title) {
      index = i;
      break;
    }
  }

  if (index !== -1) {
    // Ask the user whether to decrease the quantity or remove the whole product
    var confirmMessage = "Do you want to decrease the quantity or remove the whole product?\n";
    confirmMessage += "Click OK to decrease the quantity, or\n";
    confirmMessage += "Click Cancel to remove the whole product.";

    var decreaseQuantity = confirm(confirmMessage);

    if (decreaseQuantity) {
      // Prompt the user to enter the new quantity
      var newQuantity = prompt("Enter the new quantity for " + title + ":");

      if (newQuantity !== null && newQuantity !== "") {
        // Update the quantity of the product
        cartItems[index].quantity = newQuantity;

        // Calculate the total price
        calculateTotalPrice();

        // Display the updated cart items and total price
        displayCartItems();
      } else {
        console.log("Quantity not provided.");
      }
    } else {
      // Remove the whole product from the cartItems array
      cartItems.splice(index, 1);

      // Calculate the total price
      calculateTotalPrice();

      // Display the updated cart items and total price
      displayCartItems();
    }
  }
}

function displayCartItems() {
    var message = "Cart Items:\n\n";

    for (var i = 0; i < cartItems.length; i++) {
        var item = cartItems[i];
        message += "Title: " + item.title + "\n";
        message += "Price: " + item.price + "\n";
        message += "Quantity: " + item.quantity + "\n";
        message += "\n";
    }

    message += "Total Price: " + totalPrice.toFixed(2) + "\n";

    alert(message);
}
function gotocheckout(){
var cartItemsJson = JSON.stringify(cartItems);
        var totalPriceValue = totalPrice.toFixed(2);

        // Set the values as URL parameters
        var url = "modal.jsp?cartItems=" + encodeURIComponent(cartItemsJson) + "&totalPrice=" + encodeURIComponent(totalPriceValue);

        // Navigate to modal.jsp
        window.location.href = url;
}

    </script>


</body>
</html>
