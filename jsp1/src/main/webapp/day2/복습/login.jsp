<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- login.jsp -->
	<form action="login-result.jsp" method="get" name="login">
		<div>
			아이디 : <input name="userId">
		</div>
		<div>
			비밀번호 : <input name="pwd" type="password">
		</div>
		<div>
			<input type="submit" value="submit버튼">
			&nbsp;&nbsp;
			<input type="button" value="그냥 버튼" onclick="fnLogin()">
		</div>
	</form>
	
</body>
</html>
<script>
	function fnLogin(){
		let form = document.login;
		if(form.userId.value.length == 0){
			alert("아이디 입력하세요.");
			return;
		}
		if(form.pwd.value.length == 0){
			alert("비밀번호 입력하세요.");
			return;
		}
		
		form.submit();
		
	}
</script>







