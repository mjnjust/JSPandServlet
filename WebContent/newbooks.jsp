<%@page import="java.sql.ResultSet"%>
<%@page import="com.JSPandServlet.jdbc.DbUtil"%>
<%@page import="com.JSPandServlet.jdbc.Book"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>new books</title>
<link href="css/global.css" type="text/html" rel="stylesheet">
</head>
<%ResultSet resultSet = DbUtil.search("select count(*) as num from books where indate <'2015-11-01' ") ; %>
<%resultSet.next() ;%>
<%int num = resultSet.getInt("num"); int pages = num%5==0?num/5:num/5+1 ;%>
<%ArrayList<Book> books = (ArrayList<Book>)request.getAttribute("newbooks"); %>
<body onload="onLoad()">
		<div>
		<form action="newservlet" id="forma">
			<table border="1" id="inbooks">
				<caption>新书上线</caption>
					<tr>
						<td>书名</td>
						<td>作者</td>
						<td>出版社</td>
						<td>价格/元</td>
					</tr>
					 
					<%if(books!=null&&books.size()>0){ %>
						<%for(int i=0;i<books.size();i++){%>	
							<tr>
								<td><%=books.get(i).getBookname() %></td>
								<td><%=books.get(i).getAutho() %></td>
								<td><%=books.get(i).getPress() %></td>
								<td><%=books.get(i).getPrice() %></td>
							</tr>
						<% }%>
					<% }%>
					<tr>
						<td>
							<select id="pageSelect" onchange="pageChange(this)">
								<%for(int j=0;j<pages;j++){%>
									<option value=<%=j%>
										<%if(request.getAttribute("pageNow")!=null&&j==(Integer)request.getAttribute("pageNow")){%>
											selected ="selected"
										<%} %>
									>
										<%=j+1 %>
									</option>
								<%} %>
							</select>
						</td>
						<td>共<%=pages%>页</td>
						<td><button onclick="nextPage()">下一页</button></td>
						<td><button onclick="lastPage()">上一页</button></td>
					</tr>
			</table>
			<input type="hidden" id="pageNum" value="0" name="pageNum">
			<input type="hidden" id="pagex" value=<%=request.getAttribute("pagex") %>>
		</form>
	</div>
</body>
<script type="text/javascript">
	pageSelect = document.getElementById("pageSelect");
	pageNum = document.getElementById("pageNum");
	function onLoad(){
		var x= document.getElementById("pagex").value; 
		if(x=="null"){
			pageShow(0);
		}
	}
	function nextPage(){
		var pageNow = pageSelect.selectedIndex + 1 ;
		if(pageNow<pageSelect.options.length){
			pageShow(pageNow);
		}
	}
	function pageShow(index){
		pageNum.value = index ;
		document.getElementById("forma").submit();
	}
	function lastPage(){
		var pageNow = pageSelect.selectedIndex - 1 ;
		if(pageNow>=0){
			pageShow(pageNow);
		}
	}
	function pageChange(obj){
		pageShow(obj.value);
	}
</script>

</html>