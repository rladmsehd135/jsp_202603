
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- id가 test, pwd 1234 면 '로그인 성공' 출력 -->
	<!-- 아니면 '로그인 실패' 출력 -->
	
		<%@ include file="../../db.jsp" %>
		<%
			String userId = request.getParameter("userId");
			String pwd = request.getParameter("pwd");	
			
			String sql = "SELECT * FROM TBL_USER "
						+ "WHERE USERID = '" + userId + "'";
			ResultSet rs = stmt.executeQuery(sql);
			
			
			if(rs.next()){
				/*아이디는 있는 경우*/
				if(pwd.equals(rs.getString("PWD"))){
					out.print("로그인 성공");
				}else{
					/*비밀번호는 다를 떄*/
					out.print("비밀번호를 확인해수제요");
				}
			}else{
				out.print("해당 아이디는 존재하지 않습니다");
			}
	
		%>

		
		
</body>
</html>