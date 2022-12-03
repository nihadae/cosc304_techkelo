<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>

<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{	out.println("No products");
	productList = new HashMap<String, ArrayList<Object>>();
}


// Read parameters
String id = request.getParameter("id");


// Update quantity for product selected
if (productList.containsKey(id)) 
{ // find item in shopping cart
	productList.remove(id);
}

session.setAttribute("productList", productList);
%>


<jsp:forward page="showcart.jsp" />






