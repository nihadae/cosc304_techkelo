<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Your Shopping Cart</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="style.css">
<script src="https://kit.fontawesome.com/a0e85a8b00.js" crossorigin="anonymous"></script>
</head>
<form name="form1">
<body class="showCartBody">
	<script>
		function update(newid, newqty){
			window.location="updateItem.jsp?id="+newid+"&newqty="+newqty;
		}

		function remove(removeId){
			window.location="remove.jsp?id="+removeId;
		}
	</script>
	<%@ include file="header.jsp" %>


	  <div class="container">
		<div class="row d-flex flex-column align-items-center">
<%
// Get the current list of products
boolean check = false;
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
if (productList == null)
{	
	out.println("<h1 class='text-center border p-4 mt-4'><i class='fa-solid fa-cart-shopping mr-2 text-success'></i>Your Shopping Cart</h1>");
	out.println("<div class='shoppingCart col-lg-12 d-flex'>");
	out.println("<div class='left-side col-lg-9'>");
	out.println("<div class='topBar col-lg-12 bg-light p-3'><span class='font-weight-bold'>Products</span></div>");
	out.println("<h2 style='font-weight: 300;' class='border p-3'>No item found in the shopping cart.</h2>");

	out.println("</div>");
	out.println("<div class='right-side col-lg-3'>");
	out.println("<div class='topBar col-lg-12 bg-light p-3'><span class='font-weight-bold'>Subtotal</span></div>");
	out.println("<h4 style='font-weight: 600;' class='mt-3 text-center'>"+currFormat.format(0.0)+"</h4>");
	out.println("<hr class='mt-3'>");
	out.println("<h3 class='h6 font-weight-semibold'><span class='badge badge-success mr-2'>Note</span>Additional comments</h3>");
	out.println("<textarea class='form-control mb-3' id='order-comments' rows=''></textarea>");
	out.println("<a href='checkout.jsp' class='text-center mt-4'><button type='button' class='btn btn-primary showButton col-lg-12'><i class='fa-solid fa-credit-card mr-2'></i>Proceed to Checkout</button></a>");
	out.println("<a href='listprod.jsp?categoryName=&productName=' class='text-center mt-4'><button type='button' class='btn btn-secondary showButton col-lg-12 mt-2'><i class='fa-solid fa-basket-shopping mr-2'></i>Continue Shopping</button></a>");
	out.println("</div>");
	out.println("</div>");
	productList = new HashMap<String, ArrayList<Object>>();
}
else
{

	out.println("<h1 class='text-center border p-4 mt-4'><i class='fa-solid fa-cart-shopping mr-2 text-success'></i>Your Shopping Cart</h1>");
	out.println("<div class='shoppingCart col-lg-12 d-flex'>");
	out.println("<div class='left-side col-lg-9'>");
		out.println("<div class='topBar col-lg-12 bg-light p-3'><span class='font-weight-bold'>Products</span></div>");
		double total = 0;
		Iterator<Map.Entry<String, ArrayList<Object>>> iterator1 = productList.entrySet().iterator();
		while (iterator1.hasNext()) 
		{	Map.Entry<String, ArrayList<Object>> entry1 = iterator1.next();
			ArrayList<Object> product = (ArrayList<Object>) entry1.getValue();
			if (product.size() < 4)
			{
				out.println("Expected product with four entries. Got: "+product);
				continue;
			}
			
			String name = "newqty" + product.get(0);
			Object price = product.get(2);
			Object itemqty = product.get(3);
			double pr = 0;
			int qty = 0;
			
			try
			{
				pr = Double.parseDouble(price.toString());
			}
			catch (Exception e)
			{
				out.println("Invalid price for product: "+product.get(0)+" price: "+price);
			}
			try
			{
				qty = Integer.parseInt(itemqty.toString());
			}
			catch (Exception e)
			{
				out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
			}		

			check = true;
			out.println("<div class='shoppingItem d-flex flex-row border'><div class='imageItem col-lg-4'><img src='"+product.get(4)+"'></div><div class='informationItem col-lg-6 d-flex flex-column'><span class='mt-5 font-weight-bold'>"+product.get(1)+"</span><span class='text-muted mt-4'>Brand new</span><span class='mt-4'>"+currFormat.format(pr)+"</span></div><div class='changeItem col-lg-2 d-flex flex-column'><span class='mt-5'>Quantity</span><input type='text' class='mt-2' name='"+name+"' size='3' value='"+product.get(3)+"'><input type='button' class='btn btn-outline-secondary btn-sm mt-1' onclick='update("+product.get(0)+", document.form1.newqty"+product.get(0)+".value)' value='Update cart'><input type='button' class='btn btn-outline-danger btn-sm mt-1' onclick='remove("+product.get(0)+")' value='Remove'><span class='mt-2 totalItem text-muted'>Total: "+currFormat.format(pr*qty)+"</span></div></div>");	
			total = total +pr*qty;
		}
		if(!check){
			out.println("<h2 style='font-weight: 300;' class='border p-3'>No item found in the shopping cart.</h2>");
		}
	out.println("</div>");
	out.println("<div class='right-side col-lg-3'>");
	out.println("<div class='topBar col-lg-12 bg-light p-3'><span class='font-weight-bold'>Subtotal</span></div>");
	out.println("<h4 style='font-weight: 600;' class='mt-3 text-center'>"+currFormat.format(total)+"</h4>");
	out.println("<hr class='mt-3'>");
	out.println("<h3 class='h6 font-weight-semibold'><span class='badge badge-success mr-2'>Note</span>Additional comments</h3>");
	out.println("<textarea class='form-control mb-3' id='order-comments' rows=''></textarea>");
	out.println("<a href='checkout.jsp' class='text-center mt-4'><button type='button' class='btn btn-primary showButton col-lg-12'><i class='fa-solid fa-credit-card mr-2'></i>Proceed to Checkout</button></a>");
	out.println("<a href='listprod.jsp?categoryName=&productName=' class='text-center mt-4'><button type='button' class='btn btn-secondary showButton col-lg-12 mt-2'><i class='fa-solid fa-basket-shopping mr-2'></i>Continue Shopping</button></a>");
	out.println("</div>");
	out.println("</div>");

}
%>
</form>
</div>
</div>
<style>
	.shoppingItem .imageItem img{
		width: 100%;
	}
	.totalItem{
		font-size: 15.5px;
	}
</style>
</body>
</html> 

