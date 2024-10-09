package DB.DAO;

import java.sql.*;
import java.util.ArrayList;

import DB.DatabaseConnection;
import DB.Data.Data_User;

//추가 insertUserData
//수정 
//삭제 
//검색 loadUserDataList

public class DAO_UserDB extends DatabaseConnection {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	public static void main(String[] args) {
		new DAO_UserDB();
	}
	public DAO_UserDB(){
		//System.out.println(loadUserData("user0001").toString());
	}
	
	public String setData(String type,String dbData){
		String result = "";
		if(type.equals("load")){
			result = dbData;
		}
		return result;
	}
	
	public Data_User loadUserData(String userid) {
		//System.out.println("loadUserData 호출");
		Data_User data = new Data_User();
		
		try {
			conn = getConnection();

			String checkIdSql = "SELECT * FROM moviedb.user where userid=?";
			pstmt = conn.prepareStatement(checkIdSql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				
				data.setId(rs.getString(1));
				data.setPw(rs.getString(2));
				data.setName(rs.getString(3));
				data.setBirthday(rs.getDate(4));
				data.setEmail(rs.getString(5));
				data.setAddress(rs.getString(6));
				data.setGenre_1(rs.getString(7));
				data.setGenre_2(rs.getString(8));
				data.setGenre_3(rs.getString(9));
				data.setGenre_4(rs.getString(10));
				// System.out.println(data.toString());
			}
		} catch (Exception e) {
			System.out.println("에러 발생" + e.getMessage());
		}
		System.out.println("loadUserData 반환값");
		System.out.println(data.toString());
		
		return data;
	}
	
	public ArrayList<Data_User> loadUserDataList() {
		ArrayList<Data_User> result = new ArrayList<Data_User>();
		System.out.println("loadUserDataList 호출");
		int count = 0;
		try {
			conn = getConnection();

			String checkIdSql = "SELECT * FROM moviedb.user";
			pstmt = conn.prepareStatement(checkIdSql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Data_User data = new Data_User();

				data.setId(rs.getString(1));
				data.setPw(rs.getString(2));
				data.setName(rs.getString(3));
				data.setBirthday(rs.getDate(4));
				data.setEmail(rs.getString(5));
				data.setAddress(rs.getString(6));
				data.setGenre_1(rs.getString(7));
				data.setGenre_2(rs.getString(8));
				data.setGenre_3(rs.getString(9));
				data.setGenre_4(rs.getString(10));
				// System.out.println(data.toString());
				result.add(data);
				count++;
			}
		} catch (Exception e) {
			System.out.println("에러 발생" + e.getMessage());
		}
		System.out.println("loadUserDataList 종료 [" + count + "]개 불러옴");
		return result;
	}
	public int updateUserData(String[] datas) {
		return updateUserData(new Data_User(datas));
	}
	public int updateUserData(Data_User u) {
		int result = -1;
		try {
			conn = getConnection();

			String insertSql = "UPDATE moviedb.user SET \r\n" + "		userpw=? ,\r\n" + "		username=? ,\r\n"
					+ "		birthday=? ,\r\n" + "		useremail=? ,\r\n" + "		useraddress=? ,\r\n"
					+ "		genre_1=?, genre_2=?,\r\n" + "		genre_3=?, genre_4=?\r\n" + "	WHERE userId=?";
			pstmt = conn.prepareStatement(insertSql);

			pstmt.setString(10, u.getId());
			pstmt.setString(1, u.getPw());
			pstmt.setString(2, u.getName());
			pstmt.setDate(3, u.getBirthday());
			pstmt.setString(4, u.getEmail());
			pstmt.setString(5, u.getAddress());
			pstmt.setString(6, u.getGenre_1());
			pstmt.setString(7, u.getGenre_2());
			pstmt.setString(8, u.getGenre_3());
			pstmt.setString(9, u.getGenre_4());
			
			int rowsInserted = pstmt.executeUpdate();
			
			System.out.println("유저 정보 수정 : " + u.toString());
			if (rowsInserted > 0) {
				// 정보 수정 완료
				result = 0;
			} else {
				// 정보 수정 실패
				result = -1;
			}

		} catch (SQLException e) {
			result = 1;
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	public int deleteUserData(String[] datas) {
		return deleteUserData(new Data_User(datas));
	}
	public int deleteUserData(Data_User u) {
		int result = -1;
		try {
			conn = getConnection();

			String insertSql = "DELETE FROM moviedb.user WHERE userId = ?";
			pstmt = conn.prepareStatement(insertSql);

			pstmt.setString(1, u.getId());
			
			int rowsInserted = pstmt.executeUpdate();
			
			System.out.println("유저 정보 삭제 : " + u.toString());
			if (rowsInserted > 0) {
				// 정보 수정 완료
				result = 0;
			} else {
				// 정보 수정 실패
				result = -1;
			}

		} catch (SQLException e) {
			result = 1;
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	public int signupUser(Data_User u) {
		int result = -1;
		try {
			conn = getConnection();

			String checkIdSql = "SELECT * FROM moviedb.user WHERE id = ?";
			pstmt = conn.prepareStatement(checkIdSql);
			pstmt.setString(1, u.getId());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				// 중복된 아이디가 이미 존재하는 경우
				result = -1;
			} else {
				// 중복된 아이디가 없는 경우 회원 정보를 데이터베이스에 저장
				String insertSql = "INSERT INTO user (id, pw, name, birthday, email, address, genre) VALUES (?, ?, ?, ?, ?, ?, ?)";
				pstmt = conn.prepareStatement(insertSql);
				pstmt.setString(1, u.getId());
				pstmt.setString(2, u.getPw());
				pstmt.setString(3, u.getName());
				pstmt.setDate(4, u.getBirthday());
				pstmt.setString(5, u.getEmail());
				pstmt.setString(6, u.getAddress());
				pstmt.setString(7, u.getGenre_1());

				int rowsInserted = pstmt.executeUpdate();

				if (rowsInserted > 0) {
					// 회원가입 성공
					result = 0;
				} else {
					// 회원가입 실패
					result = -1;
				}
			}
		} catch (SQLException e) {
			result = 1;
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	public int insertUserData(Data_User u) {
		int result = -1;
		try {
			conn = getConnection();

			String checkIdSql = "SELECT * FROM moviedb.user WHERE id = ?";
			pstmt = conn.prepareStatement(checkIdSql);
			pstmt.setString(1, u.getId());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				// 중복된 아이디가 이미 존재하는 경우

			} else {
				// 중복된 아이디가 없는 경우 회원 정보를 데이터베이스에 저장
				String insertSql = "INSERT INTO user (id, pw, name, birthday, email, address, genre) VALUES (?, ?, ?, ?, ?, ?, ?)";
				pstmt = conn.prepareStatement(insertSql);
				pstmt.setString(1, u.getId());
				pstmt.setString(2, u.getPw());
				pstmt.setString(3, u.getName());
				pstmt.setDate(4, u.getBirthday());
				pstmt.setString(5, u.getEmail());
				pstmt.setString(6, u.getAddress());
				pstmt.setString(7, u.getGenre_1());

				int rowsInserted = pstmt.executeUpdate();

				if (rowsInserted > 0) {
					// 회원가입 성공
					result = 0;
				} else {
					// 회원가입 실패
					result = -1;
				}
			}
		} catch (SQLException e) {
			result = 1;
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}

}
