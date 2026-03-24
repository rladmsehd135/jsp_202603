<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 보기</title>
<style>
body {
	margin: 30px;
}

table, th, tr, td {
	border: 1px solid black;
	padding: 5px 10px;
	border-collapse: collapse;
}

th {
	width: 50px;
	background-color: #eee;
}

td {
	width: 250px;
}

.contents {
	height: 200px;
}

.btn-area {
	margin-top: 5px;
}

.line {
	margin: 30px 0px;
	border-bottom: 1px solid #aaa;
}

.comment-area {
	margin-bottom: 500px;
}

.comment-area th {
	width: 100px;
}

.comment-area td {
	width: 250px;
}
</style>
</head>
<body>

	<%@ include file="../../db.jsp"%>

	<form action="" name="form">

		<%
		String sessionId = (String) session.getAttribute("sessionId");
		String boardNo = request.getParameter("boardNo");
		String sessionRole = (String) session.getAttribute("sessionRole");

		if (sessionRole == null) {
			sessionRole = "";
		}
		%>

		<input name="boardNo" value="<%=boardNo%>" hidden>

		<table>

			<%
			String sql = "UPDATE TBL_BOARD SET CNT = CNT + 1 " + "WHERE BOARDNO = " + boardNo;
			stmt.executeUpdate(sql);

			sql = "SELECT * FROM TBL_BOARD WHERE BOARDNO = " + boardNo;
			ResultSet rs = stmt.executeQuery(sql);

			String userId = "";

			if (rs.next()) {
				userId = rs.getString("USERID");
			%>

			<tr>
				<th>제목</th>
				<td colspan="3"><%=rs.getString("TITLE")%></td>
			</tr>

			<tr>
				<th>작성자</th>
				<td><%=rs.getString("USERID")%></td>
				<th>조회수</th>
				<td><%=rs.getString("CNT")%></td>
			</tr>

			<tr>
				<th>작성일</th>
				<td colspan="3"><%=rs.getString("CDATETIME")%></td>
			</tr>

			<tr>
				<th>내용</th>
				<td colspan="3" class="contents"><%=rs.getString("CONTENTS")%></td>
			</tr>

			<%
			} else {
			out.println("게시글이 존재하지 않습니다.");
			}
			%>

		</table>

		<div class="btn-area">

			<%
			if (userId.equals(sessionId) || "A".equals(sessionRole)) {
			%>
			<input type="button" value="수정" onclick="fnEdit()"> <input
				type="button" value="삭제" onclick="fnRemove()">
			<%
			}
			%>

			<input type="button" value="되돌아가기" onclick="history.back()">

		</div>

		<div class="line"></div>

		<div class="comment-area">

			<table>

				<%
				sql = "SELECT * FROM TBL_COMMENT WHERE BOARDNO = " + boardNo;
				
				rs = stmt.executeQuery(sql);

				while (rs.next()) {
				%>

				<tr>
					<th><%=rs.getString("USERID")%></th>
					<td><%=rs.getString("CONTENTS")%></td>
				</tr>

				<%
				}
				%>

			</table>

			<table>
					<th>댓글 등록</th>
					<td style="width: 470px; border-right: none;"><textarea name ="contents" cols="60" rows="5"></textarea></td>
					<td style="width: 100px; border-left: none;"><input
						type="button" value="등록" onclick="fnCommentAdd()">
					</td>
				

			</table>

		</div>

	</form>

</body>
</html>

<script>
	function fnEdit() {
		let form = document.form;
		form.action = "board-edit.jsp";
		form.submit();
	}

	function fnRemove() {
		console.log(<%=boardNo%>);
		
		location.href = "board-remove.jsp?boardNo=" + <%=boardNo%>;
	}
	function fnCommentAdd() {
		let form = document.form;
		form.action = "board-comment-add.jsp";
		form.submit();
	}
</script>
