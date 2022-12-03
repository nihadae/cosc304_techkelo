<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order List</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link rel="stylesheet" href="style.css">
</head>
<body class="listOrderBody">
    <%@ include file="header.jsp" %>
    <div class="container">
	<div class="row d-flex flex-column align-items-center">
		<h1 class="h1OrderList col-lg-3">Order List</h1>

<%
username = String.valueOf(session.getAttribute("authenticatedUser"));
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
boolean check = false;

try ( Connection con = DriverManager.getConnection(url, uid, pw);
      Statement stmt = con.createStatement();) 
{       
    NumberFormat currFormat = NumberFormat.getCurrencyInstance();
    ResultSet rst = stmt.executeQuery("SELECT os.orderId, os.orderDate, os.customerId, (SELECT c.firstName from customer c where customerId = os.customerId), (SELECT c.lastName from customer c where customerId = os.customerId), totalAmount FROM ordersummary os where os.customerId = (select customerId from customer where userid ='"+username+"')");     
    out.println("<table class='tableOrder' border='1'><tr><th>Order ID</th><th>Order Date</th><th>Customer ID</th><th>Customer Name</th><th>Order Amount</th></tr>");

    while (rst.next())
    {
        int qty = 0;
        check = true;
        PreparedStatement pstmt = con.prepareStatement("select productId, quantity, price from orderproduct where orderId = ?");
        pstmt.setInt(1, rst.getInt(1));
        ResultSet rst1 = pstmt.executeQuery();
            out.println("<tr><td>"+rst.getInt(1)+"</td>"+"<td>"+rst.getTimestamp(2)+"</td>"+"<td>"+rst.getInt(3)+"</td>"+"<td>"+rst.getString(4)+" "+rst.getString(5)+"</td>"+"<td>"+currFormat.format(rst.getDouble(6))+"</td></tr>");
            out.println("<tr align='right'><td colspan='5'><table class='tableProduct' border='1'><th>Product Id</th><th>Quantity</th><th>Price</th></tr>");
            while(rst1.next()){ 
                out.println("<tr><td>"+rst1.getInt(1)+"</td>"+"<td>"+rst1.getInt(2)+"</td>"+"<td>"+currFormat.format(rst1.getDouble(3))+"</td></tr>");
				qty+=rst1.getInt(2);
            }
			out.println("<tr><td>Total:</td>"+"<td>"+qty+"</td>"+"<td>"+currFormat.format(rst.getDouble(6))+"</td></tr>");
            out.println("</table></td></tr>");
    }
    out.println("</table>");
}
catch (SQLException ex) {   
    out.println(ex); 
}

if(!check){
    out.println("<h3 class='text-center mt-2 bg-danger' style='font-weight: 300; padding: 20px; border-radius: 20px; color: white;'>No order history to display.</h3>");
}
%>
<div class="backToMain">
	<a href="customerPage.jsp"><button type="button" class="btn btn-danger">Back to Main Page</button></a>
</div>
</div>
</div>
</body>
</html>

