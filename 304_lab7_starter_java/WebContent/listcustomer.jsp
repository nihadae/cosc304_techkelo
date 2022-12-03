<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="styleInfo.css">
</head>
<body class="customerBody">
		<%@ include file="headerAdmin.jsp" %>
	

<div class="container">
	<div class="row">
		<div class="headerCust col-lg-12">
			<h2 class="topPartCust text-center">Customer Information</h2>
		</div>
<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%

// TODO: Print Customer information
try
		{
			getConnection();
			String sql = "select * from customer where (select customerId from customer where userid ='admin') not like customerId";
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery(sql);
			out.println("<table class='customerTable' border='1'>");
                out.println("<tr><th>ID</th><th>First Name</th><th>Last Name</th><th>Email</th><th>Phone Number</th><th>Address</th><th>City</th><th>State</th><th>Postal Code</th><th>Country</th><th>User ID</th></tr>");
			while(rst.next()){
                out.println("<tr><td>"+rst.getInt(1)+"</td><td>"+rst.getString(2)+"</td><td>"+rst.getString(3)+"</td><td>"+rst.getString(4)+"</td><td>"+rst.getString(5)+"</td><td>"+rst.getString(6)+"</td><td>"+rst.getString(7)+"</td><td>"+rst.getString(8)+"</td><td>"+rst.getString(9)+"</td><td>"+rst.getString(10)+"</td><td>"+rst.getString(11)+"</td></tr>");
			}
            out.println("<br>");
            out.println("</table>");
		} 
		catch (SQLException ex) {
			out.println(ex);
		}
// Make sure to close connection
%>
	</div>
</div>
<style>
    .customerTable tr td{
        padding: 10px;
    }
</style>
</body>
</html>

