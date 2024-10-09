package DB;

import java.sql.*;
import java.text.SimpleDateFormat;

import org.json.JSONObject;

import DB.Data.Data_User;

public class DatabaseConnection {

	protected Connection connection;

	private final String jdbcUrl = "jdbc:mysql://121.130.132.95:3306/moviedb"; // 데이터베이스 URL
	private final String jdbcUsername = "outlineuser"; // 데이터베이스 사용자 이름
	private final String jdbcPassword = "outline0000"; // 데이터베이스 암호

//	private final String jdbcUrl = "jdbc:mysql://localhost:3306/moviedb"; // 데이터베이스 URL
//	private final String jdbcUsername = "root"; // 데이터베이스 사용자 이름
//	private final String jdbcPassword = "0000"; // 데이터베이스 암호
	public int StringParseInt(String stringInt) {
		try {
			return Integer.parseInt(stringInt);
		} catch(Exception e) {
			return -1;
		}
	}
	public Date transStringDate(String stringDate) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

		// 문자열 -> Date
		SimpleDateFormat beforeFormat = new SimpleDateFormat("yyyymmdd");

		// Date로 변경하기 위해서는 날짜 형식을 yyyy-mm-dd로 변경해야 한다.
		SimpleDateFormat afterFormat = new SimpleDateFormat("yyyy-mm-dd");

		java.util.Date tempDate = null;

		// 현재 yyyymmdd로된 날짜 형식으로 java.util.Date객체를 만든다.
		try {
			tempDate = afterFormat.parse(stringDate);
		} catch (java.text.ParseException e) {
			// TODO Auto-generated catch block
			System.out.println("에러 발생");
			tempDate = new java.util.Date("1900-01-01");
			e.printStackTrace();
		}

		String transDate = afterFormat.format(tempDate);


		System.out.println("날짜 문자열 : " + transDate);
		
		Date date = Date.valueOf(transDate);
		return date;
	}
	// 데이터베이스 연결을 설정하고 커넥션을 반환하는 메서드
	public Connection getConnection() {
		connection = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(jdbcUrl, jdbcUsername, jdbcPassword);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return connection;
	}

	public void closeConnection(Connection connection) {
		if (connection != null) {
			try {
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public int signUp(Data_User u) {
		int result = 0;
		
		result = checkId(u.getId());
		connection = getConnection();
		// 데이터베이스에 데이터 삽입 쿼리
		if(result != 0) {
			return result;
		}
		try {
			/*
			 * 				userData.put("userName",rs.getString("userName"));
				userData.put("userId",rs.getString("userId"));
				userData.put("userPw",rs.getString("userPw"));
				userData.put("userEmail",rs.getString("userEmail"));
				userData.put("birthDay",rs.getString("birthDay"));
				userData.put("userAddress",rs.getString("userAddress"));
				userData.put("Genre_1",rs.getString("Genre_1"));
				userData.put("Genre_2",rs.getString("Genre_2"));
				userData.put("Genre_3",rs.getString("Genre_3"));
				userData.put("Genre_4",rs.getString("Genre_4"));*/
			
			String insertQuery = "insert into moviedb.user(userId,userPw,userName,birthDay,userEmail,userAddress,Genre_1,Genre_2,Genre_3,Genre_4) values(?,?,?,?,?,?,?,?,?,?);";
			PreparedStatement preparedStatement = connection.prepareStatement(insertQuery);
			preparedStatement.setString(1, u.getId());
			preparedStatement.setString(2, u.getPw());
			preparedStatement.setString(3, u.getName());
			preparedStatement.setDate(4, u.getBirthday());
			preparedStatement.setString(5, u.getEmail());
			preparedStatement.setString(6, u.getAddress());
			preparedStatement.setString(7, u.getGenre_1());
			preparedStatement.setString(8, u.getGenre_2());
			preparedStatement.setString(9, u.getGenre_3());
			preparedStatement.setString(10, u.getGenre_4());

			// 데이터 삽입 실행
			preparedStatement.executeUpdate();

			// 리소스 해제
			preparedStatement.close();
			closeConnection(connection);
		} catch (SQLException e) {
			result = -1;
			// TODO Auto-generated catch block
			System.out.println(e.getErrorCode());
			e.printStackTrace();
		}
		return result;
	}
	
	public int checkId(String userId) {
		int result = 0;
		connection = getConnection();
		// 데이터베이스에 데이터 삽입 쿼리
		try {
			connection = getConnection();

			String checkIdSql = "SELECT * FROM moviedb.user WHERE userId = ?";
			PreparedStatement preparedStatement = connection.prepareStatement(checkIdSql);
			preparedStatement.setString(1, userId);
			ResultSet rs = preparedStatement.executeQuery();
			
			if (rs.next()) {
				result = 1;
			}
			
			preparedStatement.close();
			closeConnection(connection);
		} catch (SQLException e) {
			result = -1;
			// TODO Auto-generated catch block
			System.out.println(e.getErrorCode());
			e.printStackTrace();
		}
		return result;
	}
	public JSONObject signIn(Data_User u) {
		int result = 1;
		connection = getConnection();
		JSONObject userData = new JSONObject();
		// 데이터베이스에 데이터 삽입 쿼리
		try {
			connection = getConnection();

			String checkIdSql = "SELECT * FROM moviedb.user WHERE userId = ? and userPw = ?";
			PreparedStatement preparedStatement = connection.prepareStatement(checkIdSql);
			preparedStatement.setString(1, u.getId());
			preparedStatement.setString(2, u.getPw());
			ResultSet rs = preparedStatement.executeQuery();
			
			if (rs.next()) {

				result = 0;
				
				userData.put("userName",rs.getString("userName"));
				userData.put("userId",rs.getString("userId"));
				userData.put("userPw",rs.getString("userPw"));
				userData.put("userEmail",rs.getString("userEmail"));
				userData.put("birthDay",rs.getString("birthDay"));
				userData.put("userAddress",rs.getString("userAddress"));
				userData.put("Genre_1",rs.getString("Genre_1"));
				userData.put("Genre_2",rs.getString("Genre_2"));
				userData.put("Genre_3",rs.getString("Genre_3"));
				userData.put("Genre_4",rs.getString("Genre_4"));
			}
			
			preparedStatement.close();
			closeConnection(connection);
		} catch (SQLException e) {
			result = -1;
			// TODO Auto-generated catch block
			System.out.println(e.getErrorCode());
			e.printStackTrace();
		}

		userData.put("result",result);
		return userData;
	}
//UPDATE table_name SET name = '테스트 변경', country = '대한민국' WHERE id = 1105;
	public int userInfoEdit(JSONObject json) {
		int result = 1;
		String userName = json.getString("userName");
		String userId = json.getString("userId");
		String userPw = json.getString("userPw");
		String userEmail = json.getString("userEmail");
		String birthDay = json.getString("birthDay");
		String userAddress = json.getString("userAddress");
		String Genre_1 = json.getString("Genre_1");
		String Genre_2 = json.getString("Genre_2");
		String Genre_3 = json.getString("Genre_3");
		String Genre_4 = json.getString("Genre_4");
		connection = getConnection();
		// 데이터베이스에 데이터 삽입 쿼리
		try {
			connection = getConnection();
			
			String checkIdSql = "UPDATE moviedb.user SET userName=?, userEmail=?, birthDay=?, userAddress=?, Genre_1=?, Genre_2=?, Genre_3=?, Genre_4=? WHERE userId = ? and userPw = ?";
			PreparedStatement preparedStatement = connection.prepareStatement(checkIdSql);
			preparedStatement.setString(1, userName);
			preparedStatement.setString(2, userEmail);
			preparedStatement.setString(3, birthDay);
			preparedStatement.setString(4, userAddress);
			preparedStatement.setString(5, Genre_1);
			preparedStatement.setString(6, Genre_2);
			preparedStatement.setString(7, Genre_3);
			preparedStatement.setString(8, Genre_4);
			preparedStatement.setString(9, userId); System.out.println("ID : [" + userId + "]");
			preparedStatement.setString(10, userPw); System.out.println("PW : [" + userPw + "]");
			int rs = preparedStatement.executeUpdate();
			
			if(rs == 1) result = 0;
			
			preparedStatement.close();
			closeConnection(connection);
		} catch (SQLException e) {
			result = -1;
			// TODO Auto-generated catch block
			System.out.println(e.getErrorCode());
			e.printStackTrace();
		}
		System.out.println("DatabaseConnection.userInfoEdit[result] : " + result);
		return result;
	} ; 
}