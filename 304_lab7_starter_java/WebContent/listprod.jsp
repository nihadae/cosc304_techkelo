<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="style.css">
<script src="https://kit.fontawesome.com/a0e85a8b00.js" crossorigin="anonymous"></script>
</head>
<body class="listProdBody d-flex flex-column">

	<%@ include file="header.jsp" %>

	  <div class="banner-top mb-4">
		<h4>Promising 2 Day Delivery</h4>
	</div>
	  <div class="container">
		<div class="row d-flex justify-content-center">

	<%
	try
	{
		getConnection();
		String sql = "select top 3 productId, sum(quantity) from orderproduct group by productId order by sum(quantity) desc";
		Statement stmt = con.createStatement();
		ResultSet rst = stmt.executeQuery(sql);
		out.println("<h2 style='font-weight: 300' class='col-lg-12 text-center'>Our featured products</h2>");
		while(rst.next()){
			String link;
			String linkProduct;
			PreparedStatement pstmt = con.prepareStatement("select productId, productName, productPrice from product where productId = ?");
			pstmt.setInt(1, rst.getInt(1));
            ResultSet rst1 = pstmt.executeQuery();
			while(rst1.next()){
				link = "\"addcart.jsp?id=" + rst1.getInt(1) + "&name=" + rst1.getString(2) + "&price=" + rst1.getDouble(3) + "\"";
				linkProduct = "\"product.jsp?id=" + rst1.getInt(1)+"\"";
				out.println("<div class='card col-lg-3 mt-4'>");
					out.println("<img class='card-img-top' src='img/"+rst1.getInt(1)+".jpeg' alt='Card image cap'>");
					out.println("<div class='card-body'>");
					out.println("<h5 class='card-title'>"+rst1.getString(2)+"</h5>");
					out.println("<span class='text-muted d-block mb-4'>$"+rst1.getDouble(3)+"</span>");
					out.println("<div class='buttons d-flex justify-content-between flex-wrap'>");
					out.println("<a href="+link+" class='btn btn-primary col-12'><i class='fa-solid fa-cart-plus mr-2'></i>Add to cart</a>");
					out.println("<a href="+linkProduct+" class='btn btn-danger col-12 mt-2'><i class='fa-solid fa-circle-info mr-2'></i>Learn More</a>");
					out.println("</div>");
					out.println("</div>");
					out.println("</div>");
			}
        }
	} 
	catch (SQLException ex) {
		out.println(ex);
	}
	%>

	<h2 class="text-center col-lg-12 mt-4" style="font-weight: 300;">Products</h2>
<form method="get" action="listprod.jsp" class="col-12 d-flex flex-row align-items-center justify-content-center">
	<select size="1" name="categoryName" class="form-control col-3">
		<option></option>
		<option>Laptops & MacBooks</option>
		<option>Desktop Computers</option>
		<option>Tablets & iPads</option>
		<option>Cell Phones</option>
		<option>Televisions</option>
		<option>Headphones</option>
		<option>Cameras</option>
		<option>Video Games & VR</option>
		<option>Smartwatches & Apple Watch</option>
		<option>Printers, Scanners & Fax</option>
		</select>
<input type="text" name="productName" placeholder="Search a product" class="form-control col-5" size="50">

<input type="submit" value="Submit" class="btn btn-outline-success col-1"><input type="reset" value="Reset" class="btn btn-outline-danger col-1"> 
</form>
<br><br>
<% // Get product name to search for
String name = request.getParameter("productName");
String categoryNameRequested = request.getParameter("categoryName");

//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!


String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

try ( Connection con = DriverManager.getConnection(url, uid, pw);
      Statement stmt = con.createStatement();) 
{       
    NumberFormat currFormat = NumberFormat.getCurrencyInstance();

		ResultSet rst = stmt.executeQuery("SELECT p.productName, p.categoryId, p.productDesc, p.productPrice, p.productId from product p where productName like '%"+name+"%' and (SELECT categoryName from category c where c.categoryId = p.categoryId) like '%"+categoryNameRequested+"%'");     
        String link;
		String linkProduct;
    while (rst.next())
    {
        link = "\"addcart.jsp?id=" + rst.getInt(5) + "&name=" + rst.getString(1) + "&price=" + rst.getDouble(4) + "\"";
		linkProduct = "\"product.jsp?id=" + rst.getInt(5)+"\"";
		PreparedStatement pstmt = con.prepareStatement("SELECT categoryName from category where categoryId = ?");
		pstmt.setInt(1, rst.getInt(2));
		ResultSet rst1 = pstmt.executeQuery();
		while(rst1.next()){
			out.println("<div class='card col-lg-3 mt-4 mr-2'>");
			out.println("<img class='card-img-top' src='img/"+rst.getInt(5)+".jpeg' alt='Card image cap'>");
			out.println("<div class='card-body'>");
			out.println("<h5 class='card-title'>"+rst.getString(1)+"</h5>");
			out.println("<span class='text-muted d-block mb-4'>$"+rst.getDouble(4)+"</span>");
			out.println("<div class='buttons d-flex justify-content-between flex-wrap'>");
			out.println("<a href="+link+" class='btn btn-primary col-12'><i class='fa-solid fa-cart-plus mr-2'></i>Add to cart</a>");
			out.println("<a href="+linkProduct+" class='btn btn-danger col-12 mt-2'><i class='fa-solid fa-circle-info mr-2'></i>Learn More</a>");
			out.println("</div>");
			out.println("</div>");
			out.println("</div>");
		}
        
    }
}
catch (SQLException ex) {   
    out.println(ex); 
}

// Make the connection

// Print out the ResultSet

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>
</div>
</div>
<footer class="text-center text-lg-start text-white mt-4">
	<!-- Section: Social media -->
	<section class="d-flex justify-content-center justify-content-lg-between p-4 border-bottom">
	  <!-- Left -->
	  <div class="me-5 d-none d-lg-block">
		<span>Get connected with us on social networks:</span>
	  </div>
	  <!-- Left -->
  
	  <!-- Right -->
	  <div>
		<a href="" class="me-4 text-reset">
		  <i class="fab fa-facebook-f"></i>
		</a>
		<a href="" class="me-4 text-reset">
		  <i class="fab fa-twitter"></i>
		</a>
		<a href="" class="me-4 text-reset">
		  <i class="fab fa-google"></i>
		</a>
		<a href="" class="me-4 text-reset">
		  <i class="fab fa-instagram"></i>
		</a>
		<a href="" class="me-4 text-reset">
		  <i class="fab fa-linkedin"></i>
		</a>
		<a href="" class="me-4 text-reset">
		  <i class="fab fa-github"></i>
		</a>
	  </div>
	  <!-- Right -->
	</section>
	<!-- Section: Social media -->
  
	<!-- Section: Links  -->
	<section class="">
	  <div class="container text-center text-md-start mt-5">
		<!-- Grid row -->
		<div class="row mt-3">
		  <!-- Grid column -->
		  <div class="col-md-3 col-lg-4 col-xl-3 mx-auto mb-4">
			<!-- Content -->
			<h6 class="text-uppercase fw-bold mb-4">
			  <a class="navbar-brand text-white" href="index.jsp"><span class="name">Tech</span>Kelo</a>
			</h6>
			<p>
			  Promising 2 day delivery. Our main aim is to keep customer experience at the top level.
			</p>
		  </div>
		  <!-- Grid column -->
  
		  <!-- Grid column -->
		  <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
			<!-- Links -->
			<h6 class="text-uppercase fw-bold mb-4">
			  Products
			</h6>
			<p>
			  <a href="#!" class="text-reset">Laptops & MacBooks</a>
			</p>
			<p>
			  <a href="#!" class="text-reset">Cell Phones</a>
			</p>
			<p>
			  <a href="#!" class="text-reset">Televisions</a>
			</p>
			<p>
			  <a href="#!" class="text-reset">Headphones</a>
			</p>
		  </div>
		  <!-- Grid column -->
  
		  <!-- Grid column -->
		  <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mb-4">
			<!-- Links -->
			<h6 class="text-uppercase fw-bold mb-4">
			  Useful links
			</h6>
			<p>
			  <a href="#!" class="text-reset">Pricing</a>
			</p>
			<p>
			  <a href="#!" class="text-reset">Settings</a>
			</p>
			<p>
			  <a href="#!" class="text-reset">Orders</a>
			</p>
			<p>
			  <a href="#!" class="text-reset">Help</a>
			</p>
		  </div>
		  <!-- Grid column -->
  
		  <!-- Grid column -->
		  <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-md-0 mb-4">
			<!-- Links -->
			<h6 class="text-uppercase fw-bold mb-4">Contact</h6>
			<p><i class="fas fa-home me-3"></i> 3333 University Way, Kelowna, BC, V1V0C4, CA</p>
			<p>
			  <i class="fas fa-envelope me-3"></i>
			  info@example.com
			</p>
			<p><i class="fas fa-phone me-3"></i> + 01 234 567 88</p>
			<p><i class="fas fa-print me-3"></i> + 01 234 567 89</p>
		  </div>
		  <!-- Grid column -->
		</div>
		<!-- Grid row -->
	  </div>
	</section>
	<!-- Section: Links  -->
  
	<!-- Copyright -->
	<div class="text-center p-4" style="background-color: rgba(0, 0, 0, 0.05);">
	  © 2022 Copyright:
	  <a class="text-reset fw-bold" href="https://mdbootstrap.com/">techkelo</a>
	</div>
	<!-- Copyright -->
  </footer>
<style>
	.banner-top{
		width: 100%;
		background-color: #2E8B57;
		height: 100px;
		color: white;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	footer{
		background-color: #343A40;
	}
</style>
</body>
</html>