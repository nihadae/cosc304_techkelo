<%@ include file="jdbc.jsp" %>
<%
String first = request.getParameter("first");
String last = request.getParameter("last");
String email = request.getParameter("email");
String phone = request.getParameter("phone");
String address = request.getParameter("address");
String city = request.getParameter("city");
String state = request.getParameter("state");
String postal = request.getParameter("postal");
String country = request.getParameter("country");

String userid = String.valueOf(session.getAttribute("authenticatedUser"));


// TODO: Print Customer information
try
		{
			getConnection();
            String sql = "UPDATE customer SET firstName = ?, lastName = ?, email = ?, phonenum = ?, address = ?, city = ? , state = ?, postalCode = ?, country = ? where userid = ?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, first);
            pstmt.setString(2, last);
            pstmt.setString(3, email);
            pstmt.setString(4, phone);
            pstmt.setString(5, address);
            pstmt.setString(6, city);
            pstmt.setString(7, state);
            pstmt.setString(8, postal);
            pstmt.setString(9, country);
            pstmt.setString(10, userid);
            if(!first.equals("") && !last.equals("") && !email.equals("") && !phone.equals("") && !address.equals("") && !city.equals("") && !state.equals("") && !postal.equals("") && !country.equals("")){
                pstmt.executeUpdate();
            }
		} 
		catch (SQLException ex) {
			out.println(ex);
		}

%>

<jsp:forward page="customer.jsp" />








