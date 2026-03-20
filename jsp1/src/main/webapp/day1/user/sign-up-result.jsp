<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="../../db.jsp" %>
	<%
		String userId = request.getParameter("userId");
		String pwd1 = request.getParameter("pwd1");
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		
		String sql= String.format(
				"INSERT INTO TBL_USER(USERID, PWD, USERNAME, GENDER) VALUES ('%s','%s','%s','%s')"
				,userId, pwd1, name, gender);
		int result = stmt.executeUpdate(sql);
		if(result > 0){
			out.println("가입추카");
		}else{
			out.println("오류 발생!!!");
		}
	%>
	
	
</body>
</html>
