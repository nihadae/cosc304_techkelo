<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="styleInfo.css">
</head>
<body class="customerBody">
	<script>
		function update(first, last, email, phone, address, city, state, postal, country){
			window.location="updateCustomer.jsp?first="+first+"&last="+last+"&email="+email+"&phone="+phone+"&address="+address+"&city="+city+"&state="+state+"&postal="+postal+"&country="+country;
		}
	</script>
	<%
	if(session.getAttribute("authenticatedUser").toString().equals("admin")){ %>
		<%@ include file="headerAdmin.jsp" %>
	<%}else{%>
		<%@ include file="header.jsp" %>
	<% } %>

<div class="container d-flex flex-column align-items-center justify-content-center">
	<div class="row d-flex justify-content-center">
		<div class="headerCust col-lg-10">
			<h2 class="topPartCust text-center mt-4 p-3 bg-light" style="font-weight: 400;">Personal Information</h2>
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
			String sql = "select * from customer where userid = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userName);
			ResultSet rst = pstmt.executeQuery();

			
			while(rst.next()){
				out.println("<div class='profile col-lg-8 d-flex flex-row flex-wrap justify-content-center'>");
				out.println("<div class='imagePerson col-lg-3'><img src='img/person.png' style='width: 100%;'></div>");
				out.println("<form name='personal' class='d-flex flex-row flex-wrap justify-content-center'>");
				out.println("<div class='d-flex flex-column col-lg-12'><label>ID</label><input class='form-control' type='text' value='"+rst.getInt(1)+"' disabled></div>");
				out.println("<div class='d-flex flex-column mt-2 col-lg-6'><label>Name</label><input class='form-control' type='text' name='first' value='"+rst.getString(2)+"'></div>");
				out.println("<div class='d-flex flex-column mt-2 col-lg-6'><label>Surname</label><input class='form-control' type='text' name='last' value='"+rst.getString(3)+"'></div>");
				out.println("<div class='d-flex flex-column mt-2 col-lg-6'><label>Email</label><input class='form-control' type='text' name='email' value='"+rst.getString(4)+"'></div>");
				out.println("<div class='d-flex flex-column mt-2 col-lg-6'><label>Phone Number</label><input class='form-control' type='text' name='phone' value='"+rst.getString(5)+"'></div>");
				out.println("<div class='d-flex flex-column mt-2 col-lg-12'><label>Address</label><input class='form-control' type='text' name='address' value='"+rst.getString(6)+"'></div>");
				out.println("<div class='d-flex flex-column mt-2 col-lg-3'><label>City</label><input class='form-control' type='text' name='city' value='"+rst.getString(7)+"'></div>");
				out.println("<div class='d-flex flex-column mt-2 col-lg-3'><label>State</label><input class='form-control' type='text' name='state' value='"+rst.getString(8)+"'></div>");
				out.println("<div class='d-flex flex-column mt-2 col-lg-3'><label>Postal Code</label><input class='form-control' type='text' name='postal' value='"+rst.getString(9)+"'></div>");
				out.println("<div class='d-flex flex-column mt-2 col-lg-3'><label>Country</label><input class='form-control' type='text' name='country' value='"+rst.getString(10)+"'></div>");
				out.println("<div class='d-flex flex-column mt-2 col-lg-12'><label>Username</label><input class='form-control' type='text' name='user'value='"+rst.getString(11)+"' disabled></div>");
				out.println("<input type='button' class='btn btn-outline-secondary col-lg-8 mt-3' onclick='update(document.personal.first.value, document.personal.last.value, document.personal.email.value, document.personal.phone.value, document.personal.address.value, document.personal.city.value, document.personal.state.value, document.personal.postal.value, document.personal.country.value)' value='Edit profile'>");
				out.println("</form>");
				out.println("</div>");
			}
			
		} 
		catch (SQLException ex) {
			out.println(ex);
		}
// Make sure to close connection
%>
	</div>
	<a href="logout.jsp"><button type="button" class="btn btn-outline-danger mt-3 col-lg-12">Log out</button></a>
</div>
<style>
	.customerTable tr td{
		padding-left: 100px;
		padding-right: 100px;
	}
</style>
</body>
</html>

