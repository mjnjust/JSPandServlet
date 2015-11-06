<%@page import="java.util.ArrayList"%>
<%@page import="com.JSPandServlet.jdbc.Book" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>search book</title>
</head>
<body onload="onLoad()">
	<form action="searchservlet" method="post">
		<a>请输入关键字：</a><input name="search_info" type="text">
		<select name="search_ano">
			<option value="1">书名</option>
			<option value="2">作者</option>
		</select>
		<input type="submit" value="确定">
	</form>
	<%ArrayList<Book> books = (ArrayList<Book>)request.getAttribute("books"); %>
	<%if(books!=null&&books.size()>0) { %>
		<%int pages = 0 ;int i = 0;int outbooks = 0;int t = 0;%>
		<%for(t = 0;t<books.size();t++){%>
			<%if(books.get(t).getBorrowdate()!=null){pages=(t%10==0?t/10:t/10+1);outbooks = books.size()-t;%>
			<% break;} %>
		<%} %>
		<%if(t == books.size()){ %>
			<% pages=(t%10==0?t/10:t/10+1);outbooks = books.size()-t;%>
		<%} %>
		<input type="hidden" id = pagesNum value = <%=pages %>>
		<%for(int pg = 0; pg<pages; pg++){ %>
			<div id=<%="div"+pg%> style="display:none">
				<table border="1" id="inbooks">
					<caption>可借阅</caption>
						<tr>
							<td>书名</td>
							<td>作者</td>
							<td>出版社</td>
							<td>价格/元</td>
						</tr>
						<%for(i=0;i<books.size()&&i<(pg+1)*10&&books.get(i).getBorrowdate()==null;i++){ %>
						<tr>
							<td><%=books.get(i).getBookname() %></td>
							<td><%=books.get(i).getAutho() %></td>
							<td><%=books.get(i).getPress() %></td>
							<td><%=books.get(i).getPrice() %></td>
						</tr>
						<%} %>
				</table>
			</div>
		<%} %>
		<table>
			<tr>
				<td>
					<select  name="pageNum" id="pageSelect" onchange="pageChange(this)">
						<%for(int j=0;j<pages;j++){%>
							<option value=<%=j%>><%=j+1 %></option>
						<%} %>
					</select>
				</td>
				<td>共<%=pages%>页</td>
				<td><button onclick="nextPage()">下一页</button></td>
				<td><button onclick="lastPage()">上一页</button></td>
			</tr>
		</table>
		<%pages = outbooks%10==0?outbooks/10:outbooks/10+1 ;%>
		<input type="hidden" id = pagesNumb value = <%=pages %>>
		<%if(outbooks>0){ %>
			<%for(int pg=0;pg<pages;pg++){ %>
				<div id=<%="bdiv"+pg %> style="display:none">
					<table border="1">
						<caption>已借出</caption>
						<tr>
							<td>书名</td>
							<td>作者</td>
							<td>出版社</td>
							<td>价格/元</td>
							<td>借出日期</td>
							<td>应还日期</td>
						</tr>
						<%for(int b = 0;i<books.size()&&b<10;i++,b++){ %>
						<tr>
							<td><%=books.get(i).getBookname() %></td>
							<td><%=books.get(i).getAutho() %></td>
							<td><%=books.get(i).getPress() %></td>
							<td><%=books.get(i).getPrice() %></td>
							<td><%=books.get(i).getBorrowdate().toString() %></td>
							<td><%=books.get(i).getSbackdate().toString() %></td>
						</tr>
						<%} %>
					</table>
				</div>
			<%} %>
			<table>
			<tr>
				<td>
					<select  name="pageNumb" id="pageSelectb" onchange="pageChangeb(this)">
						<%for(int j=0;j<pages;j++){%>
							<option value=<%=j%>><%=j+1 %></option>
						<%} %>
					</select>
				</td>
				<td>共<%=pages%>页</td>
				<td><button onclick="nextPageb()">下一页</button></td>
				<td><button onclick="lastPageb()">上一页</button></td>
			</tr>
		</table>
		<%} %>
	<%}else if(books!=null){ %>
		<p>没有符合条件的书籍！</p>
	<%} %>
</body>
<script type="text/javascript">
	var before = 0;
	var beforeb = 0;
	pagesNum = document.getElementById("pagesNum").value ;
	pagesNumb = document.getElementById("pagesNumb").value ;
	mselect = document.getElementById("pageSelect");
	bselect = document.getElementById("pageSelectb");
	function onLoad(){
		mdivNow = document.getElementById("div"+0);
		if(mdivNow != null){
			mdivNow.style.display = "block";
			mselect.options[0].selected = "selected" ;
		}
		bdivNow = document.getElementById("bdiv"+0);
		if(bdivNow != null){
			bdivNow.style.display = "block";
			bselect.options[0].selected = "selected";
		}
	}
	function pageShow(index){
		mdivBef = document.getElementById("div"+before);
		mdivBef.style.display="none"
		mdivNow = document.getElementById("div"+index);
		mdivNow.style.display="block";
		before=parseInt(index);
	}
	function pageChange(obj){
		index = obj.value;
		pageShow(index);
	}
	function nextPage(){
		var pageNow = before + 1 ;
		if(pageNow<pagesNum){
			mselect.options[pageNow].selected = "selected" ;
			pageShow(pageNow);
		}
	}
	function lastPage(){
		var pageNow = before - 1 ;
		if(pageNow>=0){
			mselect.options[pageNow].selected = "selected" ;
			pageShow(pageNow);
		}
	}
	function pageShowb(index){
		bdivBef = document.getElementById("bdiv"+beforeb);
		bdivBef.style.display="none"
		bdivNow = document.getElementById("bdiv"+index);
		bdivNow.style.display="block";
		beforeb=parseInt(index);
	}
	function pageChangeb(obj){
		index = obj.value;
		pageShowb(index);
	}
	function nextPageb(){
		var pageNow = beforeb + 1 ;
		if(pageNow<pagesNumb){
			bselect.options[pageNow].selected = "selected" ;
			pageShowb(pageNow);
		}
	}
	function lastPageb(){
		var pageNow = beforeb - 1 ;
		if(pageNow>=0){
			bselect.options[pageNow].selected = "selected" ;
			pageShowb(pageNow);
		}
	}
</script>
</html>