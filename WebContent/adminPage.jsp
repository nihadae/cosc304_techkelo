<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>TechKelo - Admin</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="style.css">
<script src="https://kit.fontawesome.com/a0e85a8b00.js" crossorigin="anonymous"></script>
</head>
<body class="adPage d-flex flex-column">

	<%@ include file="headerAdmin.jsp" %>

	  
      <%
      out.println("<div class='displayMain'><h2 class='text-center'>Welcome <span class='text-muted'>"+session.getAttribute("authenticatedUser").toString()+"</span>!</h2><h1 class='text-center'>Long time no see</h1></div>");
      %>
      <style>
        .displayMain{
            position: absolute;
            top: 50%; right: 50%;
            transform: translate(50%,-50%);
        }
        .adPage{
            width: 100%;
            height: 100vh;
            position: relative;
        }
      </style>
</body>
</html>