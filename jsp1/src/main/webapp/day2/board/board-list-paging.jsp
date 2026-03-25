<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#container {
	width: 800px;
	margin: 80px auto;
}

table {
	width: 100%;
	margin: 0 auto;
}

.select-area {
	text-align: right;
	margin-bottom: 5px;
}

body {
	margin: 30px;
}

table, th, tr, td {
	border: 1px solid black;
	padding: 5px 10px;
	border-collapse: collapse;
	text-align: center;
}

th {
	background-color: #eee;
}

.paging-area {
	margin-top: 5px;
	text-align: center
}

.paging-area a {
	padding: 5px;
	text-decoration: none;
	color: #4c4848;
	font-size: 20px;
}

.paging-area .active {
	font-weight: bold;
	color: black;
}

.title {
	text-align: left;
	width: 40%;
}

.comment-cnt {
	color: blue;
	font-weight: bold;
}

.search-area {
	margin: 10px 0px;
	text-align: center;
}
</style>
</head>
<body>
	<div id="container">
		<form action="board-list-paging.jsp" name="form">
			<%@ include file="../../db.jsp"%>
			<%
			int pageSize = 5;
			if (request.getParameter("pageSize") != null) {
				pageSize = Integer.parseInt(request.getParameter("pageSize"));
			}
			String keyword = request.getParameter("keyword");
			%>
			<div class="search-area">
				<label>검색어 : <input name="keyword" value="<%= keyword != null ? keyword : ""  %>" ></label> 
				<input type="submit" value="검색" > 


			</div>
			<div class="select-area">
				<select name="pageSize" onchange="fnPageSize()">
					<%
					int arr[] = {3, 5, 10, 15, 20};
					for (int i = 0; i < arr.length; i++) {
					%>
					<option value="<%=arr[i]%>"
						<%=pageSize == arr[i] ? "selected" : ""%>><%=arr[i]%> 개씩
					</option>
					<%
					}
					%>
				</select>
			</div>
			<table>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>작성일</th>
				</tr>
				<%
				String cntSql = "SELECT COUNT(*) AS TOTAL FROM TBL_BOARD WHERE 1=1 ";
				if(keyword != null){
					cntSql += "AND TITLE LIKE '%" + keyword + "%' ";
				}
				ResultSet rsCnt = stmt.executeQuery(cntSql);
				
				rsCnt.next();
				int total = rsCnt.getInt("TOTAL");

				int pageList = (int) Math.ceil((double) total / pageSize);
				int currentPage = 1;
				if (request.getParameter("page") != null) {
					currentPage = Integer.parseInt(request.getParameter("page"));
				}
				int offset = (currentPage - 1) * pageSize;

				/* String sql = "SELECT B.*, TO_CHAR(CDATETIME, 'YYYY-MM-DD') AS CDATE "
					+ "FROM TBL_BOARD B WHERE 1=1 "; */
				String sql = "SELECT B.*, TO_CHAR(CDATETIME, 'YYYY-MM-DD') AS CDATE, NVL(COMMENT_CNT, 0) AS COMMENT_CNT "
						+ "FROM TBL_BOARD B " + "LEFT JOIN ( " + "    SELECT COUNT(*) AS COMMENT_CNT, BOARDNO "
						+ "    FROM TBL_COMMENT " + "    GROUP BY BOARDNO " + ") T ON B.BOARDNO = T.BOARDNO " + "WHERE 1=1 ";
				if(keyword != null){
					sql += "AND TITLE LIKE '%" + keyword + "%' ";
				}
				if (true) {
					sql += "ORDER BY B.BOARDNO ASC ";
				}
				if (true) {
					sql += "OFFSET " + offset + " ROWS FETCH NEXT " + pageSize + " ROWS ONLY";
				}

				ResultSet rs = stmt.executeQuery(sql);
				while (rs.next()) {
				%>
				<tr>
					<td><%=rs.getString("BOARDNO")%></td>
					<td class="title"><%=rs.getString("TITLE")%> <%
 						if (rs.getInt("COMMENT_CNT") != 0) {
 						%>
						<span class="comment-cnt">[ <%=rs.getString("COMMENT_CNT")%>
							]
					</span> <%
 					}
 					%></td>
					<td><%=rs.getString("USERID")%></td>
					<td><%=rs.getString("CNT")%></td>
					<td><%=rs.getString("CDATE")%></td>
				</tr>
				<%
				}
				%>
			</table>


			<div class="paging-area">
				<%
				if (currentPage != 1) {
				%>
				<a href="?page=<%=currentPage - 1%>&pageSize=<%=pageSize%>&keyword=<%=keyword%>">◀</a>
				<%
				}
				%>
				<%
				for (int i = 1; i <= pageList; i++) {
				%>
				<a href="?page=<%=i%>&pageSize=<%=pageSize%>&keyword=<%=keyword%>"
					class="<%=currentPage == i ? "active" : ""%>"><%=i%></a>
				<%
				}
				%>

				<%
				if (currentPage != pageList) {
				%>
				<a href="?page=<%=currentPage + 1%>&pageSize=<%=pageSize%>&keyword=<%=keyword%>">▶</a>
				<%
				}
				%>
			</div>
		</form>
	</div>
</body>
</html>
<script>
	function fnPageSize() {
		document.form.submit();
	}
</script>
​
