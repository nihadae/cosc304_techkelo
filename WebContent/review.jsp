<%@ include file="jdbc.jsp" %>
<%
String productId = request.getParameter("prodId");
String customerId = request.getParameter("custId");
String rating = request.getParameter("rating");
String message = request.getParameter("message");


// TODO: Print Customer information
try
		{
            boolean check = true;
			getConnection();
            String sql = "select count(*) from review where customerId="+customerId+" and productId="+productId+"";
            Statement stmt10 = con.createStatement();
            ResultSet rst10 = stmt10.executeQuery(sql);
            if(rst10.next()){
                if(rst10.getInt(1) != 0){
                    check = false;
                }
            }
			String sql1 = "insert review(reviewRating, customerId, productId, reviewComment) values (?, ?, ?, ?)";
            if(!productId.equals("") && !customerId.equals("") && !rating.equals("") && !message.equals("") && check){
                PreparedStatement pstmt = con.prepareStatement(sql1);
			pstmt.setInt(1, Integer.parseInt(rating));
            pstmt.setInt(2, Integer.parseInt(customerId));
            pstmt.setInt(3, Integer.parseInt(productId));
            pstmt.setString(4, message);
            pstmt.executeUpdate();
            }
		} 
		catch (SQLException ex) {
			out.println(ex);
		}

%>

<jsp:forward page="listprod.jsp?categoryName=&productName=" />








