package DB.DAO;

import java.sql.*;
import java.util.*;

import DB.DatabaseConnection;
import DB.Data.Data_Review;

public class DAO_ReviewDB extends DatabaseConnection {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

//userid, movieCode, score, review, date
	public static void main(String[] args) {
		DAO_ReviewDB d = new DAO_ReviewDB();
//		ArrayList<Data_Review> reviewList = d.getReviewList();
//		ArrayList<Data_Review> reviewList = d.getReviewList("userid","userid");
		ArrayList<Data_Review> reviewList = d.getReviewList("movie", "userid", "docid");
		for (Data_Review review : reviewList) {
			System.out.println(review.toString()); 
		}
	}
	
	public ArrayList<Data_Review> getReviewList() {
		return getReviewList("", "", "");
	}

	public ArrayList<Data_Review> getReviewList(String userid) {
		return getReviewList(userid, "", "");
	}
	
	public int deleteReview(String[] data) {
		return deleteReview(new Data_Review(data));
	}
	public int deleteReview(Data_Review data) {
		int result = -1;
		int no = data.getNo();
		int score = data.getScore();
		if(no<=0) return 1;
		//System.out.println(data.toString());
		
		String userid = data.getUserid();
		String title = data.getTitle();
		String DOCID = data.getDOCID();
		String review = data.getReview();
		
		if(no<=0) {
			//return insertReview(data); // ?
		}
		try {

			conn = getConnection();
			// "SELECT * FROM moviedb.review WHERE ? = ?"
			String checkIdSql = "DELETE FROM moviedb.review WHERE no = ?";

			pstmt = conn.prepareStatement(checkIdSql);

			pstmt.setInt(1, no);

			int rs = pstmt.executeUpdate();

			if (rs > 0) {
				result = 0;
			}

		} catch (SQLException e) {
			System.out.println("에러 : " + e.getMessage());
			e.printStackTrace();
			result = -1;
		}

		return result;
	}
	public int updateReview(String[] data) {
		return updateReview(new Data_Review(data));
	}
	public int updateReview(Data_Review data) {
		int result = -1;
		
		int no = data.getNo();
		
		int score = data.getScore();
		String userid = data.getUserid();
		String title = data.getTitle();
		String DOCID = data.getDOCID();
		String review = data.getReview();
		
		if(no<=0) {
			return insertReview(data);
		}
		try {

			conn = getConnection();
			// "SELECT * FROM moviedb.review WHERE ? = ?"
			String checkIdSql = "UPDATE moviedb.review SET score=?, review=?, date=curdate() WHERE no=?";

			pstmt = conn.prepareStatement(checkIdSql);

			pstmt.setInt(1, score);
			//System.out.println("DB추가 점수 : " + score);
			pstmt.setString(2, review);
			pstmt.setInt(3, no);

			int rs = pstmt.executeUpdate();

			if (rs > 0) {
				result = 0;
			}

		} catch (SQLException e) {
			System.out.println("에러 : " + e.getMessage());
			e.printStackTrace();
			result = -1;
		}

		return result;
	}

	public int insertReview(Data_Review data) {
		int result = -1;
		int score = data.getScore();
		
		String userid = data.getUserid();
		String title = data.getTitle();
		String DOCID = data.getDOCID();
		String review = data.getReview();
		
		try {

			conn = getConnection();
			// "SELECT * FROM moviedb.review WHERE ? = ?"
			String checkIdSql = "insert into moviedb.review(userid,title,DOCID,score,review) value(?,?,?,?,?)";

			pstmt = conn.prepareStatement(checkIdSql);

			pstmt.setString(1, userid);
			pstmt.setString(2, title);
			pstmt.setString(3, DOCID);
			pstmt.setInt(4, score);
			//System.out.println("DB추가 점수 : " + score);
			pstmt.setString(5, review);

			int rs = pstmt.executeUpdate();

			if (rs > 0) {
				result = 0;
			}

		} catch (SQLException e) {
			System.out.println("에러 : " + e.getMessage());
			e.printStackTrace();
			result = -1;
		}

		return result;
	}

	public ArrayList<Data_Review> getReviewList(String type, String userid, String DOCID) {
		ArrayList<Data_Review> reviewList = new ArrayList<Data_Review>();
		
		int dataCount = 0;
		System.out.println("getReviewList 실행 type : " + type);
		if (type.equals("")) {
			dataCount = 0;
		} else if (type.equals("movie")) {
			dataCount = 2;
		}else if (type.equals("my")) {
			dataCount = 1;
		}
		
		try {

			conn = getConnection();
			// "SELECT * FROM moviedb.review WHERE ? = ?"
			String checkIdSql = "";

			if (dataCount == 0) {
				checkIdSql = "SELECT * FROM moviedb.review";
				//System.out.println("리뷰 불러오기(전체)");
			} else if (dataCount == 1) {
				checkIdSql = "SELECT * FROM moviedb.review WHERE userid = ?";
				//System.out.println("리뷰 불러오기(아이디)");
			} else if (dataCount == 2) {
				checkIdSql = "SELECT * FROM moviedb.review WHERE DOCID = ? ORDER BY (userid = ?) DESC";
				//System.out.println("리뷰 불러오기(영화 본인)");
			}

			System.out.println("checkIdSql : " + checkIdSql);
			pstmt = conn.prepareStatement(checkIdSql);

			if (dataCount == 1) {
				pstmt.setString(1, userid);
			} else if (dataCount == 2) {
				pstmt.setString(1, DOCID);
				pstmt.setString(2, userid);
			}

			rs = pstmt.executeQuery();

			while (rs.next()) {

				Data_Review review = new Data_Review();
				review.setNo(rs.getInt(1));
				review.setDOCID(rs.getString(2));
				review.setTitle(rs.getString(3));
				review.setUserid(rs.getString(4));
				review.setScore(rs.getInt(5));
				review.setReview(rs.getString(6));
				review.setDate(rs.getDate(7));
				//System.out.println(review.toString());
				reviewList.add(review);
			}

		} catch (SQLException e) {
			System.out.println("에러 : " + e.getMessage());
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
				System.out.println("finally : " + e.getMessage());
			}
		}
		return reviewList;
	}
}
