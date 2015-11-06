package com.JSPandServlet.jdbc;

import java.sql.Date;

public class Book {

	private String bookname ;
	private String username ;
	private String press ;
	private String autho ;
	private Date borrowdate ;
	private Date sbackdate ;
	private double price ;
	
	public String getBookname() {
		return bookname;
	}
	public void setBookname(String bookname) {
		this.bookname = bookname;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPress() {
		return press;
	}
	public void setPress(String press) {
		this.press = press;
	}
	public String getAutho() {
		return autho;
	}
	public void setAutho(String autho) {
		this.autho = autho;
	}
	public Date getBorrowdate() {
		return borrowdate;
	}
	public void setBorrowdate(Date borrowdate) {
		this.borrowdate = borrowdate;
	}
	public Date getSbackdate() {
		return sbackdate;
	}
	public void setSbackdate(Date sbackdate) {
		this.sbackdate = sbackdate;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
}
