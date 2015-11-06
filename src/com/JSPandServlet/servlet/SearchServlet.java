package com.JSPandServlet.servlet;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.JSPandServlet.jdbc.Book;
import com.JSPandServlet.jdbc.DbUtil;

public class SearchServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doGet(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String data = req.getParameter("search_info");
		String se = req.getParameter("search_ano");
		ResultSet resultSet = null ;
		ResultSet resultSet2 = null ;
		ArrayList<Book> books = new ArrayList<Book>();
		if(se.equals("1")){
			resultSet = DbUtil.search("select*from books where bookname like '%"+data+"%' and type = 0");
		}else if (se.equals("2")) {
			resultSet = DbUtil.search("select*from books where autho like '%"+data+"%' and type = 0");
		}
		if(resultSet!=null){
			try {
				while(resultSet.next()){
					Book book = new Book();
					book.setAutho(resultSet.getString("autho"));
					book.setBookname(resultSet.getString("bookname"));
					book.setPress(resultSet.getString("press"));
					book.setPrice(resultSet.getDouble("price"));
					books.add(book);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(se.equals("1")){
			resultSet2 = DbUtil.search("select*from booksout where bookname like '%"+data+"%'");
		}else if (se.equals("2")) {
			resultSet2 = DbUtil.search("select*from booksout where autho like '%"+data+"%'");
		}
		if(resultSet2!=null){
			try {
				while(resultSet2.next()){
					Book book = new Book();
					book.setAutho(resultSet2.getString("autho"));
					book.setBookname(resultSet2.getString("bookname"));
					book.setPress(resultSet2.getString("press"));
					book.setPrice(resultSet2.getDouble("price"));
					book.setBorrowdate(resultSet2.getDate("borrowdate"));
					book.setSbackdate(resultSet2.getDate("sbackdate"));
					books.add(book);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		System.out.println(books.size());
		req.setAttribute("books", books);
		RequestDispatcher rd = req.getRequestDispatcher("search.jsp");
		rd.include(req, resp);
//		super.doPost(req, resp);
	}	
}
