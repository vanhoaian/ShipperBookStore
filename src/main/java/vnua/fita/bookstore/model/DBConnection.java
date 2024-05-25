package vnua.fita.bookstore.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import vnua.fita.bookstore.util.Constant;

public class DBConnection {
	private static String url= Constant.URL;
	private static String username= Constant.USERNAME;
	private static String password= Constant.PASSWORD;
	
	public static Connection createConnection(String jdbcURL, String jdbcUsername,
			String jdbcPassword) {
		Connection conn = null;
		try {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
			conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	public static Connection createConnection() {
		Connection conn=null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn=DriverManager.getConnection(url,username,password);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return conn;
	}
	
	public static void closeConnection(Connection conn) {
		try {
			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public static void closePreparedStatement(PreparedStatement ps) {
		try {
			ps.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public static void closeStatement(Statement st) {
		try {
			    st.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public static void closeResultSet(ResultSet rs) {
		try {
			rs.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public static void rollbackQuietly(Connection conn) {
		try {
			conn.rollback();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
