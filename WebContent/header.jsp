<%
String username = session.getAttribute("authenticatedUser").toString();
%>
<nav class="navbar navbar-expand-lg bg-dark">
    <div class="container-fluid">
      <div class="collapse navbar-collapse d-flex justify-content-center" id="navbarNavDropdown">
        <ul class="navbar-nav">
            <a class="navbar-brand text-white" href="customerPage.jsp"><span class="name">Tech</span>Kelo</a>
          <li class="nav-item">
            <a class="nav-link text-white" aria-current="page" href="customerPage.jsp">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-white" href="listMyOrders.jsp">My Orders</a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-white" href="listprod.jsp?categoryName=&productName=">Shop Products</a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-white" href="showcart.jsp">Shopping Cart</a>
          </li>
        </ul>
        <a href="customer.jsp" style="text-decoration-style: none; right: 10%; color: white;">
        <span style="float: right; position: absolute; right: 8%; top: 30%;"><%=username%></span>
        <div style="width: 40px; height:40px; float: right; position: absolute; right: 5%; top: 10%;"><img src="img/person.png" style="width: 100%;"></div>
        </a>
      </div>
    </div>
  </nav>