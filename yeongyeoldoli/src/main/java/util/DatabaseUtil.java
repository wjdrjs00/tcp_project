package util;

import java.sql.Connection;  
import java.sql.DriverManager;
import java.sql.PreparedStatement;
 
public class DatabaseUtil {
	public static Connection getConnection() {
		try {
			String dbURL = "jdbc:mysql://localhost/ydori";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver");
			return  DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static void close(Connection conn, PreparedStatement pstmt) {
		// TODO Auto-generated method stub
		
	}

}

