<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="../../db.jsp"%>
	<%
		String productId = request.getParameter("productId");
		String sql = "SELECT * FROM PRODUCT WHERE PRODUCT_ID =" + productId;
		ResultSet rs = stmt.executeQuery(sql);
		if(rs.next()){
			out.println("<div>" + rs.getString("PRODUCT_NAME") + "</div>");
			out.println("<div>" + rs.getString("BRAND") + "</div>");
			out.println("<div>" + rs.getString("CATEGORY") + "</div>");
			out.println("<div>" + rs.getString("PRICE") + "</div>");
			out.println("<div>" + rs.getString("DESCRIPTION") + "</div>");
			
		}else{
			out.println("제품 없지롱");
		}
	%>
</body>
</html>