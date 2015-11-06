package com.JSPandServlet.servlet;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.JSPandServlet.jdbc.Book;
import com.JSPandServlet.jdbc.DbUtil;

public class NewServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String pageNumx = req.getParameter("pageNum") ;
		String pageNum = ""+Integer.parseInt(req.getParameter("pageNum"))*5;
		String sql = "select*from books where indate<'2015-11-01' limit "+pageNum+",5" ;
		ResultSet resultSet = DbUtil.search(sql);
		ArrayList<Book> books = new ArrayList<Book>();
		try {
			while(resultSet.next()){
				Book book = new Book();
				book.setAutho(resultSet.getString("autho"));
				book.setBookname(resultSet.getString("bookname"));
				book.setPress(resultSet.getString("press"));
				book.setPrice(resultSet.getDouble("price"));
				books.add(book);
			}
			req.setAttribute("pagex", "pagex");
			if(books!=null&&books.size()>0){
				req.setAttribute("newbooks", books);
				req.setAttribute("pageNow", Integer.parseInt(pageNumx));
			}else {
				req.setAttribute("ret", "error");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		RequestDispatcher rd = req.getRequestDispatcher("newbooks.jsp");
		rd.include(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		super.doPost(req, resp);
	}
	
}
