<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>YOUR NAME Grocery Shipment Processing</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="styleInfo.css">
</head>
<body>
        
	<%@ include file="header.jsp" %>

	  <div class="container">
		<div class="row d-flex flex-column text-center align-items-center">

<%
@SuppressWarnings({"unchecked"})
	// TODO: Get order id
	int id =  Integer.parseInt(request.getParameter("orderId"));
    boolean check = false;
	String sql = "select * from ordersummary where orderId = ?";
	// TODO: Check if valid order id
	try
	{
		getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, id);
		ResultSet rst = pstmt.executeQuery();
		if(rst.next()){
			check = true;
		}
	}
	catch (SQLException ex)
	{
	System.err.println(ex);
	}

	int qtyPrev = 0;
	int qtyRequested = 0;
	int prId = 0;
	boolean checkShip = true;
	if(check)
	{
		try
		{
			getConnection();
			Statement stmt = con.createStatement();
			con.setAutoCommit(false);
			PreparedStatement pstmt = con.prepareStatement("select quantity from productinventory where productId = ?");
			ResultSet rst = stmt.executeQuery("SELECT productId, quantity from orderproduct where orderId = "+id+"");
			while (rst.next())
			{ 
				PreparedStatement pstmt2 = con.prepareStatement("UPDATE productinventory SET quantity = ? WHERE productId=?");
				qtyRequested = rst.getInt(2);
				prId = rst.getInt(1);
				pstmt.setInt(1, prId);
				ResultSet rst1 = pstmt.executeQuery();
				if(rst1.next() && (rst1.getInt(1) - qtyRequested) >= 0){
					qtyPrev = rst1.getInt(1);
					pstmt2.setInt(1, qtyPrev-qtyRequested);
					pstmt2.setInt(2, prId);
					pstmt2.executeUpdate();
					out.println("<table class='tableShip' border='1'><tr><td>Ordered Product ID</td><td align='center'>"+prId+"</td></tr><tr><td>Requested amount</td><td align='center'>"+qtyRequested+"</td></tr><tr><td>Previous Inventory</td><td align='center'>"+qtyPrev+"</td></tr><tr><td>New Inventory</td><td align='center'>"+ (qtyPrev - qtyRequested)+"</td></tr></table>");
					con.commit();
				}else{
					con.rollback();
					checkShip = false;
					}	
 			} 
			if(checkShip){
				PreparedStatement pstmt2 = con.prepareStatement("insert into shipment (shipmentDate, warehouseId) values (GETDATE(),?)");
				pstmt2.setInt(1, 1);
				pstmt2.executeUpdate();
				con.commit();    
				out.println("<h1 class='back'>Shipment successfully processed.</h1>");
			}else{
				out.println("<h1 class='notDone'>Shipment not done.</h1>");
				out.println("<table border='1' class='tableNotShip'><tr><td>Insufficient inventory for Product ID</td><td align='center'>"+prId+"</td></tr></table>");
			}
		}
			catch (SQLException ex)
			{
				System.err.println(ex);
				out.println(ex);
				out.println(qtyPrev);
				out.println(qtyRequested);
				con.rollback(); 
			}
	}else{
		out.println("Not valid order id.");
	}
	con.setAutoCommit(true);
	// TODO: Start a transaction (turn-off auto-commit)
	
	// TODO: Retrieve all items in order with given id
	// TODO: Create a new shipment record.
	// TODO: For each item verify sufficient quantity available in warehouse 1.
	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
	
	// TODO: Auto-commit should be turned back on
%>                       				

<a href="customerPage.jsp"><button type="button" class="btn btn-danger mt-3">Back To Main Page</button></a>

</div>
</div>

<style>
	.back{
		background-color: green;
		display: block;
		margin-top: 50px;
		color: white;
		padding: 20px;
		border-radius: 20px;
	}

	.notDone{
		background-color: rgb(136, 125, 11);
		display: block;
		margin-top: 50px;
		color: white;
		padding: 20px;
		border-radius: 20px;
	}

.tableShip{
    width: 60%;
    background-color: antiquewhite;
	margin-top: 50px;
}
.tableShip tr td{
    padding: 10px;
}

.tableNotShip{
    width: 60%;
    background-color: antiquewhite;
	margin-top: 50px;
}
.tableNotShip tr{
	padding: 20px;
}
.tableNotShip tr td{
    padding: 10px;
}

</style>
</body>
</html>
