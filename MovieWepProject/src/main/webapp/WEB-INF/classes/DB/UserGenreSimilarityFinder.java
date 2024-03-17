package DB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import KMDB.*;
import Office.*;

//영화 추천용 선호장르 유사 유저 검색
public class UserGenreSimilarityFinder extends DatabaseConnection {

	// private Connection connection;

	public static void main(String[] args) {

		UserGenreSimilarityFinder d = new UserGenreSimilarityFinder();

		List<MainBoxCtor> dataList = d.resultInterestMovieData("user0002");

//		System.out.println(d.resultInterestMovieData(dataList));

		for (MainBoxCtor data : dataList) {
			System.out.println(data.toString());
		}

	}

	public List<MainBoxCtor> resultInterestMovieData(String userid) {
		return resultInterestMovieData(getInterestMovieList(userid));
	}

	public List<MainBoxCtor> resultInterestMovieData(ArrayList<InterestMovieData> datas) {//추천되는 영화의 정보를 리스트로 반환(docid, 제목, 개봉일, 포스터, 랭크(순서))
		ArrayList<MainBoxCtor> result = new ArrayList<MainBoxCtor>();
		JSONArray array = new JSONArray();
		int count = 1;
		for (InterestMovieData data : datas) {
			LoadKMDBData load = new LoadKMDBData();
			KMDB_Data movie = load.getKMDB_movieDOCID(data.getDocid()).get(0);
			
			MainBoxCtor mainData = new MainBoxCtor();
			mainData.setMovieDOCID(movie.getDOCID());
			mainData.setMovieNm(movie.getTitle());
			mainData.setOpenDt(movie.getRepRlsDate());
			mainData.setPosterUrl(movie.getPosters()[0]);
			mainData.setRank((count++) + "");
			result.add(mainData);
		}
		return result;
	}

	public ArrayList<InterestMovieData> getInterestMovieList(String userId) {//입력한 아이디에게 추천하는 영화 5개를 출력(docid,점수)
		ArrayList<InterestMovieData> result = new ArrayList<InterestMovieData>();
		String[] userIds = { "", "", "", "", "" };
		ArrayList<SimilarInterestUserData> SimilarUserList = getSimilarInterestUsers(userId);
		String cond = "";

		for (int i = 0; i < SimilarUserList.size(); i++) {

			userIds[i] = SimilarUserList.get(i).getId();
			System.out.println(userIds[i]);
			// cond = cond + " and " + "userid=\'" + SimilarUserList.get(i).getId() + "\'";
		}
		try {
			connection = getConnection();

			String checkIdSql = "SELECT DISTINCT docid, score\r\n" + "	FROM moviedb.review\r\n"
					+ "	WHERE userid IN (?, ?,?,?,?) AND score >= 5 ORDER BY score DESC limit 5";
			PreparedStatement preparedStatement = connection.prepareStatement(checkIdSql);
			preparedStatement.setString(1, userIds[0]);
			preparedStatement.setString(2, userIds[1]);
			preparedStatement.setString(3, userIds[2]);
			preparedStatement.setString(4, userIds[3]);
			preparedStatement.setString(5, userIds[4]);
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				// System.out.print(rs.getString(1) + " : ");
				InterestMovieData data = new InterestMovieData(rs.getString(1), rs.getInt(2));
				result.add(data);
				// System.out.println(rs.getInt(2));
			}

			preparedStatement.close();
			closeConnection(connection);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e.getErrorCode());
			e.printStackTrace();
		}
		return result;
	}

	public ArrayList<SimilarInterestUserData> getSimilarInterestUsers(String userId) {	//선호장르가 가장 비슷한 유저 최대 5명까지 불러옴 (유저아이디,유사도)
		ArrayList<SimilarInterestUserData> result = new ArrayList<SimilarInterestUserData>();

		try {
			connection = getConnection();

			String checkIdSql = "SELECT u1.userId,\r\n" + "       SUM(\r\n"
					+ "         IF(u1.Genre_1 = u2.Genre_1 OR u1.Genre_1 = u2.Genre_2 OR u1.Genre_1 = u2.Genre_3 OR u1.Genre_1 = u2.Genre_4, 1, 0) +\r\n"
					+ "         IF(u1.Genre_2 = u2.Genre_1 OR u1.Genre_2 = u2.Genre_2 OR u1.Genre_2 = u2.Genre_3 OR u1.Genre_2 = u2.Genre_4, 1, 0) +\r\n"
					+ "         IF(u1.Genre_3 = u2.Genre_1 OR u1.Genre_3 = u2.Genre_2 OR u1.Genre_3 = u2.Genre_3 OR u1.Genre_3 = u2.Genre_4, 1, 0) +\r\n"
					+ "         IF(u1.Genre_4 = u2.Genre_1 OR u1.Genre_4 = u2.Genre_2 OR u1.Genre_4 = u2.Genre_3 OR u1.Genre_4 = u2.Genre_4, 1, 0)\r\n"
					+ "       ) AS overlap_count\r\n" + "FROM `user` u1\r\n"
					+ "INNER JOIN `user` u2 ON u1.userId != u2.userId\r\n" + "WHERE u2.userId = ?\r\n"
					+ "GROUP BY u1.userId\r\n" + "ORDER BY overlap_count DESC\r\n" + "limit 5";
			PreparedStatement preparedStatement = connection.prepareStatement(checkIdSql);
			preparedStatement.setString(1, userId);
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				// System.out.print(rs.getString(1) + " : ");
				SimilarInterestUserData data = new SimilarInterestUserData(rs.getString(1), rs.getInt(2));
				result.add(data);
				// System.out.println(rs.getInt(2));
			}

			preparedStatement.close();
			closeConnection(connection);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e.getErrorCode());
			e.printStackTrace();
		}
		return result;
	}

	class SimilarInterestUserData {
		String id = "";
		int sim = 0;

		SimilarInterestUserData(String id, int sim) {
			this.id = id;
			this.sim = sim;
		}

		public String getId() {
			return id;
		}

		public int getSim() {
			return sim;
		}

		public void setId(String id) {
			this.id = id;
		}

		public void setSim(int sim) {
			this.sim = sim;
		}
	}

	class InterestMovieData {
		String docid = "";
		int score = 0;

		@Override
		public String toString() {
			// TODO Auto-generated method stub
			return "[docid : " + docid + "] [score : " + score + "]";
		}

		InterestMovieData(String docid, int score) {
			this.docid = docid;
			this.score = score;
		}

		public int getScore() {
			return score;
		}

		public void setScore(int score) {
			this.score = score;
		}

		public String getDocid() {
			return docid;
		}

		public void setvDocid(String docid) {
			this.docid = docid;
		}
	}
}
