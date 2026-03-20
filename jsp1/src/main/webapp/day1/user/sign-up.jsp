<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form action="sign-up-result.jsp" name="sign" method="get">
		<div>
		<label>아이디 : <input name = "userId"></label>
		</div>
		<div>
		<label>비밀번호 : <input name = "pwd1" type ="password"></label>
		</div>
		<div>
		<label>비밀번호 확인: <input name = "pwd2" type ="password"></label>
		</div>
		<div>
		<label>이름 : <input name = "name"></label>
		</div>
		<div>
			성별
			<label><input type = "radio" value="M" name="gender" checked>남자</label>
			<label><input type = "radio" value="F" name="gender">여자</label>
		</div>
		<div>
			<input type="button" value="회원가입!" onclick="fnSignUp()">
		</div>
	</form>
</body>
</html>
<script>
	function fnSignUp(){
		let sign = document.sign;
		/* console.log(login.userId.value); */
		if(sign.userId.value.length == 0){
			alert("아이디 입력하셈");
			sign.userId.focus();
			return;
		}
		if(sign.pwd1.value.length == 0){
			alert("비밀번호 입력하셈");
			sign.pwd1.focus();
			return;
		}
		if(sign.pwd2.value.length == 0){
			alert("비밀번호 확인 입력하셈");
			sign.pwd2.focus();
			return;
		}
		if(sign.name.value.length == 0){
			alert("이름 입력하셈");
			sign.name.focus();
			return;
		}
		if(sign.pwd1.value != sign.pwd2.value){
		    alert("비밀번호가 일치하지 않습니다");
		    sign.pwd2.focus();
		    return;
		}
		//위 조건을 모두 만족했을 때, 최종 submit(action 페이지 호출)
		sign.submit();
	}


</script>