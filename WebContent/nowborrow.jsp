<%@page import="com.JSPandServlet.jdbc.DbUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.JSPandServlet.jdbc.Book" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>nowborrow</title>
</head>
<body>
	<%ResultSet resultSet = DbUtil.search("select*from booksout where username = '"+session.getAttribute("username")+"'"); %>
	<table border="1">
		<caption>当前借阅图书信息</caption>
		<tr>
			<td>书名</td>
			<td>作者</td>
			<td>出版社</td>
			<td>价格</td>
			
			<td>借书日期</td>
			<td>应还日期</td>
		</tr>
		<%while(resultSet.next()){ %>
		<tr>
			<td><%=resultSet.getString("bookname")%></td>
			<td><%=resultSet.getString("autho") %></td>
			<td><%=resultSet.getString("press") %></td>
			<td><%=resultSet.getDouble("price") %></td>
			<td><%=resultSet.getDate("borrowdate").toString() %></td>
			<td><%=resultSet.getDate("sbackdate")%></td>
		</tr>
		<%} %>
	</table>
</body>
</html>