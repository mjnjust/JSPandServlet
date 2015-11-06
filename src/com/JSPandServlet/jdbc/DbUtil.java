package com.JSPandServlet.jdbc;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

public class DbUtil {
	static Connection connection = null ;
	static Statement statement = null ;
	static{
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connection = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/jspandservlet", "root", "root");
			statement = (Statement) connection.createStatement() ;
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}
	public static ResultSet search(String sql){
		ResultSet resultSet = null ;
		System.out.println(sql);
		try {
			resultSet = statement.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return resultSet ;
	}
}
