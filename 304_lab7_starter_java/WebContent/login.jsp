<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="styleInfo.css">
</head>
<body style="width: 100%; height: 100vh;">


<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null)
	out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
%>


<form name="MyForm" method=post action="validateLogin.jsp" class="form-control d-flex flex-column align-items-center">
<table>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
	<td><input type="text" name="username"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
	<td><input type="password" name="password" size=10 maxlength="10"></td>
</tr>
</table>
<input class="submit btn btn-outline-danger mt-4" type="submit" name="Submit2" value="Log In">
<a class="btn btn-outline-success mt-4" href="index.jsp">Back</a>
</form>


<style>
	.form-control{
		position: absolute;
		top: 50%;
		transform: translateY(-50%);
	}
</style>
</body>
</html>

