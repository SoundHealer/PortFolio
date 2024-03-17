package Server_DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	Connection conn = null;

	public Connection getConnection() {

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");

			String url = "jdbc:mysql://localhost:3306/gamedb";
			String id = "root";
			String pwd = "1234";
			conn = DriverManager.getConnection(url, id, pwd);
//			System.out.println("연결 성공");

		} catch (Exception e) {
			
			return reConnection();// 다른 패스워드 적용
		}
		return conn;
	}

	public Connection reConnection() {

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");

			String url = "jdbc:mysql://121.130.132.95:3306/gamedb";
			String id = "outlineuser";
			String pw = "outline0000";
			conn = DriverManager.getConnection(url, id, pw);
//			System.out.println("연결 성공");

		} catch (Exception e) {
			System.out.println("연결 실패");
			e.printStackTrace();
		}
		return conn;
	}

	public void close() {
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		new DBConnection().getConnection();

	}

}