package com.JSPandServlet.test;

import java.sql.Array;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

//利用这个类进行简单的测试
public class Test {
	
	//利用jdbc连接数据库
	@org.junit.Test
	public void testJdbc() {
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/njusttalk";
		String user = "root" ;
		String password = "root" ;
		Connection connection = null ;
		Statement statement = null ;
		ResultSet resultSet = null ;
		try {
			Class.forName(driver);
			connection = (Connection) DriverManager.getConnection(url, user, password);
			statement = (Statement) connection.createStatement();
			resultSet = statement.executeQuery("select*from user");
			while(resultSet.next()){
				System.out.println(resultSet.getString("id")+" "+resultSet.getString("userid")+" "+resultSet.getString("password"));
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}
