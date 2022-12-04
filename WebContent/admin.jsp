<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="style.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.5.1/chart.min.js"></script>
</head>
<body onload="drawChart()">
	<%@ include file="headerAdmin.jsp" %>
      <div class="container">
        <div class="row d-flex flex-column align-items-center justify-content-center">

<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>
<%

ArrayList<String> dates = new ArrayList<String>();
ArrayList<Double> sales = new ArrayList<Double>();

try
	{
		getConnection();
		String sql = "select CONVERT(nvarchar(10), orderDate, 120), SUM(totalAmount) from ordersummary group by CONVERT(nvarchar(10), orderDate, 120)";
		Statement stmt = con.createStatement();
		ResultSet rst = stmt.executeQuery(sql);
		out.println("<h2 style='font-weight: 300;'>Report of sales</h2>");
        out.println("<table class='adminTable' border='1'><tr><th>Order Date</th><th>Total Order Amount</th></tr>");
		while(rst.next()){
			dates.add(String.valueOf(rst.getDate(1)));
			sales.add(rst.getDouble(2));
            out.println("<tr><td>"+rst.getDate(1)+"</td><td>"+rst.getDouble(2)+"</td></tr>");
        }
        out.println("</table>");
	} 
	catch (SQLException ex) {
		out.println(ex);
	}


%>
<canvas id="myChart" class="col-lg-6"></canvas>

<%
try
	{
		getConnection();
		String sql = "select productId, quantity, price from productinventory";
		Statement stmt = con.createStatement();
		ResultSet rst = stmt.executeQuery(sql);
		out.println("<h2 style='font-weight: 300;'>Product Inventory for Main Warehouse</h2>");
        out.println("<table class='adminTable' border='1'><tr><th>Product ID</th><th>Quantity</th><th>Price ($)</th></tr>");
		while(rst.next()){
            out.println("<tr><td>"+rst.getInt(1)+"</td><td>"+rst.getInt(2)+"</td><td>$"+rst.getDouble(3)+"</td></tr>");
        }
        out.println("</table>");
	} 
	catch (SQLException ex) {
		out.println(ex);
	}

%>
<h3 style="font-weight: 500;" class="text-center">Note: This action cannot be undone. Consider before clicking. It will wipe out the database and convert it to its inital state.</h3>
<a class="btn btn-danger mb-4 text-white" href="loaddata.jsp">RESTORE THE DATABASE</a>
</div>
</div>
<script>
	function drawChart() {
		var sales = [];
		<%for(int i=0;i<sales.size();i++){%>
    	sales.push("<%= sales.get(i)%>");
		<%}%>
      var dates = [];
	  <%for(int i=0;i<dates.size();i++){%>
    	dates.push("<%= dates.get(i)%>");
		<%}%>
      new Chart('myChart', {
        type: 'bar',
        data: {
          labels: dates,
          datasets: [{
            label: 'Sales by Day',
            data: sales,
			backgroundColor: "green"
          }]
        },
      });
    }

</script>
</body>
</html>

