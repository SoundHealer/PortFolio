package Server_User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import Server_DB.DBConnection;

public class UserDAO extends DBConnection{

	Connection conn=null;
	PreparedStatement pstmt=null;
	Statement stmt=null;
	ResultSet rs=null;
	
	
	
	// UserDAO class
	public boolean checkUser(User user) {
	    conn = getConnection();

	    String sql = "SELECT * FROM user WHERE userid = ? AND userpw = ?";

	    try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getUserid());
            pstmt.setString(2, user.getUserpw());

	        rs = pstmt.executeQuery();

	        return rs.next();

	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    } finally {
	        close();
	    }
	}

	
	public void insertUser(User user) {
		conn = getConnection();

		String sql="insert into user values(?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserid());
			pstmt.setString(2, user.getUserpw());

			pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		close();
	}
	
	public void close() {
		try {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();

		}catch(Exception e) {
			System.out.println("종료시 에러");
		}

	}
}
