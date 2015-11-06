package com.JSPandServlet.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.JSPandServlet.jdbc.DbUtil;

public class LogServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		System.out.println("Myservlet.doGet()");
		resp.setContentType("text/html;charset=UTF-8");
		req.setCharacterEncoding("UTF-8");
		String name = req.getParameter("name");
		String password = req.getParameter("password");
		ResultSet resultSet = DbUtil.search("select*from user where name = '"+name+"'");
		String db_password = null ;
		String db_name = null ;
		try {
			while(resultSet.next()){
				db_name = resultSet.getString("name");
				db_password=resultSet.getString("password");
				break;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(db_password.equals(password)){
			RequestDispatcher rd = req.getRequestDispatcher("index.html");
			req.getSession().setAttribute("username", db_name);
			rd.forward(req, resp);
		}else {
			PrintWriter out = resp.getWriter();
			out.println("密码错误");
			RequestDispatcher rd = req.getRequestDispatcher("login.html");
			rd.include(req, resp);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("Myservlet.doPost()");
		super.doPost(req, resp);
	}

	@Override
	protected void service(HttpServletRequest arg0, HttpServletResponse arg1)
			throws ServletException, IOException {
		System.out.println("do MyServlet.service(http)");
		super.service(arg0, arg1);
	}

	@Override
	public void service(ServletRequest arg0, ServletResponse arg1)
			throws ServletException, IOException {
		System.out.println("do Myservlet.service()");
		super.service(arg0, arg1);
	}

	public LogServlet() {
		System.out.println("do MyServlet()");
	}
	
	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		System.out.println("do Myservlet.init()");
		super.init();
	}
	
}
