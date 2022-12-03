<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>    

<html>
<head>
<title>Ray's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="style.css">
<script src="https://kit.fontawesome.com/a0e85a8b00.js" crossorigin="anonymous"></script>

</head>
<body class="productBody">

	<script>
		function sendReview(reviewRating, reviewMessage, customerId, productId){
			window.location="review.jsp?rating="+reviewRating+"&message="+reviewMessage+"&custId="+customerId+"&prodId="+productId;
		}
	</script>
    <%@ include file="header.jsp" %>


	  <div class="container">
		<div class="row d-flex justify-content-center">
<%
// Get product name to search for
// TODO: Retrieve and display info for the product
boolean check = false;
String productId = request.getParameter("id");
String sql = "SELECT productImageURL, productName, productPrice, productDesc from product where productId = " + productId + "";
username = session.getAttribute("authenticatedUser").toString();
String custIdLast = "";

try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");  
LocalDateTime now = LocalDateTime.now();  

String pname = "";
double price = 0.0;
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

try ( Connection con = DriverManager.getConnection(url, uid, pw);
      Statement stmt = con.createStatement();) 
{       
			String sql1 = "select customerId from customer where userid = '"+username+"'";
			ResultSet rst5 = stmt.executeQuery(sql1);
			if(rst5.next()){
				custIdLast = String.valueOf(rst5.getInt(1));
				}
		ResultSet rst = stmt.executeQuery(sql);     
		
		 
    
    while (rst.next())
    {
        pname = rst.getString(2);
        price = rst.getDouble(3);
		String link = "\"addcart.jsp?id=" + productId + "&name=" + pname + "&price=" + price + "\"";
		out.println("<div class='allInfo d-flex mt-4 flex-wrap justify-content-center'>");
		out.println("<div class='image col-4 d-flex justify-content-center justify-content-center'>");
        out.println("<img class='d-block mb-4' src="+rst.getString(1)+">");
		out.println("</div>");
		out.println("<div class='rightside col-8 d-flex flex-column justify-content-center align-items-center'>");
		out.println("<h2 class='text-center' style='font-weight: 300;'>"+pname+"</h2>");
		int splitter = String.valueOf(rst.getDouble(3)).indexOf(".");
		out.println("<span class='dollars'>"+String.valueOf(rst.getDouble(3)).substring(0, splitter)+"</span>");
		out.println("<div class='details d-flex flex-column'>");
		out.println("<span class='text-muted'>Sold and shipped by TechKelo</span>");
		out.println("<span>This will be delivered as early as "+dtf.format(now.plusDays(2))+"</span>");
		out.println("<span>Enjoy fast, free shipping on most orders over $35.</span>");
		out.println("<a href="+link+"><button type='button' class='btn btn-danger showButton col-12 mt-3'><i class='fa-solid fa-cart-plus mr-2'></i>Add to Cart</button></a>");
		out.println("</div>");
		out.println("</div>");
		out.println("<h4 class='col-12 text-center mt-4'>Overview</h4>");
		out.println("<p class='w-50'>"+rst.getString(4)+"</p>");
		out.println("</div>");
    }
}
catch (SQLException ex) {   
    out.println(ex); 
}
// TODO: If there is a productImageURL, display using IMG tag
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
// TODO: Add links to Add to Cart and Continue Shopping
out.println("<a href='listprod.jsp?categoryName=&productName=' class='text-center mt-4'><button type='button' class='btn btn-success showButton'>Continue Shopping</button></a></div>");
%>

<%
	try
	{
		getConnection();
		sql = "select categoryId from product where productId = "+productId+"";
		Statement stmt = con.createStatement();
		ResultSet rst = stmt.executeQuery(sql);
		out.println("<h2 style='font-weight: 300' class='col-lg-12 text-center mt-4'>You can also view</h2>");
		out.println("<div class='d-flex flex-row flex-wrap justify-content-around'>");
		while(rst.next()){
			String link;
			String linkProduct;
			PreparedStatement pstmt = con.prepareStatement("select productId, productName, productPrice from product where categoryId = ?");
			pstmt.setInt(1, rst.getInt(1));
            ResultSet rst1 = pstmt.executeQuery();
			while(rst1.next()){
				link = "\"addcart.jsp?id=" + rst1.getInt(1) + "&name=" + rst1.getString(2) + "&price=" + rst1.getDouble(3) + "\"";
				linkProduct = "\"product.jsp?id=" + rst1.getInt(1)+"\"";
				out.println("<div class='card col-lg-3 mt-4 mb-3'>");
					out.println("<img class='card-img-top' src='img/"+rst1.getInt(1)+".jpeg' alt='Card image cap'>");
					out.println("<div class='card-body'>");
					out.println("<h5 class='card-title'>"+rst1.getString(2)+"</h5>");
					out.println("<span class='text-muted d-block mb-4'>$"+rst1.getDouble(3)+"</span>");
					out.println("<div class='buttons d-flex justify-content-between flex-wrap'>");
					out.println("<a href="+linkProduct+" class='btn btn-danger col-12 mt-2'><i class='fa-solid fa-circle-info mr-2'></i>Learn More</a>");
					out.println("</div>");
					out.println("</div>");
					out.println("</div>");
			}
        }
	out.println("</div>");
	} 
	catch (SQLException ex) {
		out.println(ex);
	}
	%>
	<div class="reviewPart d-flex justify-content-center">
		<form name="feedback">
		  
		   <div class="pinfo"><span><i class="fa fa-heart mr-2"></i>Rate the product</span></div>
			
		  
		  
			 <select class="form-control" id="rate" name="ratingLike">
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
			  </select>
		
		  
		   <div class="pinfo"><span><i class="fa fa-pencil mr-2"></i>Write your feedback</span></div>
			
		  
		 
			<textarea class="form-control" id="review" name="msg" rows="3"></textarea>
		   
		   <input type="button" onclick="sendReview(document.feedback.ratingLike.value, document.feedback.msg.value, <%=custIdLast%>, <%=productId%>)" class="btn btn-primary col-lg-12" value="Submit">
		  
		  
		  </form>
	</div>
	<div class="reviewList">
		<%
	try
	{
		getConnection();
		sql = "select reviewId, customerId, reviewRating, reviewComment from review where productId = "+productId+"";
		Statement stmt = con.createStatement();
		ResultSet rst = stmt.executeQuery(sql);
		while(rst.next()){
			PreparedStatement pstmt = con.prepareStatement("select firstName, lastName from customer where customerId = ?");
			pstmt.setInt(1, rst.getInt(2));
            ResultSet rst1 = pstmt.executeQuery();
			while(rst1.next()){
				check = true;
				out.println("<div class='card col-lg-12 mt-4 mb-3'>");
					out.println("<div class='card-body'>");
					out.println("<h5 class='card-title'>"+rst1.getString(1) + " " + rst1.getString(2) +"</h5>");
					out.println("<span class='text-muted d-block mb-4'>Rating: "+rst.getInt(3)+"★</span>");
					out.println("<span>"+rst.getString(4)+"</span>");
					out.println("</div>");
					out.println("</div>");

				}
			

        }
		if(!check){
			out.println("<h2 style='font-weight: 200; border: 1px solid lightgray; padding: 20px;' class='text-center'>No review to show for now.</h2>");
		}
	} 
	catch (SQLException ex) {
		out.println(ex);
	}
	%>
	</div>
		</div>
	  </div>

	  <div class="banner-bottom col-12">
	  <ul class="list-group d-flex flex-row justify-content-around">
		<li class="list-group-item col-1 d-flex flex-column align-items-center"><i class="fa-solid fa-bolt"></i><span class="text-center">Quick and Easy Store Pickup</span></li>
		<li class="list-group-item col-1 d-flex flex-column align-items-center"><i class="fa-solid fa-truck-fast"></i><span class="text-center">Free shipping over $35</span></li>
		<li class="list-group-item col-1 d-flex flex-column align-items-center"><i class="fa-solid fa-sack-dollar"></i><span class="text-center">Low Price Guarantee</span></li>
		<li class="list-group-item col-1 d-flex flex-column align-items-center"><i class="fa-solid fa-face-smile-wink"></i><span class="text-center">Latest and Greatest Tech</span></li>
	  </ul>
	</div>
	  <style>
		.banner-bottom{
			border-top: 1px solid lightgray;
			border-bottom: 1px solid lightgray;
			bottom: 0;
		}

		.list-group-item{
			border: none;
		}

		.list-group-item span{
			font-weight: 600;
			font-size: 16px;
		}
		.list-group-item i{
			color: #2E8B57;
			font-size: 32px;
		}
		.list-group{
			padding: 25px;
		}

		.image img{
			width: 100%;
		}

		.dollars{
			color: #BB1128;
			font-weight: 700;
			font-size: 32px;
		}

		.dollars::before{
			content: '$';
			font-size: 24px;
		}
		.dollars::after{
			content: '.99';
			font-size: 16px;
		}
		.details{
			background-color: #F4F6F9;
			padding: 30px;
		}
		.productBody{
			position: relative;
		}

	  </style>
</body>
</html>

