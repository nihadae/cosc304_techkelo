<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>

<%@ page import="java.sql.Timestamp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order Processing</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="style.css">
</head>
<body class="d-flex flex-column">
	<%@ include file="header.jsp" %>

	  <div class="container">
		<div class="row d-flex flex-column">

<% 
// Get customer id
String custId = request.getParameter("customerId");
String password = request.getParameter("password");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Determine if valid customer id was entered
boolean cidIsInteger = true;
try{
    Integer.parseInt(custId);
}catch(Exception e){
    cidIsInteger = false;
}


// Determine if there are products in the shopping cart
// If either are not true, display an error message

// Make connection
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
if(cidIsInteger){
	try ( Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();) {
	  PreparedStatement pstmt = con.prepareStatement("select count(*) from customer where customerId = ?");
	  pstmt.setInt(1,Integer.parseInt(custId));
	  ResultSet rst = pstmt.executeQuery();
	  PreparedStatement pstmtPass = con.prepareStatement("select password from customer where customerId = ?");
	  pstmtPass.setInt(1,Integer.parseInt(custId));
	  ResultSet rstPass = pstmtPass.executeQuery();
	  rst.next();
	  rstPass.next();
	  int available = rst.getInt(1);
	  if(available == 1 && password.equals(rstPass.getString(1))){
		  if(!productList.isEmpty()){
			  PreparedStatement pstmt2 = con.prepareStatement("INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (?,?,?)", Statement.RETURN_GENERATED_KEYS);   
		  
  pstmt2.setInt(1, Integer.parseInt(custId));
  pstmt2.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
  pstmt2.setDouble(3, 0.0);
  pstmt2.executeUpdate();     
  ResultSet keys = pstmt2.getGeneratedKeys();
  keys.next();
  int orderId = keys.getInt(1);

  double total = 0;
  Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	  while (iterator.hasNext())
	  { 
		  Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		  ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		  String productId = (String) product.get(0);
		  String price = (String) product.get(2);
		  double pr = Double.parseDouble(price);
		  int qty = ( (Integer)product.get(3)).intValue();
		  PreparedStatement pstmt3 = con.prepareStatement("INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (?,?,?,?)");
		  pstmt3.setInt(1, orderId);
		  pstmt3.setInt(2, Integer.parseInt(productId));
		  pstmt3.setInt(3, qty);
		  pstmt3.setDouble(4, pr);
		  pstmt3.executeUpdate();
		  total += (qty*pr);
	  }
	  stmt.executeUpdate("Update ordersummary set totalAmount ='"+total+"' where orderId = '"+orderId+"'");
	  productList.clear();
	  NumberFormat currFormat = NumberFormat.getCurrencyInstance();
  ResultSet rst1 = stmt.executeQuery("SELECT os.orderId, os.orderDate, os.customerId, (SELECT c.firstName from customer c where customerId = os.customerId), (SELECT c.lastName from customer c where customerId = os.customerId), totalAmount FROM ordersummary os where orderId = '"+orderId+"'");      
  out.println("<h1 class='mt-3 text-center'>Your Order Summary</h1>");
  out.println("<table border='1' class='tableOrder mt-4'><tr><th>Order ID</th><th>Order Date</th><th>Customer ID</th><th>Customer Name</th><th>Order Amount</th></tr>");
String fullname ="";
  while (rst1.next())
  {
	  PreparedStatement pstmt4 = con.prepareStatement("select productId, quantity, price from orderproduct where orderId = ?");
	  pstmt4.setInt(1, rst1.getInt(1));
	  ResultSet rst2 = pstmt4.executeQuery();
	  fullname = rst1.getString(4)+" "+rst1.getString(5);
		  out.println("<tr><td>"+rst1.getInt(1)+"</td>"+"<td>"+rst1.getTimestamp(2)+"</td>"+"<td>"+rst1.getInt(3)+"</td>"+"<td>"+fullname+"</td>"+"<td>"+currFormat.format(rst1.getDouble(6))+"</td></tr>");
		  out.println("<tr align='right'><td colspan='5'><table class='tableProduct' border='1'><th>Product Id</th><th>Quantity</th><th>Price</th></tr>");
		  while(rst2.next()){
			  out.println("<tr><td>"+rst2.getInt(1)+"</td>"+"<td>"+rst2.getInt(2)+"</td>"+"<td>"+currFormat.format(rst2.getDouble(3))+"</td></tr>");
		  }
		  out.println("</table></td></tr>");
  }
  out.println("</table>");
  out.println("<h2 class='mt-3 text-center'>Your Order completed. Will be shipped soon.\n</h2>");
  out.println("<h2 class='mt-3 text-center'>Your Order Reference Number is: "+orderId+"</h2>");
  out.println("<h2 class='mt-3 text-center'>Shipping to Customer: "+Integer.parseInt(custId)+" Fullname: "+fullname+"</h2>");
  out.println("<a class='btn btn-outline-primary' href='ship.jsp?orderId="+orderId+"'>Shipment Status</a>");
  out.println("<a href='listprod.jsp?categoryName=&productName=' class='text-center mt-4'><button type='button' class='btn btn-danger showButton'>Back to Products</button></a>");
		  }else{
			out.println("<h1 class='text-danger errorText'>Your Shopping Cart is empty.</h1>");
			out.println("<br>");
			out.println("<a href='listprod.jsp?categoryName=&productName=' class='text-center mt-4'><button type='button' class='btn btn-danger showButton'>Back to Products</button></a>");
		  }
	  }else{
		  out.println("<h1 class='text-danger errorText'>Either your Customer ID or password is not valid.</h1>");
		  out.println("<a href='listprod.jsp?categoryName=&productName=' class='text-center mt-4'><button type='button' class='btn btn-danger showButton'>Back to Products</button></a>");

	  }
}
catch (SQLException ex) {   
  out.println(ex); 
}
}else{
	out.println("<h1 class=\"errorText\">Your Customer ID is not valid.</h1>");
}


// Save order information to database

	// Use retrieval of auto-generated keys.

	
	
// Insert each item into OrderProduct table using OrderId from previous INSERT

// Update total amount for order record

// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

/*
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
            ...
	}
*/

// Print out order summary

// Clear cart if order placed successfully
%>
</div>
</div>
</BODY>
</HTML>

